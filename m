Return-Path: <linux-fsdevel+bounces-18929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080C8BEA12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0283AB2E14A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6316C855;
	Tue,  7 May 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YuH/FvLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF316C684
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100412; cv=none; b=sw5pKTk19hiQF9PM7hQx88gQn7H6GcCWF27JXSyiN0jbCiXHu/1ek7Lj5KcfyUYIeI1UD1lrAdvC4g0WEYvp5VIeoP3gczxDAMpB8E9MGj5qKh4l+HwjNEuxD2wt72a0zFw6pNxA+L5i7y9nMuOhJyYOjMd/SMAUkAoDJfQixPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100412; c=relaxed/simple;
	bh=VcUsDxZUpDGF/2Z4CuONrG7q84Dnoj3KVEQQuxcgc5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KPfjjXupj52w/CfB76Yl0raNjdvLK9SHcXPDHMq713JCCE1I7IFEH5Tjjx9qdXn8j/SMPGRf6yZSovCEDDdjyAF+rs0LSqb/99gPlaDGmg7H8ya+I+DyWNM05YOUGhdJRaX0pGB+YcxkK78cBQwKOLWlFyFgSSRY/bBAq28nbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YuH/FvLS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a0168c75so874826066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715100409; x=1715705209; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+/m+VOoT4mV8mZDo3MLSD/vsCL7+IgmGDq9kgXSLzI=;
        b=YuH/FvLSEp+hq5LKXfAFbcQa37Z0+i3u0KFvC06GPt20d7OUoaKK9JwVWu5bmkkItu
         4q+A8GXnUxYTLqd53NNh01oJ4z0yM67er2dTX96o3I+aL4Nm0te/30cnJe7jQ1oghHog
         sk/adP0hLbMQsZJCB1V4ClSOnfYsldEo09IxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100409; x=1715705209;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+/m+VOoT4mV8mZDo3MLSD/vsCL7+IgmGDq9kgXSLzI=;
        b=lo04gCtcnc5mXB161Pet+9AHnx4teS2tvHFpAUgS2SsjBzEAZgBvEhbDQqd68hzSxR
         AkAftGQHUkXR5i30/dqF7hCiyTgfCFvO6pKbHF8L1YSS+zcpeLR+yCqoM44Pov/FA+1H
         mExQuHO0sclzk3SqC+GypaBpAYIk4zEogQj7/B1JgUdgNV0unkF+kKG+hKS24VIJAjmP
         tzG0liS5hiz7dba/+LCqNU7tPVmb3eGpLSE6HbBk5MdxirawqVzBQ4RczN9c4W7+NiTM
         r7G7fMsYj/6RgtKePhkLpg+fs3mBFQENqwhFfuvuNiIg3AFKSB7jYD2fH4xgnHAxvrN5
         aPLg==
X-Forwarded-Encrypted: i=1; AJvYcCXvTxoZ5HXJzVuKWeAQUd/+/UGtcSK7mtVVBoiEkH6y15So51G2t8bP2wvJA0Lx3W++Ca0O2WMrhSzHliTsfEly2Ksw4ZywUrxdOKK9VQ==
X-Gm-Message-State: AOJu0YwOeh7gYtqHBw7WO/2SJL+D+oblSi85xpZk0C6D3THiTvgQ5Q/S
	Yz8TbHdsSx9QulcHBi//jJDf44UJDE5+fkdFFrrlZMoYNMrdQtz3N6Ul+Cp6sRtQAuGP6crecVH
	otz3/Bw==
X-Google-Smtp-Source: AGHT+IFiECuF8cq1IW/5PPVIOVeYuwnaKHrBew1DwKmVBG2crdES6bAW+qWgkao9dWrtOaJ76F1bNQ==
X-Received: by 2002:a17:906:a3d3:b0:a59:6fab:afee with SMTP id a640c23a62f3a-a59fb9db637mr911366b.62.1715100408892;
        Tue, 07 May 2024 09:46:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm2375896ejr.132.2024.05.07.09.46.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:46:48 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a0168c75so874817766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 09:46:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0gbmwH+iky549y/pV4sylNOmRgmvav+mw+HUSF3W2JFN7LoqgN14gm0mfmD+7aCigKlr00uSsN1shhD+ZOwqu9YjTtv2W5LEzUhpcTA==
X-Received: by 2002:a17:906:d148:b0:a59:b099:1544 with SMTP id
 a640c23a62f3a-a59fb96bda9mr1610066b.42.1715100407952; Tue, 07 May 2024
 09:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com> <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
In-Reply-To: <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 May 2024 09:46:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
Message-ID: <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 04:03, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> It's really annoying that on some distros/builds we don't have that, and
> for gpu driver stack reasons we _really_ need to know whether a fd is the
> same as another, due to some messy uniqueness requirements on buffer
> objects various drivers have.

It's sad that such a simple thing would require two other horrid
models (EPOLL or KCMP).

There'[s a reason that KCMP is a config option - *some* of that is
horrible code - but the "compare file descriptors for equality" is not
that reason.

Note that KCMP really is a broken mess. It's also a potential security
hole, even for the simple things, because of how it ends up comparing
kernel pointers (ie it doesn't just say "same file descriptor", it
gives an ordering of them, so you can use KCMP to sort things in
kernel space).

And yes, it orders them after obfuscating the pointer, but it's still
not something I would consider sane as a baseline interface. It was
designed for checkpoint-restore, it's the wrong thing to use for some
"are these file descriptors the same".

The same argument goes for using EPOLL for that. Disgusting hack.

Just what are the requirements for the GPU stack? Is one of the file
descriptors "trusted", IOW, you know what kind it is?

Because dammit, it's *so* easy to do. You could just add a core DRM
ioctl for it. Literally just

        struct fd f1 = fdget(fd1);
        struct fd f2 = fdget(fd2);
        int same;

        same = f1.file && f1.file == f2.file;
        fdput(fd1);
        fdput(fd2);
        return same;

where the only question is if you also woudl want to deal with O_PATH
fd's, in which case the "fdget()" would be "fdget_raw()".

Honestly, adding some DRM ioctl for this sounds hacky, but it sounds
less hacky than relying on EPOLL or KCMP.

I'd be perfectly ok with adding a generic "FISAME" VFS level ioctl
too, if this is possibly a more common thing. and not just DRM wants
it.

Would something like that work for you?

                 Linus

