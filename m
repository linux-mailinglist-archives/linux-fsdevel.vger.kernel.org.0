Return-Path: <linux-fsdevel+bounces-6812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5681D23F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 05:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1912847BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 04:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F314C69;
	Sat, 23 Dec 2023 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XA7GeR34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5E46A2;
	Sat, 23 Dec 2023 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BoDmPVS6ryId1Ndy9LNLIvaAlql/jHh5ljsjLKW2LUQ=; b=XA7GeR34AQ1sEHRKpLPEfIWkvw
	95V4/LUiY0glq+hos8RQbJbObvWwotsc42i0s8HtQAKMV1CnrAj51LhLYmrwv3loMGQ82pjaVtDzy
	sUecbuul7gISNrsiCGG2Ru/11OXVdkMSk7YhKNxgmKvhS19fINbutN89VqcgzAjplLh5MMgrwjpFl
	QBe3W8QoOytAbHjh7VeH9Y1BwnDooJ5AqHWDJjDu75kYln121NpYu9r9HgGwe7b63ABsWXEzosY9T
	4m0knNig6lmNyOreYULUJ3hPZYQ/hHLdwYKvsbF4sd4m792N4OFes+2LeqTP7wMoBqwqm73vx+edn
	ejt+ebBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGtts-009rnh-F2; Sat, 23 Dec 2023 04:46:12 +0000
Date: Sat, 23 Dec 2023 04:46:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] fs/ntfs3: Use kvmalloc instead of kmalloc(...
 __GFP_NOWARN)
Message-ID: <ZYZmFPnJAM3aJLlF@casper.infradead.org>
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
 <890222ac-1bd2-6817-7873-390801c5a172@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <890222ac-1bd2-6817-7873-390801c5a172@paragon-software.com>

On Mon, Jul 03, 2023 at 11:26:36AM +0400, Konstantin Komarov wrote:
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

So, um, why?  I mean, I know what kvmalloc does, but why do you want to
do it?  Also, this is missing changes from kfree() to kvfree() so if
you do end up falling back to vmalloc, you'll hit a bug in kfree().

> +++ b/fs/ntfs3/attrlist.c
> @@ -52,7 +52,8 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct
> ATTRIB *attr)
> 
>      if (!attr->non_res) {
>          lsize = le32_to_cpu(attr->res.data_size);
> -        le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
> +        /* attr is resident: lsize < record_size (1K or 4K) */
> +        le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
>          if (!le) {
>              err = -ENOMEM;
>              goto out;

This one should be paired with a kvfree in al_destroy(), I think.

> diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
> index 107e808e06ea..d66055e30aff 100644
> --- a/fs/ntfs3/bitmap.c
> +++ b/fs/ntfs3/bitmap.c
> @@ -659,7 +659,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block
> *sb, size_t nbits)
>          wnd->bits_last = wbits;
> 
>      wnd->free_bits =
> -        kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
> +        kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
> +
>      if (!wnd->free_bits)
>          return -ENOMEM;
> 

This one with wnd_close() and of course later in wnd_init().

> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index da739e509269..0034952b9ccd 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1373,7 +1373,7 @@ static int ntfs_fill_super(struct super_block *sb,
> struct fs_context *fc)
>      }
> 
>      bytes = inode->i_size;
> -    sbi->def_table = t = kmalloc(bytes, GFP_NOFS | __GFP_NOWARN);
> +    sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
>      if (!t) {
>          err = -ENOMEM;
>          goto put_inode_out;

And this one with ntfs3_free_sbi()

