Return-Path: <linux-fsdevel+bounces-18831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9928BCE11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB331B2318B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F54084D;
	Mon,  6 May 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FvBv2a8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC01DA22
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999036; cv=none; b=hfvIvK/oeA8Yse5E6eR9cAaKpTi0skSkojcfHa+oTZWBQiKOidpj7eaX4hKMS02HSSE+Y58nwnh+x+nJDhAp3zWMCWJQQ3LEgcddRBCeRQcO87emN1A8Rh9oyZ9cEfTqg0w9DJBGwTSKfCyboKVOAKN2bhdFXydl/QVBVjiEqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999036; c=relaxed/simple;
	bh=W0ii3TeUy067aqvyqv+adtlSG49/aqc2GUx5qBI/NZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM2oGAm/QRZyy3lY3dKp/F3Yve0eZMtmXewDaGGDchwrvpBIlByOCWFKib7SXFDR2SXoRGKCjZZgGOFTmzvVBBIcxduQAUbBy/IZ5b5eIlv2dfadXr/c4hvjL8+aRe01+4t8IdGh1qGIuKOHzFGltq/GpLoEVQJyvtfOGdfKyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=FvBv2a8y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ecf80482bso1247275e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714999033; x=1715603833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmNWteJIHVG/FsNg6lLCmILTCJBN+MkrWHLSaZrPJk4=;
        b=FvBv2a8y7KaPOzeWXOlRwnY4lH1/WLZlQfEApXgvbpTUi6F1uRXzYtzHLxd34xbg1u
         lzQ4L8SrSgf8fTvp0TUjJwrwNvxd5DfSFpaHbPJ0Vust7ey2Py3OgetloVHthlUVf9qR
         z3R54uLMsCTneHkdevvCARM3z2xfNRrIIF8DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714999033; x=1715603833;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmNWteJIHVG/FsNg6lLCmILTCJBN+MkrWHLSaZrPJk4=;
        b=Fyp/XFd4yXmZygoMa/m0eVmxQGeoIHhxHQi1Q+pHJLBJsFjBm72ZH9LhIU5cZLni18
         352MbGuwvgCQI7SZWuWUhofT3LxgRD4KxpuLklFSQWjUeDA6yK5UwmSWV1US+Izg29QH
         XBHxCtPYSh9H05OqmOVACgBYMmXgmBmn5Cuc8Z7/VoNJzTS7p1Y1zO3a0nBFAzwcsN6z
         U9asWG+ts0gssJuN38jHBmE6aCVhI6slAr12ZhYcbuXWqlILFngKW6r6oVvb6fWNeRhs
         v1pUcYMCqJuSuNB7vWPxDZO/eBEgtc/cxe9A/kycPykz6vG5jwfxmA5bL3zshCd1fXhh
         geog==
X-Forwarded-Encrypted: i=1; AJvYcCXcmims40++syxP8lQloxHzDuB3QWKrlS8iy2h9V3bxZVNVSqOOjmduX7XLi6gsbVq6hDGW/WYtM3XWoMl5p4nvvc8sQVPrSw+Y3rWPJA==
X-Gm-Message-State: AOJu0YwGg3OHzmswicocjkmsAYx3SdrTFHr/Fw9Y+lp3gf9Hwnf6bxei
	E+AHpDeGE5Xb+GBTL7sni5e8LeeHa1c5SK53x+x2SS//i4vY4tYM5POWTyWX7Sw=
X-Google-Smtp-Source: AGHT+IF4oVKBpTMWMqUQ/dzQ+O/7RQpt5fMGVwZ3eSkPNG4BC5o71WjeNR+MccKjqHnTIbg2KzBZFg==
X-Received: by 2002:a05:600c:1d25:b0:418:ef65:4b11 with SMTP id l37-20020a05600c1d2500b00418ef654b11mr7944219wms.2.1714999033407;
        Mon, 06 May 2024 05:37:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0041c7ac6b0ffsm19767802wmb.37.2024.05.06.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 05:37:13 -0700 (PDT)
Date: Mon, 6 May 2024 14:37:10 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
	axboe@kernel.dk, brauner@kernel.org, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org,
	jack@suse.cz, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, minhquangbui99@gmail.com,
	sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
Message-ID: <ZjjO9kaRjT48Uyuc@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>, axboe@kernel.dk,
	brauner@kernel.org, christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org,
	jack@suse.cz, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, minhquangbui99@gmail.com,
	sumit.semwal@linaro.org,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
References: <202405031110.6F47982593@keescook>
 <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV>
 <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV>
 <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
 <202405031529.2CD1BFED37@keescook>
 <20240503230318.GF2118490@ZenIV>
 <202405031616.793DF7EEE@keescook>
 <CAHk-=wjoXgm=j=vt9S2dcMk3Ws6Z8ukibrEncFZcxh5n77F6Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoXgm=j=vt9S2dcMk3Ws6Z8ukibrEncFZcxh5n77F6Dg@mail.gmail.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Fri, May 03, 2024 at 04:41:19PM -0700, Linus Torvalds wrote:
> On Fri, 3 May 2024 at 16:23, Kees Cook <keescook@chromium.org> wrote:
> >
> > static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
> > {
> >         return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
> > }
> >
> > If we end up adding epi_fget(), we'll have 2 cases of using
> > "atomic_long_inc_not_zero" for f_count. Do we need some kind of blessed
> > helper to live in file.h or something, with appropriate comments?
> 
> I wonder if we could try to abstract this out a bit more.
> 
> These games with non-ref-counted file structures *feel* a bit like the
> games we play with non-ref-counted (aka "stashed") 'struct dentry'
> that got fairly recently cleaned up with path_from_stashed() when both
> nsfs and pidfs started doing the same thing.
> 
> I'm not loving the TTM use of this thing, but at least the locking and
> logic feels a lot more straightforward (ie the
> atomic_long_inc_not_zero() here is clealy under the 'prime->mutex'
> lock

The one the vmgfx isn't really needed (I think at least), because all
other drivers that use gem or ttm use the dma_buf export cache in
drm/drm_prime.c, which is protected by a bog standard mutex.

vmwgfx is unfortunately special in a lot of ways due to somewhat parallel
dev history. So there might be an uapi reason why the weak reference is
required. I suspect because vmwgfx is reinventing a lot of its own wheels
it can't play the same tricks as gem_prime.c, which hooks into a few core
drm cleanup/release functions.

tldr; drm really has no architectural need for a get_file_unless_doomed,
and I certainly don't want to spread it it further than the vmwgfx
historical special case that was added in 2013.
-Sima

> IOW, the tty use looks correct to me, and it has fairly simple locking
> and is just catching the the race between 'fput()' decrementing the
> refcount and and 'file->f_op->release()' doing the actual release.
> 
> You are right that it's similar to the epoll thing in that sense, it
> just looks a _lot_ more straightforward to me (and, unlike epoll,
> doesn't look actively buggy right now).
> 
> Could we abstract out this kind of "stashed file pointer" so that we'd
> have a *common* form for this? Not just the inc_not_zero part, but the
> locking rule too?
> 
>               Linus

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

