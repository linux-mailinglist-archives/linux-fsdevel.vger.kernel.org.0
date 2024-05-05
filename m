Return-Path: <linux-fsdevel+bounces-18779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C751D8BC3C7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 22:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9558B20FE8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D67603A;
	Sun,  5 May 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S1WupaUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076E757FD
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942452; cv=none; b=hZjB3PcweTmIelUCOeqeRzDv2MTRLHdohq4PqvcTT3xnzDOkESh+fnC1UIXk7bmZtcJjg44FbWaUrQP/lI4i2PWoMsWBlzzrh20FmFDW6K/MeFu9mWxrWRF6ESkPEABImaHPlweKI36YaLubFKfWGXImikivP4+8h4DYC3Zucvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942452; c=relaxed/simple;
	bh=R+qvYyLMsL0XW6ld3jDTzisj//rKgA9vvCmBe+m5ItU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nmm0fNJTrLBHpKlp74ar7PpuX5U+iKndWsQ9P61ZZWBfwToRwf72uWOCdXk0sjcLdtF1tgBnUnOD/mmH9fVvGNylsQaTcPwpwF/FazMfos1o0azBow5zuBfxbvz+0yCdRortXtFAbHT8hGSPakRtvr2X/VUlx9Yi0obr6n//zO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S1WupaUB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f40b5e059so1575900e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714942449; x=1715547249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMg+wUi7Jg85TzG1l7LAOtzS/OMsOgVla4IG61dTMc8=;
        b=S1WupaUBE/T6xO763HbNcrQt4mJF7Woj0imNFn9H5gLCTsguhiNT8L/9gbUz92gNK1
         YFjMnbf4gLBCJXiCBDT5aRpSzcNjIvge0mMpcr+lMoCymfr7RMuCfEPJADgkIM/Ma4EE
         STICDlWmK00GTP974VlqubyS3rgr5wT4U2lY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714942449; x=1715547249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMg+wUi7Jg85TzG1l7LAOtzS/OMsOgVla4IG61dTMc8=;
        b=cn+wEkDIV0jgx56ugtFtPbogK6J+a+QNdCPuZ7CaN15PH6+Bzsu3xGblzBJnl8D4BD
         vmxYkTgsUmatV8Q1wBnj/H46Ly4+QY3gNS+AV4s//Au8phYe9W3xBc51GcmUv+2BfTPE
         Mr5RFhPK09lZK/SPbazG4i6yD+UldbPEGRqfP8TwanQaZQG3jJ9gfl5ku9eFBSMEkkm8
         /EjrPvcLO5arvuraNXna7n9u1xUoQPy3Er6PTSf3DvRNqlpPs0JIghrncWmNOVwgXFhP
         eXctt8PjzrFhuQrwfFIal0UYQJhTANPrFDiY+FlaSWoSR7Gyr8KUnVGEKJ24gz+UBnrz
         4RSw==
X-Forwarded-Encrypted: i=1; AJvYcCWmX+NdraJRNbpv9bsH8VmnWAuA8LIRygvHU9hIq1jhHy79doRzbQU3nR2QKwlHCtLsKXBgDi2wQBoZO0h20yk7qPP1KSW+TVZPHKcdGg==
X-Gm-Message-State: AOJu0YxChtOrhCqJWt/kQQKw3z1FcZqpuLeUO/vvpvLoPIj+xutofDrZ
	8Z3FaJrSV++3eKeV06X6oMOJjnDytwIp7Bre95q8Y5TtvoxcwUbDPsVi7NwzE+OcqRECJq2/jR7
	RvOF3sw==
X-Google-Smtp-Source: AGHT+IF9dl03rBwDsMBxhooQR2u2Ral5/2+VlJ//raffazRB/ou9I6dQ5TCUwWkS0ZKKcU5ISzsa6g==
X-Received: by 2002:a05:6512:3e3:b0:51f:5d0a:d71a with SMTP id n3-20020a05651203e300b0051f5d0ad71amr4865829lfq.10.1714942449012;
        Sun, 05 May 2024 13:54:09 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id es26-20020a056402381a00b00572e2879500sm2210878edb.53.2024.05.05.13.54.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 13:54:07 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so9547635e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:54:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmuRL3bCelJFXFikZ8xCf3CVPiqMklI1Ijq6GLiIa48o5ucnGDN891UeILlkdm2oiAgqcHpnUyPzkuGMv9uDRRCdhzcRbFhCNq5A+etg==
X-Received: by 2002:a05:600c:314f:b0:416:88f9:f5ea with SMTP id
 h15-20020a05600c314f00b0041688f9f5eamr6455233wmo.34.1714942445499; Sun, 05
 May 2024 13:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
 <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com>
 <20240505194603.GH2118490@ZenIV> <CAHk-=wipanX2KYbWvO5=5Zv9O3r8kA-tqBid0g3mLTCt_wt8OA@mail.gmail.com>
 <20240505203052.GJ2118490@ZenIV>
In-Reply-To: <20240505203052.GJ2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 13:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFg8-WyMbVUGW5c0baurGzqmRtzFLoU-gxtRXq2nVZ+w@mail.gmail.com>
Message-ID: <CAHk-=whFg8-WyMbVUGW5c0baurGzqmRtzFLoU-gxtRXq2nVZ+w@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 May 2024 at 13:30, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> 0.      special-cased ->f_count rule for ->poll() is a wart and it's
> better to get rid of it.
>
> 1.      fs/eventpoll.c is a steaming pile of shit and I'd be glad to see
> git rm taken to it.  Short of that, by all means, let's grab reference
> in there around the call of vfs_poll() (see (0)).

Agreed on 0/1.

> 2.      having ->poll() instances grab extra references to file passed
> to them is not something that should be encouraged; there's a plenty
> of potential problems, and "caller has it pinned, so we are fine with
> grabbing extra refs" is nowhere near enough to eliminate those.

So it's not clear why you hate it so much, since those extra
references are totally normal in all the other VFS paths.

I mean, they are perhaps not the *common* case, but we have a lot of
random get_file() calls sprinkled around in various places when you
end up passing a file descriptor off to some asynchronous operation
thing.

Yeah, I think most of them tend to be special operations (eg the tty
TIOCCONS ioctl to redirect the console), but it's not like vfs_ioctl()
is *that* different from vfs_poll. Different operation, not somehow
"one is more special than the other".

cachefiles and backing-file does it for regular IO, and drop it at IO
completion - not that different from what dma-buf does. It's in
->read_iter() rather than ->poll(), but again: different operations,
but not "one of them is somehow fundamentally different".

> 3.      dma-buf uses of get_file() are probably safe (epoll shite aside),
> but they do look fishy.  That has nothing to do with epoll.

Now, what dma-buf basically seems to do is to avoid ref-counting its
own fundamental data structure, and replaces that by refcounting the
'struct file' that *points* to it instead.

And it is a bit odd, but it actually makes some amount of sense,
because then what it passes around is that file pointer (and it allows
passing it around from user space *as* that file).

And honestly, if you look at why it then needs to add its refcount to
it all, it actually makes sense.  dma-bufs have this notion of
"fences" that are basically completion points for the asynchronous
DMA. Doing a "poll()" operation will add a note to the fence to get
that wakeup when it's done.

And yes, logically it takes a ref to the "struct dma_buf", but because
of how the lifetime of the dma_buf is associated with the lifetime of
the 'struct file', that then turns into taking a ref on the file.

Unusual? Yes. But not illogical. Not obviously broken. Tying the
lifetime of the dma_buf to the lifetime of a file that is passed along
makes _sense_ for that use.

I'm sure dma-bufs could add another level of refcounting on the
'struct dma_buf' itself, and not make it be 1:1 with the file, but
it's not clear to me what the advantage would really be, or why it
would be wrong to re-use a refcount that is already there.

                 Linus

