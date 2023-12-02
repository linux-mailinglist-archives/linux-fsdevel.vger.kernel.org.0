Return-Path: <linux-fsdevel+bounces-4681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145D801C8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 13:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED3F1F21098
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75982168B3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w0SVGWs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F2123;
	Sat,  2 Dec 2023 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UrYSUWtR9hmePrOrhJRLWibt7ZulRWhgkGXJBEj7lv8=;
	t=1701513647; x=1702723247; b=w0SVGWs5JzHgMg2UK6rKAhmOL+wtjJmRoNMsdmOIf71WAzw
	luxjkHbWQbQ16TmIdKxMxqDiMs+V6o6gY6BII6TSK0VntOw+MJCIAAOBP8v40qFdvcGZEOOHzjwOi
	dJSRMW5jBuAHYSXmk0+8epVOzF6Hm4Wawfa7LCoeKe2ZwBB98tukI+0s1TZUyvGGc/Ope8bXzj4FV
	oQqKF19T7IX2jR++MHPIMsrVreDGuDn7H4ja0qFo8ACdlsjPRWFkJPJq2XNATFC/FzUAbxYUF3vAu
	k49ru1dc2zpsmW3Qe6HgZ3lm1bzmbyx/oV6PWv8phm4JGOYd9OVpae8vpsilE8+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9NQS-0000000CQpO-49ZI;
	Sat, 02 Dec 2023 11:40:45 +0100
Message-ID: <9ffaef32a70d3ba5cd015ec22cf8437cd7c80e79.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/6] debugfs: annotate debugfs handlers vs. removal
 with lockdep
From: Johannes Berg <johannes@sipsolutions.net>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
 Nicolai Stange <nicstange@gmail.com>, Ben Greear <greearb@candelatech.com>,
 Minchan Kim <minchan@kernel.org>
Date: Sat, 02 Dec 2023 11:40:43 +0100
In-Reply-To: <20231202063735.GD404241@google.com>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
	 <20231109222251.a62811ebde9b.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>
	 <20231202063735.GD404241@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2023-12-02 at 15:37 +0900, Sergey Senozhatsky wrote:
> On (23/11/09 22:22), Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > When you take a lock in a debugfs handler but also try
> > to remove the debugfs file under that lock, things can
> > deadlock since the removal has to wait for all users
> > to finish.
> >=20
> > Add lockdep annotations in debugfs_file_get()/_put()
> > to catch such issues.
>=20
> So this triggers when I reset zram device (zsmalloc compiled with
> CONFIG_ZSMALLOC_STAT).

I shouldn't have put that into the rc, that was more or less an
accident. I think I'll do a revert.

> debugfs_create_file() and debugfs_remove_recursive() are called
> under zram->init_lock, and zsmalloc never calls into zram code.
> What I don't really get is where does the
> 	`debugfs::classes -> zram->init_lock`
> dependency come from?

"debugfs:classes" means a file is being accessed and "classes" is the
name, so that's=20

static int zs_stats_size_show(struct seq_file *s, void *v)

which uses seq_file, so there we have a seq_file lock.

I think eventually the issue is that lockdep isn't telling the various
seq_file instances apart, and you have one that's removed under lock
(classes) and another one that's taking the lock (reset).

Anyway, I'll send a revert, don't think this is ready yet. I was fixing
the wireless debugfs lockdep and had used that to debug it.

johannes

