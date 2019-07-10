Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0B64C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfGJTLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 15:11:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41642 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:11:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so1670039pls.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RBKExhVhuO8dUwdopkobYrfDp83fiSSvdj+BjPC70s=;
        b=j9c62XFEZ9kneeuEMtK85d/vkG2d0b3HHa2TZlXsQSuaSKSRug6eb1bl4cKUZZkmJK
         6IS8RZlqzhzFjwNz+zV5QgphhyNsbooUbliEaAnL4/k7y78mowllauMGCE5dCXCUR5+L
         thZKWFHCr6OTl+X4yZ6gTpNHZ3qUDwhE+4uFb5Kl6OwMqJTXO/DGXzNq1TGMG1BZkTdw
         HGxldShXjkSPmX1j5S9pdclx8uY3JXY7bNK29ZFVh0twxvORyjed8MOPePpt96DK/DaI
         5BDryfetRewi2JhNcZ3WsMMVy0mvAAX2JwEk1fsuD/9i0kMVR5sAqIqGyMl0WVWas+N/
         NEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RBKExhVhuO8dUwdopkobYrfDp83fiSSvdj+BjPC70s=;
        b=FhxmfzR0mcP7BRgmNc8zYMJf8DCMYPvzuotcItOPC77fwPzrMV6S1ghTGiBzFPUD4e
         mTeayC+G9+sMyVQNn4IetanVvvisMrWzJOw4EUmAAEPGn9IM8OPOrID1ezGhLFQvM14g
         rGxzv8lm6EUK3wFeotgAjD3qToDSFVER0yQgaWqmfmKwY1321/gtPVCPh/ss89JIiR9z
         20d0lSo2CyIzmkf06XtwCoE2sZ/7iGXvCIko6KSLJrJ1YprxEEku4Edmf1WJYeK2HZDX
         Bs4VOtIp16xEd4F2j01u7u54g+6vcePVl7L/YfgXVDQVQXlnudHs9E4BP+nOrYhJfbA9
         lbyA==
X-Gm-Message-State: APjAAAUbKi2lHWsp3LOYjbg6fNqppBPQoRyBOfCy4WMkt8OQv7vCBFm7
        VVFUEg5snhNvIMI44ONV6BZohw==
X-Google-Smtp-Source: APXvYqzFRRFWfxpescU3C0myEwOeav3RIPv9v2eiOwcuRGi+UKzV4Z/k6Bf+F4vc1CD5unHTdPoy5A==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr40889083plq.12.1562785878616;
        Wed, 10 Jul 2019 12:11:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id t11sm3066474pgb.33.2019.07.10.12.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:11:17 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:11:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 6/6] mm,thp: avoid writes to file with THP in pagecache
Message-ID: <20190710191116.GG11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-7-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:46PM -0700, Song Liu wrote:
> In previous patch, an application could put part of its text section in
> THP via madvise(). These THPs will be protected from writes when the
> application is still running (TXTBSY). However, after the application
> exits, the file is available for writes.
> 
> This patch avoids writes to file THP by dropping page cache for the file
> when the file is open for write. A new counter nr_thps is added to struct
> address_space. In do_last(), if the file is open for write and nr_thps
> is non-zero, we drop page cache for the whole file.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  fs/inode.c         |  3 +++
>  fs/namei.c         | 23 ++++++++++++++++++++++-
>  include/linux/fs.h | 32 ++++++++++++++++++++++++++++++++
>  mm/filemap.c       |  1 +
>  mm/khugepaged.c    |  4 +++-
>  5 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index df6542ec3b88..518113a4e219 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping->flags = 0;
>  	mapping->wb_err = 0;
>  	atomic_set(&mapping->i_mmap_writable, 0);
> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
> +	atomic_set(&mapping->nr_thps, 0);
> +#endif
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>  	mapping->private_data = NULL;
>  	mapping->writeback_index = 0;
> diff --git a/fs/namei.c b/fs/namei.c
> index 20831c2fbb34..3d95e94029cc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3249,6 +3249,23 @@ static int lookup_open(struct nameidata *nd, struct path *path,
>  	return error;
>  }
>  
> +/*
> + * The file is open for write, so it is not mmapped with VM_DENYWRITE. If
> + * it still has THP in page cache, drop the whole file from pagecache
> + * before processing writes. This helps us avoid handling write back of
> + * THP for now.
> + */
> +static inline void release_file_thp(struct file *file)
> +{
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) {
> +		struct inode *inode = file_inode(file);
> +
> +		if (inode_is_open_for_write(inode) &&
> +		    filemap_nr_thps(inode->i_mapping))
> +			truncate_pagecache(inode, 0);
> +	}
> +}
> +
>  /*
>   * Handle the last step of open()
>   */
> @@ -3418,7 +3435,11 @@ static int do_last(struct nameidata *nd,
>  		goto out;
>  opened:
>  	error = ima_file_check(file, op->acc_mode);
> -	if (!error && will_truncate)
> +	if (error)
> +		goto out;
> +
> +	release_file_thp(file);
> +	if (will_truncate)
>  		error = handle_truncate(file);

This would seem better placed in do_dentry_open(), where we're done
with the namespace operation and actually work against the inode.

Something roughly like this?

diff --git a/fs/open.c b/fs/open.c
index b5b80469b93d..cae893edbab6 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -799,6 +799,11 @@ static int do_dentry_open(struct file *f,
 		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
 			return -EINVAL;
 	}
+
+	/* XXX: Huge page cache doesn't support writing yet */
+	if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
+		truncate_pagecache(inode, 0);
+
 	return 0;
 
 cleanup_all:
