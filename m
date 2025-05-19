Return-Path: <linux-fsdevel+bounces-49431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F5ABC411
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9753A6299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14163289352;
	Mon, 19 May 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMqHaZGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16B289350
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671101; cv=none; b=Y3WxrRnwDbm4QCSqSRZl8BM5LpLNbPPiiYZPgD36/FTK7uX+z35qhJsusM2U+y23f1Xleml2v56n3+BWqxrc/z/jo1kQQX4bzTjWj4LtDXGdQEtD5pDosMCVeHWC8RBSZdH5d4UXBm2f+Iakl7MeuKg3oDQZWM44GYKRBleBos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671101; c=relaxed/simple;
	bh=fQqhwRct2zYiKUV2MxExt+YwBxnmcowniZIdiq9mLVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d74WdXhY9CH52dNRgEUW50uSBebsTX1Lntb01Ks6r071uBleTGmDqmIk5eihpvYws2c28eoL5mt28L/WREPR+IyUpGTQnqeN1fxyFT46cOyb23S1o0iuwNFYNiK0vkPVdlP8GdsRSI0s4xCp0GddxoSOwcR63gSPQ20lrtoQKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMqHaZGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747671098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FCUDQGeA3DvixcZApWgoXlHly+SHL0ArXKwLqnATz8k=;
	b=KMqHaZGde8Ejta0JeXZsB7rjewn+AvVTpgQeNhCls7RfYjA5HFBRzn56k1t8R0LGAS1gk0
	in4mkOu8TCXNjP0hNttLpXbXNjZrOcp1jD3ODn0dzEJSAsBvvN5kS6744/Gihli4i5VIMN
	qURZvYRajpsCYvuqUjP4XJvyATfm1FI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-_vgrlQGDMO2TtSQZQBDesg-1; Mon,
 19 May 2025 12:11:37 -0400
X-MC-Unique: _vgrlQGDMO2TtSQZQBDesg-1
X-Mimecast-MFC-AGG-ID: _vgrlQGDMO2TtSQZQBDesg_1747671096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFB171801A17;
	Mon, 19 May 2025 16:11:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C18F019560AA;
	Mon, 19 May 2025 16:11:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vfs, afs, bash: Fix miscomparison of foreign user IDs in the VFS
Date: Mon, 19 May 2025 17:11:21 +0100
Message-ID: <20250519161125.2981681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Christian,

Here's a pair of fixes that deal with some places the VFS mishandles
foreign user ID checks.  By "foreign" I mean that the user IDs from the
filesystem do not belong in the same number space as the system's user IDs.
Network filesystems are prime examples of this, but it may also impact
things like USB drives or cdroms.

Take AFS as example: Whilst each file does have a numeric user ID, the file
may be accessed from a world-accessible public-facing server from some
other organisation with its own idea of what that user ID refers to.  IDs
from AFS may also collide with the system's own set of IDs and may also be
unrepresentable as a 32-bit UID (in the case of AuriStor servers).

Further, kAFS uses a key containing an authentication token to specify the
subject doing an RPC operation to the server - and, as such, this needs to
be used instead of current_fsuid() in determining whether the current user
has ownership rights over a file.

Additionally, filesystems (CIFS being a notable example) may also have user
identifiers that aren't simple integers.

Now the problem in the VFS is that there are a number of places where it
assumes it can directly compare i_uid (possibly id-mapped) to either than
on another inode or a UID drawn from elsewhere (e.g. current_uid()) - but
this doesn't work right.

This causes the write-to-sticky check to work incorrectly for AFS (though
this is currently masked by a workaround in bash that is slated to be
removed) whereby open(O_CREAT) of such a file will fail when it shouldn't.

Two patches are provided: The first specifically fixes the bash workaround
issue, delegating the check as to whether two inodes have the same owner
and the check as to whether the current user owns an inode to the
filesystem.

AFS then uses the result of a status-fetch with a suitable key to determine
file ownership and just compares the 64-bit owner IDs to determine if two
inodes have the same ownership.

The second patch expands the use of the VFS helper functions added by the
first to other VFS UID checks.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

David Howells (2):
  afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
  vfs: Fix inode ownership checks with regard to foreign ownership

 fs/afs/dir.c       |  2 ++
 fs/afs/file.c      |  2 ++
 fs/afs/internal.h  |  3 ++
 fs/afs/security.c  | 52 ++++++++++++++++++++++++++++++
 fs/attr.c          | 58 ++++++++++++++++++++-------------
 fs/coredump.c      |  3 +-
 fs/inode.c         |  8 +++--
 fs/internal.h      |  1 +
 fs/locks.c         |  7 ++--
 fs/namei.c         | 80 ++++++++++++++++++++++++++++++++--------------
 fs/remap_range.c   | 20 ++++++------
 include/linux/fs.h |  3 ++
 12 files changed, 177 insertions(+), 62 deletions(-)


