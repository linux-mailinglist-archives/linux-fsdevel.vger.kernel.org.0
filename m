Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436AD778768
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjHKG1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHKG1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:27:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1AF2D4F
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:27:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-586a3159588so24269977b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691735230; x=1692340030;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjSC6ORUGqX5v9IH/a5QjzTjJ0xPrBuZ4pptH8o9IgM=;
        b=Ne5/1/YuoznmAWP9saoti+yPi0jnWl9VKghSRaCnRpWZ7kNaigo131ld1R4sZCWXqM
         xtptL/obzPWlxsXVucEc3oZ4xmUq5seUpUn98/zCzzLrVv3rEWkugM13AkU/qG6VX1dm
         y/JYsycPB7FgCJHOFC9703Kyw3lew4kxX3gDdpeTK6ormuMaU8wtH2CfpSRrsHn2f570
         D0BkT8Y5oGI3Ie+WE6RJXuJ/xOAbo9z6es7jdLyxTRRXwUKS7Rz85MukUwZaLlw/rwDi
         BkR60JRKmE0fy31UnWWmQcytaMlzBzyIoXN2ooIB4VemfkZPzGKD64GxN2uoWeL+Lmae
         TKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691735230; x=1692340030;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjSC6ORUGqX5v9IH/a5QjzTjJ0xPrBuZ4pptH8o9IgM=;
        b=P898eT6bkdzgihmP1G46W7ohtfOT7pHlh/QwBTiCBw2jEzW30hOvkhXv82zIjN6qtL
         FEeUUCLWCgUEbNUq99aY4078Qsr0ArjUu8IDKHft/NfOxC31DKqYIgi9xdhTUWNN6yBG
         N7WY3EDcRYSWaivHw5GgCjOrsfX/Gchnxi+GpVb9PGHHJ0n3GFvA/7xwyRaBkAS9YiSm
         4PXMF9MWjvLzGzsY5vQ/8yemNs4Snmyhhv+z2OGYzSWRLxDcsWvKBvaAbue5UUWHVRMu
         EjGfMez5saXttL7zbj7Nek21tqz2GEF7dAHciISGmvqJD5dGAewfzWK4JoOt6j+tXAEP
         HI3A==
X-Gm-Message-State: AOJu0Yxr3w5stfeFQnXb3Tk7h3oAubuWpaxoI+vzOctlAS8/NB4aD5sg
        qyIjYkQNkJqD+4WMMgfhJfIs6w==
X-Google-Smtp-Source: AGHT+IEmm8MWAaG7syMMW88reDhcEhTyiYTMB0u94NqgqZhkO7TO6fu1NBNpSAC8ZfvcJtoyRS37fA==
X-Received: by 2002:a0d:d4c9:0:b0:579:e6e4:a165 with SMTP id w192-20020a0dd4c9000000b00579e6e4a165mr5056049ywd.10.1691735230373;
        Thu, 10 Aug 2023 23:27:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h123-20020a0df781000000b0055a373a7e5asm817227ywf.131.2023.08.10.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:27:09 -0700 (PDT)
Date:   Thu, 10 Aug 2023 23:27:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs v2 4/5] tmpfs: trivial support for direct IO
In-Reply-To: <7c12819-9b94-d56-ff88-35623aa34180@google.com>
Message-ID: <6f2742-6f1f-cae9-7c5b-ed20fc53215@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <7c12819-9b94-d56-ff88-35623aa34180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Depending upon your philosophical viewpoint, either tmpfs always does
direct IO, or it cannot ever do direct IO; but whichever, if tmpfs is to
stand in for a more sophisticated filesystem, it can be helpful for tmpfs
to support O_DIRECT.  So, give tmpfs a shmem_file_open() method, to set
the FMODE_CAN_ODIRECT flag: then unchanged shmem_file_read_iter() and new
shmem_file_write_iter() do the work (without any shmem_direct_IO() stub).

Perhaps later, once the direct_IO method has been eliminated from all
filesystems, generic_file_write_iter() will be such that tmpfs can again
use it, even for O_DIRECT.

xfstests auto generic which were not run on tmpfs before but now pass:
036 091 113 125 130 133 135 198 207 208 209 210 211 212 214 226 239 263
323 355 391 406 412 422 427 446 451 465 551 586 591 609 615 647 708 729
with no new failures.

LTP dio tests which were not run on tmpfs before but now pass:
dio01 through dio30, except for dio04 and dio10, which fail because
tmpfs dio read and write allow odd count: tmpfs could be made stricter,
but would that be an improvement?

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Thanks for your earlier review, Jan: I've certainly not copied that
into this entirely different version.  I prefer the v1, but fine if
people prefer this v2.

 mm/shmem.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ca43fb256b8e..b782edeb69aa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2388,6 +2388,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int shmem_file_open(struct inode *inode, struct file *file)
+{
+	file->f_mode |= FMODE_CAN_ODIRECT;
+	return generic_file_open(inode, file);
+}
+
 #ifdef CONFIG_TMPFS_XATTR
 static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
 
@@ -2839,6 +2845,28 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval ? retval : error;
 }
 
+static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto unlock;
+	ret = file_remove_privs(file);
+	if (ret)
+		goto unlock;
+	ret = file_update_time(file);
+	if (ret)
+		goto unlock;
+	ret = generic_perform_write(iocb, from);
+unlock:
+	inode_unlock(inode);
+	return ret;
+}
+
 static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
 			      struct pipe_buffer *buf)
 {
@@ -4434,12 +4462,12 @@ EXPORT_SYMBOL(shmem_aops);
 
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
-	.open		= generic_file_open,
+	.open		= shmem_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
 	.llseek		= shmem_file_llseek,
 	.read_iter	= shmem_file_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.write_iter	= shmem_file_write_iter,
 	.fsync		= noop_fsync,
 	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-- 
2.35.3
