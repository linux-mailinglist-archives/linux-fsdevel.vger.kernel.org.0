Return-Path: <linux-fsdevel+bounces-50487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6ADACC87E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4391895506
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F404238C0B;
	Tue,  3 Jun 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCAoitPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10B132111;
	Tue,  3 Jun 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958780; cv=none; b=dblY1M0VdXDeMdik7SZOSR14k8DuGAqdOnZuuRtYQ/ybpLJCLh7PHpSKkPPrM8MKn5ehNfNjEtRzRatIk/geybOCoiMjBVCInaOJVBGwnMqbMo/eGXp1kDVQaLEcvrACyLWPQancFCu1U3Vts1gvYdtDi93v1dazyxZ854RnSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958780; c=relaxed/simple;
	bh=56xm7d/i4w3yNuEd8L05kuAjEab3Mgm2fv1xTPSDORc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvTwMFlUDwyHRnTyo7hT27/NZZ8TyD5ONIVT8m1Kxr7vQVnqJ3cmjNrTwwdGQgzIlZ/4u/DWNA7/3UQJOQv/Auhpu3YJA8KY1dcW0aBK2qOoKMz/wWlXvWOkdO+PdAhwifMQ37zaok4wZxxTXoUvEgwibxnr4PMUOpe5ZekDoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCAoitPR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad56829fabdso873602866b.1;
        Tue, 03 Jun 2025 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748958777; x=1749563577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3dgRxegT5qf67xryaScOvVUZaIAW5sj2uHc8EGQ1+g=;
        b=VCAoitPRD1EOHnvBXbVkw7xFZBpXbfRmypolE0EbhIl6fGTrjLwCJkMSauCkwY+N7l
         0OUgkPS5/SNr0p1yOLGSA2duizu/oKk+PUGo4cIRWEMwxIxVH2QDhbqXF5W4hEgbAFR2
         mE9757gQr6wX/v+H3URjRUv4AAA2DFsKiQEfI01cTsjFJW8joMcKaNGZDXrt8X9hMLr7
         3UZdIe2I13c6VI9t8j97DlcH9lL80L1N8CqabxnUuKm7X7N6oVlcQCKLh0/tP5iFL4+J
         GVYEP55QHPzVqbJeD3lGL0vUuDSRIhJW2EA/Bk2248E1DYJkgCz6UscsMUnSBZYAXfty
         +Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958777; x=1749563577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3dgRxegT5qf67xryaScOvVUZaIAW5sj2uHc8EGQ1+g=;
        b=DG4dL2VVUZpbpTJIiLWEWHUw0N6T/KTZvELHP5xYochtWyErzrrFPRFLPogC5HemTh
         XvmbFh7ME9WKEHBgShTc0LTOIDVdHCLLeGvt1Db3zKoKSRVuLpbzJqv+tjPC4e1GTha8
         ICWNM6PrBdwB84qqH9hJ1IwuWUEJwWEFn41sBWOhir8kd3t21oNDJb2Sc+4vALuwlzSm
         XPnBb3ufsAfUvy3LIQeUz+fDgkoVhNkOdnl1MMuxTVQeXajQ2gIVlJfFNlGGwa3uwan8
         wIN7+AFHODSIcKAj0v6p0SgtncKIZ8amG21f74M4z/fDUcQZRaJnsK+C0IRr99o1GJ0I
         /9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU/kVwMYxcKQvhrJh89nE2ZVA1Z61gRySpxVQiC5XKK37wt1zkkNrxs8grQnCEAoo5Cy7w4LtOB21+i3d5@vger.kernel.org, AJvYcCWPv6eVbK1Rf7wvqr45x7EPUJ5APY2CrpLswJGzizD1uH5TULm7FXAgcR3uZcy3QvAmBqlAGOPGJdhR@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiLRp+wpKMHYIrePZqLrb0cW/ZCFdZv+zhuzJct4krWlCPKpY
	LJaEmow6l4tk8QndTBllFMYUWWEIqIe7HYxBdEutSjFNg082VyiRpeVrxATA8CQrXJX6tw/ZBm4
	+FTYz6PeqpSGK8HqIfp6rTIoi1m20bg==
X-Gm-Gg: ASbGnctwRk4XfHa6WDI+ejt1enwjzuN+uNrQJpinR+KRdLgZ46oOTpYR5kJTS3KqKyH
	9e3/YotULy4Ds7BigHhSzTO7AHnKMdwnjWhwi6vR3VljyMy6Q1gWOL8pAmqdZw8RejAsjwvj6Xa
	T8318suFZfxoPJVDfQGOdwJHAymGhu3Y7GPYFb+lOVeVVaqf3VBVIFE/oDnDQH4GPpj2OxnTCyn
	A==
X-Google-Smtp-Source: AGHT+IFus+lYy/Vn8DX7AejSTWq5DWSZv2otFfVWZOt+Ot1Cw3NBGg/aiRMWu1o2ZMIdoZsQp1gzV5igzu9cyaTxn5s=
X-Received: by 2002:a17:907:3f0f:b0:ad8:9909:20b5 with SMTP id
 a640c23a62f3a-adb496037b7mr1318776566b.56.1748958777045; Tue, 03 Jun 2025
 06:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de>
In-Reply-To: <20250603132434.GA10865@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 3 Jun 2025 19:22:18 +0530
X-Gm-Features: AX0GCFs142Om3-wJu99daJuShs3COk0AlQwDiy7BvMajL8e3IU6AzAyzk8BCwWQ
Message-ID: <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Christoph Hellwig <hch@lst.de>
Cc: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, 
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net, 
	p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com, kundanthebest@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 6:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Jun 03, 2025 at 02:46:20PM +0530, Anuj Gupta/Anuj Gupta wrote:
> > On 6/2/2025 7:49 PM, Christoph Hellwig wrote:
> > > On Thu, May 29, 2025 at 04:44:51PM +0530, Kundan Kumar wrote:
> > > Well, the proper thing would be to figure out a good default and not
> > > just keep things as-is, no?
> >
> > We observed that some filesystems, such as Btrfs, don't benefit from
> > this infra due to their distinct writeback architecture. To preserve
> > current behavior and avoid unintended changes for such filesystems,
> > we have kept nr_wb_ctx=3D1 as the default. Filesystems that can take
> > advantage of parallel writeback (xfs, ext4) can opt-in via a mount
> > option. Also we wanted to reduce risk during initial integration and
> > hence kept it as opt-in.
>
> A mount option is about the worst possible interface for behavior
> that depends on file system implementation and possibly hardware
> chacteristics.  This needs to be set by the file systems, possibly
> using generic helpers using hardware information.

Right, that makes sense. Instead of using a mount option, we can
introduce generic helpers to initialize multiple writeback contexts
based on underlying hardware characteristics =E2=80=94 e.g., number of CPUs=
 or
NUMA topology. Filesystems like XFS and EXT4 can then call these helpers
during mount to opt into parallel writeback in a controlled way.

>
> > Used PMEM of 6G
>
> battery/capacitor backed DRAM, or optane?

We emulated PMEM using DRAM by following the steps here:
https://www.intel.com/content/www/us/en/developer/articles/training/how-to-=
emulate-persistent-memory-on-an-intel-architecture-server.html

>
> >
> > and NVMe SSD of 3.84 TB
>
> Consumer drive, enterprise drive?

It's an enterprise-grade drive =E2=80=94 Samsung PM1733

>
> > For xfs used this command:
> > xfs_io -c "stat" /mnt/testfile
> > And for ext4 used this:
> > filefrag /mnt/testfile
>
> filefrag merges contiguous extents, and only counts up for discontiguous
> mappings, while fsxattr.nextents counts all extent even if they are
> contiguous.  So you probably want to use filefrag for both cases.

Got it =E2=80=94 thanks for the clarification. We'll switch to using filefr=
ag
and will share updated extent count numbers accordingly.

