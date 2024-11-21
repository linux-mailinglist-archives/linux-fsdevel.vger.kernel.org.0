Return-Path: <linux-fsdevel+bounces-35489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7569D557F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DE91F24334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157781AAE06;
	Thu, 21 Nov 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fT4/D4ML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A15695
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228337; cv=none; b=cRkBeCkVpdErbVyiezhkkY+M9yBJkhHgUw9pxXSnCSr5vfM9zJfK7TEJap8sHNQuLss4GAwH5Vbqw3lwmCvCC5JpETCJuJQ+gB9vCpZpU/pcSGEJuRvkHl03sTWJFvIph4fR7CZmpCcSc4Ea1dMXr80p+386oCgZrtil9+teDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228337; c=relaxed/simple;
	bh=L+jgTcZZ7/PNczPhM5S9MmCk+Byla2giQN0PGmjcmBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Neku1u3mNsnAQ5MDZxZCuOiJ2MmbCWThKHG4/Mzu1+dLdXqyJ8QFZ9tHQzab2zALGwiXWElA8mparw085ezvTmgsloWeLT9t0MxZY97V2U2lL2TFDL286qFQGXr7cLCE8DHP56jkqhoKH2wXD01ucJTWNl5h95ec+VzS4PbkBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fT4/D4ML; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ee55cfa88cso13154567b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732228335; x=1732833135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=br4Z4jmJKM2k8q9ejgtU2VhhTuKOW9xE5Y6pOSf2atw=;
        b=fT4/D4MLpxypeBxq5bRUp3asGN7FwzhZKABrVz/cinjo8S9Gs5krOUjo2Z7U9+9PhH
         /FF386x9+MWVxcL3WVnw9tlKUDKzxNYibwxb8rWE8/p6AmRPUkEPVhCha44UjAO2qbB1
         M5xmOdbrCJ0AoG86chELxt814ozbeGTgjI1LN8Fgtlp0vTQbSGsPkEPP7ff4CvE7/ElE
         luIY9BO2MVH5tPAHplKTFFDJ48T/bCVtglh2h5wWdoZTkWqJei6HQ29zEE96xIoSQ/Y2
         zSwvFyHS8MBv89BLSFcmeIdS7si4BwhAJfJ20gKTulptFRuR4d9GDqAURO6LHIhTHqJW
         zDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228335; x=1732833135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br4Z4jmJKM2k8q9ejgtU2VhhTuKOW9xE5Y6pOSf2atw=;
        b=BI1HXk0/FLbOqvk5v06p7M5WqnnLm5DYI7gcGQ8X8PYR8+Jc/tWZaHdZ/T4Yht3IR0
         ljNttUpPNyI5J466Qmq6SuaASzR7TITrRmiNIPwOXqwDQAy77HbjR8GVClb9mQxK/u42
         hbN4crSZiLgFZq+Cyqar/mFmfMsymf02PBSjoZh1qSLv0Bx6zQQnNJMtALJulRsLQXBe
         NCF7qO/COZSv31G8HYMhDyEhBbw+pAigtMTP7kTZwsuIgNqY70kO6JFsXG+brgX+yorL
         LYzQvk+mKfAFfh1ksgPnavvFNHM3qpjKPpjX8PfPiXtu9gK5JDviBINS8fFfnrtRjrV7
         dGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQJ/8q6y6XJj9IB1Ma33JxDWQDoHZfQYZR5vOKaUgasYIDyNvAnhkUzRItToavlyacyWfh4N72FS4nU42X@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxoFR97n3tfaD4c+Io8PQiu/YGuf+05tNI2sigARtnzmmFDJa
	s1KHLOxHigQHS3dY2VibWLxtAF8p1PQsnLUt4xkRwPV4s4Wkap6HLnFA+ZJjKqI=
X-Gm-Gg: ASbGncuvmGBy1eulMQ+wE5Q+5BP6gL0VZrOqmgncTsXGs2bS4ytw5lyvnhCwmproaDO
	K1EpjbizayxY01X/rtysxyZ1qBaMdbvnZkViy+wsGGkVYJolPJ6iC4QWeyZMJ+QAJxgHbx+f7LL
	g6UqCJDPiYJSXPyH6AVbmG67/2RVRQl07/tRWX0mTWyZIlJ7HOJPzCs4QmiTtcb3b8DFBMSm6jf
	10YgQ4hJRdvS2liYmXbWWCTWDSFBrwJd3sz+5+peAZF7zbdvn7uguY4DIYC7pBMwtYr1rsTsBu4
	bkfZldDyQr4=
X-Google-Smtp-Source: AGHT+IHVngTJRCKqnYjM1yW4Mgq6M6vuSNbiyEvgwnQUffWmj0Mc3ILb9/t1JK54RbyPQld+/VJo2A==
X-Received: by 2002:a05:690c:3581:b0:6e3:1869:8983 with SMTP id 00721157ae682-6eee0a6fe56mr9726647b3.40.1732228334863;
        Thu, 21 Nov 2024 14:32:14 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee008cd94sm1663167b3.95.2024.11.21.14.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:32:14 -0800 (PST)
Date: Thu, 21 Nov 2024 17:32:13 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 04/12] fuse: support large folios for non-writeback writes
Message-ID: <20241121223213.GE1974911@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-5-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:50PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for non-writeback
> writes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a89fdc55a40b..6ee23ab9b7f2 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1146,19 +1146,15 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  	num = min(num, max_pages << PAGE_SHIFT);
>  
>  	ap->args.in_pages = true;
> -	ap->descs[0].offset = offset;
>  
>  	while (num) {
>  		size_t tmp;
>  		struct folio *folio;
>  		pgoff_t index = pos >> PAGE_SHIFT;
> -		unsigned int bytes = min(PAGE_SIZE - offset, num);
> -
> - again:
> -		err = -EFAULT;
> -		if (fault_in_iov_iter_readable(ii, bytes))
> -			break;
> +		unsigned int bytes;
> +		unsigned int folio_offset;
>  
> +	again:
>  		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>  					    mapping_gfp_mask(mapping));
>  		if (IS_ERR(folio)) {
> @@ -1166,10 +1162,20 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  			break;
>  		}
>  
> +		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		bytes = min(folio_size(folio) - folio_offset, num);
> +
> +		err = -EFAULT;
> +		if (fault_in_iov_iter_readable(ii, bytes)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			break;
> +		}

This is a deadlock potentially.  mmap the file, then buffered write to it with
the mmaped region and you will deadlock because fault_in_iov_iter_readable()
will try to lock the folio to submit the read, and you're already holding the
lock from the __filemap_get_folio() call.

If you look at iomap_write_iter it does a the fault_in_iov_iter_readable() call
before getting the folio, and it just uses the mapping_max_folio_size() value to
fault in larger chunks for whatever folio we manage to grab.  Thanks,

Josef

