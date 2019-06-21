Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDCC4E885
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFUNHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 09:07:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40861 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfFUNHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:07:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so10036453eds.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/K0/kvf7+EWXr6rQfoz7UxMfktgW7/4j5Pgej3x77XM=;
        b=PAE6OEZ8NC/qeGpE32S7WnaYR8nyncYe408Jq0CgpSEX5qzdvqxgDZs5ZCZwf9z2M/
         MfmA07u7v2Dcvj6N9Gc4vkUdsz3EIDYCqEMeeoBYxLeIb/y9bGSed3H8d9o3PlC4Ytxn
         oA+VlnKMSsS7quvovP4p8aKwmbYWhZkd0zTnk3u9Du+67+nLBJwp5bknGKkUG+ONwhjz
         tkTJX8Bq4oIKNeZVi+bbrVcdMW8Y1t9Y67TTb0mrmwBheAxfAtMwJDljsYfa7Ogu0jLk
         RAaOEsejUFYQQpQXuZEuxRWQuaGtNp10HL9BRM8wQxljKfSAywRlF4E5te+9lTIG2AOz
         S/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/K0/kvf7+EWXr6rQfoz7UxMfktgW7/4j5Pgej3x77XM=;
        b=cUZ77H6lxdKBudchOaXrXJYI7PjlRJOpgGMLGQSYvzyqcr8pUgeZu+/RJu9z4m23G9
         e0I7a/XB9nL2MMjb3pW7AP6kq7m2tH8bAv3rZ3C0mCldP2WZlUTUiFo9QfU/ogi3aOA6
         gLeq9pYtV2fDAa14SF6FFwa2IfwpDhxQZpO+x8f0oIebhZpKPu0oiYooQos1VH8bRJur
         sLhEf9vnwg6XNMjee3Z4W4bT9WBsBcYIHoJUkPaGyx2hNF8vAiRyUuRG0/2HiYZQMlO/
         dO8FAITTn6IIDTtrmHkdan9b0QnFrHYMr8rW7c98vmC2fCZgfB2TDKlJyiHdYCRVe1Zj
         82ZA==
X-Gm-Message-State: APjAAAXUns31nwOK2khBapzRAc2hrX92YX9konthC06+2jxJxZVqdvmS
        tQGNllJknpOUWyNT9JSVi5seLg==
X-Google-Smtp-Source: APXvYqwSIu9UphVAwE3sOjCJhhXK/jVAbMQD+iKQGW5Qdf6dAWE8bX5wKC8SIAJa13mOWwqqReekHg==
X-Received: by 2002:a50:913c:: with SMTP id e57mr95497578eda.257.1561122459409;
        Fri, 21 Jun 2019 06:07:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e12sm813636edb.72.2019.06.21.06.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:07:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C59BE10289C; Fri, 21 Jun 2019 16:07:40 +0300 (+03)
Date:   Fri, 21 Jun 2019 16:07:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org
Subject: Re: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in pagecache
Message-ID: <20190621130740.ehobvjjj7gjiazjw@box>
References: <20190620205348.3980213-1-songliubraving@fb.com>
 <20190620205348.3980213-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205348.3980213-7-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 01:53:48PM -0700, Song Liu wrote:
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
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  fs/inode.c         |  3 +++
>  fs/namei.c         | 22 +++++++++++++++++++++-
>  include/linux/fs.h | 31 +++++++++++++++++++++++++++++++
>  mm/filemap.c       |  1 +
>  mm/khugepaged.c    |  4 +++-
>  5 files changed, 59 insertions(+), 2 deletions(-)
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
> index 20831c2fbb34..de64f24b58e9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3249,6 +3249,22 @@ static int lookup_open(struct nameidata *nd, struct path *path,
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
> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
> +	struct inode *inode = file_inode(file);
> +
> +	if (inode_is_open_for_write(inode) && filemap_nr_thps(inode->i_mapping))
> +		truncate_pagecache(inode, 0);
> +#endif
> +}
> +
>  /*
>   * Handle the last step of open()
>   */
> @@ -3418,7 +3434,11 @@ static int do_last(struct nameidata *nd,
>  		goto out;
>  opened:
>  	error = ima_file_check(file, op->acc_mode);
> -	if (!error && will_truncate)
> +	if (error)
> +		goto out;
> +
> +	release_file_thp(file);

What protects against re-fill the file with THP in parallel?


-- 
 Kirill A. Shutemov
