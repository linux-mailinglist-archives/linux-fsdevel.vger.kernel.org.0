Return-Path: <linux-fsdevel+bounces-9607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D89843443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3375BB224BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBAE107B3;
	Wed, 31 Jan 2024 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ycQyGxYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EEEAEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669696; cv=none; b=lmkhc/d6LTNPEeup/WSkbD5BxaBWIKT/PHByAILJdu/PQZ/d3kOrWTNE7+GQy+bka8A+xGe609CXjsSwCvxQn1AAeh9zngyiW0fKdRvSfIqxPQw9B037rISqiMijLq5K+3pLCbW9e/KSxk3aXG0doelRUye5PaASy1O48hvApvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669696; c=relaxed/simple;
	bh=LJ3udZSHrDCtqPTHKXcSvvFa8cnl3Jy+15O/rE0H2q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev8g358YJQ/FXi6MVlpd0U5fQNBzAmy67p4aM8NLJ7tpDzD8Sj4WL3MMjTnd/PE19YLTsSGyBfEdhzh3IeUpsP423hoSq6O99pisi2HgW05zviqpfQmg289rnmaA9W2MKNWREOCtUcyiHgEETcwshNwU4npWawZ6hgQIWzW67/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ycQyGxYx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d746856d85so25111705ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706669693; x=1707274493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hrfb/n6ZOTCIrooBWZCWqo5ZO6oBNst73LpENqxcGZ0=;
        b=ycQyGxYx3azh6mivxtRzofSJmPXKKxHVTq7j7HZ6BcIn5DtwmadJu4FPGYxx7X0QE8
         gqAPFO1AElS6XqTtTsBUTignTb8e9i1NcRJh0W34rGAl68I/2AOdd5CNXzg/XN3EICHC
         aQkOj7XiAShXUlUAbgJBsm4gt1oYRshOMR8Wu3wUeTfw1kDTAsdDtCQoFFXRadK1Edft
         lI1eH7ILNp2hWf7zgRbDwT1+WZxhW0cfrWo8OCc9bM9zOc3hbzI/iaOwVgPvLk6E5iDa
         robIq9ZohxhyGOVmga2wagi1FdrZlD/kOzmEWIFBpZoQCiO9EdOi37ojpgu3kvAzduZh
         KrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706669693; x=1707274493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrfb/n6ZOTCIrooBWZCWqo5ZO6oBNst73LpENqxcGZ0=;
        b=Ph0sHgqvKZ/BVT4V5AcYEbidtMwbyLZ54oSWDqziavoFIw+hUDJG77+RZOToZLG0Ac
         9yU5/edFeBeTEOSK3Y4W0LGxBSMtkTrldjcGogQPQn/6mbMxzflqDyIbx87OPEcc2F1p
         GrPABFyHycwz21kefAqopWiTmbjtVqU03/3cKbAibfr56qaxIYHNQIGBiisaLr55/aMu
         7dcQyHwotPtuWN6yNUJsBDZf9bCioSx0OxJ/kdn+EQnhJJuSOdqKrAVVze8q4pieOoNX
         Gzj/2lCWlsf7rtqOzxz/csc80sdWvzZulAeE7UU2JM9JAtELkISM4ur7mjv7do5olqb4
         1UPg==
X-Gm-Message-State: AOJu0YyrQkzsq+23nDNl/ZxjnHC1BxkjvPgSBUkLSmeE74Pu0QPLVGjs
	TusXBjqWhizLvH7o2INfiMJfvPEap6S9tnSMIOiHUzFC7gFr0I3+iLcKUl3c0Xg=
X-Google-Smtp-Source: AGHT+IFAsmT6LMZORDa5sxVPam1HZWjCzng8qaLjFgSc57xDu0HuvkqFVz27rOWDpFLvz8J8s9MLSw==
X-Received: by 2002:a17:902:e748:b0:1d8:e5f3:3b88 with SMTP id p8-20020a170902e74800b001d8e5f33b88mr661552plf.64.1706669692809;
        Tue, 30 Jan 2024 18:54:52 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001d8d0666312sm5067490pld.126.2024.01.30.18.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:54:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rV0kT-00HZps-2X;
	Wed, 31 Jan 2024 13:54:49 +1100
Date: Wed, 31 Jan 2024 13:54:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 8/8] dax: Fix incorrect list of dcache aliasing
 architectures
Message-ID: <Zbm2eS/AMlmhm8EW@dread.disaster.area>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-9-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130165255.212591-9-mathieu.desnoyers@efficios.com>

On Tue, Jan 30, 2024 at 11:52:55AM -0500, Mathieu Desnoyers wrote:
> commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> prevents DAX from building on architectures with virtually aliased
> dcache with:
> 
>   depends on !(ARM || MIPS || SPARC)
> 
> This check is too broad (e.g. recent ARMv7 don't have virtually aliased
> dcaches), and also misses many other architectures with virtually
> aliased dcache.
> 
> This is a regression introduced in the v5.13 Linux kernel where the
> dax mount option is removed for 32-bit ARMv7 boards which have no dcache
> aliasing, and therefore should work fine with FS_DAX.
> 
> This was turned into the following implementation of dax_is_supported()
> by a preparatory change:
> 
>         return !IS_ENABLED(CONFIG_ARM) &&
>                !IS_ENABLED(CONFIG_MIPS) &&
>                !IS_ENABLED(CONFIG_SPARC);
> 
> Use dcache_is_aliasing() instead to figure out whether the environment
> has aliasing dcaches.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: nvdimm@lists.linux.dev
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/dax.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index cfc8cd4a3eae..f59e604662e4 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -5,6 +5,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/radix-tree.h>
> +#include <linux/cacheinfo.h>
>  
>  typedef unsigned long dax_entry_t;
>  
> @@ -80,9 +81,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  }
>  static inline bool dax_is_supported(void)
>  {
> -	return !IS_ENABLED(CONFIG_ARM) &&
> -	       !IS_ENABLED(CONFIG_MIPS) &&
> -	       !IS_ENABLED(CONFIG_SPARC);
> +	return !dcache_is_aliasing();

Yeah, if this is just a one liner should go into
fs_dax_get_by_bdev(), similar to the blk_queue_dax() check at the
start of the function.

I also noticed that device mapper uses fs_dax_get_by_bdev() to
determine if it can support DAX, but this patch set does not address
that case. Hence it really seems to me like fs_dax_get_by_bdev() is
the right place to put this check.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

