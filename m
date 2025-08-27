Return-Path: <linux-fsdevel+bounces-59364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9DB3834F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A6D1BA3809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B235206B;
	Wed, 27 Aug 2025 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iMI+q5oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FC2820C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299949; cv=none; b=GfjaVb0kx8oCtguhRRHzeuJaIMAjVm54cp/dVnPiN3PK4z9LZg2LMZULJcrS0vx2Xdygo4qnD/2fAU86kFS/PpOzm8htPt8V9rzxeKPBNoaywFVTzfOcvqlsJgM3NWh/pwreCedzgA/yl+j2Ldsb7uGh3mOEyA24f4yTfrq3xtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299949; c=relaxed/simple;
	bh=Lg5YJJaXpBc/s0JfoRj0Jz/sHkqXKEkjrx56oNdh6UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/X5BE786JQa8XbfElVIY6AzN8hLoD2ilwhyQBeCZXqMgMuip1AmaHmDVAsDm6LQM8JOoqWvEMDoSK9iqkBMwaCucbeEXpQN3rPCOzfbt9ubbEG3glVQeUpsVgDnSK4nzzUW1HAr4YXnI25ltXAP/WqRcSkV2IaN82TXgdL8ho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iMI+q5oa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109912545so88366651cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756299946; x=1756904746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS9A1xArxW2DbHOyp5U7gUvufvKTYOF7Z8twNaozFaA=;
        b=iMI+q5oa4hKi016w+wiT6+ebiebiA6MW71fGyRmaONWPqmnhli1IgPAeJZNMJiq3Ra
         I5YNXHcaoaYIgNHMZieVcY13r+t9DUZrfH1fnbO+WHOG4ziU1UMidX73oiaDqaPMktDH
         Qfll2mqaGFkkgYlDOmZmqouUb9j2W/qnQn9ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299946; x=1756904746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS9A1xArxW2DbHOyp5U7gUvufvKTYOF7Z8twNaozFaA=;
        b=k7AxQBeaOW073qOnBOl2rewacWfSo6LKmz2fiQ7jXB+BSFtoRO6PphWimPJfUJbI6s
         tGDBZttOlF+BkIuSjM1WUozpUyf2w8kOXn2DSbHJ9b+k4b8EH2VuLWYSX55g8ljz+74U
         /zjKnKYqSaiOcUGC+rjq0TcYoZW+F3tK/K4ZWku6rq63HQYhHJBLhmmLQkwws5Si0aPI
         sVVL7xlY2Ef91LFugllXauU3CZrkS2UC2QXQxKIHIC6St8iafyM7rrXA3FQj4UuBQcEQ
         2MaWYUe012zD14kzHoeVs2gNriVhJS3rDqS7mfxFoPBRopSlQfXzh3hr6Y5ndYDP+uiT
         bjQw==
X-Gm-Message-State: AOJu0YwzIpR/AqvaijQXoK+vLYd++egBjsPngauU0mH+8Rlq12ZMKAD9
	vIqZGMC522FlhJeiEG7eDuIyJYlQGnuEPg2X0PjxFUu1dE06VrL8O4SeTjzOKpvc4gX82itix/I
	ungVmhdniaIJ2GGwitAxmyE3Db+ArbSjS4U+qZL3P/Q==
X-Gm-Gg: ASbGncs53TLlIosaohTAJ/PRsFJuRhI+1umjYcgB0Ne+lFRdfG/wEvImUdybFhpXW49
	sn2FO22Ig43xxslCRnE86M1/r7N6cmb3wCUseRde3YfqZtgBRB03/mTgXMnHRlMfIDbWSdcNJ8s
	ndzeYipovJ8fq7sbb6jUcvcnQwURrhb2dnvshfn5BtLqd0Ofoiy4dirx7KbimNcdpTRqXK3qSBs
	I22YLfaGXSrWV2bPndb
X-Google-Smtp-Source: AGHT+IGLeocHq+w8KKF32Jz+bx2Tk/02BB9NqaabL//OB62XP1A63lXRphuALAt/uyjA7/9UrZ1B5iZzrud5rKizpFo=
X-Received: by 2002:ac8:7d50:0:b0:4b1:1fc6:863a with SMTP id
 d75a77b69052e-4b2aab0cfa2mr202698391cf.63.1756299946002; Wed, 27 Aug 2025
 06:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
 <CAJfpegvmhpyab2-kaud3VG47Tbjh0qG_o7G-3o6pV78M8O++tQ@mail.gmail.com> <1E1F125C-8D8C-4F82-B6A9-973CDF64EC3D@nvidia.com>
In-Reply-To: <1E1F125C-8D8C-4F82-B6A9-973CDF64EC3D@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Aug 2025 15:05:34 +0200
X-Gm-Features: Ac12FXzh4c9-bhOGpJCxyjBS2F9uSLYJUbMNbime6Sd-tJCzwd6Aonr7-j-nBrI
Message-ID: <CAJfpegtmakX4Ery3o5CwKf8GbCeqxsR9GAAgdmnnor0eDYHgXA@mail.gmail.com>
Subject: Re: Questions about FUSE_NOTIFY_INVAL_ENTRY
To: Jim Harris <jiharris@nvidia.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Roman Spiegelman <rspiegelman@nvidia.com>, Ben Walker <benwalker@nvidia.com>, 
	Oren Duer <oren@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 at 22:42, Jim Harris <jiharris@nvidia.com> wrote:
>
>
>
> > On Aug 20, 2025, at 1:55=E2=80=AFAM, Miklos Szeredi <miklos@szeredi.hu>=
 wrote:

> > FUSE_NOTIFY_INVAL_ENTRY with FUSE_EXPIRE_ONLY will do something like
> > your desired FUSE_NOTIFY_DROP_ENTRY operation, at least on virtiofs
> > (fc->delete_stale is on).  I notice there's a fuse_dir_changed() call
> > regardless of FUSE_EXPIRE_ONLY, which is not appropriate for the drop
> > case, this can probably be moved inside the !FUSE_EXPIRE_ONLY branch.
>
> Thanks for the clarification.
>
> For that extra fuse_dir_changed() call - is this a required fix for corre=
ctness or just an optimization to avoid unnecessarily invalidating the pare=
nt directory=E2=80=99s attributes?

You see it correctly, it would be an optimization.



> > The other question is whether something more efficient should be
> > added. E.g. FUSE_NOTIFY_SHRINK_LOOKUP_CACHE with a num_drop argument
> > that tells fuse to try to drop this many unused entries?
>
> Absolutely something like this would be more efficient. Using FUSE_NOTIFY=
_INVAL_ENTRY requires saving filenames which isn=E2=80=99t ideal.

Okay, I suspect an interface that supplies an array of nodeid's would
be best, as it would give control to the filesystem which inodes it
wants to give up, but would allow batching the operation and would not
require supplying the name.

Will work on this.

Thanks,
Miklos

