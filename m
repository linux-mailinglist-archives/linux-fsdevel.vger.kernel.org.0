Return-Path: <linux-fsdevel+bounces-46424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235AEA8902F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A7189B978
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0DC1F4635;
	Mon, 14 Apr 2025 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvRWHxDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A915B54C
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673831; cv=none; b=EFbeNxd1VZkhaK0lPEWokdO9xwaAjKHHsbXIu3W4HQlul1ckR1AOQHq64Nk0JTujuQMOv+z8wQnDAoRCUIhku7pIibLGn9iaIPHdSFRvSdgaZ7DhhbNksTEX5ACvOm9OvGIz3hqFHJIp8iJKjm4T6l7vWmjM5HVGdumtpWRPAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673831; c=relaxed/simple;
	bh=UOCGOR7yeOl32ekDi32nySx+Jx1JMo8OU5FHOd0LALM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIYkaPH6UGX/XzsS24aUzHjfdapLfujPocFXGwHCF1j51C9vueu0pUJuJuiTNe1TxwDPscPmHMqo/l8CgJ//+uj+dl3j9cDmWhYSr7SaquBMT/NB4h5Xpuc/D6dJRZ+usYNV1BqkFASYzU4uDt0v968fJ47HwrYLKgxwWfaicR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvRWHxDa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47662449055so25123211cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744673829; x=1745278629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkEJFtdZi+EzgX1Mal3WJcgq6ZXtnUW/ie4E4ZvuZww=;
        b=fvRWHxDaE+azhpQFoZ8hAS+FAL7K0NhIWz+TaFt5FG8t/s0R9F1xSxxlR7pHzm6rai
         7SwVlWTME3i9urSSdTABchBflbaXBRukHOT/yol8bD56MAPoezzZPtay5P144kvGRMK0
         udqeCcFniqLXX/Gmyh7HGgmsh8XkqOANBWuTv5ySBRLzouZZbQdJiIQc4f1TYR2UR3or
         nBnjxIGn3umFhn3ppfm5II4gEHx3xEBuLZDG2onn0VOOjHJYbBCpNRE9R2AJIHhNcTY5
         PdHa6g2AWbl/n0v3+RbHm55I7B6lv8STe+/QZ9fltwlbs4IgWP2hBoR85PzvRzAmY2sp
         eRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744673829; x=1745278629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkEJFtdZi+EzgX1Mal3WJcgq6ZXtnUW/ie4E4ZvuZww=;
        b=ZdNGCkfKhFrDAtiDlhOqeQoEOX3vCdsotcAF2fXSSTV39cU6URxWVQ5vuw8PmhalbL
         S/SkqXz5+dr0bkd+IdraKYleCdRhDczqooj0d7dT6xNF6vBhJ2MyaM+mpyvUAaXPy6Bd
         cC1w0Ji1QOuq6RHn4izs7aVpNTXA951n6eg5J7fd1quCEOArFj1uXTOABLLJGWyCNoBN
         PKRptCE0zY7oAN93DBKHETRBpi+/7cZjwMDxM3F/JMPxeeoybr9zU5ANGkeuvaWeh5TW
         4VPJTTcA37tIQTY35g1u6DFRuoKP4LKuYEW+sjbB+M21Eg7BWteEV/+5Vj7Lf+nwSuyS
         q/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVifecHPAs0bmmvWlUjdiFCVO/NNr5nPlf/JRuzUyb1U3yBc9KKXagGdikAShsO/PzUKdY8gPwkTEkIlVE8@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxxRV6apyA8XDm5lCmoU7Lvgh0Ji9CnVT5xTygd/1igiUjuF4
	CseBKdXiIAZFLCpy+LtD9jCjAtF5sj/PtpLfp+DMy6BA12DPASKwMSVRWQ3oHt/ecB/AOXk7iUC
	I6KxDcT2Xb5PBGZScl/PxckTPIms=
X-Gm-Gg: ASbGncujvUgDpAZvbKnV6epEo2v/Rcv3fp2j19NqYZYp5e9dfqTpPefe98MLaQyTXyY
	VcPeqTV3NyAuG9nyxDWsbKa5kjmI1h5qeJoXK0LclirXRq56EmlF7y+IIYkSfBiDW94RoJ02X3I
	7ExaMkggVlTUzQL+9JbmObwDW9DvLB2KqvcZIiXQ==
X-Google-Smtp-Source: AGHT+IGrjgxGl1fonqvUMphRraDW6+qDVp27T+I+zxoVUnnOfYSUccDwx7Pa9fqJCO7wPBSKxzCxIMmoZU5rIIaN40k=
X-Received: by 2002:ac8:5e10:0:b0:477:6fdd:c429 with SMTP id
 d75a77b69052e-47977535df0mr191286141cf.10.1744673828979; Mon, 14 Apr 2025
 16:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414222210.3995795-1-joannelkoong@gmail.com> <cvrrumc6uduvg43gyx24bw2llre3ihdq7pjj24l6yeon7antni@7e2bmd2bya5c>
In-Reply-To: <cvrrumc6uduvg43gyx24bw2llre3ihdq7pjj24l6yeon7antni@7e2bmd2bya5c>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 14 Apr 2025 16:36:58 -0700
X-Gm-Features: ATxdqUE23w-ZM4jk8nnKPQna5P-H_f0w3LsuVG9TXVHNx4uBCMkRUMmWbBEen-I
Message-ID: <CAJnrk1bOJYFTAybYHL9HW=Ex7rs3DgYU10W=7wsuu8t1OoMx8Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] fuse: remove temp page copies in writeback
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jefflexu@linux.alibaba.com, 
	david@redhat.com, bernd.schubert@fastmail.fm, ziy@nvidia.com, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 3:47=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Apr 14, 2025 at 03:22:08PM -0700, Joanne Koong wrote:
> > The purpose of this patchset is to help make writeback in FUSE filesyst=
ems as
> > fast as possible.
> >
> > In the current FUSE writeback design (see commit 3be5a52b30aa
> > ("fuse: support writable mmap"))), a temp page is allocated for every d=
irty
> > page to be written back, the contents of the dirty page are copied over=
 to the
> > temp page, and the temp page gets handed to the server to write back. T=
his is
> > done so that writeback may be immediately cleared on the dirty page, an=
d this
> > in turn is done in order to mitigate the following deadlock scenario th=
at may
> > arise if reclaim waits on writeback on the dirty page to complete (more
> > details
> > can be found in this thread [1]):
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> >
> > Allocating and copying dirty pages to temp pages is the biggest perform=
ance
> > bottleneck for FUSE writeback. This patchset aims to get rid of the tem=
p page
> > altogether (which will also allow us to get rid of the internal FUSE rb=
 tree
> > that is needed to keep track of writeback status on the temp pages).
> > Benchmarks show approximately a 20% improvement in throughput for 4k
> > block-size writes and a 45% improvement for 1M block-size writes.
> >
> > In the current reclaim code, there is one scenario where writeback is w=
aited
> > on, which is the case where the system is running legacy cgroupv1 and r=
eclaim
> > encounters a folio that already has the reclaim flag set and the caller=
 did
> > not have __GFP_FS (or __GFP_IO if swap) set.
> >
> > This patchset adds a new mapping flag, AS_WRITEBACK_MAY_DEADLOCK_ON_REC=
LAIM,
> > which filesystems may set on its inode mappings to indicate that reclai=
m
> > should not wait on writeback. FUSE will set this flag on its mappings. =
Reclaim
> > for the legacy cgroup v1 case described above will skip reclaim of foli=
os with
> > that flag set. With this flag set, now FUSE can remove temp pages altog=
ether.
> >
> > With this change, writeback state is now only cleared on the dirty page=
 after
> > the server has written it back to disk. If the server is deliberately
> > malicious or well-intentioned but buggy, this may stall sync(2) and pag=
e
> > migration, but for sync(2), a malicious server may already stall this b=
y not
> > replying to the FUSE_SYNCFS request and for page migration, there are a=
lready
> > many easier ways to stall this by having FUSE permanently hold the foli=
o lock.
> > A fuller discussion on this can be found in [2]. Long-term, there needs=
 to be
> > a more comprehensive solution for addressing migration of FUSE pages th=
at
> > handles all scenarios where FUSE may permanently hold the lock, but tha=
t is
> > outside the scope of this patchset and will be done as future work. Ple=
ase
> > also note that this change also now ensures that when sync(2) returns, =
FUSE
> > filesystems will have persisted writeback changes.
> >
> > For this patchset, it would be ideal if the first patch could be taken =
by
> > Andrew to the mm tree and the second patch could be taken by Miklos int=
o the
> > fuse tree, as the fuse large folios patchset [3] depends on the second =
patch.
>
> Why not take both patches through FUSE tree? Second patch has dependency
> on first patch, so there is no need to keep them separate.

If that's possible, that sounds great to me too. The patchset went
through Andrew's mm tree last time, so I'm not sure if the protocol is
that any/all mm changes need to go through Andrew's tree.

Thanks,
Joanne

