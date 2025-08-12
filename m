Return-Path: <linux-fsdevel+bounces-57526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D7B22C37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37255503C0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444D2F744C;
	Tue, 12 Aug 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SNra44Eu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227B23D7DB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013816; cv=none; b=JPCSIyk0gttXCFkMonHQiaGDbxwCrIDf1HZjuCM9fxqFNpDepmZ18Sm95YsiAIuCB2kbv0TcyysmiKpz97vzBJHWB/TUpMXK9Mi6I/vw7bsaBtd1ApEE0DRZ4wFhES+JtWJPFrwFJuB+gw/qk8QqxY3qL7yRZE9amf9blZb8eFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013816; c=relaxed/simple;
	bh=aQVwMfKixKRQPvxzY6UQSRwcofQ5AEV0bdWG8OQqx/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkBIhDpUoysqRzD/iNfat0E6qUvAeuniipBVj9yZsrslGzyswiToSpT2lePjt/L0VxiUmtrn89GhEh7dglCsCUHvIkzfe8gAIOhfjVDyrBCfdPT2YBp1ySAbRrTLF9DHb56VIoRueFN/6Dfz2on+zTw6QP1ynH5HZDkqrIgiWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SNra44Eu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4af027d966eso66550421cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755013812; x=1755618612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKNapRmAKNQZFT18qrlhTl2TH+yUs2yAdt0JKnATnlM=;
        b=SNra44EuAeBZONcWxXM2EJNiD3m0OdbcxllpiRuXFuy8SfRl+b9p4U+uVCNZ49D5+S
         UncOwRGEREG3wvVYDfmeCyi3VGVuBtDKU4/O2kmpfndTEm9KF7dhUDjyIWL/yDXjKJbl
         w8rUz7PvzOsXbcUxgTyiVLJRvUpstOMyAjzA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013812; x=1755618612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKNapRmAKNQZFT18qrlhTl2TH+yUs2yAdt0JKnATnlM=;
        b=wqLGMRlFK2gzx1JU3vy3vNz3HO75LmtCLAlkcUqLvMYLcoMO6sPTNGm1+WK+JqJs2J
         TSTmIc207b93q8MlLWsj78Ua57PRWeyalxgMTpL0GDYO0T5v5sXPtzO/0GaDj4EnKyU6
         yyGpUE30jr8jxSS12Nzvr2dFHAGJGNNsE405XDwYknHSA5g3MwMJHsKnBWTBJxzOikSg
         SCvV4Gq1gsJJ1emCmc0xsbBWklUYOCvPve21hW+CNMC+l9pFhRwB4PX74DB5knjWB/+u
         lfDmLRfieS4qv/EdkXcfpCe6Hg5p9XlJ9nAQBimCiNPneQ+6IjtWeB5MhnvnvROMWYTm
         Rrmg==
X-Forwarded-Encrypted: i=1; AJvYcCWn4NjVXsohxR1bEMGfVWM1XXFosNBkvR4D7phvx34OfknAgteM7qmDWVbbH1BlK96g3MaKFaB2KeP4NE51@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUHcRj6JdSnpo0O7UQIETcXFYxq6jwgeeDdO+hGGK/JsbzaXp
	9fcOoiOkKQD0X35mLmcm4rKyuolz+8ql9SLBzvpY7DADLYraztHjic12Pf9SYYUW1FRRBRSBb8v
	BGQQM+zhoImNl/9DLiwECF5KOII+DMBGnFR+L/MaPTw==
X-Gm-Gg: ASbGnct7jpg+hYeDPHYSC62GIAN+il8z1Qe/33El0V9CQvN+rm13CZ+QcUC1kc4HnfV
	gim+9rbK3FfyLoH/58hhnAsaXk9rTJUX5wYrKM1IXAGpnYDk52sVE/PjcSTfiOmWWYv4G1H+ZDj
	nkUjSRA7M8HUuzzAsKWs07UR+LdOf9lHZ6i4yhI5RYqrTxYSSbz85Anz2zqBB5hy8Gc+0R++KIm
	aK7
X-Google-Smtp-Source: AGHT+IHg5P0OEUYn9SCG0+rd8LLkTy1bic9Mp/5yPMCG51z5wUWdHuW2S5872YRxPKHeCM+gOK/FngNDR+4ibPs11yc=
X-Received: by 2002:ac8:5745:0:b0:4ab:730d:c17e with SMTP id
 d75a77b69052e-4b0fa8ac981mr958981cf.39.1755013811975; Tue, 12 Aug 2025
 08:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805183017.4072973-1-mszeredi@redhat.com> <20250805183017.4072973-2-mszeredi@redhat.com>
 <CAOQ4uxj4Naa_=fPTXT1n68xsPhtZLPYpe0rd4LhzFotkb+fk=A@mail.gmail.com>
In-Reply-To: <CAOQ4uxj4Naa_=fPTXT1n68xsPhtZLPYpe0rd4LhzFotkb+fk=A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Aug 2025 17:50:00 +0200
X-Gm-Features: Ac12FXxtjxLadzhKLRpOHKZYWrkrLTvqJlK-YVLZ6N7rJHPqblE-dgG37qpbi_0
Message-ID: <CAJfpegtGa07mCA3CqOarKaL9=GtZ2k9gwE2prSTtDoBsqj8X0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] copy_file_range: limit size if in compat mode
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>, Florian Weimer <fweimer@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 at 16:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Aug 5, 2025 at 8:30=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:

> > +       /* Make sure return value doesn't overflow in 32bit compat mode=
 */
> > +       if (in_compat_syscall() && len > MAX_RW_COUNT)
> > +               len =3D MAX_RW_COUNT;
> > +
>
> 1. Note that generic_copy_file_checks() can already shorten len,
>     so maybe this should also be done there?? not sure..

I guess it doesn't really matter, since all of these functions are
local.  I've decided to do it directly in vfs_copy_file_range because
in other cases MAX_RW_COUNTS are  checked directly in vfs_...

> 2. Both ->remap_file_range() and splice cases already trim to MAX_RW_COUN=
T
>     so the only remaining case for len > MAX_RW_COUNT are filesystems
>     that implement ->copy_file_range() and actually support copying range=
s
>     larger than 2MB (don't know if they actually exist)
>
> IOW, if we do:
>
> if (splice || !file_out->f_op->copy_file_range || in_compat_syscall())
>         len =3D min_t(loff_t, MAX_RW_COUNT, len);
>
> We will not need to repeat the same trim of len in 3 different places
> in this function.

Makes sense.

Thanks,
Miklos

