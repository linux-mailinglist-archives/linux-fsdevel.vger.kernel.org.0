Return-Path: <linux-fsdevel+bounces-9959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B9C84670F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 05:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D23B26B5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D7F9D3;
	Fri,  2 Feb 2024 04:43:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDD171A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848997; cv=none; b=UkytkxfYU9rJd2TEAbj3umGYk5h5mQKN0bTwxAb2KHrX1fCF3r69a+w5/JbRZoBJsOA0mlr4Fzr9NQRN6+LcllfCTtiKuZJNewL78wjQjNzXfiLJk9TmCJz7oPRExhgL9qaFz43qBFC5R0XXypNNcxY/83nw4KwtugC3/aqsxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848997; c=relaxed/simple;
	bh=KbBjZy9iycVf4ojBY1It8CEOUxZ9lKWWvYcer608C4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd0toiHkI4aDyKyi0axfW/QP1GASbFxXsKAcXJ3KSqj3QIbcoqxt5h7fqPC7lzkozMgvD50ZwMpJbQQ5c+62IyV0bbqUxV9+CFNbW7x/FMVya8t5rtd1yUrATv/I/jA1b6tStAcmJ+tTyJhXYN4zKTCnNU6ykuiPkvPuIdUhumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c3a14c6e7so8129336d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 20:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706848993; x=1707453793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpbVH2T0wltjnZkqMBBaWFJ/E+D1lvYVrdtxC3+idLI=;
        b=Cao3fRsV/qTxAOwjTgTPEJwzjECfFd3FDBFjket8O1RM7nNFC2ElBBnNq07bfeT4rC
         2wkkrDFGVEBx9gkXffzNYDXcBkyvTHHzBaZgSbQL71Fg1Lz8KQFbaK3sk3kUFHf4WHsM
         ZZaT5mmOwC3lEsOf3ztOsDDd9uh5ReiR1e89mOs738Ufn1zTTMHfgMDQl3n979q+AlQK
         it13vgsIzW2pt+jk+iKFSv91wwvSuAJ8G5tynbS0CszGTpWEOTH66h37VW5L+R5WZjPa
         kWNrVCkRmu82Aov8LBhOQhcu5zgoYcziztDLJc0l7xT1FHCCfFm4u5JR7snm9m26Gmdv
         xPIQ==
X-Gm-Message-State: AOJu0YxUaolEi4zfJGg+BSjihBacbPgpVjnqMav2y4667EkGZL9Ocwxf
	QSuyS5n6ifqT7LUm+YqvNVxUpUQg/nFXUeUvRCL1QHREtJgU6Ldn1oeTuBRVJw==
X-Google-Smtp-Source: AGHT+IFkfgQQl6ScAsRKVY+kYHICcKa/8Aap2tR0uxRTjTowwMAG4fOOLe8DmmPudwYqaj/ngdwZLg==
X-Received: by 2002:a0c:f108:0:b0:68c:668d:a671 with SMTP id i8-20020a0cf108000000b0068c668da671mr4471350qvl.7.1706848993232;
        Thu, 01 Feb 2024 20:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxDF2cihEXJ7LLzKJJwE8WhiB/Szmvo9Pe1CG4D9R9oobsPLZeUSaO5F9I3teoYkkwNRR5KARS2kmo9oi0op83C2LvpaP92YiLP7SfHSJO1yjkSSlxuWtHz93m/pz2sn0fUp4R9bukGtCaTO7NoHy04nmhtq+5fAMiiXiG29p3pZwLqMoe9HqhYlefxKyUuyk3v5rbhd1IKj5Ljp7JyEkvNXKMgxfVNWfnzCfPacOkCbu5Y8VQO/LOIo2Eo8gTBbVDxi+2BIshKNIpFwMUeS1j0yb1UA1wKJLj+bd1B/1dk5LpzqLrbrxkOkJj8JLUusqbnVer9+fQNEUjPNwI8cCARRTFm1k4KqrlfosUuITU/g==
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05620a198d00b0078409ed9030sm384126qkb.124.2024.02.01.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 20:43:12 -0800 (PST)
Date: Thu, 1 Feb 2024 23:43:11 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: mm/madvise: set ra_pages as device max request size during
 ADV_POPULATE_READ
Message-ID: <Zbxy30POPE8rN_YN@redhat.com>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202022029.1903629-1-ming.lei@redhat.com>

On Thu, Feb 01 2024 at  9:20P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> madvise(MADV_POPULATE_READ) tries to populate all page tables in the
> specific range, so it is usually sequential IO if VMA is backed by
> file.
> 
> Set ra_pages as device max request size for the involved readahead in
> the ADV_POPULATE_READ, this way reduces latency of madvise(MADV_POPULATE_READ)
> to 1/10 when running madvise(MADV_POPULATE_READ) over one 1GB file with
> usual(default) 128KB of read_ahead_kb.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Don Dutile <ddutile@redhat.com>
> Cc: Rafael Aquini <raquini@redhat.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  mm/madvise.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 912155a94ed5..db5452c8abdd 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -900,6 +900,37 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  		return -EINVAL;
>  }
>  
> +static void madvise_restore_ra_win(struct file **file, unsigned int ra_pages)
> +{
> +	if (*file) {
> +		struct file *f = *file;
> +
> +		f->f_ra.ra_pages = ra_pages;
> +		fput(f);
> +		*file = NULL;
> +	}
> +}
> +
> +static struct file *madvise_override_ra_win(struct file *f,
> +		unsigned long start, unsigned long end,
> +		unsigned int *old_ra_pages)
> +{
> +	unsigned int io_pages;
> +
> +	if (!f || !f->f_mapping || !f->f_mapping->host)
> +		return NULL;
> +
> +	io_pages = inode_to_bdi(f->f_mapping->host)->io_pages;
> +	if (((end - start) >> PAGE_SHIFT) < io_pages)
> +		return NULL;
> +
> +	f = get_file(f);
> +	*old_ra_pages = f->f_ra.ra_pages;
> +	f->f_ra.ra_pages = io_pages;
> +
> +	return f;
> +}
> +

Does this override imply that madvise_populate resorts to calling
filemap_fault() and here you're just arming it to use the larger
->io_pages for the duration of all associated faulting?

Wouldn't it be better to avoid faulting and build up larger page
vectors that get sent down to the block layer in one go and let the
block layer split using the device's limits? (like happens with
force_page_cache_ra)

I'm concerned that madvise_populate isn't so efficient with filemap
due to excessive faulting (*BUT* I haven't traced to know, I'm just
inferring that is why twiddling f->f_ra.ra_pages helps improve
madvise_populate by having it issue larger IO. Apologies if I'm way
off base)

Mike

