Return-Path: <linux-fsdevel+bounces-45688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D3A7AF13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 22:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF216604A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49422E415;
	Thu,  3 Apr 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A4QKqm0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE022E00E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707948; cv=none; b=AfXg4HxV9dWmW/Ngqz6VFzsmpLekDcVT6R7/SPHhRkfIIVdEaZokwWBps3q9qpEz+68fNxLkZIdM/XlgiPeyPcvex6GBb7gTH73Q1GeVJPGHk5gowJ+tIMj0MXa1e84fH7u3RGGYYXSwqIMnaifX39n2bqb91J+B1WLCMhp3ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707948; c=relaxed/simple;
	bh=T5uoDV9HKncHWI6WuWJr72wllf/CE9rQIuIo7jAU41E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agOGFArtk4b2qMPx0i5dyIwRlfmihF3PaUE9triRcEaQJex3Z+BOs6Wf0djH4JA2gJt188Yf1nt2qdzZe1jkdRYT+xkLz9xT2xpr35jqJJuNBBG+nU+Mtem75gINwEAFR+QwmP38kaFnVfCtuSF1zECgCBHFxHWqX/OQ4RpST4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A4QKqm0D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so244677266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743707944; x=1744312744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOJ+a6c7HX+Aw8dr/wh7QGl7onl6cqWKpJLTwkfT2G8=;
        b=A4QKqm0DKMkO8/9BQrvm3PoaYGAuSdnYKTO7weA7DN+7Ya0rqZPCMmWHmnPv/FBfx8
         cWx7xoTDaPxSVbsC02Tb0OLWhh8Y6BKJMn5Fkayqtk3iF5pJiOLRPaEZqAW8LE2KPtnD
         J8hL67DjpGQgms90Ys4QkJY8rlXN8JgEOCGek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707944; x=1744312744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOJ+a6c7HX+Aw8dr/wh7QGl7onl6cqWKpJLTwkfT2G8=;
        b=aHd5LoT/yony+7YgMsFkQsiUCD+G2Rrcm6Gil08nA5XyDAPu7rFM+WIrZSgIXSxgi/
         Dh2mEbRgOCyOF8S+aytPBSJeem9OHz8goxofWMb4ysAX6OE6+pfRHWb9FR9kzMtp1RFU
         mU4g5idDDXOBvZWd9v5Wv/p1skFEUCHsqrkqhNnAe1LmuuxjIJ9mjeEqgpZBVhuTQV4h
         Qu/z/GyB6ycnlEVv2vNhJwCe23SEFDQJ2lClqlYjPUHAelRSBSHmBzIdCjj5C0gjaQPU
         U3tURyT+8fAMzqNzgbJ4Vq8AHIQVaoI9a4dUEb5rHnCS1q9wFeAlgGwi2FI1JDW+bdur
         sw6w==
X-Forwarded-Encrypted: i=1; AJvYcCUr00McUYNXnZjTItqHJAYAL6O/ubaoexWbehjtkxAB87Q8ZniQ+sNYacGHApPSYLvsZDd6TwKPOTPfppj2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq7r7C0YSwzEpiC8bo+Ba6L6qQmInHOr35vHLFbzO5vpMCOvuW
	wNeabakuBb4Gm8L1Agq9hPGjNVYa4SNFk7qviHvS0bjJfeNSg+y/7ZGxutINIC20qP2L8bXepXG
	cfsI=
X-Gm-Gg: ASbGnctC6T2nNcuRrF867gPySZ8z/8Nx0F202l0es0ZPTlxZS/Ng8NSdv58UluF9Hk4
	unb91pZJ6fwyZ28bnhoL53Sh+s7Vf793t3v44gxk/xfQ85F+VOC3steGF5nVZgXMq2xn5+6kQK5
	uGjKoLV9joOsTDpMtu55IEln8RSBVytp/EGqietGxLwS7JNjzL0FqYpwp52p+GKrwhd0XivGr39
	1BFocGCJLAdrfokCXPLy7e36UGfCyto5g+BxZRPiDbe0FQS2lHuWFeVsngohTKi+9eXvtQONNJx
	y7+YF7frRD7+bgIqx5gi/Yk22+LehdB+SBFqPUhEEJQ8w9CzamU7/NqPDTSm5W4Hs7ovcVRjf0K
	b6bRx7xUaJaKknfb7k+k=
X-Google-Smtp-Source: AGHT+IFUEV2idIQy3XuGGYi8st+IdMOhgCa30Y04u9F0sYf10qhKTa74vSy04iQCj9YCMIsZ/eSgPA==
X-Received: by 2002:a17:907:2d94:b0:ac7:805f:9056 with SMTP id a640c23a62f3a-ac7d18c5f64mr70852866b.32.1743707943718;
        Thu, 03 Apr 2025 12:19:03 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c018aeadsm135078266b.153.2025.04.03.12.19.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 12:19:03 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so244672766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 12:19:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdW//0nRj+nppU+YyvG2EK/CC5R0Kb9yRnCyXvZtGaE4fsi9OlpvWOqAOfgi/LgGQxZBnnv5aXrnh2h9/h@vger.kernel.org
X-Received: by 2002:a17:907:9801:b0:ac7:33d0:dbe with SMTP id
 a640c23a62f3a-ac7d18cb7f9mr80311566b.33.1743707942619; Thu, 03 Apr 2025
 12:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-vfs-mount-b08c842965f4@brauner> <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal> <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner> <20250403182455.GI84568@unreal>
In-Reply-To: <20250403182455.GI84568@unreal>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 12:18:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>
X-Gm-Features: ATxdqUFMslVpxLZQwg1CWi9MwTwtlcmOR2f0G9_2Lk6dEltjaQ2iJobffD6Dc_o
Message-ID: <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 11:25, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > -     scoped_guard(rwsem_read, &namespace_sem)
> > +     guard(rwsem_read, &namespace_sem);
>
> I'm looking at Linus's master commit a2cc6ff5ec8f ("Merge tag
> 'firewire-updates-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394")
> and guard is declared as macro which gets only one argument: include/linux/cleanup.h
>   318 #define guard(_name) \
>   319         CLASS(_name, __UNIQUE_ID(guard))

Christian didn't test his patch, obviously.

It should be

        guard(rwsem_read)(&namespace_sem);

the guard() macro is kind of odd, but the oddity relates to how it
kind of takes a "class" thing as it's argument, and that then expands
to the constructor that may or may not take arguments itself.

That made some of the macros simpler, although in retrospect the odd
syntax probably wasn't worth it.

            Linus

