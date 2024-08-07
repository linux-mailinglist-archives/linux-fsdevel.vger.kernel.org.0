Return-Path: <linux-fsdevel+bounces-25202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4C949C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877201F22C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D72F5A;
	Wed,  7 Aug 2024 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2ih/FZYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A72119
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722988851; cv=none; b=dg83yc8zz7EyuSjcy7lYFdrFZ638fGluNKOdK6cPyUglgx//m9ja+pe5V4KCmnzRQJ7IUhBcl8TixDPjfvAd48+mYGQ9UvxwQYXznGirFCr8z/dqSvh9WhPlRbZt6fX0Nq9NhFsSJIMqCjSXJy/4UBBNdVLcB0Zw2DGma3/kbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722988851; c=relaxed/simple;
	bh=2aSqKoeIL7H1XnqTVZYnhSa9Sxg7fRAqjT3icKRimgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=triUyjxzpNYG+uGzULTzBPb3cR2Qjo3R9CjLfTVo6zgQefG5tRLA/wxyrjmpv4dJrPJ3jL1ptl1+ldvNtSGO7JBroNKwLK/PDIvZqlpWYErUuiRXjWsegHZHea8SkWAi9PqEb4TAV6Jsw6HqRuEtRZTJsnQA2e13nnottdlnQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2ih/FZYd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso1055011b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722988849; x=1723593649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkbg7RhfRFm56OQaj9VVBTsqBGFrSx4GH7fUN2VwLaI=;
        b=2ih/FZYduh6OtbjRXFmnVTT6gz1TB6WTlsbuyQFdRP51vzzaFYLEFlYVn2D4Ds85Nl
         BOFR7UOWqF/aCpGtg9ABr1H4MZpK3P405gjcSPg1TA5OQUhplcT9l6d5KYHV2T9rn2Hz
         aMpWVy75TJnl1BXP6jrp8CvIoIUkYPJBqhW5ZKwCp2+lETGLuW5J1ROTbG9woa/+Lujx
         uTueIBAcxJ1sxURBo3UFkmoYJ1FSnqUL6NJXFn1GuPjodBSBWlwsNIpVF457zfZcZsY+
         APE0ZtwALC7SAH/OMemCuh8OutajnZIIVtvq7sl7glJV62WX1nCQaot60xlTAnzdJ80+
         ZukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722988849; x=1723593649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkbg7RhfRFm56OQaj9VVBTsqBGFrSx4GH7fUN2VwLaI=;
        b=CZ1pI9he3wlFcZ2vq/BtvW5p+DcgcI7+vbpRVqSqfa8Tey6MLcQw7jGUMSGGlQCcAp
         DlG6OZFP4ngCtWsHompXReoW97FhsiGTOebBdNffe2U3zabaIJquMX5K1rExze/7paFC
         qGv0wP06/S8ygEbDYn4YUmK7SJxeNubm3Q9X2TOZhR4JLw7vLna/j/BMyLkZuLaiyAro
         8kFoKB9cW/uF5tBbiK40iCHysuD2yOTXrAl1/OPLY/Q39aCBHWSUnTWLWehbap0kl5Y0
         S57aV+hwbOTu6DpWV2Um7VjYAAruBuNJPGjW9BY/8tC9I2ulwwlv+0a3i5maaOGf/yAs
         Q0vg==
X-Forwarded-Encrypted: i=1; AJvYcCU9gZeZY7G+S7bN0waczxlNZi1UU2w3qKEdP37T+DUNyMnOWlqBAoljOhYwg0fQ6JKeVlo75DIJJVI+ZeqBcop9f3aW8nWODW4kKJCIaw==
X-Gm-Message-State: AOJu0YxBA3r084CEc1S3kz4VCZtAaXKZz0bMPGujseq0QVuAh+T27zfi
	Ji3UGLro7SVQXG/HUJinXkrgALZj6NeMncVtQN4kfDqbdLRA5F13+wfm3V0Pg34=
X-Google-Smtp-Source: AGHT+IGjuYHFxiGqFhb6phLGMfE0TvNxItmu2KVYzOt2XbeUv5QmT4Am5+FxycPh4+8CFBdU8ZnNvg==
X-Received: by 2002:a05:6a00:194f:b0:70d:3104:425a with SMTP id d2e1a72fcca58-7106d02ba22mr21668337b3a.23.1722988849335;
        Tue, 06 Aug 2024 17:00:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfccd3sm7673423b3a.144.2024.08.06.17.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:00:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbU6g-007vzC-2Y;
	Wed, 07 Aug 2024 10:00:46 +1000
Date: Wed, 7 Aug 2024 10:00:46 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v3 04/14] xfs: make EOF allocation simpler
Message-ID: <ZrK5Lu1+oqqyG3ke@dread.disaster.area>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-5-john.g.garry@oracle.com>
 <20240806185853.GI623936@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806185853.GI623936@frogsfrogsfrogs>

On Tue, Aug 06, 2024 at 11:58:53AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 01, 2024 at 04:30:47PM +0000, John Garry wrote:
> > @@ -3688,12 +3649,19 @@ xfs_bmap_btalloc_filestreams(
> >  	}
> >  
> >  	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> > -	if (ap->aeof)
> > -		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
> > +	if (ap->aeof && ap->offset)
> > +		error = xfs_bmap_btalloc_at_eof(ap, args);
> >  
> > +	/* This may be an aligned allocation attempt. */
> >  	if (!error && args->fsbno == NULLFSBLOCK)
> >  		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
> >  
> > +	/* Attempt non-aligned allocation if we haven't already. */
> > +	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
> > +		args->alignment = 1;
> > +		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
> 
> Oops, I just replied to the v2 thread instead of this.
> 
> From
> https://lore.kernel.org/linux-xfs/20240621203556.GU3058325@frogsfrogsfrogs/
> 
> Do we have to zero args->alignslop here?

No. It should always be zero here to begin with. It is the
responsibility of the allocation attempt that modifies
args->alignment and args->alignslop to reset them to original values
on allocation failure.

The only places we use alignslop are xfs_bmap_btalloc_at_eof() and
xfs_ialloc_ag_alloc(). They both zero it and reset args->alignment
on allocation failure before falling through to the next allocation
attempt.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

