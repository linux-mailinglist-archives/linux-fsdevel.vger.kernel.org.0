Return-Path: <linux-fsdevel+bounces-18936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600148BEB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1663A2875D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD116D31B;
	Tue,  7 May 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eo+YnCWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1D16C862
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105067; cv=none; b=MpwFO99bkYcS04NJh43wo3jWvEJylJ5aoerGGIldBa3hX4RiLdLRbYrxu6NQyHaxOHgfrSvX93Xf3SV5R3x0Lmcis6MNYDqjVGFIgawZeWjPRsehVoPDxx81vSb5m91q7zDfdOdcBEnL/I0wpt9e+LKBTtNA/qcw5327Ggvg2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105067; c=relaxed/simple;
	bh=bAeC75xvNb+JauaCbjaxHSxSCPq7tnqY5BqL0SZHYRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Id/ecTtLnkDdg46VDhv1Lo/LSKQeHEeT97kFV5aty8G0kvSfmQRe1m1/8XYWJI8zTuu4UiX9QQAb7EGdxkRIf5M2vjhhFwVHGST1nBlFKE44UgAteCOv9m3cRrpAqHB0ONy5sOh7h8LF2zvlVcd5aher6SpqUn7L1OWsLERhzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=eo+YnCWO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c74a49fc4cso125683b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715105065; x=1715709865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YmWheXdPpQuPLWl1RiMEbt0Eg1z181/dlD8IMNrkg1o=;
        b=eo+YnCWOylpYuKvM7GG0ZejU8v4QEDQ1r73vBdA99OHLl2GcaygX80XSd9UDYeJfvk
         3sDUd7+rkuhuYRoyrZ7S9Gw/e7g3GEgmha28eVvySJRUQiF3GIXqcuEPD2tknRAKTjIV
         YAuGOVeB9P/q7P5b3e00HC/xqHRlFGb2HMO08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105065; x=1715709865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmWheXdPpQuPLWl1RiMEbt0Eg1z181/dlD8IMNrkg1o=;
        b=tvOR7EfsUz4ki+rYUSdkfHXD7ZgOlgEFxzDipNdzTKa0RNYIeDnMzRne0DHhC7hlLk
         9XUdJ9NXqXb9h1uK4iopUlK9wFDFcIAgnDdXIOBUjtSL28iwO8wRX/5qX0w5RI1pj0gY
         DEWWeHTA7KAf18wgL+BGvgDyHLpQdF3+CGUDRN+6mQuRG4Mb2hUHCk/PCBP8F/ot86gQ
         PAXuYKBrhg1nH/5HI6YJtaOkvpWzxBpUSrl9CwlHfpWxlMiuknOtzAC3gA81qud8Xq59
         HiejNPcQ6ZNbHGai3uXg0s8a6ZWpmcY1FTYzPzeH2t/shir5hpfhX4bHDGXta1zA00HW
         rWSw==
X-Forwarded-Encrypted: i=1; AJvYcCXDmxlfiPyZfj7NZVfJvC44lKogzdfi0h7XUrb6dSdfHBItGcUyjHUagUL80lUPCLI5z9jPXeGKjw8VrVaB1WWh8N9jCB1iWmxGCDaPRg==
X-Gm-Message-State: AOJu0Yw6zCtQG9eE9g7dupCGvQJ5lxFKGi5Y0oR67ruYiBkkGuhyRRqT
	iAHZBNt8H6NIIoQ4mh5rl91elnLx34EAcOFjulmRQNISEFFgO2V5k/jlO9EpzYpIkCAHczPB8K2
	mpc/U/MZgh2WUqiuJ7vw8WC/aVzLT7sQWIVdTVw==
X-Google-Smtp-Source: AGHT+IHmrwrHAXCxOJC+DssE4b3IrYE7fedfWDlb1+phM010DsU5X6/lJatnzj106ycVmmtXnenEsbtAWj3Yy2ck3IU=
X-Received: by 2002:a05:6870:239a:b0:22e:dfbc:4aae with SMTP id
 586e51a60fabf-240980ba70cmr376610fac.2.1715105064951; Tue, 07 May 2024
 11:04:24 -0700 (PDT)
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
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
In-Reply-To: <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 7 May 2024 20:04:13 +0200
Message-ID: <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: Linus Torvalds <torvalds@linux-foundation.org>, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, 
	axboe@kernel.dk, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, May 07, 2024 at 09:46:31AM -0700, Linus Torvalds wrote:
> On Tue, 7 May 2024 at 04:03, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > It's really annoying that on some distros/builds we don't have that, and
> > for gpu driver stack reasons we _really_ need to know whether a fd is the
> > same as another, due to some messy uniqueness requirements on buffer
> > objects various drivers have.
>
> It's sad that such a simple thing would require two other horrid
> models (EPOLL or KCMP).
>
> There'[s a reason that KCMP is a config option - *some* of that is
> horrible code - but the "compare file descriptors for equality" is not
> that reason.
>
> Note that KCMP really is a broken mess. It's also a potential security
> hole, even for the simple things, because of how it ends up comparing
> kernel pointers (ie it doesn't just say "same file descriptor", it
> gives an ordering of them, so you can use KCMP to sort things in
> kernel space).
>
> And yes, it orders them after obfuscating the pointer, but it's still
> not something I would consider sane as a baseline interface. It was
> designed for checkpoint-restore, it's the wrong thing to use for some
> "are these file descriptors the same".
>
> The same argument goes for using EPOLL for that. Disgusting hack.
>
> Just what are the requirements for the GPU stack? Is one of the file
> descriptors "trusted", IOW, you know what kind it is?
>
> Because dammit, it's *so* easy to do. You could just add a core DRM
> ioctl for it. Literally just
>
>         struct fd f1 = fdget(fd1);
>         struct fd f2 = fdget(fd2);
>         int same;
>
>         same = f1.file && f1.file == f2.file;
>         fdput(fd1);
>         fdput(fd2);
>         return same;
>
> where the only question is if you also woudl want to deal with O_PATH
> fd's, in which case the "fdget()" would be "fdget_raw()".
>
> Honestly, adding some DRM ioctl for this sounds hacky, but it sounds
> less hacky than relying on EPOLL or KCMP.

Well, in slightly more code (because it's part of the "import this
dma-buf/dma-fence/whatever fd into a driver object" ioctl) this is what we
do.

The issue is that there's generic userspace (like compositors) that sees
these things fly by and would also like to know whether the other side
they receive them from is doing nasty stuff/buggy/evil. And they don't
have access to the device drm fd (since those are a handful of layers away
behind the opengl/vulkan userspace drivers even if the compositor could get
at them, and in some cases not even that).

So if we do this in drm we'd essentially have to create a special
drm_compare_files chardev, put the ioctl there and then tell everyone to
make that thing world-accessible.

Which is just too close to a real syscall that it's offensive, and hey
kcmp does what we want already (but unfortunately also way more). So we
rejected adding that to drm. But we did think about it.

> I'd be perfectly ok with adding a generic "FISAME" VFS level ioctl
> too, if this is possibly a more common thing. and not just DRM wants
> it.
>
> Would something like that work for you?

Yes.

Adding Simon and Pekka as two of the usual suspects for this kind of
stuff. Also example code (the int return value is just so that callers know
when kcmp isn't available, they all only care about equality):

https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/util/os_file.c#L239
-Sima

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

