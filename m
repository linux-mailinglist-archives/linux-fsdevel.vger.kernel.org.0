Return-Path: <linux-fsdevel+bounces-68824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E0C673AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B905B4EDC18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 04:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F628640F;
	Tue, 18 Nov 2025 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X8UhUr/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF927467E
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439260; cv=none; b=Cf4kLIN4gwru3j8foVLepL9kRL4odUmNttfRhL5F/Gce0EqczW5nGAdonJY/gS2SzWs+eIBnR/z95/ahmDuICEDV1kHc/ycQLrBW5ijA8t8yiLkYtYjw0D+tt4ZFqYxcXAnuiejnvCdma8Kd515Y0FyK/pbiNstGhDh35ikZuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439260; c=relaxed/simple;
	bh=ts1YP1pM3KgXnMVQbSukSL8QcmoDGRWp0/OUxrRR1xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRkCm/h9nAcIvnuaGkvvXjhigAQf5OHpzLUvtxVEC+sl+MuKJpWfRVJCmvFeLPfLvRFna3SqgwSj1O8qg1oaVyahypFfYLyplI5MBr+or9US3aAac5PODxGhb6a8BkFJBNphuZYRpcgK4nnzwZxtYBGAIZ0kVmEsXXkCTU3eTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=X8UhUr/u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so8459131a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763439256; x=1764044056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07HeZKjyOA8sg+0j8XO2NQGRkS4H44zMUY+FSrwKOW8=;
        b=X8UhUr/uDMN8miCltzMbNWGLcTUtbXmoeDmt9YDmo3R36JQP6r6agnLotGnTdNtPiX
         Exf26RpcbpXEIPw0Q4BTDiOc0QpZq3axJWZbPQpyhOTq23zV+58m/DTqNpnrRGyCVOlY
         dOB4VfbV0ycLFcL3pQeEuLSKtQveAbfU4NGHrSUbsmXqiqYq5WiAZpioazvRdyKwe2em
         hR/RGZgwkOXcrnr2p2VVpEKM6242vsuRPrbV/frGbGYDmt3fVwLSsQMyDTDJD1N6vaur
         dm8H6fsNmobg/yyGuwqzitl5V/TYutGvl6c3M0eisyMdKyyBKjCbV9KuQog19b+NS3Yv
         XIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439256; x=1764044056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07HeZKjyOA8sg+0j8XO2NQGRkS4H44zMUY+FSrwKOW8=;
        b=UkwuhJTJoYS8acDeUhwwDjxsznijZuaroF/DPMj3OGt7ljpjvy3XsqNBVcvWx055fX
         Ti7xHSgF3WVSdXRQs41F5ho2L4u8RA5HcjNjiz2x7V5XexPLTN+LNcoEKLqBFSqxVcxj
         Q3kuxH/nmJviWcFk208M/nl93iaNUjpXvp2Yq6cDh9JTWjKj7kIAcLGVfk1y2klkdGsV
         HsMUwApIydbISlWuXRVEN8ifea0oL40uanh2nd4Q3RLsCRIIXfrXRguGjSf4Zbbd5I8H
         HAKx/z4+2Tbsdw/TOJbp8BtevEhuT1UKLhKVAoFloi4nYAy7Nu1diIeB4kwSASrHqqEq
         xYLw==
X-Forwarded-Encrypted: i=1; AJvYcCXnYqJZL1Fh01jSxr8SajsmgXOtcI23ouKoSW7ZG2mjndQvS43ydPzMZHj9ZPs28+/bW7NCob5mylJS4qx6@vger.kernel.org
X-Gm-Message-State: AOJu0YzcibKLZJENShsf7m65/EERjHF3BBxN18Dho6AyCLDC0YSpCmVf
	tLdivgxMwR2kwpx9febBjQzLIxeuWapwQ6uhqN5mKBEmGNLZXzmV2haroYiU1IraCbBecI7Uu0G
	oTi+hKclgRQvd0kSKPOdTX6SKtBXe5cFrlPIRvLdY7w==
X-Gm-Gg: ASbGncvDlmycQqcjl/07/hFmlPMvKvgVbJ7D7PRqKF0zVRwBZj0l8aZ89rSo6nk1Uf8
	ZBRoNeJyaUvYk/ulzZ5XjM+E3YmU0/E95nVQcalwt/U7QlvJAk67QA0DM0dJQe/aBvUgfi/nUFt
	jIa+ihpaGgjw56zdIYt5Sec6PKVbNrnNXOSFpI9aSSFEXgXbNvn4SLf7ko1AThjA0UWqNL2vwn2
	DOKF+9QaQ3DmxGXhtxTdfPiJjdDwts2SIuXOq8uMcfdV+VJZJmvPXvozsggEa2ppZUu
X-Google-Smtp-Source: AGHT+IF7odRYhWUKE4hEH/yqZovWuRxLWp+QjpvspuEPYgC7PACIvotSh+56pMkd5f5Wg4bGjW+/7/Gip+y+Hfcb0Tw=
X-Received: by 2002:a05:6402:1445:b0:640:e75a:f95d with SMTP id
 4fb4d7f45d1cf-64350e06df6mr15371153a12.15.1763439255422; Mon, 17 Nov 2025
 20:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-13-pasha.tatashin@soleen.com> <aRr0CQsV16usRW1J@kernel.org>
In-Reply-To: <aRr0CQsV16usRW1J@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 23:13:39 -0500
X-Gm-Features: AWmQ_blVntX9altpCY4SXrXyEKO7X1UIHIxI-cPMY5rvalxcvtOdur6QxS28SKk
Message-ID: <CA+CK2bC7O4B=R7Wb2wZ7QYH2_Ujo-REXVqUX1ukfPJ-XDubtLA@mail.gmail.com>
Subject: Re: [PATCH v6 12/20] mm: shmem: allow freezing inode mapping
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +/* Must be called with inode lock taken exclusive. */
> > +static inline void shmem_i_mapping_freeze(struct inode *inode, bool freeze)
>
> _mapping usually refers to operations on struct address_space.
> It seems that all shmem methods that take inode are just shmem_<operation>,
> so shmem_freeze() looks more appropriate.

Done, renamed to shmem_freeze()

>
> > +{
> > +     if (freeze)
> > +             SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
> > +     else
> > +             SHMEM_I(inode)->flags &= ~SHMEM_F_MAPPING_FROZEN;
> > +}
> > +
> >  /*
> >   * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
> >   * beyond i_size's notion of EOF, which fallocate has committed to reserving:
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 1d5036dec08a..05c3db840257 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1292,7 +1292,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
> >               loff_t newsize = attr->ia_size;
> >
> >               /* protected by i_rwsem */
> > -             if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
> > +             if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
>
> A corner case: if newsize == oldsize this will be a false positive

Added a fix.

Thanks,
Pasha

>
> > +                 (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
> >                   (newsize > oldsize && (info->seals & F_SEAL_GROW)))
> >                       return -EPERM;
> >
> > @@ -3289,6 +3290,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
> >                       return -EPERM;
> >       }
> >
> > +     if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
> > +                  pos + len > inode->i_size))
> > +             return -EPERM;
> > +
> >       ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
> >       if (ret)
> >               return ret;
> > @@ -3662,6 +3667,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >
> >       inode_lock(inode);
> >
> > +     if (info->flags & SHMEM_F_MAPPING_FROZEN) {
> > +             error = -EPERM;
> > +             goto out;
> > +     }
> > +
> >       if (mode & FALLOC_FL_PUNCH_HOLE) {
> >               struct address_space *mapping = file->f_mapping;
> >               loff_t unmap_start = round_up(offset, PAGE_SIZE);
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> --
> Sincerely yours,
> Mike.

