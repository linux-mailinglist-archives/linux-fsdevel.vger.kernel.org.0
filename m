Return-Path: <linux-fsdevel+bounces-64966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1FDBF7894
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78DF3502EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B425338930;
	Tue, 21 Oct 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bEZ7gn9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF3355051
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062306; cv=none; b=QvUMNO9KYJBuCxCnNX60JfclwVV17UcWsJpfoiZmBrcjP7CrLXJ3t+3E93VDmPyz1cDl6D6yIIX354d6gdFxgnn+RJTuOfD7HhWBspA2XN871ShPzIsxmnHVTSpILTwN+Czf/wD7VSoE0qo7kpN2zB7b4crMAWs+9+MVVqonx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062306; c=relaxed/simple;
	bh=lViBcaKLu+UAiDt1Nf19hKosCzWDWEUaKqiaIlkaqqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF6dfGn/D5VQ9b7TMCyYmwdxrvvD5kRFRJjTUQL8oFKdSG36xfTwtUcEQvYVopo1skxv92cB9JmOx1YrC3yEMyuR2fWmjnMPP1x3cLJJjmJ6BLAYnkJSb77geJVKVvvHb4f8F9xS2P6oeJ7PSxCMxFuPdfPhpA/GnzD/ZEa3sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bEZ7gn9g; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so9323516a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761062302; x=1761667102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0cSMAwFRMJRxsYANvmyJeRZmZI2zdPSEESzl/tT500=;
        b=bEZ7gn9geKKKrnyAu2Sx6cw/G34fvKOU4U4cwJpYEnCIfudytykKJhFniYVgLYOGO2
         /Mno6nIE5CGZcNkGV2bsMPjZtHob5LCYengsvIYF311xpJrj4h0PouvPAXH9APOZHc0O
         2TByDaHh8/nj4oD5dqD8vb6XCujMbcaDCQDfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062302; x=1761667102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0cSMAwFRMJRxsYANvmyJeRZmZI2zdPSEESzl/tT500=;
        b=njzN0rMYiFUGLWByOwzRSjTyr4vcVVVckN/YEVAUR+N4zfNdFH+j7w6/XeciDbEfyr
         mNcMWO/GrR832ZJUz8n7RNv7Lr4UHXEf/NpPZO8Dpgd6aAgrESzkG83HgMHlqiuoehA+
         6dKzUb5CTWmMVSarDyr8rPnZVcm8DOjh0LNFdqizdxFM7fxKR5qN/bOKWIt9M5Dt4UNp
         oZwrk6gOiE4UPEUaTMDROEzuUfj4D4BEYXNCGIIIur5viE6U3+IedFtMrn/fgUhkdbCr
         cqwvzzSLdSsd/gg5ABgnTuqVMcTmiEGuXoRkhdN6NYEdUZvjntnVam1dQqhrq6CWHxdW
         FKJA==
X-Forwarded-Encrypted: i=1; AJvYcCUqEU3FsY7UJmlY7rmcJhHI7T04Irtj24uyFQCpXzXYy9Awp8Om0qKOQaVxcbU+dcl/t6dbbjqaF6ouYg60@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7A6HMT6LZeOb0rt0iHyUBoSw0Wcpkwxwu0u4jHuJodHxr5eI
	v+VVO1uyKaeL359Hmju3+yVDCMAmv9nAo0dF07LbkmuPsq1m4NbHP/FtLZUuEbLzz0JcTjq9Bdm
	pqQIHzGr5fA==
X-Gm-Gg: ASbGncvHlotcx8G4xNmxyDStifxVSvDqntFC9OacgPhdKK/4A8pXNWkFbZ69CFWjkW1
	kxv3fuF7cgBMMLYInDISSeK9otA4i3os9js0D6hFPjUOrnuY1/zl1I060D0R/MWVob7OyRfY8QL
	CuRlihEyZUTTbSxUWrMWYt+cmcptav9vFImI2376T/tzlCujtttdy2dEU1JZ+rW1ulDkwkeCt0M
	y4fGhcEXxm6PNn4UZc7yYPA6W30xHnlgx4gJ7w3pyIR6QV1T52Q1eKBr+MYvtLClWmdfLnyM4IR
	ZTrciZ9rp4WeIShXJPTW3ukqPUZcitLEG4Ps/zjdH2f1YlhdCSK/B4iriHYHBmNchQ+cSOSAtTK
	bcrPm7Yshn9u2uTr2PGuw8DEvx176VvhzN94FoKDLG+VPsJ6MAp0Py8LgtkZ4RuIcZaX/dZSx1E
	e6biILSRmDH/2nkYXgN0iw8L0r4aruThOXt+yvpme6ZBk3IwsQ189/59I1h4Sz
X-Google-Smtp-Source: AGHT+IF2koEBVq4SrG6NBKmzV36gQXlEEnaNfz3Kesyy9tnxxppfqv82IqxT+bAz5Mygmr6GI66AFg==
X-Received: by 2002:a05:6402:254b:b0:634:9121:7a2d with SMTP id 4fb4d7f45d1cf-63c1f6e5309mr18264580a12.26.1761062302323;
        Tue, 21 Oct 2025 08:58:22 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f003sm9919764a12.27.2025.10.21.08.58.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:58:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso9766695a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:58:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+KD3j8JtChHqvgfWOkmi72BcVAXAyKAqTUe1f4I1z4rCGj4Ucc6J4PU9lXzpSn37pwXaKCoUPdGD82JNV@vger.kernel.org
X-Received: by 2002:a05:6402:518e:b0:63c:4da1:9a10 with SMTP id
 4fb4d7f45d1cf-63c4da19c97mr11628470a12.31.1761061904052; Tue, 21 Oct 2025
 08:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017085938.150569636@linutronix.de> <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin> <877bwoz5sp.ffs@tglx> <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
 <871pmwz2a3.ffs@tglx>
In-Reply-To: <871pmwz2a3.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:51:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj3VgQAwUjfM_6f5O5gFr4kXBma2q5m8PLarRCnA8R49w@mail.gmail.com>
X-Gm-Features: AS18NWAG7YIQvZWdpCHOlvhJ3OJWyOrD174ntZFm1lwB34kJVwOkBypjHYnGjQo
Message-ID: <CAHk-=wj3VgQAwUjfM_6f5O5gFr4kXBma2q5m8PLarRCnA8R49w@mail.gmail.com>
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 05:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Oct 21 2025 at 05:06, Linus Torvalds wrote:
> >
> > We could still change it since there aren't that many users, but I'm
> > not sure what would be a better name...
>
> I couldn't come up with something sensible for the architecture side.
>
> But for the scope guards I think the simple scoped_user_$MODE_access()
> is fine as for the usage site it's just a user access, no?

Ack.

               Linus

