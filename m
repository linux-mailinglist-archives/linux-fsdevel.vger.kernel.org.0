Return-Path: <linux-fsdevel+bounces-15555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E6890558
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E4F294EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4D5338F;
	Thu, 28 Mar 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3H2sbzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9893BBF4
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643703; cv=none; b=u3wNBqf5MvMoH+er6WdatIr3TYZE6MLBUjaoX2hKXmslGR6zMHUvLlfLN8t4AJ64caBnPve+g/XP/miN9satZWCRYS0c5Silj+/zjoiQZR0pA2uH32Ss6X7eFrFuetG5HSQa2i+ZdJAaR1iHmsTKHYlqtZDPrvAF1T6Xni+H8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643703; c=relaxed/simple;
	bh=jdfIqeGx7iuHgqcMFhxtu5WAhVw5xPnhsJo7b6P/XKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyAge6zyEUvZCXm1U5wGRrm2Nfodxvi96ZbPqSdx2G9IPEr8MyjxSVDm01QvoHbGsBZrfoIiPbDayRDI/ZWre4nXjYYWuKss/ykt1fuhZBDedOY6CtW50/48y0pRR01SPM+jhwiSBqLYHyeD5I+m5Qrtz7sHMDyAuPXpP8517J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3H2sbzG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDfAk4YAlKNdLmSwUMxTH3zTc83Y1JZRxoVOBJSESsg=;
	b=f3H2sbzGZPPNNlxobpqD4DaLEuJ+zhq2iVArzjg4taPJMbLwp8js8623MACG6VLstvxfRy
	U71h0E8TVYPFz5LO597UG77hDH98sq7ujEg5U3VU9XmaVyKCaeewH5iN0EfiC7/R509u4l
	Ro0KTZTbFOTfk1QHhpw2ODcqLQ4xDBs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-HdMk_3MKM8CSF0IznLHt6w-1; Thu,
 28 Mar 2024 12:34:53 -0400
X-MC-Unique: HdMk_3MKM8CSF0IznLHt6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1060F3C0BE45;
	Thu, 28 Mar 2024 16:34:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA9EB492BC6;
	Thu, 28 Mar 2024 16:34:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 02/26] 9p: Clean up some kdoc and unused var warnings.
Date: Thu, 28 Mar 2024 16:33:54 +0000
Message-ID: <20240328163424.2781320-3-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Remove the kdoc for the removed 'req' member of the 9p_conn struct.

Remove a pair of set-but-not-used v9ses variables.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
---
 fs/9p/vfs_inode_dotl.c | 4 ----
 net/9p/trans_fd.c      | 1 -
 2 files changed, 5 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..7af27ba1c25d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -297,7 +297,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			       umode_t omode)
 {
 	int err;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	kgid_t gid;
 	const unsigned char *name;
@@ -307,7 +306,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	v9ses = v9fs_inode2v9ses(dir);
 
 	omode |= S_IFDIR;
 	if (dir->i_mode & S_ISGID)
@@ -739,7 +737,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	umode_t mode;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	struct inode *inode;
 	struct p9_qid qid;
@@ -749,7 +746,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		 dir->i_ino, dentry, omode,
 		 MAJOR(rdev), MINOR(rdev));
 
-	v9ses = v9fs_inode2v9ses(dir);
 	dfid = v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
 		err = PTR_ERR(dfid);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 1a3948b8c493..196060dc6138 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -95,7 +95,6 @@ struct p9_poll_wait {
  * @unsent_req_list: accounting for requests that haven't been sent
  * @rreq: read request
  * @wreq: write request
- * @req: current request being processed (if any)
  * @tmp_buf: temporary buffer to read in header
  * @rc: temporary fcall for reading current frame
  * @wpos: write position for current frame


