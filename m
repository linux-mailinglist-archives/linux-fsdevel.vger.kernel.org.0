Return-Path: <linux-fsdevel+bounces-50808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB9ACFC17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA4216FF22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2001E0DFE;
	Fri,  6 Jun 2025 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI6c19V4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48B1FAA;
	Fri,  6 Jun 2025 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749186299; cv=none; b=pUdFQwjSS5RcvdWOuY3ntMOT2PXzcYPpygNJlcOA5x+CUGWxYOy2QqKp0gmf9I8oyFA3ljFoyCTihwK5T3/Tw5sHGXAr1QgQ5FHd5lXQWtilL4X2SkXTSARGV/L480svfEdwyyFn5oXr/FHCTiDoaUU3EVu7CLGEN1p8nPobXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749186299; c=relaxed/simple;
	bh=wuFSjTvFnRUQWOWKTNT3M4TMmiJd5ktGG1l+GZMxKYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+2MzqQNBFSTVQZDXx2IgfTa9bDiFa0jjLwEpAbmnHyATv08S5UujO9QtDyWIaUMiPP0ADwSSrbIEZCsa7z7k8N+ZqRRs0ihZVRc8zVnE95EJVBX9hrEY5gGU8CXJfs9bKCuQD+mUOaofmeuYTFJS7xu5RBZnBPM7/vpy7STnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI6c19V4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so2734464a12.3;
        Thu, 05 Jun 2025 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749186296; x=1749791096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7O9dSJB968DODyLuNRE+vyi9c088XkY9pghf6qlNoA=;
        b=EI6c19V4iIpcHTRbk+FpLFv5uD5IoOEG9oLj6RtGdhC7nmIg1bZpuD9mSBE3azNVdm
         LZBLpEgTRnwQSLIG1b3/SNClA0aEiMrErqZ21AoDT3TH3X/laCeGXmxY3TkyjM707Vap
         Tb5UlIabFdMORRloVyU5yXK3Ds7/7zQNNRGVCvwAneadxqRNFY2pXNfvs71f6J4XVbKY
         nfkooWVMhbzdevjjHhTjnvBiOO6ewOY7xp5G85M4EcVm6XYmQNaLYMzQdXlCf8R5um5j
         XBugA/yzuY3k0Hpd1bifVoVZeDejovjjIOJNiYWmlufZ2wMn/36Pjqyx6ihXCU74W8hx
         /8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749186296; x=1749791096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7O9dSJB968DODyLuNRE+vyi9c088XkY9pghf6qlNoA=;
        b=GfhG6fDnTYWFMeUxZEzD5eztybxG0sFTUCyv23UauIU8pxp9uyXrt/NeqWIewugUck
         8p6cBBBf1IobdEYALUSeQFEwAo73QKGXhEDncb3ymXzbbQWjXwxGugKCwsT6YslVAVr6
         KbRUdCeyPqutxJtoegDW3Tv92H36A9ULXGZn+XgpMi2piKfvib6iYWVMQuMcYPuBXQdY
         WIVkZD48gmyxdfzF3o7aIkNKMZeVkGkUMd+sKI2AmUBdcYVULH9SArgiyb0ogdNAwUdp
         u1jMEFbtTH02aLVsCrnDFs5vHnLG3Ty6kpDmVI+Fak42H98bhZSKQ1yUJDVLQ/XpCzMW
         P2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDTwZ3GW37YYWzYYGpwXJTl+E7rrdVYuKH5ehdHgMsj/w7YNFr1j+Vv+jhOsko0XJ8FDDJKLiVkkPb5/um@vger.kernel.org, AJvYcCXLkIcKkIaHYN4NadzYRWRDsLb8IDcodVkke7Fe+u/IRLJlDaIffla6/HF/HZxKhVzyFhDe2/KmFAOA@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxEuuQQAQF00IRJscpNTnfgZdw+lPsQFCu+Fl89fbPK7tfcJB
	DzS9FMTcEOj4XCXxGPsaf9qr3yKhaUiVbw0C2/a8sWAUfEB6k9m3HfpXbdnWPu94WnBGjk100s2
	10i1s1Hd+M2h20bF/+y7glF28QqhS1bs=
X-Gm-Gg: ASbGncufuF1TzE+3/qjiOV2obwxNz2g+ylhTmCBwZfeiUvhfdVg7HauQuIY5VBOrzTm
	V9b9cf4wEOTUrmdi+HUpuDp4xvR1GnL+i5ek7W1Mz6m5NM4XnoZzUnYu6f6RAQZoRfWBwAmDK9c
	0Hlfo/AsapsNMTcbi3EcGIQ66WAQIS83hELm59wrdDCE5EFxV9uGACHytJzCLfQVkc7A==
X-Google-Smtp-Source: AGHT+IEVXR9+wlONFFF0pVmQeCbZZqUlGtHJsfnQn89wNLFqjyadnVgDXduPX3FgpzRh4Sq2aUSNlvX2yGgw+9F0I/g=
X-Received: by 2002:a17:907:940e:b0:ad8:932e:77ba with SMTP id
 a640c23a62f3a-ade1aa06f9bmr166304966b.38.1749186295861; Thu, 05 Jun 2025
 22:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de>
 <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
 <20250603140445.GA14351@lst.de> <20250603140513.GB14351@lst.de>
In-Reply-To: <20250603140513.GB14351@lst.de>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Fri, 6 Jun 2025 10:34:42 +0530
X-Gm-Features: AX0GCFtEIAaI-VeodZn7ESl9-Aw4m_sJDaXecGQwiyGHiN7UJTfm9c_uBk6SQ-Q
Message-ID: <CALYkqXoAGHqGkX9WqEE+yiOftcWkap-ZGH3CSAeFk-cPg4q25A@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj gupta <anuj1072538@gmail.com>, "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, 
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net, 
	p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 7:35=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Jun 03, 2025 at 04:04:45PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 03, 2025 at 07:22:18PM +0530, Anuj gupta wrote:
> > > > A mount option is about the worst possible interface for behavior
> > > > that depends on file system implementation and possibly hardware
> > > > chacteristics.  This needs to be set by the file systems, possibly
> > > > using generic helpers using hardware information.
> > >
> > > Right, that makes sense. Instead of using a mount option, we can
> > > introduce generic helpers to initialize multiple writeback contexts
> > > based on underlying hardware characteristics =E2=80=94 e.g., number o=
f CPUs or
> > > NUMA topology. Filesystems like XFS and EXT4 can then call these help=
ers
> > > during mount to opt into parallel writeback in a controlled way.
> >
> > Yes.  A mount option might still be useful to override this default,
> > but it should not be needed for the normal use case.
>
> .. actually a sysfs file on the bdi is probably the better interface
> for the override than a mount option.

Hi Christoph,

Thanks for the suggestion =E2=80=94 I agree the default should come from a
filesystem-level helper, not a mount option.

I looked into the sysfs override idea, but one challenge is that
nr_wb_ctx must be finalized before any writes occur. That leaves only
a narrow window =E2=80=94 after the bdi is registered but before any inodes
are dirtied =E2=80=94 where changing it is safe.

This makes the sysfs knob a bit fragile unless we tightly guard it
(e.g., mark it read-only after init). A mount option, even just as an
override, feels simpler and more predictable, since it=E2=80=99s set before
the FS becomes active.

