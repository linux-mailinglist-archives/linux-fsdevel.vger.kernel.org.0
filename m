Return-Path: <linux-fsdevel+bounces-19697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4255D8C8D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AD1F2334E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E558140364;
	Fri, 17 May 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+4+siCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21B65F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976485; cv=none; b=jCpJzXNTf2NdsMNsbm23MoLoKHLzX2JWpAiFHftKYEEceKFpb1nRpBTFLlk8mW69eYV89Jt3rFFU4o+4Y/tQar8U3Tl1a6CFVfzjjT1wR+g+NiRXdfKMftbX/UmSOj07fzOkMfGUFhFaoLuT2+JZLdISyl7h1ISlZBEUxCXep+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976485; c=relaxed/simple;
	bh=7IgxB0kiiQMpwo7s2tIvd/RS+XyMu/z/CbpWJ6EllWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfL0Trf05x+/Ze+c7yhSHm0wshagsTKj7qR75o3YuRViONHimhO8nitwMzyA//pM1d/OsOQIXYma7wmRO7p0P6D9X8MFMTk2shtqeKbfKHNubRTbAE9LCJ2M15E3h2p1f5UtmHxaFAq1HogMfL+87Yl2bL74M0O9QWvT8u9pE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q+4+siCt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59b097b202so403505266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715976481; x=1716581281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PxPHFD4y9TQVnLF3OPdeMfeUh0vrSiPGIUpBI0E7gI=;
        b=Q+4+siCtLR1k5ODhgieV95YIZSgnm+Vjez0ZF4ihjgyMPGZ/L9065tSsaHNDfxRusL
         TZSikCgd3wybl0tOgfv65ZugewsKPtBox6ooV4gB0aiDFQpAObF6nkOQYLHuOOysFrQL
         vxe3sjhnA/UmDKeKs8wdtVmaiy72muqvwhdmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715976481; x=1716581281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PxPHFD4y9TQVnLF3OPdeMfeUh0vrSiPGIUpBI0E7gI=;
        b=CY1aJZOF2U31uk3c+RnjoEZUt5NDH8hcfIW8hymgDHKckSyljzQFgsw9KKpJT2peZ9
         wSEyjQsRBLNBBz2U2YOd64IaCutp85uxTn0QVcZqkx2CI3cM2ZgxtWsV/xfHbwL43peT
         cvuIGRUcvMzc4NDZ9GkqcCgb3X84ZMXR/GYOfhIatlx8oH5FE+dTPu2I6lXuTqJ6Psv+
         uMGlCjw8hP/PXcau4vy3FU5csdaxAMdxcisNUxnW5U3Z6kZDKHSJvZPoilVkvrfl+C1i
         1D7qHynOp+ID0TpkxS99BWv/INzKtTBkvhrFVSStv+2vQrhJhdqtOXFMfaTTeEAVpQ+Y
         cVJg==
X-Forwarded-Encrypted: i=1; AJvYcCUnwMSPQbsqh8bzJ+usPeMSMzmGJ3u6Z8f83xV76ZzNsOtTO04WZf6OaphweQfpFTRXN4pwpgb+J+nNMhQezL+848pmzTZSr+p0SK9WuQ==
X-Gm-Message-State: AOJu0Yx/ltI2Itept8jXSYfp0NYFiUAfxLKkevDIB6sufF32rAtNvneY
	D0FY0sJ2zI/IqadPPiFcQrrkFkhHrwaL+k6S68S37wdqoso2QSBAbgyeJOlGA8KQRBDkiyVtbKB
	nP85X7g==
X-Google-Smtp-Source: AGHT+IHbQfc86unhb0E2TWS2ZxT1DFLuQuMfcyi5kr1Id9pxx5RHQdAANosi309vvmAGZio44vWZnA==
X-Received: by 2002:a17:906:f59f:b0:a5c:fe8e:cf6f with SMTP id a640c23a62f3a-a5cfe8ed230mr341206966b.56.1715976481262;
        Fri, 17 May 2024 13:08:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cde6f8c89sm295979866b.70.2024.05.17.13.08.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 13:08:00 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so5956657a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 13:08:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3d9H9vwnZij/rDgsJdhOJCNjzJT/SsbKa9GgQEIlLocR/6ZLD1X510OGtPIUDF8014SPRRRuK+JdjqrF3XCWkC9z8Fu5wRzfi5/KEiQ==
X-Received: by 2002:a17:907:91c7:b0:a5a:3a6c:8b56 with SMTP id
 a640c23a62f3a-a5a3a6c8ff6mr1220625366b.11.1715976479947; Fri, 17 May 2024
 13:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner> <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org> <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
In-Reply-To: <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 May 2024 13:07:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
Message-ID: <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 00:54, Jiri Slaby <jirislaby@kernel.org> wrote:
>
>          inode->i_private = data;
>          inode->i_flags |= S_PRIVATE;
> +       inode->i_mode &= ~S_IFREG;

That is not a sensible operation. S_IFREG isn't a bit mask.

But it looks like 'anon_inode' traditionally had *no* type bytes at
all. That's literally crazy.

Doing a 'stat -L' on one in /proc/X/fd/Y will correctly say "weird
file" about them.

What a crock. That's horrible, and we apparently never noticed how
broken anon_inodes were because nobody really cared. But then lsof
seems to have done the *opposite* and just said (for unfathomable
reasons) "this can't be a normal regular file".

But I can't actually find that code in lsof. I see

                 if (rest && rest[0] == '[' && rest[1] == 'p')
                     fdinfo_mask |= FDINFO_PID;

which only checks that the name starts with '[p'. Hmm.

[ Time passes, I go looking ]

Oh Christ. It's process_proc_node:

        type = s->st_mode & S_IFMT;
        switch (type) {
        ...
        case 0:
            if (!strcmp(p, "anon_inode"))
                Lf->ntype = Ntype = N_ANON_INODE;
            break;

so yes, process_proc_node() really seems to have intentionally noticed
that our anon inodes forgot to put a file type in the st_mode, and
together with the path from readlink matching 'anon_inode' is how lsof
determines it's one of the special inodes.

So yeah, we made a mistake, and then lsof decided that mistake was a feature.

But that does mean that we probably just have to live in the bed we made.

But that

> +       inode->i_mode &= ~S_IFREG;

is still very very wrong. It should use the proper bit mask: S_IFMT.

And we'd have to add a big comment about our historical stupidity that
we are perpetuating.

Oh well.

               Linus

