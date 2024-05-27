Return-Path: <linux-fsdevel+bounces-20275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199608D0DF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C961D281630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2F15FD0F;
	Mon, 27 May 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LjxmE6kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA01EEF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838533; cv=none; b=WTuEVGEHP8PDqRZabQuzNbzAzAI6m7retJ/Hu4MiAeyyHgphZYesmmn7uZvJ1XcwkP6YuRUZ/4dxECWnLodOTuLoiudQ4WWe2HM7kfCDM6aT9T7ZJzs8W2daX8pZ7hVPeNSgz+VN5RjW0iQTbVtgDLxSqojPbvPo2O/3Q5ezFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838533; c=relaxed/simple;
	bh=ZAC9dibzZkUV27AOfCm+HmzKUnlE6D9L0M0AmO6yPKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVrr+QfiLvoRg3gsrYIVTg0jXQRXwww0bnmnNjpxqehvXadLnsx5D2LRc7M5tYKV6l+9njHAJt6y1sWPPFCsjObuNFkQ7uUCmtKMUsIx/mPlc4kQqpuHXbBqe328zfeSSckhhympCz+Rn5fV2MjMrBnkXUwNIIYJNNJg57ayWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LjxmE6kq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-578676a1b57so22689a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716838530; x=1717443330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YkZYHxtJS2xHnOCsSRDKNUe9pZJf/wZ8lc/xWYyje1g=;
        b=LjxmE6kqLHwFEJ091HnhXeOMbBXkl8JChT2fW1woYY7kN03fF7wVF2FVETAZJB26vM
         yjkgEgpSm3v8Q22XHnrB62iZWQlQ5QHmBvQmlSFmma3L6+sYyPIWWGWXoC3BomNxzs/t
         HyiWLGX0A2XY6c2omgWIQQ7XPfRGb8eSWz85s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838530; x=1717443330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkZYHxtJS2xHnOCsSRDKNUe9pZJf/wZ8lc/xWYyje1g=;
        b=lryUQXGiJvK+XWfYOSPumJGopo0Y1ucDQ86v+3JZKCbGF8c7yKK8FF8HlqVKk7mpHk
         8bEhGwsqIcDTloKHmvjlqnL9tOGGzDggn57+FNtdxUkEORDFQ6PP6ebvJdOxUrz/jxnO
         WrI1/kCS7IzM6DqJCrfLk5iQXXcnoBU06nWqjcOLhuL4hpfMSOGKmgHBz1mG9ZzArhy7
         fRUEm2GFqH8sDpzGVdibWZkjdew2sC/qL1aixVPx9JuQsxDQ46b9an9sv0nRZfdgdM0A
         n0xeO9pU6M2X9+O0lvhxrtSd9ZvpdhG6HozuyLjEVh4LmEPhaqToxnInVmAoqnyYyCvu
         MrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7MvCGgyY3veMRgte5xcvIfA2G3aBgwJISnIGwKWCt2bxgKdlXtx8hmF0DOeJkkM3SME0Db5CH3O20qk04w7Bc203Gg0s9gY85JFwbDQ==
X-Gm-Message-State: AOJu0Yx3NKhGcmVXtTDObhd/nzhuI6ZahKmEbM9XTEuE+PHGKAjG10C3
	G0AUkaNNtC2wNzBqeZtX/xTy74uk8fOBvw1j+Q406x3EsPbnS8vs5fc7mH2hTtNatnC+tCRZqPv
	3yi0V2A==
X-Google-Smtp-Source: AGHT+IHvgSlZrOafEWy31LVFbRrnhWHlvP/nppD7w0r+okG3jU7Hy/d3VtIsrP7iMx25ZoCFfU+YnQ==
X-Received: by 2002:a50:cc43:0:b0:579:c460:67d4 with SMTP id 4fb4d7f45d1cf-579c460a72cmr4652167a12.7.1716838529635;
        Mon, 27 May 2024 12:35:29 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785241268esm6176964a12.58.2024.05.27.12.35.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:35:29 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354faf5f1b4so46022f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 12:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHEksem7Xb8rU+XKlMoeyx99TM6x8BOzXX6vL9sa+o09wks8OksOd8ttpJSPxr5jDRVACKOytlJ35/tkOKyd85qWJ6o9FIUozyaXm4BA==
X-Received: by 2002:a05:6000:1742:b0:34f:41e7:eb37 with SMTP id
 ffacd0b85a97d-3552fda7295mr8768323f8f.30.1716838528781; Mon, 27 May 2024
 12:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV> <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV> <20240527163116.GD2118490@ZenIV> <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
In-Reply-To: <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 May 2024 12:35:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjojZuj_it97tBRZiHm-9bP1zUbmVs-g=M2+=DP-kF8EQ@mail.gmail.com>
Message-ID: <CAHk-=wjojZuj_it97tBRZiHm-9bP1zUbmVs-g=M2+=DP-kF8EQ@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 12:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> With just a couple of helpers it would be mostly a cleanup.

Looking around, I think we could even take four bits. Without any
debugging, 'struct file' is 160 bytes on 32-bit, it would not hurt at
all to just force a 16-byte alignment.

In fact, in practice it is aligned more than that - we already use
SLAB_HWCACHE_ALIGN, which in most cases means that it's 64-byte
aligned.

But to be safe, we should specify the 16 bytes in the
kmem_cache_create() call, and we should just make this all very
explicit:

  --- a/fs/file_table.c
  +++ b/fs/file_table.c
  @@ -512,7 +512,7 @@ EXPORT_SYMBOL(__fput_sync);

   void __init files_init(void)
   {
  -     filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
  +     filp_cachep = kmem_cache_create("filp", sizeof(struct file), 16,
                                SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
                                SLAB_PANIC | SLAB_ACCOUNT, NULL);
        percpu_counter_init(&nr_files, 0, GFP_KERNEL);
  --- a/include/linux/fs.h
  +++ b/include/linux/fs.h
  @@ -1025,7 +1025,7 @@ struct file {
        errseq_t                f_wb_err;
        errseq_t                f_sb_err; /* for syncfs */
   } __randomize_layout
  -  __attribute__((aligned(4)));       /* lest something weird
decides that 2 is OK */
  +  __attribute__((aligned(16))); /* Up to four tag bits */

   struct file_handle {
        __u32 handle_bytes;

and while four tag bits isn't something to waste, it looks pretty
reasonable here.

               Linus

