Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CF59E799
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiHWQi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbiHWQiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336334D4E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9ORJYSZYbAzoak3DB6oNeDOw/eyq14PJdfI25alqlE=;
        b=D/2D5hFwfcXP6ZgUBwmzJF4M/3taFSLreoCY/ADaXQ79qdnDuJUe0u/ViZBq7X3uerzqvZ
        TE7AcTX/wDavIz1i9j4DDJAaH0WFMxUDQdhzgfV/IcKZ/XRFnZreYdeHXnqbnn7s/ln9LM
        jIey1N5LF35IP7e6KyV9Xv9TER1ERlI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-hJ7USIJtNyOnShiPXKs8ZQ-1; Tue, 23 Aug 2022 09:07:30 -0400
X-MC-Unique: hJ7USIJtNyOnShiPXKs8ZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B22FA3826A48;
        Tue, 23 Aug 2022 13:07:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92154492D1A;
        Tue, 23 Aug 2022 13:07:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/5] smb3: Move the flush out of smb2_copychunk_range() into
 its callers
From:   David Howells <dhowells@redhat.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org
Cc:     lsahlber@redhat.com, jlayton@kernel.org, dchinner@redhat.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, samba-technical@lists.samba.org
Date:   Tue, 23 Aug 2022 14:07:28 +0100
Message-ID: <166126004796.548536.8555773200873112505.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
References: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the flush out of smb2_copychunk_range() into its callers.  This will
allow the pagecache to be invalidated between the flush and the operation
in smb3_collapse_range() and smb3_insert_range().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Ronnie Sahlberg <lsahlber@redhat.com>
---

 fs/cifs/cifsfs.c  |    2 ++
 fs/cifs/smb2ops.c |   20 ++++++++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f54d8bf2732a..e9fb338b8e7e 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1219,6 +1219,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 
 	cifs_dbg(FYI, "copychunk range\n");
 
+	filemap_write_and_wait(src_inode->i_mapping);
+
 	if (!src_file->private_data || !dst_file->private_data) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 96f3b0573606..7e3de6a0e1dc 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1600,17 +1600,8 @@ smb2_copychunk_range(const unsigned int xid,
 	int chunks_copied = 0;
 	bool chunk_sizes_updated = false;
 	ssize_t bytes_written, total_bytes_written = 0;
-	struct inode *inode;
 
 	pcchunk = kmalloc(sizeof(struct copychunk_ioctl), GFP_KERNEL);
-
-	/*
-	 * We need to flush all unwritten data before we can send the
-	 * copychunk ioctl to the server.
-	 */
-	inode = d_inode(trgtfile->dentry);
-	filemap_write_and_wait(inode->i_mapping);
-
 	if (pcchunk == NULL)
 		return -ENOMEM;
 
@@ -3689,6 +3680,8 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 		goto out;
 	}
 
+	filemap_write_and_wait(inode->i_mapping);
+
 	rc = smb2_copychunk_range(xid, cfile, cfile, off + len,
 				  i_size_read(inode) - off - len, off);
 	if (rc < 0)
@@ -3716,18 +3709,21 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 	int rc;
 	unsigned int xid;
 	struct cifsFileInfo *cfile = file->private_data;
+	struct inode *inode = file_inode(file);
 	__le64 eof;
 	__u64  count;
 
 	xid = get_xid();
 
-	if (off >= i_size_read(file->f_inode)) {
+	if (off >= i_size_read(inode)) {
 		rc = -EINVAL;
 		goto out;
 	}
 
-	count = i_size_read(file->f_inode) - off;
-	eof = cpu_to_le64(i_size_read(file->f_inode) + len);
+	count = i_size_read(inode) - off;
+	eof = cpu_to_le64(i_size_read(inode) + len);
+
+	filemap_write_and_wait(inode->i_mapping);
 
 	rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 			  cfile->fid.volatile_fid, cfile->pid, &eof);


