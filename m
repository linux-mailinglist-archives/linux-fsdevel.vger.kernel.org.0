Return-Path: <linux-fsdevel+bounces-32432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E895F9A501C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08F51F27DC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8718660F;
	Sat, 19 Oct 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DQ7Zd6BP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7118C33B
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358857; cv=none; b=Wh7pzw54/fIpyRsrqWWiM1kBCqKO7oeIWzm84LhpG73eoPv9FjT/CrfVu88kS5ONK6Yr13iNeb65PTwKZvukriptiyBSgrCX9ykyd9Lwm6A818n6FGjO9ItRwRrd8mwb/FJVx5DSPok5z0wSaMg6qF/cZho3UjSp8Xe8Ax/6bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358857; c=relaxed/simple;
	bh=ontuTpRSBFjoediaod8L53PGHivs0or50y62IvqAoUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAtUvboHzHxxSwfH/YdLg6cyp4Nv46ivHWu/DyKEnxahI6ZOyieQXrh0Te9xy4ORsSymZVyp5Vy5i86oj+5UpaziX1WcOrDknrVTx4aINfkxssV/sgTSQxabLkgbUEWSNpl6sFDQSlgqnRXHO/41jsX1YthRWu6olXm6/5I+Owo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DQ7Zd6BP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so30889525e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729358854; x=1729963654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=krew34JfzK1KtuNv7UDkmw4XlH9AmrJPuPrIgRH0nv8=;
        b=DQ7Zd6BP4dF4V+28PfCY8LDPF267h+KGk5VKCu+GHEesBZoth5ZVPAtf+XolsuB95g
         PYBQC3/QBXc2wifJ963bAOTnTQyijaZlpwEZo8P89iZwhtEQOPmpzvAEqd+lLhdb+nKA
         JeZc998AJyXvoV4t8Pu1ZL855DH7Dap9eWfng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729358854; x=1729963654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krew34JfzK1KtuNv7UDkmw4XlH9AmrJPuPrIgRH0nv8=;
        b=LbecBrZ8jN0mMxTGhQUX2s4VMy11rCTn3rE1Q55l6cFhKn71reiNaSCyAavp1Z+60q
         zYkvyl0zBuxwYp2e/M1OmEUv/yqEv5Wf2oXxxY+6P396xSvvMWhtZecYQhzJ9BeoM3fa
         OXr2ySsXv1N1WstY2m4zSXAtlduvC4byNygBXu5mfUjlCLtoAKzbImsza2EqMZk9O3pq
         d70Sr7j//m0xNIwatlFdqKQ5LZ2NYKzCF2SKcHgJnk+lFcnb4jm42R9pCXm5xIN8yO4q
         ye0/ane9r61OSSzkNbs69fFC65G7t4YEzABK+KVmg5++4Iq+/csiz4r2bMkGPgl52feS
         kGuA==
X-Forwarded-Encrypted: i=1; AJvYcCVMa0p284R6of4AmBXbzzErfxJun32TPd9Iy46dNUulPYOkWa/BuhJh/CJLwzNwMvaNWyzCIpcvW4oXRqZt@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqvdy2NV41CWam/dJFAazqkbAooyAedjKYxyuUQj0fpA8Nilf
	bY/TaB2R0AiGQojS5hPljHDcjAa0SmbpRZl4OHZAKL14Wg/xUFMYipTfMKJSF0hJ9c9f9xqnC4W
	RbS4=
X-Google-Smtp-Source: AGHT+IFx7zFmDlAnvkVpMFq8OVetm+3a2IUQ/oMES8J3WLl0BeiX/huGf9+cfhJNVjge2x3mk94Rlg==
X-Received: by 2002:a05:600c:1d8d:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4316169168fmr49012755e9.35.1729358853658;
        Sat, 19 Oct 2024 10:27:33 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc4f33sm231544466b.119.2024.10.19.10.27.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 10:27:33 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d58377339so3373940f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 10:27:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0Fxd5SQ5BVGFNtLPiwzrDmi99K42p28HdbA5Tt/7md08RVWeBnLocqdVKqWG8tptPEfrpRkiNIhMuCMMC@vger.kernel.org
X-Received: by 2002:a5d:4308:0:b0:37d:4619:f975 with SMTP id
 ffacd0b85a97d-37ea21d8b00mr5259751f8f.19.1729358852266; Sat, 19 Oct 2024
 10:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016050908.GH4017910@ZenIV> <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV> <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV> <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV> <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV> <CAHk-=wh_QbELYAqcfvSdF7mBcu+6peXSCzeJVyg+N+Co+wWg5g@mail.gmail.com>
 <20241019171118.GE1172273@ZenIV>
In-Reply-To: <20241019171118.GE1172273@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 19 Oct 2024 10:27:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVFiRrcsdDpDSvuVchZxvp5gCcv6Jojf7au2y86X4VTA@mail.gmail.com>
Message-ID: <CAHk-=wgVFiRrcsdDpDSvuVchZxvp5gCcv6Jojf7au2y86X4VTA@mail.gmail.com>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of pathname copy-in
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Oct 2024 at 10:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> There'd been an example of live use of that posted upthread:
>
> https://sources.debian.org/src/snapd/2.65.3-1/tests/main/seccomp-statx/test-snapd-statx/bin/statx.py/?hl=71#L71
>
> "" rather than NULL, but...

Note that outside of a library, I'd argue that using NULL is an active
bug, and should not be supported.

It's purely a Linux extension, after all.

That said, I do think my "what if a library implements fstat() using
fstatat()" argument could equally well be "what if a library does a
Linux-specific optimization and uses NULL instead of the empty
string".

So I guess it would be entirely valid for a Linux libc to do something like

       int fstatat(int dirfd, const char *restrict pathname,
                struct stat *restrict statbuf, int flags)
        {
                if ((flags & AT_EMPTY_PATH) && !*pathname)
                        pathname = NULL;
                return SYSCALL(__NR_fstatat, dirfd, pathname, statbuf, flags);
        }

so yeah, I guess it's however we just decide to document it.

               Linus

