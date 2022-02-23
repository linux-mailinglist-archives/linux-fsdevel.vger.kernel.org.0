Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0149B4C0E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 09:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiBWIup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 03:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiBWIup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:50:45 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEF67804B
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 00:50:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q17so43267522edd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpfKLc99g2AFPaNgll4n6SEjyTg8UdxdMIQ94Ww8aqM=;
        b=OIbDrTlUvuyMg6rNiq7c57g+SKrXjLRR7n6ZdMWrCssWWLDi2jKpHDX6T9s9GSoqNd
         ruTn78V4szfzLVPVQmPja9+TVFg4wfHrTA0jhmslTmgxg1NgXV8AcRktrK8KhiIGfbjC
         FQDxxV85yh2//76ghd5IVwIZU9fht3S4D/f3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpfKLc99g2AFPaNgll4n6SEjyTg8UdxdMIQ94Ww8aqM=;
        b=dB3awSRV+dE/lI7HqhUDb3wGJ484z16xXpE4qGOKEgJw7Do6TYGKkci7YlVVO215CB
         3raN06akbRF/is8tCtjBLeOuKCYzvgfn9tcPDZxKriAtVP/lWyzfp8K760qCNG7z0Zoo
         yXBcjpb46wVroDegtSGTY9gUXgF9hwgN4/0eT+q1vZ8thO5FcOQ1c9GV+zFNUnbLduI6
         sjIlsaZ6LTekmYu9vFHEV3i5ZWHQ5gtZnmPEOGC0o4pb39to1nUpKCh+vAv79eZPtLHq
         CGTnCYZluz0TmPtPLJb7RY0yOCaPbAOm9qDFT65Bq40CP4q4Scvc96IRo2hcSMJuWhiz
         bl3w==
X-Gm-Message-State: AOAM532mRU4PtjFMBwcj40jYSOXP7xXUvhz1O58A7dYDzBFXZ+Bh35wg
        CZpePTwneQ4FL7HtT4uuotX44A==
X-Google-Smtp-Source: ABdhPJyRR4QwzCSZ0eUweZDNv61B0PjzkG3wmCpseV3m49uZfuDTOYBxrtCle8a06vl+py2/XiNfTQ==
X-Received: by 2002:aa7:d7c8:0:b0:3f9:3b65:f2b3 with SMTP id e8-20020aa7d7c8000000b003f93b65f2b3mr29820183eds.389.1645606212336;
        Wed, 23 Feb 2022 00:50:12 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id c11sm11836709edx.42.2022.02.23.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 00:50:12 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:50:10 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com
Subject: Re: [PATCH v2] fuse: fix deadlock between atomic O_TRUNC open() and
 page invalidations
Message-ID: <YhX1QlW87Hs/HS4h@miu.piliscsaba.redhat.com>
References: <20211229040239.66075-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229040239.66075-1-zhangjiachen.jaycee@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 29, 2021 at 12:02:39PM +0800, Jiachen Zhang wrote:
> fuse_finish_open() will be called with FUSE_NOWRITE set in case of atomic
> O_TRUNC open(), so commit 76224355db75 ("fuse: truncate pagecache on
> atomic_o_trunc") replaced invalidate_inode_pages2() by truncate_pagecache()
> in such a case to avoid the A-A deadlock. However, we found another A-B-B-A
> deadlock related to the case above, which will cause the xfstests
> generic/464 testcase hung in our virtio-fs test environment.
> 
> For example, consider two processes concurrently open one same file, one
> with O_TRUNC and another without O_TRUNC. The deadlock case is described
> below, if open(O_TRUNC) is already set_nowrite(acquired A), and is trying
> to lock a page (acquiring B), open() could have held the page lock
> (acquired B), and waiting on the page writeback (acquiring A). This would
> lead to deadlocks.
> 
> open(O_TRUNC)
> ----------------------------------------------------------------
> fuse_open_common
>   inode_lock            [C acquire]
>   fuse_set_nowrite      [A acquire]
> 
>   fuse_finish_open
>     truncate_pagecache
>       lock_page         [B acquire]
>       truncate_inode_page
>       unlock_page       [B release]
> 
>   fuse_release_nowrite  [A release]
>   inode_unlock          [C release]
> ----------------------------------------------------------------
> 
> open()
> ----------------------------------------------------------------
> fuse_open_common
>   fuse_finish_open
>     invalidate_inode_pages2
>       lock_page         [B acquire]
> 	fuse_launder_page
> 	  fuse_wait_on_page_writeback [A acquire & release]
>       unlock_page       [B release]
> ----------------------------------------------------------------
> 
> Besides this case, all calls of invalidate_inode_pages2() and
> invalidate_inode_pages2_range() in fuse code also can deadlock with
> open(O_TRUNC). This commit tries to fix it by adding a new lock,
> atomic_o_trunc, to protect the areas with the A-B-B-A deadlock risk.

Thanks.  Can you please try the following patch?  Instead of introducing a new
lock it tries to fix this by moving the truncate_pagecache() out of the nowrite
protected section.

Thanks,
Miklos

---
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..56f439719129 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -537,6 +537,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_file *ff;
 	void *security_ctx = NULL;
 	u32 security_ctxlen;
+	bool trunc = flags & O_TRUNC;
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
@@ -561,7 +562,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	inarg.mode = mode;
 	inarg.umask = current_umask();
 
-	if (fm->fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
+	if (fm->fc->handle_killpriv_v2 && trunc &&
 	    !(flags & O_EXCL) && !capable(CAP_FSETID)) {
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
@@ -623,6 +624,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	} else {
 		file->private_data = ff;
 		fuse_finish_open(inode, file);
+		if (fm->fc->atomic_o_trunc && trunc)
+			truncate_pagecache(inode, 0);
 	}
 	return err;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..2e041708ef44 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -210,7 +210,6 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		fi->attr_version = atomic64_inc_return(&fc->attr_version);
 		i_size_write(inode, 0);
 		spin_unlock(&fi->lock);
-		truncate_pagecache(inode, 0);
 		file_update_time(file);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
@@ -239,30 +238,32 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (err)
 		return err;
 
-	if (is_wb_truncate || dax_truncate) {
+	if (is_wb_truncate || dax_truncate)
 		inode_lock(inode);
-		fuse_set_nowrite(inode);
-	}
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, 0);
 		if (err)
-			goto out;
+			goto out_inode_unlock;
 	}
 
+	if (is_wb_truncate || dax_truncate)
+		fuse_set_nowrite(inode);
+
 	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
 	if (!err)
 		fuse_finish_open(inode, file);
 
-out:
+	if (is_wb_truncate | dax_truncate)
+		fuse_release_nowrite(inode);
+	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC))
+		truncate_pagecache(inode, 0);
 	if (dax_truncate)
 		filemap_invalidate_unlock(inode->i_mapping);
-
-	if (is_wb_truncate | dax_truncate) {
-		fuse_release_nowrite(inode);
+out_inode_unlock:
+	if (is_wb_truncate | dax_truncate)
 		inode_unlock(inode);
-	}
 
 	return err;
 }
