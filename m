Return-Path: <linux-fsdevel+bounces-24345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64D93D9D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 22:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749A11F246A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30AD1494DA;
	Fri, 26 Jul 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5jki3Hl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BBEFC1F;
	Fri, 26 Jul 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026144; cv=none; b=GC229v3N2eovHrs700A+po3ev4yle9aP77pSeCfiuZa/SDqtjG8Mbb6EI63+i/JwMiiJxTNFQP/FlRkCKYPIrLsbYte7YcKdx4CfLZbAuy6E+/6tuhSD8S5Hba0aCTxkcCuZKi3QJ30tu3ctB4laNNUypEU5P7ba/VRgBehnJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026144; c=relaxed/simple;
	bh=t9M6nuJxKb+dGy8opqEavSOz8C3vnFWfXCr9ohgswFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjPA7t6pvHAfsjrmPQ3478PHaK1lMbXr1nDjqZLfww/ktNYN5mg+EC3ogs3zE4QlCIOvbkck7KwPp9GLV2CkNLDbpwAXZLTwx/Y9IRrA9CWq6B8G1b1TUQeFHoGTWYH0fgxXZ2EBIj90V15X2TdHE3DXTbZRKPK9u33Z09grGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5jki3Hl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368557c9e93so44226f8f.2;
        Fri, 26 Jul 2024 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026141; x=1722630941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9M6nuJxKb+dGy8opqEavSOz8C3vnFWfXCr9ohgswFQ=;
        b=X5jki3HlAW7bVQw657cIAZ5Vx48a5tN2GnR1AJsOuROZ81rQAap9sL3YDIL+U+VBCS
         51BFCkHLQyp2TvlC6vhAjURNquWdnmb5kiIxv0LvsspOAf+hytj+4J9jbukwwfSmVhuf
         i/dhNMfLp8Hl4ZbSH49wb/ofi1ys9F1M152Jt8WPUbCAPjP80i/MSPFLbWLKXFo5xzQd
         50Vy2GaUKSrfFuvEMtVkDue2HLIKZOG9G2tVWG21E2R0WlMmNxoJVATiOl7CCiRXU2mP
         sDd2oXYMUrNMF5v87+eX8cqO7ErQEbQxif1GRJSw7KmHqhfD7iHvlO5+AeqGV0gw/+p5
         7jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026141; x=1722630941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9M6nuJxKb+dGy8opqEavSOz8C3vnFWfXCr9ohgswFQ=;
        b=GZY5HJrYfI89NW4/ZC43n8fd02wCS6k0yrqVbkqOSGAhPQ2DIgc5GR88aroX0JjDtk
         NFjalNbPuUVzCiv9QlwfThFBEw32pvW04PKZmFsgwlAgUeyDjANNgW6nvsBabJI5z7rE
         E4JEyh57MoxRG96RaSsyOUSHSYNitC55FMmqK1pK6KyGtQ0l7ctR6wQA9691Qhl6OLvo
         Jd12AK7KztJZJkXDac8yBGsh5vYR97EU7vcqYm7FnDeCoq5Y0cu+lwZmOIZIq3nlIt9n
         ZVX9F8wLrrWx0H+EbZzCOqDXZSgmPWpwLg7OKlQcAA9j2nxEdtNzXv+rFqDPbvJ+jBCi
         0fSA==
X-Forwarded-Encrypted: i=1; AJvYcCWo7glX4fWYyP84hSU4hRVp1oP7+lSJ0jqWQrm0k8ex4VLLBfRkqMHahwdXub62HV1tmlrwTilWAVm0pgOSuTf8QKucb/cgkUOyfzjyqGue2gzzJf+7yYtJ7fh4VsYx+fG6og==
X-Gm-Message-State: AOJu0YyvDcfuKz21YEqoFNmg+qINxQqx4yzVhpthf7m8d3q/aISGztq2
	7967n5Y0qvX+ut7kJwAX1p0kzou9eo4aZF6Sf9BnjXl0R573L1yYlO/dObtIxFeG9g3sianwULo
	JuNFxt53homs6gaCh5fV6CN/LcCk=
X-Google-Smtp-Source: AGHT+IFG3aeN23OifwalzBN88+kcjF6H+eLQ8/tesvYhFTHXI/J7WCE59h+Y02JN0rf6WUkgR2N/ObR7Ymrvupk3+vs=
X-Received: by 2002:adf:ea12:0:b0:368:35db:273c with SMTP id
 ffacd0b85a97d-36b5cef907fmr552163f8f.18.1722026140697; Fri, 26 Jul 2024
 13:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com> <20240726-clown-geantwortet-eb29a17890c3@brauner>
In-Reply-To: <20240726-clown-geantwortet-eb29a17890c3@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Jul 2024 13:35:29 -0700
Message-ID: <CAADnVQK2GkwEqg_KtFha69wWjPKi-9Q6eS_OMWQ9QtGYgUEz3A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/3] introduce new VFS based BPF kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jann Horn <jannh@google.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 6:22=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jul 26, 2024 at 08:56:01AM GMT, Matt Bobrowski wrote:
> > G'day!
> >
> > The original cover letter providing background context and motivating
> > factors around the needs for these new VFS related BPF kfuncs
> > introduced within this patch series can be found here [0]. Please do
> > reference that if needed.
> >
> > The changes contained within this version of the patch series mainly
> > came at the back of discussions held with Christian at LSFMMBPF
> > recently. In summary, the primary difference within this patch series
> > when compared to the last [1] is that I've reduced the number of VFS
> > related BPF kfuncs being introduced, housed them under fs/, and added
> > more selftests.
>
> I have no complaints about this now that it's been boiled down.
> So as far as I'm concerned I'm happy to pick this up.

We very much prefer to go standard route via bpf-next
like we do for all kfuncs to avoid conflicts in selftests,
and where these patches will be actively tested by CI and developers.

So please provide an Ack.
I can fix up <=3D while applying.

> (I also wouldn't
> mind follow-up patches that move the xattr bpf kfuncs under fs/ as
> well.)

np. I'm sure Song can move xattr kfunc to this newly added file.

