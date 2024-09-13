Return-Path: <linux-fsdevel+bounces-29299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A67977DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1121F20C66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24671D86DF;
	Fri, 13 Sep 2024 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv5RGncU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20E1B9849
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223780; cv=none; b=fkzHI4RgOjhadr774Xa75yVilOtrrL2gyOjmZmfjwJEUoQ6fIS5XA/XtirQ4sYiUbYKOdh3q3ynTHBfiRx/CyIB0hft7MiP73gc3JVoXHZ0dzcz3HD7vHJ5YxDuEnXrOlca38QS0oC5eESj+VYX/g22hQivbwCyfiNp875wqTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223780; c=relaxed/simple;
	bh=0J7ZDEUgSlw0yYaaOKzRDoMSiSBCTJ/ApCaQEwTWKeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgIMxLPRHwIaBhAwr4pgvBvarOK2Z54lZosgou9BC9MIRI0jfbnIqR6L/UX/mbExwikidi1ErYZPrkCuhFpB2M7AO0f+l7NnNfkhI4Qk/PBQ9EEVg3/7yNufkGj6aO1V3DSDP+07m/Ap2rRnUHn+hIsISUlQzD3zF27ubodFvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv5RGncU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso1451196a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223778; x=1726828578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TglC6+5zZl4XILxFHTsDbXr63jHCRKQKtjZyigcUsc=;
        b=Hv5RGncU76cbBiLBUPzOJQmAD5G8kqHXx/Z90TTirfys392XAsZi2hTaxQDZlQsX/6
         0bWDrduLIG7PJt5F5A7tbviaf8LqlJHeNygnrXphN8muhQM5exhVHkNpLyuOrEfFy1Ml
         XrnSnXqZ5uJTG0NkjgietENe528ui1sgfEEypOIA4CJJwiDiyX3BAGCzBiRjnHodkeQy
         SoyZAQQm5CP4Qty31iEebdKZnt/VaWzE+AxL3NwHxQ5sdqUL/4t8buCXgnOtJSjjatY6
         9nTZDjZUCMTmGHQWZdEw1E5d+ANXc3iYbGVNyhmE3e8L3o3zDoJwTevgvnWJFZgE+k2Q
         /JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223778; x=1726828578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TglC6+5zZl4XILxFHTsDbXr63jHCRKQKtjZyigcUsc=;
        b=ZJV5htejXtiIjnlj491H45MRTpKRMuXan8NojOCafx1HsMfDKsaxuDk0S9wEgrwucO
         l5T+5BH/GUXKCk6HN3U3Mm+6KTvW35X8t73KublOSc+Ash1vxPShgzMIR5pAWCyjAXTg
         A+4ZUJH97Xp/wbcbKPq4tyPDnUPjEVRaCwGFxpZMp+a8f8tdTDzGEbWumcvKejyoW9ri
         uo8esljqc+S5lEMiIrlUKQGlSPTJeV3YZf+sMpRNSz6Mja047Ud2vNOoiQ7Do/fySfhd
         Q5upAKdUgKtp9BKbsbS0TsRXDsjjIYyNYlPpj+/0YjUONRm78HJJ7+BPuINJHWNCUJOL
         UPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcmo3LHD2Slfp21SmM/HsJBpkdA0gQFO53izG+8CBl8C+Ttu3YiWLFiYXrTlqUlY/ljx3gLzhDbXh+0YnL@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7vIT5AUF2gfE7dK/CxCQhR3/Gy4M/VYFWJnCZFoltIiwGzeS
	0abA1P2T2hlRSgB/OHdSSmD+8JX0ciQ3BRucEqkbihPMPgGX2sFcPq9hTS9n/BpC5Z3kpUshCJA
	5lTv+zGh5eHR7j6ZfPBD6ns7pfZo=
X-Google-Smtp-Source: AGHT+IF/MgwkVPxLFzzQrCSFO5HCnkSEcIcSI6t88xwNZdaAxiN3FwidXbckbPsZBLdJfLJuD7+bo+YTed2ubbH3wbc=
X-Received: by 2002:a17:90a:5ae6:b0:2d8:a672:1869 with SMTP id
 98e67ed59e1d1-2dba0048720mr5869942a91.32.1726223777780; Fri, 13 Sep 2024
 03:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
 <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm> <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
 <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm> <CAOw_e7aDMOF7orJ5eaPzNyOH8EmzJCB42GojfZmcSnhg_z2sng@mail.gmail.com>
 <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
In-Reply-To: <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Fri, 13 Sep 2024 12:36:06 +0200
Message-ID: <CAOw_e7bTTP+-+=9YW2uPU+LKACog_XxumRkH_NxzscJqxtnZLQ@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 3:06=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:

> >> As you can see, that is fs/readdir.c - not fuse alone. And I guess it =
is
> >> right to stop on a pending signal. For me a but surprising that the
> >> first entry is still accepted and only then the signal is checked.
> >
> > Do you know how old this behavior is? It would be great to not have to
> > write the kludge on my side, but if it has been out there for a long
> > time, I can't pretend the problem doesn't exist once it is fixed, as
> > it will still crop up if folks run things on older kernels. The
> > runtime for Go has been issuing SIGURG for preempted goroutines since
> > ~2020.
>
> Following git history, I think introduced here
>
> commit 1f60fbe7274918adb8db2f616e321890730ab7e3
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sat Apr 23 22:50:07 2016 -0400

yeah, that is too old. I implemented the kludge here:

https://review.gerrithub.io/c/hanwen/go-fuse/+/1201139

It is not that bad after all.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

