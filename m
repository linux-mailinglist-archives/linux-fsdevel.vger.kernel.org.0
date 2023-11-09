Return-Path: <linux-fsdevel+bounces-2644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AD7E73B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAF280F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8C38DF8;
	Thu,  9 Nov 2023 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yWmkr2Ds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25038DE4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:38:19 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC942139;
	Thu,  9 Nov 2023 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jTULZb7nPWSXQoAz/suqF1eRILvjbvT5JeWBGWqkoIs=; t=1699565899; x=1700775499; 
	b=yWmkr2DsB9ml6dHBZGwupNJRRGnOI4LA7w/RsvrdVvbpU0hOGjX5qSby3a6fHhpyASv7IafZ15J
	5mkvjIPmuhPY42jaSAInV4G4T0B0Y6YPyvvig7mVIQu8JwltvZeVAqfluE5nzLLJp2MHZ+GKQrVFv
	0qNGrz2JflJBlIg8rG59zhhbtcQWzjxHB81zytmFBkAt9rDwD6KiPiBT2YDE1iYFf8eKofw5wLryH
	rZ/sGHqxXGKAS7BpPXjtQrosw2VB0CJUs3lK/qm6FM3w6QB0/7sajAngVCnIODvmKsj/6jrl/L/J2
	ve/qrKph1rOPwKiYth19qoKbhX7mDoDpW6GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1CjA-00000001znF-2PA8;
	Thu, 09 Nov 2023 22:38:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>
Subject: [RFC PATCH 0/6] debugfs/wifi: locking fixes
Date: Thu,  9 Nov 2023 22:22:52 +0100
Message-ID: <20231109212251.213873-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So ... this is a bit complex.

Ben found [1] that since the wireless locking rework [2] we have
a deadlock in the debugfs use in the wireless stack, since some
objects (netdevs, links, stations) can be removed while holding
the wiphy->mtx, where as the files (all netdev/link and agg_status
for stations) also acquire the wiphy->mtx. This of course leads
to deadlocks, since Nicolai's proxy_fops work [3] we wait for the
users of the file to finish before removing them, which they
cannot in this case:

thread 1		thread 2
lock(wiphy->mutex)
			read()/write()
			 -> lock(wiphy->mutex) // waits for mutex
debugfs_remove()
 -> wait_for_users() // cannot finish


Unfortunately, there's no good way to remove the debugfs files
*before* locking in wireless, since we may not even know which
object needs to get removed, etc. Also, some files may need to
be removed based on other actions, and we want/need to free the
objects.


I went back and forth on how to fix it, and Ben had some hacks
in the threads, but in the end I decided on the approach taken
in this patchset.

So I have
 * debugfs: fix automount d_fsdata usage

   This patch fixes a bug in the existing automount case in
   debugfs, if that dentry were ever removed, we'd try to
   kfree() the function pointer. I previously tried to fix
   this differently [4] but that doesn't work, so here I
   just allocate a debugfs fsdata for automount, there's a
   single instance of this in the tree ...

 * debugfs: annotate debugfs handlers vs. removal with lockdep

   This just makes the problem obvious, whether in wireless
   or elsewhere, by annotating it with lockdep so that we get
   complaints about the deadlock described above. I've checked
   that the deadlock in wireless actually gets reported.

 * debugfs: add API to allow debugfs operations cancellation

   This adds a bit of infrastructure in debugfs to allow for
   cancellation of read/write/... handlers when remove() is
   called for a file. The API is written more generically,
   so that it could also be used to e.g. cancel operations in
   hardware/firmware, for example, if debugfs does accesses
   to that.

 * wifi: cfg80211: add locked debugfs wrappers

   I went back and forth on this, but in the end this seemed
   the easiest approach. Using these new helpers from debugfs
   files that are removed under the wiphy lock is safe, at
   the expense of pushing the read/write functions into a new
   wiphy work, which is called with wiphy->mutex held. This
   then uses the debugfs API introduced in the previous patch
   to cancel operations that are pending while the file is
   removed.

 * wifi: mac80211: use wiphy locked debugfs helpers for agg_status
 * wifi: mac80211: use wiphy locked debugfs for sdata/link

   These convert the files that actually have the problem in
   mac80211 to use the new helpers.

Any comments would be appreciated :-)

[1] https://lore.kernel.org/r/56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com
[2] in particular commit 0ab6cba0696d ("wifi: mac80211: hold wiphy lock in netdev/link debugfs")
    but there's a lot more work that went into it
[3] commit e9117a5a4bf6 ("debugfs: implement per-file removal protection")
[4] https://lore.kernel.org/lkml/20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid/

johannes



