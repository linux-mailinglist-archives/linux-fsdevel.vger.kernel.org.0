Return-Path: <linux-fsdevel+bounces-52891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C7AE7FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800595A63C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94352BEFFB;
	Wed, 25 Jun 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2U7MUvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B12BD01A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848101; cv=none; b=swgmrAvJkiP/4s1hwpXiL9BZXb8hIlE00x3TzV2WmeXQGf8kh2dzF4GjM+rveDiBkwcww35Ij/59nJahJgGhYZgGZHCQbenuxypuMIlnKbHk+hTB2jmo6nwjv4EWM4lJwgfdMkqUAVwPqcxlILYN1zUdHwMv8sQFx9jqlx7DrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848101; c=relaxed/simple;
	bh=lOruoolLdTMrM1hsoH9Ovds3ZTDlEFaydFSeZp1B4V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln7A0SbqV39tK++icZEfNZj9jlgEkCGIQwhFAU1HYMoGgcMzGJOvVNtJozTC3DH+mxUU5c2NhYSUdhIANeQvkYAilxp7/1KwLad/+5NU7hDeRy6x4FMq7w1oukHT0QXIubMFETGdb8G4dsnBAR41Zpe6Q8oAWZV9YEBntUDmlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2U7MUvr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXzJ6BG9oFnQy0s13phUi78sKWJpBfX2ctrsD+v2g/I=;
	b=A2U7MUvrI3KIaWQqTzho6cR68uaiCFCjNvk1e/In8g7QRXZjy2zuQMvHgA5fue64PEeBEY
	887X6B4JWEg8/32ZjPLBngb8ybxaXftbaCecvbJbfswke3Fc0lPTxtaeBDApj5lunJT3/s
	5VO6ZKoJBuPlgCxGpMbbZC4fQSYLRBI=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-dNBcPPoeOTieInvd4iRcOA-1; Wed, 25 Jun 2025 06:41:36 -0400
X-MC-Unique: dNBcPPoeOTieInvd4iRcOA-1
X-Mimecast-MFC-AGG-ID: dNBcPPoeOTieInvd4iRcOA_1750848096
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e81374b168so1245738137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 03:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848096; x=1751452896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXzJ6BG9oFnQy0s13phUi78sKWJpBfX2ctrsD+v2g/I=;
        b=GW9b3rlpmGVf0UbVSES0UndmiFf0p6T9zcsEc6HAckJcVnj/6TQblgxO4wwNkrLEbl
         c5KEQApa0pLFh2vsKfLYnjJ0KLECWigV7zOGYzPIxDCXR4sC+T80e8bFvW45JBMvuosc
         a700jK6rpOXPFDLQ74btlXUOjURDZV7HYD0vik4hRE2LhoewsoIQ0lYXsLoVVtDB6LSF
         70G325B6aaivbvAr9pWnsEXCCVz863EwqhN96N2LgSQCn0ZQNh1CBrktjXEJwDh8/5zt
         434LKWeeBgnIgQWDTQ+JvYG2Rq7x+KOHFpXfPyqCndkQF4ixlJt15hXbfV3CbNYThjcw
         aLqg==
X-Forwarded-Encrypted: i=1; AJvYcCX33pB098nDfq0S3PfhoNg249ucjY8JXKOFxml+yOOD4L1oPDG9xCvPjqbrthYDaRetoP0qFKgjJ03D0bXn@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7S12DYFTjzXZjhB7TMMVFt/2Ufs6xKWB3VqAIplN8vpzvLcY
	srNVBgkkEWQl7Bgs4XfA0xN8JIfxNs+o8UyIv5Txc92y/ojbllGMLLjTohveueVYfmNFnxxa7VP
	S8RbTZMzJW/AnwQAscG35iDJJhAewwyxUsdmqs4ipBhQ1xn2rqLfmcjPFRqYRz18f/dsbJ/82Od
	ZVfzAxHFm32/lbjk2i5cBTNCfEBZEK5AiKckcGVQBdaQ==
X-Gm-Gg: ASbGnctImQ4v2p7mELAjyUlT4XFZowXj5vhJdKSONtrdKHP0XsUHhbGlhQ9jwgri20K
	0cey3G9N3hwUpGUgDQncyU7PAPSS6JzHujAn4nJLmzZs/oXs3rkjlFKi4w9J8PXIaPQ3v1WDvTd
	zB
X-Received: by 2002:a05:6102:e0b:b0:4e5:a316:6ee6 with SMTP id ada2fe7eead31-4ecc769c5d5mr977802137.18.1750848096255;
        Wed, 25 Jun 2025 03:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rRMb8Kv0RHeqhtdNcN4p/j7yM7WdX52zFHAZihqFaG1oWPDvEzBZJHq9Wbj3VxPRs3mj3K9chbZ2rnwyba8=
X-Received: by 2002:a05:6102:e0b:b0:4e5:a316:6ee6 with SMTP id
 ada2fe7eead31-4ecc769c5d5mr977794137.18.1750848095914; Wed, 25 Jun 2025
 03:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-6-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-6-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:41:25 +0300
X-Gm-Features: Ac12FXwFWhOETzcvDHbBzNovjF_5IML_YC5DRczUGY04YVAWJAwP94hRxUpsl0Q
Message-ID: <CAO8a2Sg5Q7iYTSjR2iD3R+EXHe5O735zp4V=Ur17q8AgkJFCcA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm: Remove zero_user()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> All users have now been converted to either memzero_page() or
> folio_zero_range().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index e48d7f27b0b9..a30526cc53a7 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -292,12 +292,6 @@ static inline void zero_user_segment(struct page *pa=
ge,
>         zero_user_segments(page, start, end, 0, 0);
>  }
>
> -static inline void zero_user(struct page *page,
> -       unsigned start, unsigned size)
> -{
> -       zero_user_segments(page, start, start + size, 0, 0);
> -}
> -
>  #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
>
>  static inline void copy_user_highpage(struct page *to, struct page *from=
,
> --
> 2.47.2
>
>


