Return-Path: <linux-fsdevel+bounces-15448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A10B88E8F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110A71F33B18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5140131BC6;
	Wed, 27 Mar 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfeBvTQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6591131BAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552909; cv=none; b=kHxFJqjPF3rQviIWxTDVPDY6YIHsSY8N0hUBJ3sCD/V3FJH/pepqimbmYCgnxxLNNQJs0b3gzl0w3SAZCZtZ3lg7gRD5e9VbVDjm6SOwKD5gQLyn/hLl0G/zP3V5Qb6DjZLYm+qEYLEC/SgKt/eSCexIafjEuYhGVVcqGjoYpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552909; c=relaxed/simple;
	bh=mhfoA8jCv1DDC516BG+AAL5xuYfKBZbFsPJx+Vnzofw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMKSCNULTOWgt+wFKwhwonlzLpELckVaYJ6Z8Y/1l8jFNFHzpk4Efzu8ervJSb94g7blUW9M++fLv6LI6rOMOQsR+/ytTclCMvlCr1H7XD4+DdVCBjouVcJm0IZqXHQdelY+aETFHoXdxonC0crVGdLo3DLzy3kzzWnpAvVaQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfeBvTQ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711552906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RJOr7EzuI0DVaYxx+XjeXTwjAi2iT7d0lhMZ/VIsjg=;
	b=FfeBvTQ1YOCM6sVNyKpde99nQEnNF1bbiPegJ6LoRMJz4OLuzJ7Fw8hizVP/xUyE3pUtTI
	pg2pnt6R7jteuiaraKjG1pwwKNW7Pah3Zsuf+7wcy8fZNtwkEprZkD3msgiSMEzEZw4TX7
	h/hxo47DbbYOVBC3z3m8yRRJ/luCImU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-t5UcUN9gP4C1BaNYHxuGSQ-1; Wed, 27 Mar 2024 11:21:45 -0400
X-MC-Unique: t5UcUN9gP4C1BaNYHxuGSQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dde25ac92fso3181134a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 08:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552903; x=1712157703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RJOr7EzuI0DVaYxx+XjeXTwjAi2iT7d0lhMZ/VIsjg=;
        b=JEtyIoCueQNniUiQsQTZKgeg+mAC1iPza+QIjByNghMc3cMQ2WYmYc4rq60pitr8Gk
         LGK/HN/fPqcDwtnm7seJ6/ak0VIMI4EqScUx1QZkFRqz/n6TozIoGXhKADm+gCp29lCZ
         UPTI3CdlO5Ual4NR/RZPZ7GRMEXvdX2iVPwee8lutEccqLWP5yp8GvKk4MD+A5yVeQAv
         lgJ+Y+3VHwB0mJcO5dAq8J3nk8d1hVxU83iWwsOBww2HRbeSPu4vO3DgtsWn9/SRiGDf
         /1HJIUSYtd9/tsVRl4d5rqe2U5R1f06K8ndZxBWtvsxoBUbLKESiOagAuAzZ/gCrnfxR
         UOug==
X-Forwarded-Encrypted: i=1; AJvYcCXG780BMrPJ/JF6CsQ+G3TrQQ7gKjf8h3FXr6OA5ZhwVbZY3qXqpJrQm55UxfEGRPZTEuHmgiaeAO9cZYj6pIKm34haRnIzwaaBUsfz2A==
X-Gm-Message-State: AOJu0YzGst5LJuLGIRnSL7hvfAQOl2bYRam4unBLfXDCKKPvSmPydTPp
	u4Z1uCyMjPRnUFPrSN8xVkGKWzAGDdH5OC7gmSkDDIr7bQroufZHsitvHudOWzjyTc5bhQ3khbI
	vb2X1ULwdkX1thMWDyEhi8pFZz3XmhObLhRaVRsSdel7YISv0hXLiMpeUV1lCNlg=
X-Received: by 2002:a05:6808:128a:b0:3c3:d729:1d56 with SMTP id a10-20020a056808128a00b003c3d7291d56mr316759oiw.0.1711552903450;
        Wed, 27 Mar 2024 08:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxT5qAZWntttFMbBHTXwtvywmg90pV0zoL9F4zS7SQ4GsHwDy+Ru4KfcRdtRpsXZfeVg5bqg==
X-Received: by 2002:a05:6808:128a:b0:3c3:d729:1d56 with SMTP id a10-20020a056808128a00b003c3d7291d56mr316719oiw.0.1711552902921;
        Wed, 27 Mar 2024 08:21:42 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id r15-20020a056214212f00b0069698528727sm2350243qvc.90.2024.03.27.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:21:42 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:21:40 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Message-ID: <ZgQ5hNltQ2DHQXps@x1n>
References: <20240327130538.680256-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327130538.680256-1-david@redhat.com>

On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
> Some cleanups around function names, comments and the config option of
> "GUP-fast" -- GUP without "lock" safety belts on.
> 
> With this cleanup it's easy to judge which functions are GUP-fast specific.
> We now consistently call it "GUP-fast", avoiding mixing it with "fast GUP",
> "lockless", or simply "gup" (which I always considered confusing in the
> ode).
> 
> So the magic now happens in functions that contain "gup_fast", whereby
> gup_fast() is the entry point into that magic. Comments consistently
> reference either "GUP-fast" or "gup_fast()".
> 
> Based on mm-unstable from today. I won't CC arch maintainers, but only
> arch mailing lists, to reduce noise.
> 
> Tested on x86_64, cross compiled on a bunch of archs, whereby some of them
> don't properly even compile on mm-unstable anymore in my usual setup
> (alpha, arc, parisc64, sh) ... maybe the cross compilers are outdated,
> but there are no new ones around. Hm.

I'm not sure what config you tried there; as I am doing some build tests
recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
avoid a lot of issues, I think it's due to libc missing.  But maybe not the
case there.

The series makes sense to me, the naming is confusing.  Btw, thanks for
posting this as RFC. This definitely has a conflict with the other gup
series that I had; I'll post v4 of that shortly.

-- 
Peter Xu


