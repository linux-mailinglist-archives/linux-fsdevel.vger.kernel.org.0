Return-Path: <linux-fsdevel+bounces-23933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2C934FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E299E1F215CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077E1442F0;
	Thu, 18 Jul 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EuNzPYco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0B14386E
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316261; cv=none; b=b4hY4ydQWV0DuAKVWdAE7jSPNqrWUsYaTUK3emLW//wO9N80ujDMeTnDOSIJio5F50Yy45EkOK/QNcwc6EzVysh7ZYY5yiqZNj6qQXfbhIbhK8eQqvclfA4wIHi3JwdWsHfvrGd59q75Whz6C/5bPMNh0tKWZ3SF1u97CbxQNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316261; c=relaxed/simple;
	bh=R4sVJBIk5/OEw5l+h23axEodYkhZhN3yRAaIqw/cXbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfq3chyW8G4po5xGaLeeRmTkO0NBmd413ntsdKn6OLd8JjUW5FaVYAsZU2m8CZi6n7Q1qgIXqZ4/fCSBNnB8W1UTQaqS3vECf1MXkxjf469WjENz3wu9hklnI5FPgvlTM1bYxonjP0ltnEL9NFn95Fk0q4gvPEufn91XXo4+ZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EuNzPYco; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0857a11862so420492276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721316259; x=1721921059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7dYGw8oqfQqjURLf6tbzMbsz8HNDTpgsoT30qX1hdc=;
        b=EuNzPYcoQ/A9EqEkUB/m5js4Qdfyxh6UhaNUN69yZuK7ZsNwOQ93BWViaH6X9tND+Z
         /R/tgo/Nke48BNDAdNQA2spvv9Uv5HIast94zloBkhX2Yn9HxQUcw88/qaaCy2ekQf9j
         o8k/blaKzu2hAqSPml8KDT2hgcgVFrClCfe5RuvxEoQ1KF0HVToWCt6VuF/uSVbIirav
         ejLUFDuTXMfCP2qbWNgIINZpOiVeoogewU+NTSn/7ECyF+aFc0n+6InWSg4RjwbvHQPu
         yUuIWMK6KZ34sVZg0ETee/lHllNlWtkH7KsmEf7c0AxmCuUVVZI2LNAlqE/9c2EPyl9F
         l01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316259; x=1721921059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7dYGw8oqfQqjURLf6tbzMbsz8HNDTpgsoT30qX1hdc=;
        b=TMBQR1juaOkYGuEZIMwUaUX+h6LJKLEYZ/9YMRCgYWGSPbvNXJ+XADyFmBkIlvveRn
         EhAFaXvuBkq5Yxf6RRVct1UAmzzXvXr5aMy+VpyQjm/Hjl6+ywtoC7VhjOJ2IxAryQ7U
         MqGJy2p2bhX+cXCFe83ydk3Jiqc9QNJS5BGj2n5KR3ozOF6NWaXGzm56j3XDhmrbUjC/
         wkYpXAcXeVoDvk9/m2VmxqPF0m2uNZ/xJaZrO56B+rWig1ZJoSVSmJS2fmT4Gd1gDahl
         uSAwpFmfySQxGtImWuScgTUx1dcXyyU0jc8nk+/pCMAq3sfNtclw2eDi+L1daXEW0TVx
         ahXQ==
X-Gm-Message-State: AOJu0YzFrXh9iM7GdfhgtE3AJcVHIPTzZnH0HGAVCOL9SLP7qWatBAdU
	Qr79Q4J6hDyqdVrvG/1HlkRBXWBiF3FGfBP3sDTzW658ursay/tXJpMYByHS58l41+LWeCQ3HMW
	8
X-Google-Smtp-Source: AGHT+IHcFnw3hyCKnARicEPpjSubWL8Noot7+/8sN0R5RewAwpnJC7xqfqlGtD4KUjdEHb1HrGZ4lQ==
X-Received: by 2002:a05:6902:18d5:b0:dff:1dfd:c2e1 with SMTP id 3f1490d57ef6-e05ed6b68c3mr6661226276.11.1721316258700;
        Thu, 18 Jul 2024 08:24:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05fea2687esm364316276.23.2024.07.18.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:24:18 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:24:17 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] Convert write_begin / write_end to take a folio
Message-ID: <20240718152417.GB2099026@perftesting>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>

On Wed, Jul 17, 2024 at 04:46:50PM +0100, Matthew Wilcox (Oracle) wrote:
> You can find the full branch at
> http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
> aka
> git://git.infradead.org/users/willy/pagecache.git write-end
> 
> On top of the ufs, minix, sysv and qnx6 directory handling patches, this
> patch series converts us to using folios for write_begin and write_end.
> That's the last mention of 'struct page' in several filesystems.
> 
> I'd like to get some version of these patches into the 6.12 merge
> window.
> 
> Matthew Wilcox (Oracle) (23):
>   reiserfs: Convert grab_tail_page() to use a folio
>   reiserfs: Convert reiserfs_write_begin() to use a folio
>   block: Use a folio in blkdev_write_end()
>   buffer: Use a folio in generic_write_end()
>   nilfs2: Use a folio in nilfs_recover_dsync_blocks()
>   ntfs3: Remove reset_log_file()
>   buffer: Convert block_write_end() to take a folio
>   ecryptfs: Convert ecryptfs_write_end() to use a folio
>   ecryptfs: Use a folio in ecryptfs_write_begin()
>   f2fs: Convert f2fs_write_end() to use a folio
>   f2fs: Convert f2fs_write_begin() to use a folio
>   fuse: Convert fuse_write_end() to use a folio
>   fuse: Convert fuse_write_begin() to use a folio
>   hostfs: Convert hostfs_write_end() to use a folio
>   jffs2: Convert jffs2_write_end() to use a folio
>   jffs2: Convert jffs2_write_begin() to use a folio
>   orangefs: Convert orangefs_write_end() to use a folio
>   orangefs: Convert orangefs_write_begin() to use a folio
>   vboxsf: Use a folio in vboxsf_write_end()
>   fs: Convert aops->write_end to take a folio
>   fs: Convert aops->write_begin to take a folio
>   ocfs2: Convert ocfs2_write_zero_page to use a folio
>   buffer: Convert __block_write_begin() to take a folio

I applied and reviewed this, the per-fs stuff obviously I'm less familiar with,
I mostly just validated it was 1:1 conversion and that the behavior matched the
previous behavior.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef

