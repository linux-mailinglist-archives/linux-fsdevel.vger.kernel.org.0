Return-Path: <linux-fsdevel+bounces-24228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD693BD87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2D21C2194F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80360172BB2;
	Thu, 25 Jul 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfi3s+EM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6B101F2;
	Thu, 25 Jul 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894471; cv=none; b=SFl7YHRmIONq83F9U5Wvs3slRfOZMFt+52CXtbkuC0mcqrQatnl89VB34NdVQSn4OfZRhtfAWalsYmek9uslEm04XaDgNPoCt9ySBfq9vZIu5WEYjaldxYrJFY7IK2krVivuGTIF/cpp1erD9KwOZgyzMebMpb5XJOlab3+2FBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894471; c=relaxed/simple;
	bh=kwI4x8K0G8ucv7wyd9WsBTJbrmdgts1vYkZcTKcOx4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9RAvWQvbotxSlgnXk0d8TAtdPO1lf0keupp0Mqy/djKKvKdWMxFQUZlT69vRPXHEeOEPB4yMXWZ1xDxKiG67M4yF8ogtO0ZBLsNSySRjmWqhlJV7AU68FsIDdLxgIs8hZVID/qOT54w9Gv4FvMZRhPz+Esx7A/TA5mopyLyn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfi3s+EM; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-825eaedfef3so179016241.0;
        Thu, 25 Jul 2024 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721894468; x=1722499268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXFStL4WDvV8w8BQz0i76L128nEgk4VMRX+9r1vm1UU=;
        b=Yfi3s+EMGdHfiWDLs8WC8V6dAuBX0zjgT3OArS1vLvNj66NSx0zRIj9MfhHnd4OgtJ
         DAhEUM9bE9rWTBDbGl/RpMO8Ga/Xr0uEyCD7vMhAJHNAbrlD8l0JnpzyimcHDVWkaPDa
         1qbWAfdSTRhGffrxjDGBDESMnlT+9B7a5odTEe+Kii0715agu/Khmsw0ycIhu1kDl3cV
         tIQ0RlmO9+DqB+KcJRY7Yc8/6bOTkGayyVSh7WEqjzQZHvQ+71V4QMo8rIfjhkKqHZxw
         JDL8aswLgY0AeG2H5wjm0scrA5r3DZZaOYdlASpDvQAi8u+kcwdt1MO/LhKYj6SDYs4d
         fi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894468; x=1722499268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXFStL4WDvV8w8BQz0i76L128nEgk4VMRX+9r1vm1UU=;
        b=SrcxFohFPQ350xkgY83HgyzNBfDYUmQ5BM7m4dW/HfNZ9f2jiRNSdrUodImxdTpoQq
         j/jIY+FFV/OTRGBcn46oETB47O5AxjPUif9VVjhGufqpSIPlw0vDh/W/pHoy4vDUhe1F
         xGJWTpl4XFbcVOeT1num8UX3hNPAKp9hYEM+kC+aPA/JK3diMIRyj97SGFGj1KSwfExJ
         yh0+dHfofD6UBe48RKG5HdUa3cUiq9FiGdlh95HLEzBcbXPbvpRzHznFjjdNg9z66cc5
         phMGL2i39cWPHp20uLGH5IuOEDgJZ0NLkmhxRfGDaYJNnVErXfYyPKx5DJarIzYl4oat
         ozFw==
X-Forwarded-Encrypted: i=1; AJvYcCVqdN/K0//GLQwHzqlYhG/nHtxVuRQS0vi5b7zWIkPPTkjdQefIRGxV8DOD7J3T3zRzyLBvTP/9XaHJO6ro79Flex7Dic4JPaFBsQaY3RvwLIgD7pPMpbL+bU+FhJhuWttEqddAu91su/9KZAHacRX2aa1igeQe8U/znAVtX15mn2QoeTv1pxPAfy8Y
X-Gm-Message-State: AOJu0YwVS3UOvC0qZmT2c4gGXNUO3EE5F6A0rvbJtlkBAkd/h+3xl/IZ
	hj99vniOGJVC+ihLkDsxj+OWIl3zqri8DseuFndbQb/BxvQFCz3q4wW2BWJItFHz/167cekEsb0
	/o0FhziGq+vjJbTr7yxojP8V9/LY=
X-Google-Smtp-Source: AGHT+IG2H8sC2sQ2RYkoBe63bCRGsiliAnjuxNL+E6JiRF0jXcoq6nahZ40mNbMRJ8oD1b2IxjhZOUpQVSzDZZsz41I=
X-Received: by 2002:a05:6102:3fab:b0:492:ab05:8d6e with SMTP id
 ada2fe7eead31-493d63e0ce3mr3242147137.3.1721894468430; Thu, 25 Jul 2024
 01:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
 <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
 <CAHB1NagAwSpPzLOa6s9PMPPdJL5dpLUuq=W3t4CWkfLyzgGJxA@mail.gmail.com>
 <20240724194313.01cfc493b253cbe1626ec563@linux-foundation.org>
 <CAHB1NagB0-N777xzODLe19YBV1UJn4YGuUo67-O9cgKKgc-CLg@mail.gmail.com> <20240725-interesting-annoying-mammoth-6bb3ef@buildd>
In-Reply-To: <20240725-interesting-annoying-mammoth-6bb3ef@buildd>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Thu, 25 Jul 2024 04:00:53 -0400
Message-ID: <CAHB1Nag1fXh7M5v6nJbp1b-Y_2tXWvnBjcUPGsY61d=GaOo+dg@mail.gmail.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
To: Nicolas Schier <n.schier@avm.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, masahiroy@kernel.org, 
	ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nicolas Schier <n.schier@avm.de> =E4=BA=8E2024=E5=B9=B47=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 24, 2024 at 11:05:43PM -0400, Julian Sun wrote:
> > Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=
=8824=E6=97=A5=E5=91=A8=E4=B8=89 22:43=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, 24 Jul 2024 22:30:49 -0400 Julian Sun <sunjunchao2870@gmail.c=
om> wrote:
> > >
> > > > I noticed that you have already merged this patch into the
> > > > mm-nonmm-unstable branch.
> > >
> > > Yup.  If a patch looks desirable (and reasonably close to ready) I'll
> > > grab it to give it some exposure and testing while it's under
> > > development, To help things along and to hopefully arrive at a batter
> > > end result.
> > >
> > > > If I want to continue refining this script,
> > > > should I send a new v2 version or make modifications based on the
> > > > current version?
> > >
> > >
> > > > Either is OK - whatever makes most sense for the reviewers.  Reissu=
ing
> > > > a large patch series for a single line change is counterproductive =
;)
> > Thanks for your clarification. I will send a new patch based on the
> > current version.
>
>
> > Hi Julian,
> >
> > can you please Cc linux-kbuild in v2?
Sure, sorry for missing that.
I have sent another patch to reduce false positives and CCed linux-kbuild.
>
> Kind regards,
> Nicolas


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

