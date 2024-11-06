Return-Path: <linux-fsdevel+bounces-33802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD79BF0C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76951F23500
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2F20264C;
	Wed,  6 Nov 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iNc6fAvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89E2022FE
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904831; cv=none; b=ksRO9SggCV8nLQntLdVMm7jmEaaW1M+ZmC+3M4BlzuSXlkA4vnT54rs6xTU5bPPQIhwMkWRCO14ohuFGg+5I/5pZqvkmAgYTeGSFPuM31gGZThkyvJAHJU0S8B5Ob73cNZog8KGGJ0Y27vhDxPXgdLhxbGnAPpW2bBLmZkDzy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904831; c=relaxed/simple;
	bh=qd2oxWfj8ZkVoRk1/1WgltaqLpvNVj+hI5ourNOsBOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsN3zMc/iHiTWSqtmixFSNe1KIenAwzdGE7/AwYSg2ZK/xmU7Cy8fdZjinudd5YQhvLjfMGO69h2B027a4KbGlxdWduLZUkEdkGl+gW7cOR9HqzROZhLclDbV/2RuwdfidAjqrqWWZR6bn6bvHRshlPuLAii/AmNromgcXoBXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iNc6fAvY; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5eb9ee4f14cso3031510eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730904829; x=1731509629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd2oxWfj8ZkVoRk1/1WgltaqLpvNVj+hI5ourNOsBOA=;
        b=iNc6fAvYDeRtPQr95FUNmrazZefk5IUyWYVku8Nvjklvc0w/YVHDAK9739iYEshGF5
         DbtFXsGTDrxtltYCKGm4hQiTJKJh/+49XnAA+gp3Goa10UD6FziCyKvChmqcXhuY0f30
         opVdF3FZbrUa+ZDGmClDzO9LwDDvRx8eMyNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904829; x=1731509629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd2oxWfj8ZkVoRk1/1WgltaqLpvNVj+hI5ourNOsBOA=;
        b=OoUMEOzAo6P7jXFZc3g+sSXd+cAqiAyUpMcPCCddriZlEZs12K8aqv3Az9BnlyDbvP
         zKGiW2kTWYwWMOpsflBxi4766rxrNGaEowDvjVjJa7nL17jEHWsMYrKucKzXh3V1zJjV
         rzmmLcrdXF2r3QPQrkNpiJ7VShcTQ7LAR18FJ1ZoTbNepPZpMOWZMJZTNpbR5hQL/1kl
         opuSfonAVBpSPpBu/9NzUES1mPZ+zEFx7uhOYl1yeuQS7qbOwVS4lt0OYGKdzV0FsM/Y
         dNLpDf0+RAYW6u9sl279QTwxV/DfE1Ig3nCGLGqzpXnLmv+EMCHkf+fXEtYLUurE99t4
         Kw7A==
X-Forwarded-Encrypted: i=1; AJvYcCXsINT1ra+d9dNmKj1cRiGgYN+r5518kGDp78zuk4CY1bFwfETLqaoBOuCJ9jyCIPDFVI0dr8Wcp7XAH5Hv@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVCTWzTAp302Ps4UMuTzdTSukN5Rl4o6pHbobRndrUeid+dfR
	/1MYMS4YyoEfcutSzo8DU4JW3akwos+yCQNsXA5mZe9wQpteWwD2e6f72T5GPuyOu57lCAAkJDV
	2+Y/mbS1Kmm1Dw6rWVIAYzDXVtq/OLwVb+jBlxA==
X-Google-Smtp-Source: AGHT+IFa9JnN+t6Lfxkdc0ulgnBmj1ApwylswzSBXd0agEog+CiLEpOj+2CvAIt5HGuebycCh4ZaLZNNY+Op5Y+TgtI=
X-Received: by 2002:a05:6358:729c:b0:1bc:2d00:84ad with SMTP id
 e5c5f4694b2df-1c5f98c78acmr1025710455d.3.1730904828818; Wed, 06 Nov 2024
 06:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner> <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
 <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Nov 2024 15:53:38 +0100
Message-ID: <CAJfpeguvAB-VMyV1Tin=ZDzPHE=P+ac4REQrsn4C5u8uh3+TmA@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to fsopen logs
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:

> > I am not sure about the level of risk in this format change.
> > Miklos, WDYT?

I don't think the format change will cause problems, but it does fall
under the "no regressions" rule, so if something breaks then it needs
to be reverted.

> > I am not really sure if the discussion about suppressing the kmsg error=
s was
> > resolved or dismissed or maybe it only happened in my head??

All I found is this:

https://lore.kernel.org/all/CAOQ4uxhgWhe0NTS9p0=3DB+tqEjOgYKsxCFJd=3DiJb46M=
0MF04Gvw@mail.gmail.com/

I agree that this needs more thought.

Thanks,
Miklos

