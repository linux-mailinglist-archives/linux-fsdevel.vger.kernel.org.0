Return-Path: <linux-fsdevel+bounces-34575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9D9C6620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A221F24ECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7EC13AC1;
	Wed, 13 Nov 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EoE+xZvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853BB665
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458345; cv=none; b=ZIh45LlX/p8vDhSnv8H0ravO0QkQhPfSTQaGrLZEGRf2Ggj68igIDQplhjiFAdtLaWpFaOSPEi6YGWGJD6gX3lxgzbwue06PvT176n9H/CFQxbxCA36k+NpXFX5ZWAiUvx2qINWAHt1DbzogI7dqdRwJSbi5GuSxAoMLBfTBdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458345; c=relaxed/simple;
	bh=YpobwbtA2+vKxtJu8xZ2FUyLg/btakBlHfnLUEUx69o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcUc34skMSqL3PP24lHXMGzpzaILWPSe/pFHZyMO/fmM2VhfLv8m54v/88/y8MpqNK5k2JAK+DcIaZvr0aKFA364zHaWUo31mNnRYu9qdGT5lF6engqVosgCHEQN8jOMMx254nufUTKPcTNJhVbNFhgNhXicg98ZmMMfmVD3nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EoE+xZvU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so1062066066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731458341; x=1732063141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HToIlSDY7cOn93fCLokqkKx9Z4UBbjM0FNxhpulJNm8=;
        b=EoE+xZvU6EDOKXSvsLLNaZJ9RmD6Fffex02A4Q4C3xXlUTc4oliTxpO+AKHeBUY130
         Od7ENT9349yuehtel68hjw6V06589TZmNnXGldpmdruBp02OUtC0GcAtx3KKQPc+XgOY
         w/yuR6jLbQux+QGscVnFDgk7Swp6D9d4z3ZL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731458341; x=1732063141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HToIlSDY7cOn93fCLokqkKx9Z4UBbjM0FNxhpulJNm8=;
        b=dGQXpMY1fzUIUCoGRRrEpge4kSdJdCBxCwl1syYuxSWx9Nt6dYkM8mAuM29r3t3oog
         /AezgVL4ZgQrQmiWRMyVoUOyp5GWy3/gR5gSi9cozoVT3ND9wBhV/d2Da3n77QPHLd6W
         USdSKzbDq+nXzjshRKg1btF1jX5MMcGUU+vlV1/iVOpOpb5febK0g8f7eYOiNnmjX278
         pFLoVMVgN+XYgFoSxLEo28gGk1RKs2PX/368+JOx+b4ygPzUPfi65wRqyvx+oZOhBo7S
         rHfrXu0BxGqsdhc02vHLkDzXu4oYdJlwZPDeYzY4lfMl8R0Os+TLWoVbt0YvpbxfFGd6
         Na+g==
X-Forwarded-Encrypted: i=1; AJvYcCX7yUXNCBy1grIrYqPoJOrMzAfofzXRfeOYE2xZ+n7t0KQ1u0wLV9SwKbbDJKIJ2BDcgD792b3hzdh+zQIT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MoHcC73hxKS74Wg0yFYtfkYUGsCW7MkvrrFKUjfbiFW9SvCm
	gdmfr92Ee9HUcjIJOGMVDZGQMBRyBBEMibcLKNMpIlmPSIpxHm4DCp4ppVq1/iTktvIaihCqfzL
	0wYBM2w==
X-Google-Smtp-Source: AGHT+IEgSaw3WroWFZfy0IFQrXfSpIMsiU1Wnz5r/KegT+uiTG2i5UamgTNfaCWfyynqQrlgz01a3w==
X-Received: by 2002:a17:906:6a25:b0:a9a:3fd8:9c95 with SMTP id a640c23a62f3a-aa1c57ae677mr504997266b.47.1731458341338;
        Tue, 12 Nov 2024 16:39:01 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc5759sm794555266b.128.2024.11.12.16.38.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:38:59 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so1062060266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:38:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD/PUUMziA19Sjrr+3uElTHm2BjXBGPe7P1zcDBNUL4pxJFjhac74x/mKkuTWvQ4dpfgmSxAC7bEftzdkB@vger.kernel.org
X-Received: by 2002:a17:907:1b0e:b0:a9a:1792:f05 with SMTP id
 a640c23a62f3a-aa1b10a45a5mr487896766b.31.1731458338247; Tue, 12 Nov 2024
 16:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV> <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
In-Reply-To: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:38:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Message-ID: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Ugh...  Actually, I would rather mask that on fcntl side (and possibly
> > moved FMODE_RANDOM/FMODE_NOREUSE over there as well).
> >
> > Would make for simpler rules for locking - ->f_mode would be never
> > changed past open, ->f_flags would have all changes under ->f_lock.
>
> Yeah, sounds sane.
>
> That said, just looking at which bits are used in f_flags is a major
> PITA. About half the definitions use octal, with the other half using
> hex. Lovely.
>
> So I'd rather not touch that mess until we have to.

Actually, maybe the locking and the octal/hex mess should be
considered a reason to clean this all up early rather than ignore it.

Looking at that locking code in fadvise() just for the f_mode use does
make me think this would be a really good cleanup.

I note that our fcntl code seems buggy as-is, because while it does
use f_lock for assignments (good), it clearly does *not* use them for
reading.

So it looks like you can actually read inconsistent values.

I get the feeling that f_flags would want WRITE_ONCE/READ_ONCE in
_addition_ to the f_lock use it has.

The f_mode thing with fadvise() smells like the same bug. Just because
the modifications are serialized wrt each other doesn't mean that
readers are then automatically ok.

           Linus

