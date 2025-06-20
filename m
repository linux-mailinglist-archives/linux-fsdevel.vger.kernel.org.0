Return-Path: <linux-fsdevel+bounces-52351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E17AE2256
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DF33ADC73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BA2EAB8E;
	Fri, 20 Jun 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It6HDZAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4046BFCE;
	Fri, 20 Jun 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444606; cv=none; b=T/SyOJwgKAq2tmNQhKi57BA2d2B65yw4rjh9e/HhZnGGd+ETZ8DldTnsWQq3xmNVQ43a0lATCyjQCaN8irBLUqZG684KeoZx3kRNHDiGQj3aMkC+pRdMx59hJ7Qb5hjH8cIJZNrz3w3NMYyCc/T+os4tEENUF88v90AK4htL70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444606; c=relaxed/simple;
	bh=5aprew4hKX/coXkjFe17a/Yyf3ir4h7JJIR+NElQm6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GV0XmbssbyBE7I/wm8mGFUhDyzTwalS5lC1y65YTMmzSHL5dPFbqjYwqzH3NHcRwx8G0Epu7pk/V/QjS4GdfrNtNL6r4o6gyU2jh31ygUy2VMDhVkzVNb5BHH9zy/vlUuncJc4qCjh7APfOK0ULgl2rfzGUvJeAq+pZvMLnmkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It6HDZAc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so18145835ad.3;
        Fri, 20 Jun 2025 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750444604; x=1751049404; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s4gciWTSONw0akSEEEhFqXpes8/mqcuvWff1e7xwDzs=;
        b=It6HDZAc9AL787xkUle1V7wdcGePPaVkKUbY67oohIxW0P77VpbUDvM/T7xkpGLWbr
         VI3OdY7tuXaSHDnzh8nSmaw9Wdj3ki94g1UJbbZBJP0qE3+WObmfimREtahAZBBmilGP
         j5A/T/DMdrl0fB4jl7CIxwQaG05kJmGrex9nk4Rw04aEegTkphFvleV/j/fOKeI1NCNU
         3CcusWPTT61rNdflN0GNattEsMvk7aOtSgWraG4bdA57H13ec1p3k3KKA6kTLAkdBzIO
         XIYBzgEwWn0V2oEMMWzYiWgU/XL0mjTP35e3t9x/8aiJ+hDwMnvyPeR6FM/7c0vnM9TU
         M9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750444604; x=1751049404;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4gciWTSONw0akSEEEhFqXpes8/mqcuvWff1e7xwDzs=;
        b=R7r1JXuD7kmGZZyayWRu4PahhIfQ/XOWbqzcntW8MrCSaMZXANPRw/nWIAxv24CyDO
         dGepen2IpQxorjOCcYoZpGpolD2edZxX3wgEH4IlStLMW8KKmNU8QAOhprN1uw2kL8aP
         KVj5FVI7cYwXt9/sBhdZrMwuuIsGxi4CmKKMe2BfDnAz7JX0X9oZtCurYgG+g9A1gGml
         YZzjDiGsYL3g2LERiIv0MVwF8oOxwZvH03gcNRU2QDVyhIC73w6za/eVoLnQCql1K4zy
         kTPLlvKBuFf2q+9lWvPxlRjCd1wxEj7kSORAsPdtcTFNN9U7iBs1ZgcWp7HuV4fDxDY2
         ACwg==
X-Forwarded-Encrypted: i=1; AJvYcCVe6NAK5XCZpE1ABBVWMnnFK/8bNdvdVVy5I8GozRod469/iE2ab9mMsC85lOmKDYhGEmxqcXzQ27WhVOCv@vger.kernel.org, AJvYcCW/rt/a2dedOUFswiUBXCj98CIXohgGbmipAmDTrLxdKYfhi03dk/Y3ZFD1+yGYnUvhugU+17N0V4JbdckV@vger.kernel.org, AJvYcCWhHNjVHflB//UQvlyp5yv2Uok8ela/3HW/sgosoK6qkC4rCBSxONeeXTp4pmkwXhl7LRxtHC34TEoUaG9ikSWjbuWjQs62@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbP7w9tiBQhJ7NY8eW99BJwcSdr3PJOP2rKV0ZEVXhSiJu67n
	kyCCVixfwbpj3vrnIb127TOFE++bohgoS+xkb0Rrs2BtKQCkf+mmtPh6
X-Gm-Gg: ASbGncsCM5PfWhjckAPiq0F9K1wOeebcuOr8WaLA08r88x8kR26ucOLFoSZ4dhE0xaU
	GhkxHpBbyu3HAYUTRHvI7TwS7TTZBAYpAIJCc+N+n0SWeGTztAWJQPv8xXBEdddifMMCvi7TM+W
	Sq3T1/c8AR4tPIcWmfivGdEytjwvwt+I0IsOc+hEUvO8ycrchbBSEGTYRqa081tCR/gzbrCPR5l
	25TvSJ0EU6xLRJRtJesl3ZeO8NTuAv62bPKBePZPJaPMuNRyyIs13Yskx7I3vuRXbkiGIVxfysG
	GZI4vFPxGqqyxdHB3wXsl3J+w6Ph/OiXk2ERPqYc/udzB7LU0v1qjojjYAG0eVYs99um
X-Google-Smtp-Source: AGHT+IGHKJOmUPn26KDy0m1jr5bhCOMFbt9X8MQuRFyRFftp90pbLKnHi7J8ydZpQWGBmXaW0/MOfA==
X-Received: by 2002:a17:903:2306:b0:234:d7b2:2ac4 with SMTP id d9443c01a7336-237d980da56mr67713185ad.17.1750444603773;
        Fri, 20 Jun 2025 11:36:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::247? ([2620:10d:c090:600::1:97ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a426sm23459215ad.117.2025.06.20.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:36:43 -0700 (PDT)
Message-ID: <de68f43f9e83230bbb055fdecba564ee662d6091.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] selftests/bpf: Add tests for
 bpf_cgroup_read_xattr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Song Liu	
 <song@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, "Jose E. Marchesi"
	 <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel
 <linux-fsdevel@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>, LSM
 List <linux-security-module@vger.kernel.org>,  Kernel Team
 <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Daan
 De Meyer <daan.j.demeyer@gmail.com>
Date: Fri, 20 Jun 2025 11:36:40 -0700
In-Reply-To: <CAADnVQKKQ8G91EudWVpw5TZ6zg3DTaKx9nVBUj1EdLu=7K+ByQ@mail.gmail.com>
References: <20250619220114.3956120-1-song@kernel.org>
	 <20250619220114.3956120-5-song@kernel.org>
	 <CAADnVQKKQ8G91EudWVpw5TZ6zg3DTaKx9nVBUj1EdLu=7K+ByQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-20 at 11:11 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 19, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > +       bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value=
_ptr);
>=20
> https://github.com/kernel-patches/bpf/actions/runs/15767046528/job/444455=
39248
>=20
> progs/cgroup_read_xattr.c:19:9: error: =E2=80=98bpf_dynptr_from_mem=E2=80=
=99 is static
> but used in inline function =E2=80=98read_xattr=E2=80=99 which is not sta=
tic [-Werror]
> 19 | bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> > ^~~~~~~~~~~~~~~~~~~
>=20
>=20
> Jose,
>=20
> Could you please help us understand this gcc-bpf error ?
> What does it mean?

Not Jose, but was curious.
Some googling lead to the following C99 wording [1]:

  > An inline definition of a function with external linkage shall not
  > contain a definition of a modifiable object with static storage
  > duration, and shall not contain a reference to an identifier with
  > internal linkage

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
    6.7.4 Function specifiers, paragraph 3

The helper is defined as `static`:

  static long (* const bpf_dynptr_from_mem)(...) =3D (void *) 197;

While `read_xattr` has external linkage:

  __always_inline void read_xattr(struct cgroup *cgroup)
  {
	...
	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
	...
  }

I think that declaring `read_xattr` as `static` should help with gcc.

