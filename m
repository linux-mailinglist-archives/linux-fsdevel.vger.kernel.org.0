Return-Path: <linux-fsdevel+bounces-18698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93F8BB861
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1929E1C239E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3584E05;
	Fri,  3 May 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TBq5xg1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E683CCA
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779700; cv=none; b=ASQbWFp1KMMjxfGgSz0E1VsyX0OG4t/wLrVIE5RPCBZg+yOFakIF2alcfUcJylnbYQeR+d7sylQtH/bk2T6i5I36FVKquEC3IivtnMkJ0D2ercoBNpTjyoKCSDqeFr6WUsKw6aB8calSf6ZZPx11KajbWmZLNtnZ/VRoal8XVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779700; c=relaxed/simple;
	bh=MSsbpnKLBIIDiyb/Z/B6yI6NHQlm2qNPMZwpsoocZ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXwQGvQ2Up30ZfZVirWWoxpAmLD95lXX8GAmqerch0/nlQnVmozUps5teFjMklZmwFCdtVf7SQ+IzoBWX/wnPiU0ERLbrIlwrugE2h4jcangbwM9j88/dtEem9vY6q/tobjenChbdQkOcMgvJUKPdg0Rdsi0slCXhHZq9spZsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TBq5xg1s; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518931f8d23so173859e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714779697; x=1715384497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ap01jwoCR0DRWLobuG8Czpgd5Vwn2tKoOeVWkObJWkg=;
        b=TBq5xg1sBA8zV/mvmOtoPryVJZTi1gB6j+vWmIwg2mEE/pSua3tBUv1us7XB29RnWw
         tO3hPqZl9jXu58oSPTQz5waCBbsxXHKxVPXBISdIW55YhIZRm4XspJxonoxzkfJh/U2y
         jk39reGIDIaKeKhO7uFyt9Wk7pkjLAnOWM51c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779697; x=1715384497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap01jwoCR0DRWLobuG8Czpgd5Vwn2tKoOeVWkObJWkg=;
        b=BubhdmlUda2FWHnpWomoyjA7dxiNC6K3gZUIPFhOaytWi0rrsVq4bnBVksV6HAujwW
         rqgGr89H9Va1PURDtEw7TuMwWEeoCH4xI5LodaK+FHbmvvk+zdw2/AAUj7/9ETiiqxth
         99hwsgsUcom000UpMLpJMv5GhkLAkWCByFjEMEkDgW8UxhjeUv0XVT/pSUxM1Tn3PE/e
         lI75tD50W8sm9k+dxf/BwvmssiVCnNdoTkgK3UEWvgHno7vuh/EO/WghfMi6TXyQ/DHI
         oEmDq5obRsxVTdb3qfBL/oYNpuxQGgKtDAu2E20P/2WVphemvvRVQawCViVkc6Ix+1Xn
         1lDg==
X-Forwarded-Encrypted: i=1; AJvYcCXxNvGJZCYMreP2r/SATP7dqczAGEfZKAUf7gfG1wccEjvl0Eqes+Rat6WDxpgaN1iImS4M+hqNPUxM2CxQrEPhD9d0xnvOFVGANJRNAA==
X-Gm-Message-State: AOJu0YwAHGD9Iqy6dxvTYdDRGa5Bk0MOHg6Bdl9FXbZRojILde4EkMVr
	z4jRhlm4iLGoxB1SyCVE5d+KrLT+7WNex0SLf424VTWc/Jx07igiIxU9IDfdTHtrI0XwBicaLrP
	39qME1w==
X-Google-Smtp-Source: AGHT+IFq6jgWwzwrpcUB1RDbdhbtgTSW2EGr/9vrIpQ+Y8BMYRX2NSTIsN5rCWlaFdNsyDd5CO9TQg==
X-Received: by 2002:a05:6512:3d01:b0:51e:7e65:1060 with SMTP id d1-20020a0565123d0100b0051e7e651060mr3332283lfv.67.1714779696867;
        Fri, 03 May 2024 16:41:36 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n16-20020a05651203f000b00518e44b5d4dsm697711lfq.98.2024.05.03.16.41.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 16:41:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518931f8d23so173848e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXD9eojX/apA+z4+EHwpCOnxUkNofF+E/pDBvz6TfTQeg9byUacZ1pGGdI5PylStzPSVpTEVu5dBHxVPXXFZ12WLdDDL6Ar2utPHhXdqA==
X-Received: by 2002:ac2:488d:0:b0:51b:fc6c:cbf6 with SMTP id
 x13-20020ac2488d000000b0051bfc6ccbf6mr2434386lfc.16.1714779695990; Fri, 03
 May 2024 16:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV> <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
 <202405031529.2CD1BFED37@keescook> <20240503230318.GF2118490@ZenIV> <202405031616.793DF7EEE@keescook>
In-Reply-To: <202405031616.793DF7EEE@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 16:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoXgm=j=vt9S2dcMk3Ws6Z8ukibrEncFZcxh5n77F6Dg@mail.gmail.com>
Message-ID: <CAHk-=wjoXgm=j=vt9S2dcMk3Ws6Z8ukibrEncFZcxh5n77F6Dg@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 16:23, Kees Cook <keescook@chromium.org> wrote:
>
> static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
> {
>         return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
> }
>
> If we end up adding epi_fget(), we'll have 2 cases of using
> "atomic_long_inc_not_zero" for f_count. Do we need some kind of blessed
> helper to live in file.h or something, with appropriate comments?

I wonder if we could try to abstract this out a bit more.

These games with non-ref-counted file structures *feel* a bit like the
games we play with non-ref-counted (aka "stashed") 'struct dentry'
that got fairly recently cleaned up with path_from_stashed() when both
nsfs and pidfs started doing the same thing.

I'm not loving the TTM use of this thing, but at least the locking and
logic feels a lot more straightforward (ie the
atomic_long_inc_not_zero() here is clealy under the 'prime->mutex'
lock

IOW, the tty use looks correct to me, and it has fairly simple locking
and is just catching the the race between 'fput()' decrementing the
refcount and and 'file->f_op->release()' doing the actual release.

You are right that it's similar to the epoll thing in that sense, it
just looks a _lot_ more straightforward to me (and, unlike epoll,
doesn't look actively buggy right now).

Could we abstract out this kind of "stashed file pointer" so that we'd
have a *common* form for this? Not just the inc_not_zero part, but the
locking rule too?

              Linus

