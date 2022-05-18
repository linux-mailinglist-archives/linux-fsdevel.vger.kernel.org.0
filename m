Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99152BCC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiERNWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 09:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiERNWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 09:22:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041B14AA42;
        Wed, 18 May 2022 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ihdUgHGtxRA6stOCfA5fnKVB7GMixDLtzRHuHbALlB8=; b=v3p1hKVhh7EK2y/rJO7fazBMbn
        GN9B+bx69HftB1ju+Jmp8ttle3b2cQD5TekZYjkbreJIpazJSS6cZeFxfmmWZa2eDRu0SVJFUxHRL
        vzkPksdYv9ETlr3UmN++A8Q0IQ9Vjg938iIPLDJ8kGwCdt0JkxoKKwkOcs0DJoge5Ccls0wlG72Kb
        NeZCC6AOi1u+P0xAiRbY8ZZlTenq3+s14TU39fJayiu37qcHsKAhXZBR0Rg8FBIhkogB21SDwuhZc
        eQ43GpC0nI5wcgcbK2UNuZvNJdDETUMe+9kM7xt2J49V31F9vODHSqdsyJVNrWE0JGKri1HEowl6E
        OqaoH+xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrJdJ-002HKN-PI; Wed, 18 May 2022 13:22:33 +0000
Date:   Wed, 18 May 2022 06:22:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] sparse: fix incorrect fmode_t casts
Message-ID: <YoTzGfqtbt1Bvemj@infradead.org>
References: <YoNDA0SOFjyoFlJS@infradead.org>
 <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fanotify and open.c changes looks fine, but should be split
into one each with a proper subject and description.

For procfs something simpler like the patch below might be a better
option:

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6aa..c07c6b51f0cb9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2237,13 +2237,13 @@ static struct dentry *
 proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
-	fmode_t mode = (fmode_t)(unsigned long)ptr;
+	const fmode_t *mode = ptr;
 	struct proc_inode *ei;
 	struct inode *inode;
 
 	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK |
-				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
-				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
+				    ((*mode & FMODE_READ ) ? S_IRUSR : 0) |
+				    ((*mode & FMODE_WRITE) ? S_IWUSR : 0));
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -2294,7 +2294,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 
 	if (vma->vm_file)
 		result = proc_map_files_instantiate(dentry, task,
-				(void *)(unsigned long)vma->vm_file->f_mode);
+				&vma->vm_file->f_mode);
 
 out_no_vma:
 	mmap_read_unlock(mm);
@@ -2391,7 +2391,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      &p->mode))
 			break;
 		ctx->pos++;
 	}
