Return-Path: <linux-fsdevel+bounces-19041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34098BF889
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696FB282357
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841815338F;
	Wed,  8 May 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eaeu5qAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A24204C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157134; cv=none; b=DJSPVehnMrW2oGadViANFwTKeqoJNO+PaJtz44R9od6D+HYX8zAp7NVfqCHKm/bOs6nRJSIaWad8iSfpAG9CETwLaifuGPYZEIswjL6BSNR2fb4/Z+TiVMRn1EaiWoU/gLvBWG1cr9Ix/NyC+yc/vhyhorLt5aMUozTA0Wh4/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157134; c=relaxed/simple;
	bh=b3DUk88N1D27ioVFvmL2iMHqSDZeX4sADmOjfnV9m+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXCZGwGRQR7H98/ov+iMu8RzbvalvWpONN/GSN/WXnbPkTWB1QMc4poBm3ELT7dv0IwcZ4x62Jp/rJjZnBClY3foxtxDWFtf60ZNzbcPdpWafAI8WLm9EMizN0QsyJtXxW1Qr3YbYIsz8JNmqBjmfb8xNQcRaL/N620W7vQJeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=eaeu5qAg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ad24baa2so135680566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715157131; x=1715761931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+L7cVJ0RXkqS3cuApbLADzGi4qIsO/ernkhsuK+4mg=;
        b=eaeu5qAglxOVyiOJOS4fHDF72gGQMJxJ+QWaAKQOEVXFSFTZwDvBysQONbDIZ/Agv9
         fqJaRJkP1H0iQtf5du7qnUEqAIKnrh+t+DSPOkAV3BTXUfRfQpcMOuB7CUvtlxYDCjJK
         CIT5X7aN5++07AxZRP/kI/84g2pUozbqsbbFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715157131; x=1715761931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+L7cVJ0RXkqS3cuApbLADzGi4qIsO/ernkhsuK+4mg=;
        b=NUReGPc4YGUT8mt2LGJooGuJrmS2EyzTLXUR6x8dJPreD+phhXRytrmNZASAZ6Of3e
         82k5ti1yVEinTZ7TE7XkWE+BXXL/o4Cg0BVLt9zs11r36t0mY4OiBpcFbpWVFBfugQHl
         SIkEwhHm4QXY9ghVigppnz8xCulncc98q0+sEaVqLPBO7G1evGjtihnwxDeAITYobSFV
         9uCowUYT7qIZUhcJ0wMbPG+KmDTAH4UEyfPKWaWrPvSmz9C0IlsTIXlXNTJLfjLurhS7
         GdX8MZTdbgt4gOfeJSwamSUuvwg+9KI0eMuhHFDlXZBZcB1xtliPo/Az9/VQf6yfoNAH
         /goQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNyM0luFkmp619Dx8s6oaSc8lQUVOQFH7Fvy4hiMkk2XS5TkSq2UKTAOPtxf6GF3rj3c3NVCFKZfu+PrqvDazL6xGVzwHMoPFifEwu9Q==
X-Gm-Message-State: AOJu0Yy4/GXeAkBySXuOwa+jxQKMm3d80WKGIaLS0gW319HbXW77Z6Q1
	ob902bD34q7bUq0wfYnVwNUE+gg+gjYL/5pbiKJyI/RHdq0H3F8adzZO6u6ZduM=
X-Google-Smtp-Source: AGHT+IHr0DJSEJ8IbuC5woWDxr1DEtRthw0/l9kV1uMkZSNSlIS/DcIHRg9/N+jRs+eVsPBC4/zXZw==
X-Received: by 2002:a17:906:fd17:b0:a59:7f38:8dfc with SMTP id a640c23a62f3a-a59fb9ebd21mr102078066b.5.1715157130873;
        Wed, 08 May 2024 01:32:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a599adfd49dsm6073415ejb.64.2024.05.08.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:32:10 -0700 (PDT)
Date: Wed, 8 May 2024 10:32:08 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>, Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
	axboe@kernel.dk, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org,
	jack@suse.cz, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, minhquangbui99@gmail.com,
	sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better
 about file lifetimes
Message-ID: <Zjs4iEw1Lx1YcR8M@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
	axboe@kernel.dk, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org,
	jack@suse.cz, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, minhquangbui99@gmail.com,
	sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
References: <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
 <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com>
 <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
 <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
 <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
 <040b32b8-c4df-4121-bb0d-f0c6ee9e123d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <040b32b8-c4df-4121-bb0d-f0c6ee9e123d@gmail.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Wed, May 08, 2024 at 07:55:08AM +0200, Christian K�nig wrote:
> Am 07.05.24 um 21:07 schrieb Linus Torvalds:
> > On Tue, 7 May 2024 at 11:04, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Tue, May 07, 2024 at 09:46:31AM -0700, Linus Torvalds wrote:
> > > 
> > > > I'd be perfectly ok with adding a generic "FISAME" VFS level ioctl
> > > > too, if this is possibly a more common thing. and not just DRM wants
> > > > it.
> > > > 
> > > > Would something like that work for you?
> > > Yes.
> > > 
> > > Adding Simon and Pekka as two of the usual suspects for this kind of
> > > stuff. Also example code (the int return value is just so that callers know
> > > when kcmp isn't available, they all only care about equality):
> > > 
> > > https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/util/os_file.c#L239
> > That example thing shows that we shouldn't make it a FISAME ioctl - we
> > should make it a fcntl() instead, and it would just be a companion to
> > F_DUPFD.
> > 
> > Doesn't that strike everybody as a *much* cleaner interface? I think
> > F_ISDUP would work very naturally indeed with F_DUPFD.
> > 
> > Yes? No?
> 
> Sounds absolutely sane to me.

Yeah fcntl(fd1, F_ISDUP, fd2); sounds extremely reasonable to me too.

Aside, after some irc discussions I paged a few more of the relevant info
back in, and at least for dma-buf we kinda sorted this out by going away
from the singleton inode in this patch: ed63bb1d1f84 ("dma-buf: give each
buffer a full-fledged inode")

It's uapi now so we can't ever undo that, but with hindsight just the
F_ISDUP is really what we wanted. Because we have no need for that inode
aside from the unique inode number that's only used to compare dma-buf fd
for sameness, e.g.

https://gitlab.freedesktop.org/wlroots/wlroots/-/blob/master/render/vulkan/texture.c#L490

The one question I have is whether this could lead to some exploit tools,
because at least the android conformance test suite verifies that kcmp
isn't available to apps (which is where we need it, because even with all
the binder-based isolation gpu userspace still all run in the application
process due to performance reasons, any ipc at all is just too much).

Otoh if we just add this to drm fd as an ioctl somewhere, then it will
also be available to every android app because they all do need the gpu
for rendering. So going with the full generic fcntl is probably best.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

