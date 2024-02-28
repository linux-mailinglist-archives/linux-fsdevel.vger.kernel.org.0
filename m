Return-Path: <linux-fsdevel+bounces-13133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A8586B9C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EB61F23484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF170020;
	Wed, 28 Feb 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B+m69ozj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB486270
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155289; cv=none; b=BtUo+rPFKVwLFp7U5SKsnPsC3+kHNt7dUwR8z8hKqWRLDv2ABsX+//44UilT2hprojrGFWyp1PJjzUiIDZ4g8HexgO5Jj17oot/xDXhJx2QY5ZwWQ2RZmkQP5sPlklwGJicut/IHmpwwmct4I8fx50kfJS90T627Jf1UUKEiYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155289; c=relaxed/simple;
	bh=1MRLxMSSbDaZOoH74gZrRBxdj01ORAzox/zNSSQV35k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfGJAABd50qa1FSVemCndudSUfoynYWE8NFsCFgdyAZNxibWvI7C5aej15ajQFEB0vcCoUb1WfKvf0LIYBufqVf34vzX1CtHia00ueRHc4wfSRAsXOoIHJ12b1wNnNlRO/WPBnSbqnb33ybW3A/m+7FhE1GMHjKsEjdJlNTlYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B+m69ozj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso361059a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709155286; x=1709760086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=B+m69ozjwNePNGkNIqZxY5cYxPT5xZkc2iYa3mL8hTrYFU1YOYVnRJsPkJqCi2ymQp
         hTWjmaksS/HCeGz5kk/DM0ms6EkmbZ5//kAhxkq4/NA3lQz8y8UqCP2WwQMif4pCIbFR
         Ue6ZGIY3ca0Oo0WS8pFOfA50DMxhF4102kkC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155286; x=1709760086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibURPhL0TwbuNHb2Ue6c1VsEM5dnOByPcep2Xd5k/OA=;
        b=vpon1nFFLrHpZ3fiP+3Ir4i9YkGfPbYzOmOgN3mBgqMZTbFX+693fKWyLI5aVb2+3w
         Fb5TVdPERVy/nuoiPZXhUzUdIkjbdNI5JJ72Qv4aY/owtzAY3rqD+cpYpThtuKUndnEq
         b92MDI/lnoMQ4x2eN9W5FY/LKe4UhFT2HvVgYb6bNjF4LJcQlaxaxAU6TDlVl8RxCGpb
         ADJ9/kKEF3A9a5GKPG2QgHJkcVrCs/t7WVe7Dx5gfJNItRFLAkfXQz/RbnvvQRU/IBqB
         BxTFa5SR26f+8cGnj3E6XueUKi9aGotv3IgG0X6YRFFBZ/XNmwYsYlAUhFFKuWupDTEX
         mekg==
X-Forwarded-Encrypted: i=1; AJvYcCVanil6jgpY7KiP9agt7IC3tmPHGgyUP/3M1F/4gPbJS2gS+e8dBbADcXnwT9PfDM8YBuMEl4wE2K5lUR51RtbdDaOYgEa9NNuguABE7Q==
X-Gm-Message-State: AOJu0YxKZfnZ28TUICQcIQ1x54N+Oz5X/DNh8RATM4FelgWn+VDZUY+O
	emPYSLQVmlg/k3iDC0qMgsXcBarm9U+4GRdws7zOImooW3I0LukwbT4vcsd/L4k+SDOIp8iU/mB
	rmxo7vg==
X-Google-Smtp-Source: AGHT+IGkkgi5rTRsXoQ4X32dAp4OseK+JAdi0zy2PSp/i3hkm2dZtT8bcmTuZj0pv5Ve7L8qlvZ1qw==
X-Received: by 2002:a17:906:548:b0:a43:f587:d428 with SMTP id k8-20020a170906054800b00a43f587d428mr82109eja.76.1709155285947;
        Wed, 28 Feb 2024 13:21:25 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id ss15-20020a170907c00f00b00a43f0dff8dcsm1143238ejc.53.2024.02.28.13.21.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:21:24 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso36017466b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 13:21:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXotVdj8sTY2vzg6sRoVepI8XcGlvilY7nbxj467gs2IE9jDdFcuX0aET+eGemz3QVVMEsMC99uan2FidOiHf5tJJTxymqjoMx8qPddgg==
X-Received: by 2002:a17:906:a291:b0:a44:234:e621 with SMTP id
 i17-20020a170906a29100b00a440234e621mr129720ejz.10.1709155284453; Wed, 28 Feb
 2024 13:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
In-Reply-To: <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 13:21:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Message-ID: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 19:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> After this patch:
>    copy_page_from_iter_atomic()
>      -> iterate_and_advance2()
>        -> iterate_bvec()
>          -> remain = step()
>
> With CONFIG_ARCH_HAS_COPY_MC, the step() is copy_mc_to_kernel() which
> return "bytes not copied".
>
> When a memory error occurs during step(), the value of "left" equal to
> the value of "part" (no one byte is copied successfully). In this case,
> iterate_bvec() returns 0, and copy_page_from_iter_atomic() also returns
> 0. The callback shmem_write_end()[2] also returns 0. Finally,
> generic_perform_write() goes to "goto again"[3], and the loop restarts.
> 4][5] cannot enter and exit the loop, then deadloop occurs.

Hmm. If the copy doesn't succeed and make any progress at all, then
the code in generic_perform_write() after the "goto again"

                //[4]
                if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
                              bytes)) {
                        status = -EFAULT;
                        break;
                }

should break out of the loop.

So either your analysis looks a bit flawed, or I'm missing something.
Likely I'm missing something really obvious.

Why does the copy_mc_to_kernel() fail, but the
fault_in_iov_iter_readable() succeeds?

              Linus

