Return-Path: <linux-fsdevel+bounces-27791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EF9640E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D81F227AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3AE18DF72;
	Thu, 29 Aug 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="I+JoqGn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8E4A00
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926070; cv=none; b=YN1sabLGetalmvksfEYYVIHSnlBPHl9VlUiRIc/ifIs0D0RO1v/Aprxv6OmvJDl2ZuDmO0z5nPp4CVah5VA3+jyDKy2HY00h7vHy9rd1oCmSoo8p9EbJqUMhftkFFCC9RVhybk2DDFChoJbypOeM1AoAD2lIzXAEyN46D3n4/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926070; c=relaxed/simple;
	bh=U/FCuHSqtRxLMfoBSwyur36Pgij51DYPVICKqmVnlkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxirVaeTmF+5wyDhjLvz8nAGY2hkJ9yyY3gfwAFxtfAbVMshWP6dtSeXL38akQB+OC25VxEuglZfwbsGfxiqZT31j3QCfqEkNgfOWg/g8t6Ml44XSvLL0rc0baIFRYxwnsJEHQ775hHW679oTvmIo/IkiMh2ta2PPhbez4kMQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=I+JoqGn0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso5269651fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724926067; x=1725530867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynBksYt4qQvy+LiJsvlVMlSTXOsdHldotN+DaOYfEJ4=;
        b=I+JoqGn0Hu04K2RxeGWFkHkommrWNu9ckumXi9MNxE+Uog8cxYRabT90aU6iqu6FFs
         SlI5ZiqCOf8dSDg2nn2HA7ap6bzxLTvlhs1+nESdelzPy/xZkS2E2AdXJ1WrJVfGT04J
         GTTypYPdtWiOiexHclTLh0o7iJe5nNP2RsIFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926067; x=1725530867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynBksYt4qQvy+LiJsvlVMlSTXOsdHldotN+DaOYfEJ4=;
        b=XRPDRbAFTxQbjiSleAITxNPI0fAspb8hzFyiHHGNJi5esCziUItzZ9KI4eQZSbyZy5
         LM6fmVSh7PXAPtNfTVSPHQCDS39dsuoS7n5IHFGXP30LeIhGMIFRhxU7Y3QXvPM2Azo6
         KH1/yTTY4dVMHAKbnFOpgIANXcWIMWRAlwlXOpjVDEsPtnk1nWEhgbd2qLglnASkP+B/
         7jhnaMOkdrogwKWozlozX6CjEzhULiycuTYMKrO5udWrlvC0nMk9NqRyRyXuG4WBCR+V
         6LHg3DBHcjtQo68uD3q8rJDYp0kdAQ91BEL6GuSJ7ZROpQYmQ30yeLm+VA4s/eWrv3q1
         cVMg==
X-Forwarded-Encrypted: i=1; AJvYcCVGFVC+sNWqHrV7m4HL+C+w75Y57DUrY3sw6+G7Bj11SNe/HONZO2OJUKQuCWm1Bf8DiDTJSc0ovWseMm/o@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeE7TQl0BcP05ExFloJ1CgJucoYGes4+nAwk8b82vuNrWwhgz
	oWRT5fACcpYSLguHwFzyT9KfCFtzuD7Gwiv1HmtfljufFJ2+FTk5pOfzRvR6Cu0FfVqinzQ+rSe
	ROB4NzhES6LuF+0gE0BhvspNHdEXUtIBxRc330g==
X-Google-Smtp-Source: AGHT+IEiBDRWTKw3anfpskoKQcsxG3210yWZ6VCCrxJlB8sSej4+JbJ3PuESeecUtBRzNpTPOLJOJG2n1sxnWbWdpRE=
X-Received: by 2002:a05:6512:398b:b0:533:47ca:974f with SMTP id
 2adb3069b0e04-5353e5786aemr1343918e87.27.1724926066920; Thu, 29 Aug 2024
 03:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
 <CAJfpegsbZScBZbN+iaydOD2SKPgfnfj4t=EJz8KyMBX5X3yJWQ@mail.gmail.com> <28f37d0d-6262-4620-af89-b70ab982f592@fastmail.fm>
In-Reply-To: <28f37d0d-6262-4620-af89-b70ab982f592@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 12:07:35 +0200
Message-ID: <CAJfpegtjZ_iE4bemsVJbxucsMitVZV25JAmno7x+z0YfKYQfdw@mail.gmail.com>
Subject: Re: permission problems with fuse
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: stsp <stsp2@yandex.ru>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 11:49, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/29/24 11:38, Miklos Szeredi wrote:
> > On Wed, 10 Jul 2024 at 21:55, stsp <stsp2@yandex.ru> wrote:
> >>
> >> Hi guys!
> >>
> >> I started to try my app with fuse, and
> >> faced 2 problems that are not present
> >> with other FSes.
> >>
> >> 1. fuse insists on saved-UID to match owner UID.
> >> In fact, fuse_permissible_uidgid() in fs/fuse/dir.c
> >> checks everything but fsuid, whereas other
> >> FSes seem to check fsuid.
> >> Can fuse change that and allow saved-UID
> >> to mismatch? Perhaps by just checking fsuid
> >> instead?
> >
> > Use the "allow_other" mount option.
> >
>
> Yeah, we had a long discussion here
> https://github.com/libfuse/libfuse/discussions/991

Just one note: "allow_other" doesn't require root, it just requires
ability create a new mount.  That works fine without superuser
privileges in a user namespace.

Thanks,
Miklos

