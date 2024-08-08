Return-Path: <linux-fsdevel+bounces-25483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B75794C6CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0371C21AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA9C15DBAB;
	Thu,  8 Aug 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9uBcIs1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EF55769;
	Thu,  8 Aug 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155011; cv=none; b=M/cGxMn/VA44GMNfm9DlL/U/B7xDjtukp4zCVAo48pOw5zi6IAPVHGIOrjgSvc4OMUkEF+ubeAh8OEtwWRUBNyMkWpNy3iN+Q/AI94GW12VsiLGsbEixZsbZqNNV9oML9K4jwZZHJQ/cYq9zmcvAjLESLSzIAIhGHm6v8NokUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155011; c=relaxed/simple;
	bh=4l86un5NrlZ8pgXWUQOWiS482rhUX5NkDryNnGVuv1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb3PjBl725ZPjLAr0jnB0bcHZPFc3ajpqFAMcOpSbvDt3smMAcWk+Prq0Ek2FwtmnqCukz4F8Koq5OLxJGT5GExErVorPo8jNUNIc1n+dKM2Vlx0XySwQK3yREuMyPa1XOGdRiqhjabznQFVSP7QuHhhDo8wmNF1/BCKlXNptYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9uBcIs1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f00ad303aso1828903e87.2;
        Thu, 08 Aug 2024 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723155008; x=1723759808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zc1fzOoTnegyR/h9JvW1UhMkychx7DSkfRxfH1ut1w=;
        b=e9uBcIs1J+jRNjJbJ4+dgLLVqWJKg6m8wr/VO7uElaKy1ImfenYzE5kEY4vT4H5HSz
         TJffLiqV1PRoHDLRKuQGP3fnIaDuvg8W8P9QXYSn2toCQsJeVRYVejZ9tWIQSuGi6Lcu
         kJcA7e/lgX8vyMioL0D9J3+jmOBn5M7AelPEPBY/iGiezTO/nm+GHdkViDNwdaaumBud
         9h8B/vY/tltJtqppEb9TQhLoX0yavW+zvcj5oOTcTR+30yHrQDMcoF/BK1bHkeG0af/F
         g88FOCKe9muFqZmu+iwyQwtqtpob7lXKlkwIz9OqWzHnSzx9CBGUP16EDWQcvDyW7xPI
         fWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723155008; x=1723759808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zc1fzOoTnegyR/h9JvW1UhMkychx7DSkfRxfH1ut1w=;
        b=Y89igQT/kQhSNNsmy7xw/k0UIb8sePV/yC8LD7qjlZ+8lHljQwv6136s2ZO5/p0OEO
         3G5OGVWiPUpouAG82EsTtLHQ0IG/6e1GTAsOMgMFRZewVaHG+PaDMVmhzwW+qj1mfEV8
         xnMQ94MJw60Iz9QvIvBlXhz6aAftUHUJQ9sNo2V7Uueiu6Gy6ilFdtM/+8sS0AyfQaOQ
         IR1qddEanp7D2yf3gLhjeL36nZ9RHYTvn5eme38T8JWFRDDW4fRumZcBU/RNVwt3r11P
         swShrod+LyWnQbwq0fqVKwIc8Y0PA9IltHzKU4YMzioyJtOQ+6rTA+l+9TYV2b1pl9Yk
         JIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGnHicryrrsejyErL3b6fQ1ojJx1JpnGMZT0kKHbr8Z78qXN020Rl4WX7PlKIYHQydyAecqyUS5XRvf5hwL77DpVfEJvBwDlHfgN5BurhoFalyOq+/uOvl8hZVAf1y92OcQzlQdxhmnu/Cg==
X-Gm-Message-State: AOJu0Yxj5eLTZMNaCcTWESN19+fv54QgAIFNt9XxtDCpe0C//D0soQ0u
	wJAOuDhExyD42f15leInTG2YoaQuXgWdS8gWMxQEoJcwLzsne3Yf
X-Google-Smtp-Source: AGHT+IHnVaaB2vMd/gasRkWZBOc1wvJ+LA4IpIJIeGiSzibv5ZAGjEvSM1Cujp5E825puCCy9Wj4Vw==
X-Received: by 2002:a05:6512:10c9:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-530e588ebe7mr2325073e87.48.1723155007535;
        Thu, 08 Aug 2024 15:10:07 -0700 (PDT)
Received: from f (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7311sm778033366b.195.2024.08.08.15.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 15:10:06 -0700 (PDT)
Date: Fri, 9 Aug 2024 00:09:53 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] fs: add infrastructure for multigrain timestamps
Message-ID: <gh5egnyreorb5h7powbmpcj733treuvk7grqsrdbvvqbrlskb5@cu3ld2km33sh>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-1-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-1-48e5d34bd2ba@kernel.org>

On Mon, Jul 15, 2024 at 08:48:52AM -0400, Jeff Layton wrote:
> diff --git a/fs/stat.c b/fs/stat.c
> index 6f65b3456cad..df7fdd3afed9 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,32 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +/**
> + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @stat: where to store the resulting values
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will ensure a distinct timestamp.
> + */
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
> +{
> +	atomic_t *pcn = (atomic_t *)&inode->i_ctime_nsec;
> +
> +	/* If neither time was requested, then don't report them */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime = inode_get_mtime(inode);
> +	stat->ctime.tv_sec = inode->i_ctime_sec;
> +	stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(fill_mg_cmtime);
> +

[trimmed the ginormous CC]

This performs the atomic every time (as in it sets the flag even if it
was already set), serializing all fstats and reducing scalability of
stat of the same file.

Bare minimum it should be conditional -- if the flag is already set,
don't dirty anything.

Even that aside adding an atomic to stat is a bummer, but off hand I
don't have a good solution for that.

Anyhow, this being in -next, perhaps the conditional dirty can be
massaged into the thing as present? There are some cosmetic choices to
be made how to express, may be the fastest if you guys just augment it
however you see fit.

If not I can submit a patch tomorrow.

