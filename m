Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2059E7A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiHWQjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245152AbiHWQjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D6148C8C
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAOIxblxocTtO3BL0vdfFElttBlZxbKdOb+H6jWEd7M=;
        b=FfTmY0ZbVoPbH57fPrDMDn36M24zjS2jskn7d8vn78hV7xAYxfen/Sn96VYPos2TIfeJ85
        aNrELC9BQv4g3dC5uLo7EEpoLWaFFfL6EI/ucPpc5ICUZB1h6uWP88HKchfWsxxA/h1Mib
        qXiztOX6ijoJTZkuscCFxP2xdCzZSJE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-lxsTvF6MOa6DNJO6C88fTQ-1; Tue, 23 Aug 2022 09:07:47 -0400
X-MC-Unique: lxsTvF6MOa6DNJO6C88fTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CDD43C0CD5A;
        Tue, 23 Aug 2022 13:07:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6817F40CFD0A;
        Tue, 23 Aug 2022 13:07:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/5] smb3: fix temporary data corruption in collapse range
From:   David Howells <dhowells@redhat.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org
Cc:     lsahlber@redhat.com, jlayton@kernel.org, dchinner@redhat.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, samba-technical@lists.samba.org
Date:   Tue, 23 Aug 2022 14:07:41 +0100
Message-ID: <166126006184.548536.12909933168251738646.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
References: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

collapse range doesn't discard the affected cached region
so can risk temporarily corrupting the file data. This
fixes xfstest generic/031

I also decided to merge a minor cleanup to this into the same patch
(avoiding rereading inode size repeatedly unnecessarily) to make it
clearer.

Cc: stable@vger.kernel.org
Fixes: 5476b5dd82c8b ("cifs: add support for FALLOC_FL_COLLAPSE_RANGE")
Reported-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
cc: Ronnie Sahlberg <lsahlber@redhat.com>
---

 fs/cifs/smb2ops.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 1c5a93ced946..75fcf6a0df56 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3669,41 +3669,47 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 {
 	int rc;
 	unsigned int xid;
-	struct inode *inode;
+	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
-	struct cifsInodeInfo *cifsi;
+	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	__le64 eof;
+	loff_t old_eof;
 
 	xid = get_xid();
 
-	inode = d_inode(cfile->dentry);
-	cifsi = CIFS_I(inode);
+	inode_lock(inode);
 
-	if (off >= i_size_read(inode) ||
-	    off + len >= i_size_read(inode)) {
+	old_eof = i_size_read(inode);
+	if ((off >= old_eof) ||
+	    off + len >= old_eof) {
 		rc = -EINVAL;
 		goto out;
 	}
 
+	filemap_invalidate_lock(inode->i_mapping);
 	filemap_write_and_wait(inode->i_mapping);
+	truncate_pagecache_range(inode, off, old_eof);
 
 	rc = smb2_copychunk_range(xid, cfile, cfile, off + len,
-				  i_size_read(inode) - off - len, off);
+				  old_eof - off - len, off);
 	if (rc < 0)
-		goto out;
+		goto out_2;
 
-	eof = cpu_to_le64(i_size_read(inode) - len);
+	eof = cpu_to_le64(old_eof - len);
 	rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 			  cfile->fid.volatile_fid, cfile->pid, &eof);
 	if (rc < 0)
-		goto out;
+		goto out_2;
 
 	rc = 0;
 
 	cifsi->server_eof = i_size_read(inode) - len;
 	truncate_setsize(inode, cifsi->server_eof);
 	fscache_resize_cookie(cifs_inode_cookie(inode), cifsi->server_eof);
+out_2:
+	filemap_invalidate_unlock(inode->i_mapping);
  out:
+	inode_unlock(inode);
 	free_xid(xid);
 	return rc;
 }


