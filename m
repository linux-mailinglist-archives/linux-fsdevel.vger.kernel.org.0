Return-Path: <linux-fsdevel+bounces-42607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7BA44D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B832F16C982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 20:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4C219A68;
	Tue, 25 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j6+C/8pD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0920E6E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515152; cv=none; b=oPgegL3RB6voR9ThEYx/5ipjelrFUP/YBaERILgt303eVrsYaGvw6/topIh1kPPF9SE39e/hTpw5p96bH0ppMzeTOlXwNb6Y2rpmEhsry70hTV5lmFNRziuiLMl0yhitgN6fUs5w+IRP0o6sT7/bcTsTcDWySsbc+pYhQB7M2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515152; c=relaxed/simple;
	bh=p+pwKqqiJgGoKhhKfKEb2PlC3q2bJ+lUi7mJ6sJw3Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4djmURACEO8IS1OW3gu6gH9GX7naEB/RhoAizaCETRPaEXChdWoZEg8Slho7F+EUipFJhvIu26G0WSfviSuIENxsaNUWEsbQUkbOF9Ms8WTxmZ8L2uO236wVxh1xQc+ZKO27aS2LzyTtHbDFrCbMxYAem4gDroRWEQBDUkTmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j6+C/8pD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2210d92292eso30112265ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740515150; x=1741119950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sahSWpKtSWo1rgbQdN3cw9Z14mvbGZlYM9iW6N7nIM=;
        b=j6+C/8pDPk8hVujyWgUeL3kvc+EExreU4AJ+mL5ZDQLkmx3Vafi14JMiXK8+e1yjmy
         WUTkFYLPfyjEeyPddbKPyq6EFWQSTSkj5i+eb3UzAQ2Ok3g4B44o8jcGPnLpSnKxydaf
         sSkwuUEByT4fQ1Ucc/xXI/loz6VLX9iBlCffBhiH1iOoMxVsfT+zkg8lJ3Bd/rYaygzx
         FKtYkW5aeuNRHfp3Kpu4gGiQA/8Hrz/RBMjUHpIVs6h8a1+7pNGXVQ2kvnq7Bl62lqwh
         ORYcXxs7fO86Vn1VKtDruz9srgQIXxxK6mWZtVodvj8GYgi5gaGCDRwSF/CY7xsP8k6v
         0P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515150; x=1741119950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sahSWpKtSWo1rgbQdN3cw9Z14mvbGZlYM9iW6N7nIM=;
        b=jxNOJipD0ZrQL1yEg9aTUh2/jYYFAlUidtH9aGn1nteiVBrXCh8awxwgHJGDqy8ALS
         Mmdl5ba/1r0kf6O+TFESXEE5QftWnuwSy7bwQAFb/PZ5/kfOB8VFQD9/lgfX/v62UtFX
         /nKNiGjqlfUWWOoC3KW4xExzgmmSmapPHF4IlTuct1PEmKbM/vfTJcjxOdBuPgOGeKOj
         fVKtmbrd+4+9MGp9D+FpZiBcmixaEyjq/LslbmvvizOe89zzkv1+6VCtHzmLi8l0ncif
         n5erR8j0whfepeOGCmzcgqMGYJh3uC2EHNasMAbmWQ5Mv/P+P9lHyaFkvDvg+iV0am7l
         KaZg==
X-Forwarded-Encrypted: i=1; AJvYcCWGoRHCCgj6lnbmTaRbhOqrdAZlnI9fguVNjYDXNJAXQaJm1L0WycdGQmY0buEfPsz6cucw2+kl14/3NDMz@vger.kernel.org
X-Gm-Message-State: AOJu0YwlM3fxEqN5CuGNl7PyXeC0SymrbUFmLLMbICXBfnPwAXBaHC79
	bLadXPhyrmk1u21QGHwnWMRzZ9lCm2zTO89ng0D9gzma3h59DxRQj+7IYvBb+Pw=
X-Gm-Gg: ASbGncs3moFQG5mEKT0rDvNJKqIKxaJp+J/Q8dMnDnRGKBrAGeQDia0CNhe7qhZYf4y
	EyeDaIi/wwjELHUhds8FO2IDvKfqTbzpVjfs/vEhtW7GtbaFJSihhGg+cr8BfeskIxZtn2Lq97d
	vY/z4ADuavHGkLmNPo0EIcBlrJeLWO8d2Dogo5/NJjq4NBfcgywpFeJTU2b6z5HEvWZFvzW1jOe
	MIqXZTVyr8cgiUZzcXCEbv5tDDKMIw45KXZGpbfB9z//uFc0L4E/v2Ll4LdOQb77ORoM6KT2Ly5
	FUVSYaPoxVLm/EGuklJCZoY7MOYR5AjTVg3QBavPFUrbkN6wnGt0sLVmONDuQgiwRhFklQ3frqi
	uJQ==
X-Google-Smtp-Source: AGHT+IFJUKeSO/+jJc8oE4V1Fy6IwtegHWAoWJKcW7vsL+7oK8iiuDIcLUyurk4FQbtZ6ud4ESh4Ow==
X-Received: by 2002:a17:902:d4cf:b0:216:4853:4c0b with SMTP id d9443c01a7336-223201f7d84mr10594015ad.33.1740515150171;
        Tue, 25 Feb 2025 12:25:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000830sm18730065ad.30.2025.02.25.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:25:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tn1Uw-00000005ugE-3hi6;
	Wed, 26 Feb 2025 07:25:46 +1100
Date: Wed, 26 Feb 2025 07:25:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, hch@lst.de, willy@infradead.org
Subject: Re: [PATCH v3] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z74nSu3q2b3sy5wY@dread.disaster.area>
References: <20250224143700.23035-1-raphaelsc@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143700.23035-1-raphaelsc@scylladb.com>

On Mon, Feb 24, 2025 at 11:37:00AM -0300, Raphael S. Carvalho wrote:
> original report:
> https://lore.kernel.org/all/CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com/T/
> 
> When doing buffered writes with FGP_NOWAIT, under memory pressure, the system
> returned ENOMEM despite there being plenty of available memory, to be reclaimed
> from page cache. The user space used io_uring interface, which in turn submits
> I/O with FGP_NOWAIT (the fast path).
....

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 804d7365680c..3e75dced0fd9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1986,8 +1986,19 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> -		if (err)
> +		if (err) {
> +			/*
> +			 * When NOWAIT I/O fails to allocate folios this could
> +			 * be due to a nonblocking memory allocation and not
> +			 * because the system actually is out of memory.
> +			 * Return -EAGAIN so that there caller retries in a
> +			 * blocking fashion instead of propagating -ENOMEM
> +			 * to the application.
> +			 */
> +			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
> +				err = -EAGAIN;
>  			return ERR_PTR(err);
> +		}
>  		/*
>  		 * filemap_add_folio locks the page, and for mmap
>  		 * we expect an unlocked page.

Looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

