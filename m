Return-Path: <linux-fsdevel+bounces-60268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF2B43B24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81757ADC00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F42D8771;
	Thu,  4 Sep 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rgxMczjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A72C21C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987865; cv=none; b=NkkoCrFmrJE2DPmZaZ5JdJed8wfn0MzypaixQYlXQOYyS9XhNeHI0jUmHjywroCB4xeKjNzRvFQPJycctma2fF1pOnBWLyS5B7vcUbufYsrh5m7L68+jWmBxXSec6tsFec/ktjUGkLokjU2qIiTa+JdphWF+Yoow4BKXDFpz6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987865; c=relaxed/simple;
	bh=gjlVq8FpVKFgiAyllL0wB2r8/I9yHjQu5VbHsqkQxiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csWkds/YgF9hk/9Qm+mpuz4lb+7BNjfOEOrGjyONhPl8AhAzpfy3RvJYv0LLpND6cRb9K6Xb2tCQUOfS8XxaDYWF+6qQGVGdwXTK/70+9eO0xJjSj5Mce3FlQezLeu0U6Rx0ojRQ5dmaU2ge68vFfL4fcefqzy5mYLb+CD68oOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rgxMczjY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-80e33b9e2d3so83242085a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756987861; x=1757592661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjlVq8FpVKFgiAyllL0wB2r8/I9yHjQu5VbHsqkQxiU=;
        b=rgxMczjYxPMrYMDYR3UA/atnihZuKUrpx1dDyzwH/enmjLAwiylxEJjuyzHriWA5dx
         xYJR7blt89THMY+biwAZwi2AvL1vUEajNM4N+cDFD83IvLMCGekxcN2ppDAZMVO/uKyl
         Uk9T+fSLNx+1dYpKXLqh5yOVx3XyoTlHwZK00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987861; x=1757592661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjlVq8FpVKFgiAyllL0wB2r8/I9yHjQu5VbHsqkQxiU=;
        b=jgXEssZIRYplKISkeYFXGKiMC4Oc2O100wDLAvhoD2MGa+AJ5ihaMIWRKqzeIgtCEo
         XB5xJaNW1NUcyZNtrpl5bNY/A0vfGrxUKiylVmMR6N48IlPYoJd/Y19gVF1AE2/vnsLP
         A8GZE4hbxT2IAa8Lsk/ogFA5LYKOBLNxLATZxwpkZnwnvT1TXrQCFpHryWQ0cSe2JpVP
         Uho9L+2KrxlfSwdBOg8yBCOn3ijBVnmg0ovd6IbmIHnMDpdrWwQfupK5BukH5iMRaQ51
         ufFWZ8N1/UaeAw8DA/VuYYRqLt6afuFlnAo8zRrh9BGD0vY08MVXYSNRTEknEFDoW6kg
         egnA==
X-Gm-Message-State: AOJu0Yyu6Hq0NBrs7MKB5NiyKoQkJpUGQ9Hq9vD0mogUVbiWgIG5xyO2
	5irQpRMVhhFEM53+OU/2BhEHmjW+bKeRfIFa8hN/thLhUMBzyYTrFjnF6NbV7fIj6RvpjGHKKUE
	iS/DlpdWzLv1FW4nkajionzi7BDOQzZFczBAk9AYXSA==
X-Gm-Gg: ASbGnct2znprZzSp+twTMT8rYSCzJNq/dzx6/tIBo1lcMs3+SiQ9UsQjbNaAGEdUeV3
	7F23X0eRREnEfgqrtWr+xQvgfPu4HHatY1DhRNaCLPCa+IY0cdqkQ7bP29PhEEO0kXTfHwflajH
	/lna4AXc6a+VRPcgja8/LTU0+sxQoM6f0p6qCOWoFFlePFrtbnMvvwm5jELqXLq7/CBxGJ2suOP
	0QVIAIDorXFPLYlCmhVNgnghKgu3JCvvCB7BvCkBefBU3ilGvRp
X-Google-Smtp-Source: AGHT+IHRBKQCViOy+3E5ogp9zVpNMNg0Q43pXtgHycVq8ia8hUOj1ReM9zgzxUU55FO82PBbTz+ok2x7oLUwMlmTuHY=
X-Received: by 2002:a05:620a:2948:b0:7fc:c964:38df with SMTP id
 af79cd13be357-7ff2b5a713dmr2135908485a.55.1756987861094; Thu, 04 Sep 2025
 05:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904120339.972-1-haiyuewa@163.com>
In-Reply-To: <20250904120339.972-1-haiyuewa@163.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 14:10:45 +0200
X-Gm-Features: Ac12FXxDCj7qXFPJlrrixUNL9wFH0RfwVg8nWGcK3mUz3g-juiYtolyxpTYsSD8
Message-ID: <CAJfpegswS_KRpOxsCYCR9-z3uCGKrJz_=-c1__CHimHC7Y=M2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: virtio_fs: fix page fault for DAX page address
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Haiyue Wang <haiyuewa@163.com>, David Hildenbrand <david@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, 
	"open list:VIRTIO FILE SYSTEM" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 14:04, Haiyue Wang <haiyuewa@163.com> wrote:
>
> The commit ced17ee32a99 ("Revert "virtio: reject shm region if length is zero"")
> exposes the following DAX page fault bug (this fix the failure that getting shm
> region alway returns false because of zero length):
>
> The commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality") handles
> the DAX physical page address incorrectly: the removed macro 'phys_to_pfn_t()'
> should be replaced with 'PHYS_PFN()'.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please pick this up?

Thanks,
Miklos

