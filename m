Return-Path: <linux-fsdevel+bounces-44331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD3A677B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15348170AF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D020F08A;
	Tue, 18 Mar 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCWnokui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106A20E024;
	Tue, 18 Mar 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311528; cv=none; b=X3nWcvMJ/U8oJoGdt6ZIfFgjaWY2XajBx+Ly/dOMuiZ/6XYRL5aTCN9t53o4S3ZsFb24i7ov2Qm0SqlTzMwJ8yS/FfLMm2mmqFWA3klvvBqGLcxnRpb7OKH97httnty1pD1fCoEwxKObzq+9Xur2YYqwKF7kUYMLDnZgb/Jqki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311528; c=relaxed/simple;
	bh=n7VgW5IdpWHpR4QRlwLyqADMhcQRXhHFMtOMOX33dhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1p1X8nu8eUj6KNu8DrLpaBSMXz6xLY2gLpbQLVQsoa6cP8qeV1Ncr1SfTNAk4cM6Wyu4/J/aCl4Sq/xRWa601YaYwEhACKpbcAGEtqoG6Vyp6OOAQTkNp9bZPyhszIeR+XKH908xNFUkGq+Kv7WOMRhcbEXudaUVYWi8IiFhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCWnokui; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fce04655so49427136d6.3;
        Tue, 18 Mar 2025 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311526; x=1742916326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
        b=hCWnokuixxvGMHot9o9nu6buYw2XTDLBFDBTOIQHi7pUG0zQxHv53f3iHwtE2QNQMW
         9xpyzLNKpIbQUB3lhKB+P2jRlIAPNWMvK96yBtGtXkiFwaYf4k+cVASkgFWPVPrf4Lk/
         nDKaqzR2ZxDYepJl9aQHFAlR4ZoB5T06SgGDRtk4rXtlffPjt9bWIw2hZKuiF6xZoLlu
         ZaOQ6C77ozKIyMVu+k5h4Xa86Q9BKFgYfZ1ynmnqYJWZctde3xL3Lsgs5jGq5H2j9KAP
         0Ys9uySODmG3vHzFwmJkkxGs+wSBx/e928qvDjVy1C2+NL3F0X9onEWyl1DX6SJRBnbU
         w7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311526; x=1742916326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyn8RJjlleD7uhnXI6huIEcPWo+6WvTYSC8J/PV1Ppw=;
        b=lP4m1kiDdXvmJWbWMzrBm3oCGwiPatsagO1TJgGeCzyFPydSNMhEg1Q8Ly7Pp0hd68
         XYYKF6W0EolQKJe/AG90bHoi0ZdppaSFD7f8GGn0b5PWiNCBPqFa4mnxALeRUveNsVpl
         rkugg2t+1nCWOEYoIBoBI6nhG/bCF8IRttfP9FSU59bfJNTP38qoUZJTqFagxQbZMDyr
         90Frw22RWIsYyX+N9w6ZyZWp8F3wVhfIdhi/99mtStrUjK/KavGy3dOmuQPQED/Daq2T
         PhJPCtv554AnQIqU71KyNr8StrokYbvcPVYCsKeFqK8aEoQJ1MpvaRm8ruy4AG5uX6/H
         AF+w==
X-Forwarded-Encrypted: i=1; AJvYcCX2J7vQwKyKykQELEjS2KYozhf4DwKViHkklveDgEAj4ditwCbX0LknooOqj6Pq+18c5K4RvI8nKvCOcbbe@vger.kernel.org, AJvYcCXus2KWj8S00cc3ffA+b70OL85R2Rb6mvkdUqPJUwgz5SNd0LDPTWg2uFyUGpP/aLWTJGvPpXLrkgcCITb5@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2cq7XaxeD606oZteZW/fLBJDbgyCGgCkGb8+FtNM/HKeaf5M
	B961DkvQgKUCCpzQYZimMXYWqo0474MQpAiV5J1cFH03+MoH2TCm
X-Gm-Gg: ASbGncsRvVS3zrd8kaYOFnND3DgNZE7AbbE20X485sGfPJrFUSbMff+MEZWr/laK1q2
	80NTAYXWbugQ8rm8b6dUC274xBYrErSPsmRfxNZNGuPct2ZgLkUjvdCiVUCZ219gizzTUm55BUa
	HFkIDg5I1z15GSIZzi+RTKqw9WwJO9h+Pg7JQqqdivM3hFQJkuAKAs1wNuw55+VUmBsltUIYsdc
	eAK/Iv2UNWRafsto9sIZqpODugajvNbsi6xmAqjQlZ+Hso6xSpZCQ9SUER7F8eEXiVTsGwTdhT/
	o5g5MXrHyHKMuzGVsrZEthv1AFHJgE2LexKqzCyW4A2L5ibj1tRshCvnvDsG
X-Google-Smtp-Source: AGHT+IFMrxghikRrokajWNq7Qgw70xbXKxuDnySNPyGwfwT2Ss7893xwolfUMGoDpYSi2hTG/afasQ==
X-Received: by 2002:a05:6214:c88:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6eb1b8391fdmr53856596d6.10.1742311525741;
        Tue, 18 Mar 2025 08:25:25 -0700 (PDT)
Received: from f (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209bcdsm69412376d6.24.2025.03.18.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:25:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:25:15 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115094702.504610-4-hch@lst.de>

On Wed, Jan 15, 2025 at 10:46:39AM +0100, Christoph Hellwig wrote:
> Replace int used as bool with the actual bool type for return values that
> can only be true or false.
> 
[snip]

> -int lockref_get_not_zero(struct lockref *lockref)
> +bool lockref_get_not_zero(struct lockref *lockref)
>  {
> -	int retval;
> +	bool retval = false;
>  
>  	CMPXCHG_LOOP(
>  		new.count++;
>  		if (old.count <= 0)
> -			return 0;
> +			return false;
>  	,
> -		return 1;
> +		return true;
>  	);
>  
>  	spin_lock(&lockref->lock);
> -	retval = 0;
>  	if (lockref->count > 0) {
>  		lockref->count++;
> -		retval = 1;
> +		retval = true;
>  	}
>  	spin_unlock(&lockref->lock);
>  	return retval;

While this looks perfectly sane, it worsens codegen around the atomic
on x86-64 at least with gcc 13.3.0. It bisected to this commit and
confirmed top of next-20250318 with this reverted undoes it.

The expected state looks like this:
       f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
       75 0e                   jne    ffffffff81b33626 <lockref_get_not_dead+0x46>

However, with the above patch I see:
       f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
       40 0f 94 c5             sete   %bpl
       40 84 ed                test   %bpl,%bpl
       74 09                   je     ffffffff81b33636 <lockref_get_not_dead+0x46>

This is not the end of the world, but also really does not need to be
there.

Given that the patch is merely a cosmetic change, I would suggest I gets
dropped.

