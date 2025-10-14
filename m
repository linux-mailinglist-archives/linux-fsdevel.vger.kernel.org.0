Return-Path: <linux-fsdevel+bounces-64134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60991BD9BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43FAC4EB3AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254C313E2D;
	Tue, 14 Oct 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9mci6U5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEF2FA0EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448970; cv=none; b=Fa6ut+mq8o/+8Mnvo2qFy0TpVqIjj5xS82xKz6p7a1vl/KFpco53N6NXHtwQGHumNW1b7C5JOnY/DDVboPecbD00b7kEG5Ddzl6j1xTc53sly14edbkNFYSb3c1sItSOQbbhzqa41Cm9TtFeOWpVxTmCHIfjmSODF5DmNwQuKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448970; c=relaxed/simple;
	bh=lgkHpwlpSJLJmES/dXoWXanhZTG+O6JwBTaZVF77ZIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrWRs7HycIeZH2aikFRSyDYr6pAy5SixrSUVcFm0X7Bn+mzEueaeVtkGlD2r9Gx2FASBrG+NNv9kXaRq4+Pn2cIh1RpI2sBxb1yxpGhxLt/rsHtfXctceCGhfjDLpDN862xRKWIY9OqrEa8ZQR5NQg990u8lPcv1XjJ5ftDgZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9mci6U5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760448966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CatxfhLxYasU2u6fzfcnGLX+yDMii7A5Aq7MzACcHMo=;
	b=O9mci6U58BVapGLO6oMU5mvwWqp/95cFhkaudmGbBV/ebghemmpY0shfUwB+SYSmOuRBoV
	z8TxnBRZL4dD80O0YA9x2HKSJt1i0Cw/t3SV+eigxrN3sNux31xzOF3d3/Z6TBs5UCmDM5
	ofFYes9pIljmmAJnH6bT1V8NYcTfHWk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-f9Irs_7vMVuRLlsdA9N0Ww-1; Tue,
 14 Oct 2025 09:36:02 -0400
X-MC-Unique: f9Irs_7vMVuRLlsdA9N0Ww-1
X-Mimecast-MFC-AGG-ID: f9Irs_7vMVuRLlsdA9N0Ww_1760448959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800991954112;
	Tue, 14 Oct 2025 13:35:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F13CE1800283;
	Tue, 14 Oct 2025 13:35:54 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vfs, afs, bash: Fix miscomparison of foreign user IDs in the VFS
Date: Tue, 14 Oct 2025 14:35:43 +0100
Message-ID: <20251014133551.82642-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Al, Christian,

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

Two patches are provided:

 (1) Add a pair of inode operations, one to compare the ownership of a pair
     of inodes and the other to see if the current process has ownership
     rights over an inode.  Usage of this is then extended out into the
     VFS, replacing comparisons between i_uid and i_uid and between i_uid
     and current_fsuid().  The default, it the inode ops are unimplemented,
     is to do those direct i_uid comparisons.

 (2) Fixes the bash workaround issue with regard to AFS, overriding the
     checks as to whether two inodes have the same owner and the check as
     to whether the current user owns an inode to work within the AFS
     model.

kAFS uses the result of a status-fetch with a suitable key to determine
file ownership (if the ADMINISTER bit is set) and just compares the 64-bit
owner IDs to determine if two inodes have the same ownership.

Note that chown may also need modifying in some way - but that can't
necessarily supply the information required (for instance, an AuriStor YFS ID
is 64 bits, but chown can only handle a 32-bit integer; CIFS might use a
GUID).

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-sticky-2

Thanks,
David

David Howells (2):
  vfs: Allow filesystems with foreign owner IDs to override UID checks
  afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir

 Documentation/filesystems/vfs.rst |  21 ++++
 fs/afs/dir.c                      |   2 +
 fs/afs/file.c                     |   2 +
 fs/afs/internal.h                 |   3 +
 fs/afs/security.c                 |  46 +++++++++
 fs/attr.c                         |  58 ++++++-----
 fs/coredump.c                     |   2 +-
 fs/inode.c                        |  11 +-
 fs/internal.h                     |   1 +
 fs/locks.c                        |   7 +-
 fs/namei.c                        | 161 ++++++++++++++++++++++++------
 fs/remap_range.c                  |  20 ++--
 include/linux/fs.h                |   6 +-
 13 files changed, 269 insertions(+), 71 deletions(-)


