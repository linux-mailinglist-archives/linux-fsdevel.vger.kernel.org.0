Return-Path: <linux-fsdevel+bounces-49916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF5AC50EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A451BA05DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BF1EF1D;
	Tue, 27 May 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gnMWlw8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28616A395
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356269; cv=none; b=fWJF95IWXfu96cGJCweC87MRXg+rw4+kip9L/99r0VoUDS5/a7DxBT9YcfHrxqQWyvYevg4FARjxl/68in8cFGGFDFD0PFLgmrfl/cVDEBMWJX1PpCuijYUqp5gbEZcJ7PBUQjlDSMz/Q+g4qFAewGorA/WR0MQ23/sfisTA944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356269; c=relaxed/simple;
	bh=HUr/kUWvEEfE9fl6NMGmlbiUMU2pDiKkDK7xwuTmsYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxXOgUMY3Sh9YDHKUhtskLdJHrdpCKPHZfZh5Gmk/2oaiOIlCk2h0t/Dr1LD7O+1WIazVd/q9/Ivod825E3Tb54y3hPNAuD18GFAigIGpi3iPgHNk2T1SMZBEY29Y2/Wqo+lFTSNCh6KHsZ2dHI/yMANlTX4Gu3EocuaW2OLAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gnMWlw8t; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8a70fe146so61137186d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1748356264; x=1748961064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUnG8ekw95gPFQGcG+7DIs+qq8aqpWajH2XCC/r58ko=;
        b=gnMWlw8tW56WHQZtSx3N+KRhQPYuViiAltJMtObg8pm4jmcn9k2rZPSQkcgQgBY3dW
         klFaZXiI8BXPhJOzTTQAmKe/D7CW3DI3nN3ttgYEcrtgkiEZ0mjxaPSpNYPB+c9O4VRh
         YbGIytLCpMEDBYgjBOENgb8K8JTxoEypWT+DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748356264; x=1748961064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUnG8ekw95gPFQGcG+7DIs+qq8aqpWajH2XCC/r58ko=;
        b=onwQzMmg5+DFqORXFSIcdWANYnRy2V1Ae2ql/Uxzy7wmnf6YrFWdGA9IWSWlrYXXxx
         h/K6gnU6UdA7T68iXM+g1r0uWijHZGumpXGk83iOcwL/0FuNoHoAP7sHhIZ/QCX/Cwac
         HcMAXxhgiCokAW75WXpHrB1uzgegF8+GhKunzCe4OzsBRjeFZzSksCEoOeltLDc19P0W
         4q6xGbvkTDcumEsw4/Cg5Ywpa9cX3vndoNje1/PtMHtc60QwiVHMWRsI4FnW8F76hifq
         rIxLGtesZZD2MOb+kthij6n1VWYLtc84+81oswnPynDM+luO6n7dk+So9xI0PwllRwgk
         tylg==
X-Forwarded-Encrypted: i=1; AJvYcCVxvPGw6OvTAjnDvMt4nkZ7NNiCEolLf6JSg2Fe9ZYtY9O3Bp/4AD/GoubAENTckU+IH/kXHvozfyqrbv60@vger.kernel.org
X-Gm-Message-State: AOJu0Ywko1ZGkDLxfnsPHY0S22rvmCAd7apeQfmDHptyNNZpCpoXxBbQ
	PZr2SCcsC2aV48A6CYw5e4dDwxxjIaJUTQcIBb3tyh4K2SWRbllqxy22ywtEEZxVP+7SlU7TWwh
	nep8GsxsYs8N21Mdyr4YVY+1cqLtKB8aXzFRPoAEwkVNUJ1fGkw4a
X-Gm-Gg: ASbGncujSRlMOoBY1wojIW8H6jg9Dvkbo6vp4eUPtSm1/dvlUfFSG7sWSuypUe/gKzc
	qpUsfG6Qt/bSH3mCmLa+m583weU+MnSq0xK74T25kdWM5SU67hf+8MROPn6hO4u920c4/k/TirT
	Ev5lWRphaSZpwPj7Zk/vwuy9s1jfFl2IlK1UY=
X-Google-Smtp-Source: AGHT+IG+guhgEmLjuVHbnT0XT9GD17XEU1P1QzitaFRZb0qHXByw0U0Of3TFKrbJRnizVwm+q8AYP+TAJ1TB0gaa1d8=
X-Received: by 2002:a05:622a:259b:b0:477:e17:6b01 with SMTP id
 d75a77b69052e-49f47de78f7mr227305421cf.43.1748356253771; Tue, 27 May 2025
 07:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com> <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>
 <20250515-dunkel-rochen-ad18a3423840@brauner> <CAJfpegutBsgbrGN740f0eP1yMtKGn4s786cwuLULJyNRiL_yRg@mail.gmail.com>
 <CAOYeF9Uj3R+j55vJvO+fiVr79BsDe2de-pvhSyveoq35wOeuuw@mail.gmail.com> <CAOQ4uxgea2g7A0R1yD7E8=EP1zuuO4R7L4yXJbzUj2DoEz4vUQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgea2g7A0R1yD7E8=EP1zuuO4R7L4yXJbzUj2DoEz4vUQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 May 2025 16:30:43 +0200
X-Gm-Features: AX0GCFsc6AbHF6x8tfR8M-PV4Q_zLzBzPlALi5MPl024qG7Jftry62EpSnV9pnE
Message-ID: <CAJfpegtpUxFoayq=4YUWmHWrc+ob3jrLn+zeWzejNxaHvRW8QA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
To: Amir Goldstein <amir73il@gmail.com>
Cc: Allison Karlitskaya <lis@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 12:12, Amir Goldstein <amir73il@gmail.com> wrote:

> I cannot help feeling that all this is really pointless.
>
> The reality is that I don't imagine the kernel's FILESYSTEM_MAX_STACK_DEPTH
> constant to grow any time soon and that for the foreseen future

I think the reason the max was defined as 2 when we implemented this
in overlayfs is that there was no use case for more since lower layers
can be stacked within overlayfs and that leaves stacking of upper
layer, which there was some use case for.

With the introduction of fuse passthrough, I can imagine that there
will be a push to raise this.  Which needs careful review of kernel
stack usage, but I suspect that we are not yet close to the limit.

> the only valid values for arg->max_stack_depth are 1 or 2.
>
> I can't remember why we did not use 0.

Kernel uses s_stack_depth of zero for no stacking, so that's what went
into the interface.  But we also added FUSE_PASSTHROUGH init flag,
which is redundant, since a stack depth of zero also implies no
passthrough.

> If the problem is that this is not defined in uapi/fuse.h we can define:
>
> #define FUSE_STACKED_UNDER (1)
> #define FUSE_STAKCED_OVER (2)

I'm not fond if hard coding these constants as they only make sense
with a max stack depth of 2.

Thanks,
Miklos

