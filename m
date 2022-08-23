Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5309159E7AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbiHWQkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiHWQjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4B6BCC6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3i5wVY9ochj5YmCQFYqh+DQ+Bg9CInRp2iKPoE27ps=;
        b=crCKmuS6jOVit3gyEo1kzTe0QwkYYLuvmzeNld3mlXzO4tdKHdfb79Pt0ieIAgufwrpSuL
        voEOW4PKnX48t/MqRzlwJnOK9F+7GGM1hYdHfH5PSxPQ9/bK5YgRoQNl7hgVZ+ktfmFtp1
        XUdYNYRIR1uffYVodrTHagE8vKAHWOc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98--U2nptawM7S0xhEt02RCBA-1; Tue, 23 Aug 2022 09:07:57 -0400
X-MC-Unique: -U2nptawM7S0xhEt02RCBA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D1433806650;
        Tue, 23 Aug 2022 13:07:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB52492C3B;
        Tue, 23 Aug 2022 13:07:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] smb3: fix temporary data corruption in insert range
From:   David Howells <dhowells@redhat.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org
Cc:     lsahlber@redhat.com, jlayton@kernel.org, dchinner@redhat.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, samba-technical@lists.samba.org
Date:   Tue, 23 Aug 2022 14:07:55 +0100
Message-ID: <166126007561.548536.12315282792952269215.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
References: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

insert range doesn't discard the affected cached region
so can risk temporarily corrupting file data.

Also includes some minor cleanup (avoiding rereading
inode size repeatedly unnecessarily) to make it clearer.

Cc: stable@vger.kernel.org
Fixes: 7fe6fe95b9360 ("cifs: FALLOC_FL_INSERT_RANGE support")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
cc: Ronnie Sahlberg <lsahlber@redhat.com>
---

 fs/cifs/smb2ops.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 5b5ddc1b4638..00c8d6a715c7 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3722,35 +3722,43 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 	struct cifsFileInfo *cfile = file->private_data;
 	struct inode *inode = file_inode(file);
 	__le64 eof;
-	__u64  count;
+	__u64  count, old_eof;
+
+	inode_lock(inode);
 
 	xid = get_xid();
 
-	if (off >= i_size_read(inode)) {
+	old_eof = i_size_read(inode);
+	if (off >= old_eof) {
 		rc = -EINVAL;
 		goto out;
 	}
 
-	count = i_size_read(inode) - off;
-	eof = cpu_to_le64(i_size_read(inode) + len);
+	count = old_eof - off;
+	eof = cpu_to_le64(old_eof + len);
 
+	filemap_invalidate_lock(inode->i_mapping);
 	filemap_write_and_wait(inode->i_mapping);
+	truncate_pagecache_range(inode, off, old_eof);
 
 	rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 			  cfile->fid.volatile_fid, cfile->pid, &eof);
 	if (rc < 0)
-		goto out;
+		goto out_2;
 
 	rc = smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
-		goto out;
+		goto out_2;
 
-	rc = smb3_zero_range(file, tcon, off, len, 1);
+	rc = smb3_zero_data(file, tcon, off, len, xid);
 	if (rc < 0)
-		goto out;
+		goto out_2;
 
 	rc = 0;
+out_2:
+	filemap_invalidate_unlock(inode->i_mapping);
  out:
+	inode_unlock(inode);
 	free_xid(xid);
 	return rc;
 }


