Return-Path: <linux-fsdevel+bounces-49108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB0AB8212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670467A4EE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2272957C2;
	Thu, 15 May 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kxG185Ku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3C28DF03
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300124; cv=none; b=DWZRcJESIr+3PseA5Xm00Lac4COFFQolhQwuU0sc5kFO8s3ndlNiN29kAd3mMu+/otDUHg8KzKJyZ6s0asoLAdrJ6uz+HAUJCIB7R7LQfik0mWjbIlzyksFQndw/W1liDyA3605FTGOQXXdQa0KBHohSpRd+CdeRAWG2idUIb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300124; c=relaxed/simple;
	bh=r0Bfm0Lezye1VJKZNFB69qPGWLtUKXRzwk7H9jXE9+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFsYXOhXuD+/xTYEEjTmy3MOTvRJF9u7OTWpFfpxQDGzDaT1v6roKkI4DpnglCOpBHPbWQx2G4sJNH8zVEBizkivr4oTcjlyF0M2R7UUXWO8haCBErmLXZIpY8x5x45i16rmPeoUg+08lwP+niW6t06nLzYYpK/06/XGqQEgvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kxG185Ku; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so5509411cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747300121; x=1747904921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7hbQxVqZsERj6YIejzl29wad9VM+LlegwZENNoI5ks=;
        b=kxG185KuCVqdmN7clDvmPB0sTKqOnmQ+w6BdUtwSZykGmfCnhJldDRMX3KnZpAtPd8
         VoMbmEmQqDq57wnS3DfoNVfrI4o19Yt8hRTYmSYAEoHXt4Fb/oNrgh3fwC2h5zqEbb49
         X/xoTy/H6TDTC+liBxyUhUjAV30dASqkywAss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747300121; x=1747904921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7hbQxVqZsERj6YIejzl29wad9VM+LlegwZENNoI5ks=;
        b=Dw1M/koyCOT4XQrP4yrulZuVGTymhq98u1SJLG4p0FePHnh49QXFhsddtzIrCQQo8C
         iLAC2y5DXQyfmj2U3xC84EEHG6dyJifDCd6e1Sz1H3oJPDLFeAJJ7QEu3gu25eBEHZzK
         mOSuALDcHFwp6yGiwx/KAlHkA3UCYl82E+fwbHpDFgJifjRaGQkys8xjciqhN5v8ZTGk
         w7U3Wu9dTeLRQc6VuqFqGXc0oILyyMecV9vQQ2qX6kPqTQ6flSy/PnYwn1owixBYcCK+
         Eeij0a1pu37x9HLHAWPEuF43XB78tsnlAzz9+BaLITTn200by9+fgfoiegi5Rga3hgzZ
         iR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWbvu0U3s5x40VTqc247uWK8bErugKHF/7qJ1kbu1DWLQ8j3v8LkEqHvkTIMJMZawGuvdpggnltOOo39S0@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTlOwfhnz86VOnhJZVgp3A5ucdhJG185LFsABLndn7xuM92Hi
	vDC0z4EnugYCY7T787kpU2Ixn1TPQUfgaMsSk5rv0DeRd02OmMuimyoqC/qTM6KedIvhT0Jf1+h
	OAwXyFpifpeVlAnasY/UJaUgoPMVmrSLdW1HfGg==
X-Gm-Gg: ASbGncuHP2LfA0fmtWTVQfcCU9iYiS18oP/gzuTY8tA+7+nTUEtRxBKnSvx1e84EpE0
	ACCBRBC5No1vjx1XMmLf4zAtNpfr8MpY/VQX8ayP/4lBikH/0sE2dQJc3nSGM6oToVPsdD6uEXn
	9EoMsHHDflkc6icVu3h167lyYPT2ilRQU=
X-Google-Smtp-Source: AGHT+IFzrnJJnn3asVm/tHppycMioZ61uytxdPeqw7tVnNEK5Hgu/5X74yE4ReIFnOXRZCTl5kwQNPBZ69nz7KgPpGw=
X-Received: by 2002:a05:622a:90f:b0:476:90ea:8ee4 with SMTP id
 d75a77b69052e-49495cdb6f5mr117127071cf.32.1747300120911; Thu, 15 May 2025
 02:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514213243.3685364-1-rdunlap@infradead.org>
In-Reply-To: <20250514213243.3685364-1-rdunlap@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 11:08:30 +0200
X-Gm-Features: AX0GCFvZSK9EPpEWzKHTuKpuK5ftqDaFys39fkZuh9wQGIlM8WOvFN1IBVc-VTQ
Message-ID: <CAJfpegv9k5tPwq66yRvA6EdFaxHUqGsxYCfxnAKg8HjwpTi_gw@mail.gmail.com>
Subject: Re: [PATCH] fuse: dev: avoid a build warning when PROC_FS is not set
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 23:32, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a build warning when CONFIG_PROC_FS is not set by surrounding the
> function with #ifdef CONFIG_PROC_FS.
>
> fs/fuse/dev.c:2620:13: warning: 'fuse_dev_show_fdinfo' defined but not used [-Wunused-function]
>  2620 | static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
>
> Fixes: 514d9210bf45 ("fs: fuse: add dev id to /dev/fuse fdinfo")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Folded, thanks.

Miklos

