Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5241D50B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfFXMtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 08:49:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34250 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfFXMtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:49:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so21668018edb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GO2oBSDlPl0PNRYpRAnBbZVvBmybpqwS00Has79olYk=;
        b=rK1fCVjro0ij0GY/+VmDa/DZKR+COsmWCeos7/Mw946RphPMrKr5mg9az3IsT3y++Y
         ZQnjSo1yDT9CeRpH++R+6uudXOuGpxZ6ouEp1OO+tcQ8QYKslWyDjoQD7nfVXstHh4Nm
         ZcEnUf1XxbmrYZmYczc5DNmFV349K8x1UTCIeinfMDSQYe0VCgaNOKER6vB8DAWiyJ4c
         oPKVW+X0co8AsiLlaF1hnbjq9I9YFpmk53bmhZl0/FgP5+v+Z4b+Uuz9sJNtGlqG+Z5c
         fTTqIU3ihnunnjAq0x22EnO3IVDCDiA13XWfT8AEcvtFd2QMGB2nvcNfjtPnqTGwP5VO
         U7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GO2oBSDlPl0PNRYpRAnBbZVvBmybpqwS00Has79olYk=;
        b=qy1aj1ETc3mWvrj4xYez/ZNwHyv13XZwOeQUdGaGayDnhyWg4hCj6zINE6Z0X2WvOs
         n5Hrn5ugoomKDnG432WFVKbNuWenGJrZayIqvD0Hf451TtWcpsPIJN/oxBYjYavdw6dh
         3Av645Xh72drPU+Y8HwVCbf7LHYw+8ctAIeD7WGMZpNRdrvNn4wVJjGk4SAFgr9OHyeW
         vIDlbHTOCAbS4vBjsdz5LAJaoZAVaiDZzhXRbrdsRVNoithgiX0VSZjQoAHymZXk3zuf
         rSrJufmHWPjutB6LMgxeOAF1nP45blC8vtGFoksGAVoBHDBWIfEwhMWagmCTxuLjP6bI
         Uksw==
X-Gm-Message-State: APjAAAUaj8+yUfU4u2aMmETAVGmyuf4kbtFMOFHQLjjAT1/1LDctTEgV
        Wng8SiJyaPSP+X6OXR/MmsrAgQ==
X-Google-Smtp-Source: APXvYqyp72hr1uxp/CILmlYg6sj6ztU4rrUmEIE/YZVKldHuBkXQ0HHxrQ0g87k/RrqZ4HGv20IDAw==
X-Received: by 2002:a17:906:c106:: with SMTP id h6mr82142308ejz.112.1561380571354;
        Mon, 24 Jun 2019 05:49:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f36sm3693648ede.47.2019.06.24.05.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:49:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1BE4210439E; Mon, 24 Jun 2019 15:49:36 +0300 (+03)
Date:   Mon, 24 Jun 2019 15:49:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v7 6/6] mm,thp: avoid writes to file with THP in pagecache
Message-ID: <20190624124936.2vq55jc3qstxrujj@box>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623054749.4016638-7-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 22, 2019 at 10:47:49PM -0700, Song Liu wrote:
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
>  fs/namei.c         | 22 +++++++++++++++++++++-
>  include/linux/fs.h | 32 ++++++++++++++++++++++++++++++++
>  mm/filemap.c       |  1 +
>  mm/khugepaged.c    |  4 +++-
>  5 files changed, 60 insertions(+), 2 deletions(-)
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

Please, use IS_ENABLED() where it is possible.


-- 
 Kirill A. Shutemov
