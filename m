Return-Path: <linux-fsdevel+bounces-46078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FDA82485
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B258C1BA6E73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D55C25EF9C;
	Wed,  9 Apr 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MVriHJ0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89C25EF86
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201261; cv=none; b=tzpe0oo9VpKbe3J4hPMLc4Tle6K/D6p5tGBdYb1+7kUB0X8/SvpFIXK01T3a6GQ3wsBxaUBFzrftrYkG8CxWRAghvNSTccsJb7qTjjiHdNIs5RuIri8uFi9D5zOuvL06QyVebrAgfAqhDtQnAd71gYfFUTwkyfegfOOb8U19QPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201261; c=relaxed/simple;
	bh=F8E53MMpOVzOsej7NjcLqtRiFyu+Wm3a327Y/mYBGu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCi7V8t5AwfB8nzAjIyPXEMZ5DBTrn4d/8fsGk8aHa2/25poHll0KBOqjGdCP7tJoNMu281dxXfHAYjtjYXikRyvrM8J3mVBsKCIWN4VYk/MW/nEtaRMogKdUv6FKHB6mErYfZeiQ5M+ns6brJ/fSwrMj7i8+2CcJupShk5ACSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MVriHJ0t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so10779588a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744201258; x=1744806058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6dvih7wvfynVrebiFBdW92QzhqAPsR5BNAa5PflLdh8=;
        b=MVriHJ0tECKyDnWE0ksBLJXdjOFKqaPkn2DeAa2YSXDmqFVKEjKvgWXj9PbMOjy7J6
         NUPH1mKwUYNr6Vnjwz5rUUtG8elftzaEyMBxswGMa4N5H1tkow27ygWFCK2knDAu0MaU
         fEyrGYL4ekuG6L/TxOMTbfjZjacS0OIynfFbFwkMtHDr6kwt1ofDttOm86WfJd6Dndlb
         ZuLYcEr5EWVqb4LKF8t4mVFj7PkRmebyZeELs0++VfGXMaCww6LY6edQ3xqutC0RhvQ0
         bAbuiS2nhk59ZqAAxO91iuZXrGVEap+mu8g7HixkWWmPcbEcttYeGhhltRtu7sHWY8Tc
         /Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744201258; x=1744806058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dvih7wvfynVrebiFBdW92QzhqAPsR5BNAa5PflLdh8=;
        b=k4PjNPn14pYu2o+7a13OTOEAfKbsot3xuXZcUXyggkDsFg1e4dW8u4l6CR9jnY5dlj
         nk7PvLUoJFQcVmxSUpBsEUz6CV3b1oRry1E0N3lHkLZrXzz8WIsNheoSrIQg+qnxiyrq
         nV5a0rFRz9a6gamAmSzfNQXMubHSj2YcQC+rqOALoaTXLu+Wt2Ysd/EH4gEAvQaB3Vmu
         FdT34gJF4VhykBHCzI8dPLTTADOQJLgogz1jbsoWJTC+l4N/CxZYrmO1DXz14PNHGiLw
         lLrc2o8sNYGTUyb3jZO5i4sllZgElVya2ZFCWS++qqG9VtDa3TY3bKqdi1oAl24e1nm+
         lQxA==
X-Forwarded-Encrypted: i=1; AJvYcCWtkijChSas/Wfg+GOf6cbcwA3NIjMhrq7KlWxZhcvRLRMXT+xHxpqj3CHuMPk4UpuFsjqh3p2+tWaD7IG6@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQyIYrmIxzMcci989Au6W42LjTx+x9s/txr4CGVuoV+A8GGA4
	XNbrH0KpF2zFJNyOq7YWqhktLdbKgGi2CZhTFWcAxLm5Uxcb2PkAPhJ6233Bj0k=
X-Gm-Gg: ASbGnctquwaJY1rB+xC/FJjOQn4+RmrxlI5DnNcykvBDrfMemC8CkhJghQbwMkZ/o12
	a93/0q6u99NE+zGh5wU7Gm0LeZvNNQJuw8QzgnqLFnagpmMjrlITOm/px68ibXeTfcTqY/tSSzB
	gsptUN3OF6tUuox0FhKmAm/9OHXyOInwPQUnXq0RlDVWVITLqz69WHHsim2NQkFImIZqC3K1JD3
	cDEcy14pTfMjoI91AVCpwPdq3WyLSAN61Uf0Ff5WCYXZJjUhveRLBpyuSxlfyEXEd6qIdg02D1P
	PQPsRrBceAWbdFs3fjak8PToTChCOww=
X-Google-Smtp-Source: AGHT+IHcrfDARD/MHD5XsauPp3j7VEdQ5ZRLkRjXHq7l1FQPMOUEjrzGco+PCPpFDVA8lCBV/861Vw==
X-Received: by 2002:a17:907:3cc3:b0:ac2:47f7:4ad7 with SMTP id a640c23a62f3a-aca9b6c1498mr315806266b.36.1744201257862;
        Wed, 09 Apr 2025 05:20:57 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acaa1cb4104sm88487366b.99.2025.04.09.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:20:57 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:20:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <Z_ZmKcA2CvMiZnSG@tiehlicka>
References: <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
 <Z-7m0CjNWecCLDSq@tiehlicka>
 <Z_YjKs5YPk66vmy8@tiehlicka>
 <0f2091ba-0a43-4dd3-aa48-fe284530044a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2091ba-0a43-4dd3-aa48-fe284530044a@suse.cz>

On Wed 09-04-25 11:11:37, Vlastimil Babka wrote:
> On 4/9/25 9:35 AM, Michal Hocko wrote:
> > On Thu 03-04-25 21:51:46, Michal Hocko wrote:
> >> Add Andrew
> > 
> > Andrew, do you want me to repost the patch or can you take it from this
> > email thread?
> 
> I'll take it as it's now all in mm/slub.c

Thanks that will work as well.
-- 
Michal Hocko
SUSE Labs

