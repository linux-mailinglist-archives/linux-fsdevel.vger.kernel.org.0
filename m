Return-Path: <linux-fsdevel+bounces-52833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4323AE7379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F094A04E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D326B2AE;
	Tue, 24 Jun 2025 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp+wmrjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50D2CCC1;
	Tue, 24 Jun 2025 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808958; cv=none; b=f4tWDi4io/vAUIYoSfSI944HHP41UUlXlgKnYoJV+JzDzllO3Oj4RZDp6u2SA273P3hoaeRgMh4nTTAvab0TZ/cT9eC7o6No51mJqnXY+BoY2qhVF/WZZseLsD2eP9vHG3x2MiSx//PfRRbM/bglVpecTQVY12BTLwLWAdH/+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808958; c=relaxed/simple;
	bh=+WzVaLfiB/QTBCdoQz5BMY7POuyyHmL4cZX9Ji5cM/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csvO7B9kLWol1/sC5XMPwRfoDcOMBUFDuB/xWFYFNqAML94scjCD013upQMLcY8sWSG2t/WUADLgPdF8GGFXb1xvctpWUMlUNcteiuZdjZWEe8bPIHNBG73mNbsRgMEG+b0YYCOcZqJoqsSoEpNL7VAIeeDfeElv1/j1rd9DsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp+wmrjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01257C4CEF1;
	Tue, 24 Jun 2025 23:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808958;
	bh=+WzVaLfiB/QTBCdoQz5BMY7POuyyHmL4cZX9Ji5cM/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bp+wmrjfdHPdrSX1U2X0vWegWVH2QUjbY+n2XJG6H/8DhfNE3TLJktXburAW7ftSI
	 MWGMY1UI3zCBwUYpVUTcdsAetw6Z8Lp8qb97JpjzmLDwQAhrAq2xdlMMltDtGxwfXx
	 w97U/L/UJUw9NAiwlu7RWk21ZK6/T+kIyjI6Q+NjoufUWtTjemllWo8HaffJJO4eKI
	 0ACoRXFSkpslKTKNn8CUpE/EPeA2ayvy6xCHI89v5ZScXbZJW9bFJOwbLWBnEajwiy
	 /lDUrnnyfTxiYBBq07NdKg7lo+nLqDosksafrSmb4XEcUSmEleCh2ywwdqh8wu+pWw
	 T9zmPQUmtEnpQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70f147b5a52so45544607b3.3;
        Tue, 24 Jun 2025 16:49:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxu/iSODeHmGY56y8eJZQP97HVdV1/QX/wXMc6/w2xCez1zzmJ5OOHDp1TNt4+5M1qEXC7lLJXS0z8Q8uz89RXhGy0sRCE@vger.kernel.org, AJvYcCW8Ep7j3Xdpvm6Sxwyb12oIGLrO6yZOJVXsczv1JA5HDyTM/AKPurfFY0EH+K34OEah6zeJoLoNfbA7Dit5@vger.kernel.org, AJvYcCXyoynW6wTgYteAdWV4JtQ47vqgLv+Av7srlrHl+NATLAQXQXvr21ve/CQCFVus/WDdfCy8rSQ2IYk3oETfcDbh@vger.kernel.org
X-Gm-Message-State: AOJu0YyiReRB4hGjlbubqhKYZKne6AsoAx9sJXLBTJqWe06SIzhFPoBn
	DXMY06uhkck16hIZK8QvY3fPcUj7o9Cy0OMJ5FqSCWmLOuw00NGrPOYvmb3svj3yEqUWBJquQfU
	7XV+LU45lEATVbvuMbw/fipXnnbmJcCA=
X-Google-Smtp-Source: AGHT+IEkA0q9OT04QUqIeI06M67+a1D1IT8t1ftcvJQrJ41ytprUweK5zbFH+96ESpvfIsdvvtIZ+8b60bUsSO0RzRc=
X-Received: by 2002:a05:690c:2506:b0:70e:15e7:59e2 with SMTP id
 00721157ae682-71406dd15demr11751867b3.24.1750808957350; Tue, 24 Jun 2025
 16:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612030951.GC1647736@ZenIV> <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
 <20250612031154.2308915-9-viro@zeniv.linux.org.uk> <CAKtyLkEcH2D5vA19n4LQwrgGE2wHTpT_vshCgk2oUiO2rB12cw@mail.gmail.com>
In-Reply-To: <CAKtyLkEcH2D5vA19n4LQwrgGE2wHTpT_vshCgk2oUiO2rB12cw@mail.gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Tue, 24 Jun 2025 16:49:05 -0700
X-Gmail-Original-Message-ID: <CAKtyLkELBbT++iWNsaiN2Xi13Bp_coBZ3X4AXrnFUcqLMJdx=g@mail.gmail.com>
X-Gm-Features: Ac12FXx0KpT4Uik68ffLxHs0YIZsByv_6tDerSLh9lDd2dpwIwoN7we-Sxic3WI
Message-ID: <CAKtyLkELBbT++iWNsaiN2Xi13Bp_coBZ3X4AXrnFUcqLMJdx=g@mail.gmail.com>
Subject: Re: [PATCH 09/10] ipe: don't bother with removal of files in
 directory we'll be removing
To: Fan Wu <wufan@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:43=E2=80=AFAM Fan Wu <wufan@kernel.org> wrote:
>
> On Wed, Jun 11, 2025 at 8:12=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > ... and use securityfs_remove() instead of securityfs_recursive_remove(=
)
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  security/ipe/fs.c        | 32 ++++++++++++--------------------
> >  security/ipe/policy_fs.c |  4 ++--
> >  2 files changed, 14 insertions(+), 22 deletions(-)
> >
>
> Acked-by: Fan Wu <wufan@kernel.org>
>
> These changes look good to me. I ran our ipe test suite and it works well=
.
>
> However, I didn't try fault injection to trigger the dentry creation
> failure. I will try it later.
>

I tried tracing the reference count with and without this patch set. I
found that without the patch, there were indeed dentry leaks in the
ipe policy folder, and this patch set has successfully fixed them.

-Fan

