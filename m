Return-Path: <linux-fsdevel+bounces-6740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA381B8E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273431C22F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4D55E69;
	Thu, 21 Dec 2023 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka4K0s4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCC55E4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703166365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rlyXAqOlyS384Hk8kpuBXYflRK12oBrIJ43cpC5VRV8=;
	b=Ka4K0s4gamLfpwNuGn00hy8PyQ2HXIbMVw9I6il9iZbGJ2VyxLY1dwxjxfzJ1APqZdjm0G
	v/AjIxgWprpVE2IiJ54cYg2TdaS6TGZ9OYCMBQMaGE03v6G7RFFnWbflZYAB/K/f1KmTwj
	bW60m9iZwfgJ08vZS3yQKm/mNk9gFaA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-hD6chBcqNRCdWwRwvh-SaA-1; Thu,
 21 Dec 2023 08:46:02 -0500
X-MC-Unique: hD6chBcqNRCdWwRwvh-SaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 653233C29A72;
	Thu, 21 Dec 2023 13:46:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E6F7C1596E;
	Thu, 21 Dec 2023 13:46:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] afs: Fix dynamic root interaction with failing DNS lookups
Date: Thu, 21 Dec 2023 13:45:27 +0000
Message-ID: <20231221134558.1659214-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Markus, Marc,

Here's a set of fixes to improve the interaction of arbitrary lookups in
the AFS dynamic root that hit DNS lookup failures[1]:

 (1) Always delete unused (particularly negative) dentries as soon as
     possible so that they don't prevent future lookups from retrying.

 (2) Fix the handling of new-style negative DNS lookups in ->lookup() to
     make them return ENOENT so that userspace doesn't get confused when
     stat succeeds but the following open on the looked up file then fails.

 (3) Fix key handling so that DNS lookup results are reclaimed as soon as
     they expire rather than sitting round either forever or for an
     additional 5 mins beyond a set expiry time returning EKEYEXPIRED.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637 [1]
Link: https://lore.kernel.org/r/20231211163412.2766147-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231211213233.2793525-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231212144611.3100234-1-dhowells@redhat.com/ # v3

Changes
=======
ver #4)
 - Reduce the negative timeout from 10s to 1s.

ver #3)
 - Rebased to v6.7-rc5 which has an additional afs patch.
 - Don't add to TIME64_MAX (ie. permanent) when checking expiry time.

ver #2)
 - Fix signed-unsigned comparison when checking return val.

David Howells (3):
  afs: Fix the dynamic root's d_delete to always delete unused dentries
  afs: Fix dynamic root lookup DNS check
  keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on
    expiry

 fs/afs/dynroot.c           | 31 +++++++++++++++++--------------
 include/linux/key-type.h   |  1 +
 net/dns_resolver/dns_key.c | 10 +++++++++-
 security/keys/gc.c         | 31 +++++++++++++++++++++----------
 security/keys/internal.h   | 11 ++++++++++-
 security/keys/key.c        | 15 +++++----------
 security/keys/proc.c       |  2 +-
 7 files changed, 64 insertions(+), 37 deletions(-)


