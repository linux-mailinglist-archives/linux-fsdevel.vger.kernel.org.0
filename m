Return-Path: <linux-fsdevel+bounces-53649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF75AF597B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986FB1671D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43776275B06;
	Wed,  2 Jul 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k9OiYvDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDA265293
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463433; cv=none; b=tdPMAlb/2kikjgkWMN6FwzC0kxVOzBW32RYJ3utsOzkUY9oYDsrUWsp7v8T/K4qeF/Wk7p8yI+xT21RaT7chpTyVr7dzqzKMhSjCPIZxEBsI7hadX37hmH5T2VNU9c/dKHmuBQdkWDR1daoH3yDT1dQqxQPMa4qFeyC6UpciGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463433; c=relaxed/simple;
	bh=srOHDgn8HhTIkI0SBqtkEC25icTRNHtg25nvoDwb18U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcUsF85dLOYryuwKH4gGzPvmuFl99HjpFkddT7B1QXOtx2dEEuxyYaeLeMkm5k0s/vw8v5QsroV5xZAsJ0IPkYF1w2lVtiBwvJn/pKKsJbViGAClSk3g2den5ASlOlflDoRebNJtHF3FBsqOSmnRFdJ608ZKOFbVfudCDYfbY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k9OiYvDT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a442a3a2bfso75015021cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751463430; x=1752068230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcshAPqVtuBMyKRQCZTND0EceDN757ts2t7L6ZRQr2U=;
        b=k9OiYvDTb6Kf0KJ2Xu0c/BZeFZAp06zvyaUBGDFXhXgRKZgmcLJuPilMG1Q+aUWXsD
         VLraD8MGRlC+i73efnw7OYj5fOTmh7ocEgBiiEaOCMSGycvGsnOR5xPgLa9w5l38auH8
         rvlIGtwwDgobjLPh2PlRJw0K95J9b1oueq1qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463430; x=1752068230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcshAPqVtuBMyKRQCZTND0EceDN757ts2t7L6ZRQr2U=;
        b=wgloL1BeoMlmkod2Qw28dEO0omTkwVg1v2AoVTFsMJ0vHP76NOnr2itCDRzMjM+avq
         wrIy2ciL1k223e9o6I++fCurryvStGygey83Laur7xl6Bf4ULqiCZa25pq4AY5sycdpT
         9FFKtDtU6cDDRGpFH1jxJpxQezqRfIOoEwK4G5i7Ym3JvknX0xbnTVlegMMSDZ7ZrJ8A
         wKElxz56EN4NIxHEkJm2qMPeGeRUIztBMFt4O0T0azmLCcLfSshQBK1qoAJFZku9AapG
         CfZmMEaCGEu+7oqtLjgbC0xBxD64z92/SAYqubJ+rmu8JRIrG45zZwS9Fm/OVe05/wwI
         6Eag==
X-Forwarded-Encrypted: i=1; AJvYcCUCJiGT8MZJDC8ad9S+IuPF9B7VUX5W4JsoxR5ty5TIHsykmz/SiChGAckYfeKL7+C0GfD2QorX567ens/G@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPOzsTdd22TendwnVES/NpLTs3M/ZZh/5q9qcw4fkuXXT/CVj
	2ZM2aQfUOeWSTj0GQJUiLCvxaHl3xzYwkGAl3B6Hl9DoTz1kwMaXVm+/KO/UEqsFS9uoMkrgEeR
	Y3lfB7YEc6gvphXyYa/0j8axsNLAYHinBSgtwyQSk0Lh9Oni/2tFKPEg=
X-Gm-Gg: ASbGncvyumkHotpKao7yqxiGG9HRkwtUaq8cS2uvITcebmsRhDxHni7zyFZIBbo7rF8
	fHhZxpzBIwPq+GhBxfer13nRTvvtGeZfIeQZADYI4kZCnEfp3dOWfrNzQ1rwQy4O5t5e2AYBUO5
	5uagxH7uHD3uM8ke9UCM7jqrc91wq24q/4U0y6bMkAcSec2TbFttfaRJ+Cgdxiqo0pPnJlL0JmT
	S4nVauzkSOPsqU=
X-Google-Smtp-Source: AGHT+IFhLgihdgwJX/2fNy5iGQbenJ992PcqbD47xsL5VQGzp0D3Ls+vOoiPBqyRuZvS/5NuW28i6xKgoiX7Tlcv5ew=
X-Received: by 2002:ac8:5794:0:b0:4a7:f9ab:7895 with SMTP id
 d75a77b69052e-4a9768f3b25mr42124991cf.4.1751463429609; Wed, 02 Jul 2025
 06:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+AidNeR+_SZPQjD37JcibOoQEwtDEYz6bBef1O3PfboS0BJtw@mail.gmail.com>
 <CAJfpegsdhqnxCmQfQzGRP=zbkuNofExcqoCi5dMk4jAFc14EoQ@mail.gmail.com> <CAOQ4uxi6QN6Mc+A0wrEUW5tWiGhGYF=ov9+q=O1Me8joDpBjQw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi6QN6Mc+A0wrEUW5tWiGhGYF=ov9+q=O1Me8joDpBjQw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 15:36:58 +0200
X-Gm-Features: Ac12FXwKcIHLV1W0e-HkxZOHmhZv0VlRBOPzf49Dz-hlMVJRbtHypRIsyNxPXvA
Message-ID: <CAJfpegvhJWFQi38xqvSJ4iRtyMz6sr6Qbkx9Pcvk66eD3Yn42g@mail.gmail.com>
Subject: Re: Query regarding FUSE passthrough not using kernel page cache thus
 causing performance regression
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ashmeen Kaur <ashmeen@google.com>, linux-fsdevel@vger.kernel.org, 
	Manish Katiyar <mkatiyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 at 15:33, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jul 2, 2025 at 2:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Wed, 2 Jul 2025 at 14:27, Ashmeen Kaur <ashmeen@google.com> wrote:
> > >
> > > Hello Team,
> > >
> > > I have been experimenting with the FUSE
> > > passthrough(https://docs.kernel.org/filesystems/fuse-passthrough.html=
)
> > > feature. I have a question regarding its interaction with the kernel
> > > page cache.
> > >
> > > During my evaluation, I observed a performance degradation when using
> > > passthrough. My understanding is that the I/O on the passthrough
> > > backing file descriptor bypasses the kernel page cache and goes
> > > directly to disk.
> >
> > Passthrough opens the backing file with the same flags as the fuse
> > file was opened.  If it had O_DIRECT, then the backing file will be
> > opened with O_DIRECT.
> >
> > If your fuse server implementation removed O_DIRECT from the open
> > flags before opening the backing file, then this can indeed be a
> > regression.   Otherwise there is probably some other issue.
>
> I am confused by this statement about O_DIRECT.
> I don't think that it was implied that O_DIRECT was used in this test.

Page cache is bypassed iff the file is opened with O_DIRECT.  So the
statement "passthrough
backing file descriptor bypasses the kernel page cache" implies that
the backing file was opened with O_DIRECT.

> "I/O on the passthrough backing file descriptor bypasses the
>  *FUSE* page cache and goes directly to *the backing file*."
> NOT *directly to disk.

Yeah, the question is where does the performance regression comes from
relative to non-passthrough mode.

Thanks,
Miklos

