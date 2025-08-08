Return-Path: <linux-fsdevel+bounces-57138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A9B1EF5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C25A443F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BDB232369;
	Fri,  8 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ftvagsDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977561F2BBB
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684438; cv=none; b=fcL3b8mF75SuBh3h+d3HokeIPu52lm8tR2Se2HI6h+jVsf8PRHT6WPevnhnYxhxfYZSyRyqMNFt9h5ThI19t8alBjuyX/C1WQFbtuEHms0ew5Ro1WgDT5xYrf1gyP1zumJG847ICHJjPcsizLNEdk+MMRhei7owAqHzGyisR3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684438; c=relaxed/simple;
	bh=xCzcDEPseUj6dwEakDSVeahmG75Mdil8GGbmQtbGq1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMpFgU2D61y4C5lim4WQxkLeEf3e7fji9XwLkBbB8jfa+rcp+clLS34ooVXShUFFmV6eUoAWEp17H5sKS048/CIPMJWmHjKFPyrGwP/y6IEhq4l58EdkFlm+Mx+fkRF0RtmsOI/CeVUHo0279w/8wehaOEMho4Tb95w9B4G2Fvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ftvagsDA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b070e57254so27634921cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684435; x=1755289235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQYa91kkeSfQG6Jm1FdT+mkrUk8mk+nsXZw2Gvf2uBM=;
        b=ftvagsDAfbPb8S4pSEKEvhXWuW0NCQzJne+7o3Np+qkVGAM4u5YEUlabGgmTKSgXzM
         NjG8uJYs4fgWiWJZQiil0in/jrqe1dvQdgati1dJClHgDTpvvq7Gn3AWj13VqXxpiary
         DlILjO4h5Rj85t7wiL0h5FR75Bgq/+oHKDqqXXdIMLIazCZkGkhoC1mfFZs3hgSjtitL
         vVDZz26fcXwRyxHCluLIte/0z1yKizDQld3ORVyn0iaEEPQdNDw4UKgk86MI77YlpvOR
         KN9W23+bj/CLEKwsqf8pNOMKsUc0O2rmpWv17bfmsrFSGmhpSITmC/DV2FBAelRYzQcg
         ELhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684435; x=1755289235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQYa91kkeSfQG6Jm1FdT+mkrUk8mk+nsXZw2Gvf2uBM=;
        b=w7a6A2c1Iabh5S79AboTSETJ5D+POqVrSVizcFDu4YP6v+y3lten8FDj6Ll7tH37VM
         Gd/9274fcQjjReDfluIMq8C4IkXMYZBqzdH1M8pLvVeAP6wcq5gGhT3Y2WvH1pJFVZ0r
         ydGbksP1gFXqm2Bqe427nMsDLkGwE4rjguj/xRVkO09jcSvz3O2YE536lXepxc+DUkfC
         vAU81lHSBXv0YWFmOTzo2NxxzIssP+SoAy+wc5ycSLApz3QhYHTIIhO9cntG8pjctHOc
         /cYLtfF3uC1LyRHuF9Sw4qm2dIcHPUhhpaKJ6I6x+27t2pNcEHuH9j9hK64f35Rtbb03
         Ap7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4lzu7zFrS0d2ef0rdbweZuCcIEKlceC/LTVRWH5vVtNNSW0YsYssW+grCPxOH+TZGp+ULvIw/wu5+AX9H@vger.kernel.org
X-Gm-Message-State: AOJu0YywmFQg3IeE0uCRzD8LbCdCjfoYivsbJx/zzaIkTHthkHu+WihT
	jjqHuZlPcC/1x3ZWweJMKCE0usyq2AxITBKGCxQ//5a1aywAYSsK9aZ3eCrvHty59zhNHQ3VEn7
	BtEQDeXdNiJR0wOMeBVDST+YmeKXIfeifIK9WlVfrow==
X-Gm-Gg: ASbGncvcPq9W+L2Dx/hK2ao7gan7b7rxeYLRUUoTllX5gL3RKG7h6Pcofq2GuRKamXD
	nn92SN7hqkcFq+cEkZEFYGsBvrRn+xyj2B1J12exC/0sR2A73eAGguhuyoSzq5cjxv/q3B8LuUg
	dQbPz+HHbIdZTtSZkng1/oaEZkMJQBUvuIcsQgbHeiiG0K6GNsMKmnY3ppbk0lCDmF4C5rh+58J
	JxQ
X-Google-Smtp-Source: AGHT+IEo3U6rdysgoF2C0xCMhrgpG0Agqof6n2ba9uwRUTWht+9WRzi5tte7RjhfTHV9iSsZvxQedOnK/ZZyoy8est4=
X-Received: by 2002:a05:622a:1a0a:b0:4b0:6cef:19d2 with SMTP id
 d75a77b69052e-4b0aed031fcmr51001501cf.8.1754684435323; Fri, 08 Aug 2025
 13:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <mafs0o6sqavkx.fsf@kernel.org>
 <mafs0bjoqav4j.fsf@kernel.org> <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
 <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org> <CA+CK2bCVziiUZzdGaEabmPSB4Dq41QZe7gVxtgwy4pWmpo=D_w@mail.gmail.com>
In-Reply-To: <CA+CK2bCVziiUZzdGaEabmPSB4Dq41QZe7gVxtgwy4pWmpo=D_w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 20:19:58 +0000
X-Gm-Features: Ac12FXymO_RsH5GAn7D-2QfHaIXjJtVjSwQOC9gpco0na8ETzrHiY720l5D8Qt8
Message-ID: <CA+CK2bBjpZLiqK_63L-o+vxotz5fTUMpO4NgUaJ=sEV72qGyqg@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 7:51=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> > > Thanks Pratyush, I will make this simplification change if Andrew doe=
s
> > > not take this patch in before the next revision.
> > >
> >
> > Yes please on the simplification - the original has an irritating
> > amount of kinda duplication of things from other places.  Perhaps a bit
> > of a redo of these functions would clean things up.  But later.
> >
> > Can we please have this as a standalone hotfix patch with a cc:stable?

Done:
https://lore.kernel.org/all/20250808201804.772010-1-pasha.tatashin@soleen.c=
om

