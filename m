Return-Path: <linux-fsdevel+bounces-19593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF98C7A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B6B1F21D62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422114F10E;
	Thu, 16 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YrVEFcX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239514EC50
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876630; cv=none; b=BDFo0+u9p7POce42Gs3BUy5vL5ClTtFoiGENHvWBoE5eNt1IDTpep0O5EfSM9b0xU14ecSr3uMdAacG6l6wSz8VIkxaSj05qEQHoWo23U7yvNDA54f7wdP0x7av1Pz66Ve2zz+92EqvHSd+HJavq+ccCZILAuy8j//yg1AKKebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876630; c=relaxed/simple;
	bh=EZ7K4NzPBe6mgvmzDvgcN0o2b/NCkPR6fbfbuMDf1ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT6QNfrCdIGattIS0DMfhrmQjP65ANHbZuielL+QfMwlffkEHpLOdrPYkEDubDK21LgF29Es96PBre+Wto3qMfUCCa8cxph1Muvxrl+bRLxxav6dTromA09+sSKXF41PzQFg2wyba5kxOBkhZUKCNc266BJ+tuB2/AKoWdsTm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YrVEFcX1; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed0710c74so7216786276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715876626; x=1716481426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Razho7lHGpyap1v7dPaP5qSSISsR7xC/uw6XBXBKDDs=;
        b=YrVEFcX1ds2TXr7XCZ5Fzp/kPwxTFs9f70qlsY7O0tR1s3pk7uoWBqDKnlqm7TdF3A
         CgAwIvtI9e1GzcSarlc1Z1YlgQmC0ZX/v8R3TQANXQddY8NiRSDggauIINJbBJ0Iczpz
         lMA709PVe5DCeKreg6yFIWlK1ceEEOINXkvutC3N3ClIByNvxJHHktZbCppgco7VocEQ
         wcbaksZwQtESir+rhGAsuKMbpk+95a7W7ODxrfoo7Z614SZzjzJd3/W4Q+HyXywn49CG
         tAgvnx4f3fpDjXR4CBJfglcTrAXsLHgZsdGw70QYisGLauQc0yRzF2aL0Wrrb+Hi6q4K
         cgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876626; x=1716481426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Razho7lHGpyap1v7dPaP5qSSISsR7xC/uw6XBXBKDDs=;
        b=P5Z8ybRX6B0pdhGXRJdvCVRymzXY87I94TTJ2w25z4kPF5XPhyT1VyWPBMB2EbcnIP
         Q1loNirjFeKEySQVD17whG4OCVxGEM+NbthvckSjKaFODi1gTE8QCDGMEKT8Sqfloo+F
         hCrMsEq1MW5xglys3DFZ3yIPd8yVSV1d0ggWHpidXKoFyiLWGMTn6jEGumeZV81sJGf4
         nej3tdwWe0pmCAhkZiQUZP0T2Z9pGnXTrivkiazmh7m3Kkeun9l/HwmrcWOncB5s6RYq
         vOo/pQ1MK2Fn0ZSGGubfRBUAKJKN8obK0j2k43hnMF+ZAWaVe2Eu5vSP866Tb/try3ia
         b0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwt2vGD5Y6YL0zL1P/vHj53Q8JXGVIo6JunCfSpj4PgRi6chsJU/aa/6DXfYPi7qC+zUyGTI+DgWwQ2RkmJb1SldQxjhhxVvuDCGGpg==
X-Gm-Message-State: AOJu0YyJbjCg+vT8fRTGzgtUQAd81Z3SH8/eNadHhS4eklHQG3mzD6Jp
	XAi6UaNrvlak1De7iX2xKTzIKVKeWMY7g3ENETjDv3/sjktiHMgBogu2W1gRBK5aRVZZSizDF4b
	OsDIylVqWoueDDuxIAFZ2HkYkjjb822U6aSPX
X-Google-Smtp-Source: AGHT+IEe/+V1bbRxOWwuKMKyGJUCyojV3Orv/M9T3K8RKww9g1UJdluzqC20c4o+/xI6Shg9MmTrzyhw8zyqu2pFzkc=
X-Received: by 2002:a25:ade7:0:b0:dcd:5c7:8466 with SMTP id
 3f1490d57ef6-dee4f3a9f30mr20073221276.44.1715876626618; Thu, 16 May 2024
 09:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 May 2024 12:23:35 -0400
Message-ID: <CAHC9VhQ=nNPLRHF8RAMxArT1CESei+qYsnGse6--ixPhACAWTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Jonathan Calmels <jcalmels@3xx0.net>, Serge Hallyn <serge@hallyn.com>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:21=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.net=
> wrote:
>
> It's that time of the year again where we debate security settings for us=
er
> namespaces ;)
>
> I=E2=80=99ve been experimenting with different approaches to address the =
gripe
> around user namespaces being used as attack vectors.
> After invaluable feedback from Serge and Christian offline, this is what =
I
> came up with.

As Serge is the capabilities maintainer it would be good to hear his
thoughts on-list about this proposal.

> There are obviously a lot of things we could do differently but I feel th=
is
> is the right balance between functionality, simplicity and security. This
> also serves as a good foundation and could always be extended if the need
> arises in the future.
>
> Notes:
>
> - Adding a new capability set is far from ideal, but trying to reuse the
>   existing capability framework was deemed both impractical and
>   questionable security-wise, so here we are.
>
> - We might want to add new capabilities for some of the checks instead of
>   reusing CAP_SETPCAP every time. Serge mentioned something like
>   CAP_SYS_LIMIT?
>
> - In the last patch, we could decide to have stronger requirements and
>   perform checks inside cap_capable() in case we want to retroactively
>   prevent capabilities in old namespaces, this might be an overreach thou=
gh
>   so I left it out.
>
>   I'm also not fond of the ulong logic for setting the sysctl parameter, =
on
>   the other hand, the usermodhelper code always uses two u32s which makes=
 it
>   very confusing to set in userspace.
>
>
> Jonathan Calmels (3):
>   capabilities: user namespace capabilities
>   capabilities: add securebit for strict userns caps
>   capabilities: add cap userns sysctl mask
>
>  fs/proc/array.c                 |  9 ++++
>  include/linux/cred.h            |  3 ++
>  include/linux/securebits.h      |  1 +
>  include/linux/user_namespace.h  |  7 +++
>  include/uapi/linux/prctl.h      |  7 +++
>  include/uapi/linux/securebits.h | 11 ++++-
>  kernel/cred.c                   |  3 ++
>  kernel/sysctl.c                 | 10 ++++
>  kernel/umh.c                    | 16 +++++++
>  kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
>  security/commoncap.c            | 59 +++++++++++++++++++++++
>  security/keys/process_keys.c    |  3 ++
>  12 files changed, 204 insertions(+), 8 deletions(-)

--=20
paul-moore.com

