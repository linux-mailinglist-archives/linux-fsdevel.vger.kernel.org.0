Return-Path: <linux-fsdevel+bounces-52707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B90AE5F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6BC16A362
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297825D1E4;
	Tue, 24 Jun 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk/Fi2ya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960B25C70F;
	Tue, 24 Jun 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753985; cv=none; b=ocJwTPE2Ygb0i9vZSepUk2Tal56vq30pn/XzeJwqMMGUc0FajiCDD2a6y7+c6ErtjJsMPtNsSAVcCw6IiNIa9gkUR1QyE6L3iYTXeQUebcO/TmnLowa2xDb3MCrzn9DbiZPxKPE7bGNog9neTO34N4oPf9S4U1OJAgWDUZXfQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753985; c=relaxed/simple;
	bh=kcXxuLYDeFqIEPL+ofXn+D0asrg1ymOU8WT5ZTAyRIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s57WfDOVt0wNTNZL1JpfhwHXjhw6ygYz2pl9n5bJ3Tw1hnhgZpD8IKThZ/hdQk8XvqqfXulpGvOvo7M3fcFQzoZP5nV16cnlWkwJ/xp1TraQSFbExp+s1DNPBlU3JrET8TSyfQW8/ZnuByHYzBsOTtDqQ5aEZhwGww+HYtfdRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk/Fi2ya; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3298429f8f.2;
        Tue, 24 Jun 2025 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750753980; x=1751358780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAcUzdSSJoRNC6czCmlN0ZjREWVQ1d/qdtR05/VTcrw=;
        b=Dk/Fi2ya7akwEiL5+2r2pGSe0N98l6VyzXSVeTcW0iMzXxcSYCjpKqGg9i5a9BnGkV
         q7cCF4bHpYBRYULmUJaNuXb1n91QNtVsb9KJvX4p3uWNJFO4A+Q1mMubz1GPJHzDsh58
         WdNs2C+bC+LUsC+gVT8qazf0nSdIhk4sZxjHgkxgMASL6QwImkOyiJTcA5o86gMvZHEF
         DAT0jOQED75oQS9r5sSjitJuq7CI7tOIVSy2PTlaYSFFToxsTM2fCnmT0iR4HcjeLT9+
         27kEOpRS9/qBwfpRUW7jBdyOR++VM0Nrs3fnPJRgsxlu6eW3nMEqcuTmMCLiqWYgk+2K
         anAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753980; x=1751358780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAcUzdSSJoRNC6czCmlN0ZjREWVQ1d/qdtR05/VTcrw=;
        b=WCSnnYNWTt/2NrQ91GLQnSwf4STdeuffWGEHmgo4RGeMb66SVsW16Kg/gCY9+kUwyN
         l8KTwza0Nq4hHJTb1uekVBQXFARennqy6kpA+ilp+BYT3zdO1k27RcoUTbsoFIH7SbX4
         AXLJhH5ERVmKdmuLCbW2KqDe0Eu9N7O9nsxM5aaH6EgmuDQp71tz2zP/Ihs3bt5FVlJ2
         jGViFJMn9Hu/KWvk+m0YYV5iuyo2hKzgeKMJYTj4Lpp9I4QR0G2LcuYoKWJnUGsICNF8
         YuXjzMLzZtt0evpXrBBcdKkusw2PNkoY72Khsmc6j1YcDCxiIDfVTNwJBorQ84R0ko1j
         Qmag==
X-Forwarded-Encrypted: i=1; AJvYcCWMrfqbjj0DsFapRRIxkbCxZGt3Iis9nyLwRF/UIfBkzb1ogjv5odLGXXwKRigv2K4kgiJ7IOMtxZraOLzb@vger.kernel.org, AJvYcCXmkghB5daATBMPKjuA5ZdcdcZmugkF5icEJMYsRlB3RchYOyeOvajw6r/SSpoEQ/uxRPFhIsa3bS8OvSco@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0VHylL0ToEpkFidNGiCh0zaAk8k8ZGitTIWVGDlZMmCmICPc
	15/Gc73pqWPTCE0DqKuXLUyJSEdd/b6MGkliOkblsYhpLSxBcfoBy9YG
X-Gm-Gg: ASbGncsGmBtvZm+5C7vUMaOOKtKlo1yX8T+ifZPgmSHTuooHF9tpYWpU7Tj8aw/jUlQ
	nHSFHyTJCbVCnFfl+Q3RZGwpuXTXl+bxkL/dfvLa1Ts6s1b4T15pqkU67KnWmt0PDGVUZuQ19iX
	QIWqb7e5K+0gnV3aTzJy7gVXkwi+KQ8wwdjZwb3NKPimMCgrvoh90RVyUs5tn0lVEg/UrGUr0uA
	VjgQmL5h/cHJybBFGt//46Ci9QzfQPZTcec0AaBaerZEMQ6Qgyc5yyrnqc4OlAtGhGjpt2vSFnJ
	qf56CTXNsLD0M0KsdmHg4oKJ8Mk589Q7OzeT8c8RqztfzFsYR6oMB6v7+jIvP1Mrr88ll9gLceQ
	KVxgsOoL9ejT9HNyArRD1Zm65
X-Google-Smtp-Source: AGHT+IFa8wKlAMcVrotXu5zgRzJw7hFatpGh+UkLiPFv+ni6YiXds6pDi5irzSKPmq0uy7jsxhYgzw==
X-Received: by 2002:a05:6000:645:b0:3a4:fefb:c8d3 with SMTP id ffacd0b85a97d-3a6d130e802mr13287583f8f.40.1750753979983;
        Tue, 24 Jun 2025 01:32:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810caefsm1285937f8f.87.2025.06.24.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:32:59 -0700 (PDT)
Date: Tue, 24 Jun 2025 09:32:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250624093258.4906c0e0@pumpkin>
In-Reply-To: <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622172043.3fb0e54c@pumpkin>
	<ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025 07:27:47 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 22/06/2025 =C3=A0 18:20, David Laight a =C3=A9crit=C2=A0:
> > On Sun, 22 Jun 2025 11:52:38 +0200
> > Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> >  =20
> >> Masked user access avoids the address/size verification by access_ok().
> >> Allthough its main purpose is to skip the speculation in the
> >> verification of user address and size hence avoid the need of spec
> >> mitigation, it also has the advantage to reduce the amount of
> >> instructions needed so it also benefits to platforms that don't
> >> need speculation mitigation, especially when the size of the copy is
> >> not know at build time. =20
> >=20
> > It also removes a conditional branch that is quite likely to be
> > statically predicted 'the wrong way'. =20
>=20
> But include/asm-generic/access_ok.h defines access_ok() as:
>=20
> 	#define access_ok(addr, size) likely(__access_ok(addr, size))
>=20
> So GCC uses the 'unlikely' variant of the branch instruction to force=20
> the correct prediction, doesn't it ?

Nope...
Most architectures don't have likely/unlikely variants of branches.
So all gcc can do is decide which path is the fall-through and
whether the branch is forwards or backwards.
Additionally unless there is code in both the 'if' and 'else' clauses
the [un]likely seems to have no effect.
So on simple cpu that predict 'backwards branches taken' you can get
the desired effect - but it may need an 'asm comment' to force the
compiler to generate the required branches (eg forwards branch directly
to a backwards unconditional jump).

On x86 it is all more complicated.
I think the pre-fetch code is likely to assume 'not taken' (but might
use stale info on the cache line).
The predictor itself never does 'static prediction' - it is always
based on the referenced branch prediction data structure.
So, unless you are in a loop (eg running a benchmark!) there is pretty
much a 50% chance of a branch mispredict.

I've been trying to benchmark different versions of the u64 * u64 / u64
function - and I think mispredicted branches make a big difference.
I need to sit down and sequence the test cases so that I can see
the effect of each branch!

>=20
> >  =20
> >> Unlike x86_64 which masks the address to 'all bits set' when the
> >> user address is invalid, here the address is set to an address in
> >> the gap. It avoids relying on the zero page to catch offseted
> >> accesses. On book3s/32 it makes sure the opening remains on user
> >> segment. The overcost is a single instruction in the masking. =20
> >=20
> > That isn't true (any more).
> > Linus changed the check to (approx):
> > 	if (uaddr > TASK_SIZE)
> > 		uaddr =3D TASK_SIZE;
> > (Implemented with a conditional move) =20
>=20
> Ah ok, I overlooked that, I didn't know the cmove instruction, seem=20
> similar to the isel instruction on powerpc e500.

It got added for the 386 - I learnt 8086 :-)
I suspect x86 got there first...

Although called 'conditional move' I very much suspect the write is
actually unconditional.
So the hardware implementation is much the same as 'add carry' except
the ALU operation is a simple multiplex.
Which means it is unlikely to be speculative.

	David


>=20
> Christophe
>=20


