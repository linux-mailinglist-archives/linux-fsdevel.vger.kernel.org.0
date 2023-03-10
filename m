Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2C6B52D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCJV2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjCJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D611FFB8;
        Fri, 10 Mar 2023 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z9Hw1mGNfrqQHCIlRf3ihFLF3C/I+Z1S5ZBLrVgW4dM=; b=DMkv1XQN3eU3rplZDSXZllZDRc
        x77HaULjFaRGtNKXZkoyQlAN9WAIrgfgafxWVcRX00sQZXkWJ9gLyMY/hfKPGwZyagpnBtv7hR6PY
        HWLHXTSqsV4bFud9duyV5lex3aBmP8YCtRpR5PGEIMAUVgn8lehz6SQI7TGUJflAHYAfIktioYMjq
        Qw1SlUPex4dxtIe+fUcfJxUAG//B72Yne2rnrafMp7+yW4a6nGqf8axapFSqmwaoMohj6+5u7ES3n
        8nMuKDIX8CKyfoZTy8hI+XVQ2SrXV2IH5FGxIgz5SuAYA5CNyQOXzLfDNObG+HdnMCCJpXgObJ3CC
        GD13aSsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHG-00FR6J-0E;
        Fri, 10 Mar 2023 21:27:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] bpf: switch to fdget_raw()
Date:   Fri, 10 Mar 2023 21:27:46 +0000
Message-Id: <20230310212748.3679076-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
References: <20230310212536.GX3390869@ZenIV>
 <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/bpf_inode_storage.c | 38 ++++++++++++++--------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 05f4c66c9089..85720311cc67 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -84,16 +84,13 @@ void bpf_inode_storage_free(struct inode *inode)
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_local_storage_data *sdata;
-	struct file *f;
-	int fd;
+	struct fd f = fdget_raw(*(int *)key);
 
-	fd = *(int *)key;
-	f = fget_raw(fd);
-	if (!f)
+	if (!f.file)
 		return ERR_PTR(-EBADF);
 
-	sdata = inode_storage_lookup(f->f_inode, map, true);
-	fput(f);
+	sdata = inode_storage_lookup(file_inode(f.file), map, true);
+	fdput(f);
 	return sdata ? sdata->data : NULL;
 }
 
@@ -101,22 +98,19 @@ static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 					 void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	struct file *f;
-	int fd;
+	struct fd f = fdget_raw(*(int *)key);
 
-	fd = *(int *)key;
-	f = fget_raw(fd);
-	if (!f)
+	if (!f.file)
 		return -EBADF;
-	if (!inode_storage_ptr(f->f_inode)) {
-		fput(f);
+	if (!inode_storage_ptr(file_inode(f.file))) {
+		fdput(f);
 		return -EBADF;
 	}
 
-	sdata = bpf_local_storage_update(f->f_inode,
+	sdata = bpf_local_storage_update(file_inode(f.file),
 					 (struct bpf_local_storage_map *)map,
 					 value, map_flags, GFP_ATOMIC);
-	fput(f);
+	fdput(f);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -135,16 +129,14 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 
 static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 {
-	struct file *f;
-	int fd, err;
+	struct fd f = fdget_raw(*(int *)key);
+	int err;
 
-	fd = *(int *)key;
-	f = fget_raw(fd);
-	if (!f)
+	if (!f.file)
 		return -EBADF;
 
-	err = inode_storage_delete(f->f_inode, map);
-	fput(f);
+	err = inode_storage_delete(file_inode(f.file), map);
+	fdput(f);
 	return err;
 }
 
-- 
2.30.2

