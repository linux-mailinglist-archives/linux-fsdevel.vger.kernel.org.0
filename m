Return-Path: <linux-fsdevel+bounces-54747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF7B02978
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 07:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B10E562B3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 05:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1372201276;
	Sat, 12 Jul 2025 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="h8pme+2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85F1F63CD
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752297923; cv=none; b=JPBv7F1yoWe7NPKnwINRkOLfKZis+3xHbwynVlhseW0q50aXRtToRSAuF0ep5ssKdtmA7Y10DtBu5Y/BRE/aIFara+Hclwam0gy2p14sYL6jyrecy8ADceF/2d0DuaO+9vQQc1c7/HdLgNsCedNx1u26URI2/0ynd82qkJCwmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752297923; c=relaxed/simple;
	bh=OzWsfRdh2rEvxUhB0pK+C5jZ3YphBuaX/nfPDWir2oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Upxog+7axXkf+ZPXmNeh0supo3JCTXmI+8OgdVmSEr/K1KrPdqXxTyp3FKNRDwpBB85WHxtrDn8Y987ukimK/YbsYiyo50jsDKBKd/o4C3A3Rz5nrtrIX74lGg+WrlbougEy39tJAZHMiP/Ip8zDf6Ic5hXNF52U6FCdbbNhLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=h8pme+2c; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so4692831a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752297919; x=1752902719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=h8pme+2czoxn377wcsYImLfiK0tyLMEzxmutBmuVmkDk8qJ7SiJRAq5ev1OYIgo7p/
         wNpqumQQL2Asw/5KPuBwSITlG9t+kLHi8D5NS7VhTXZZig9/k+8WYDLGQOAgqc9hc/FX
         g43lM0/CMvVn7qq/PZu98O2cSpDASMdUf4Fk83z9KjSrqbEKrPjcXXuIMk+Nr/WBsGhI
         AogW7Nk+6sf7tOCC/TfCd8P7ocZDbnuyg9Tc/+sTvddHGLrtDmotXV58g9uwOMWTuaAE
         4eqrPAsDNcK5CxhTzzmiWXVOGiDgkYxncNQ2uX45Q87k0rS56AicNaeu21nIFjzREgc6
         rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752297919; x=1752902719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=a4nwTZMn9h5qDzqJ4k0loUb+efgbZ8WIlSdLoXzO9oeVS9hUuV5LLlwhw6prwvOFiN
         oDBHX2nZDZCsG4Wh/UIO8PlRtsAH0V2Lomr4k24/2xsknzrFfSpejliP8hhzo3rTIyIM
         B6dmB+NhC/aPvs12zBPqkIKcG/+PimgCIH5uWIIq8t5GGhJlo1NOorC25REOM0JOPM0h
         eYOfiApvm6Pi1jWEgH1/AvxdC0X/z4Bd092pTKgyBA7bTvZ56cUosoPrqOLcoUDBswdA
         G9F7Sr52/m3Knh8TTaGV9Jgn2bPCxPAbo21jyDH5Csw8EYaDGtiriuMziTNUYDqTw9eS
         A3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXKYQBO8NU6lCgC0yr2Vdp8sVcuqfbKCXcj8AdNpfQsWxMYMCr0PXKdpPrj641iIJflNCCW+ZrDAYhXfZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zfN9dF/lUhN+e/fKyf5pMfxn1NKM7+vnYQzimKGRmGryimkC
	7EBp5pIIq8OEF+oa4S65FIbv2Q8fQhVDuoLCpGb0TznyHAl1Pd2rOKu8s+pGmHtLgGZoBsOr/ap
	U4V6Dr4a0ZICTm+7+p0sy1pppt+Fsum0sXewepbhjMA==
X-Gm-Gg: ASbGncsxD9AjzX3/z8gLwCJw5ENgjIL/hmRQBv8P5YlEc5/BSp/Hdmk1mtxI3aW02Cq
	pCB7fEf5IT0BVF+CCw6r4+3gFvswd9uSIOcXvdMjISr3oj6EtGKj2gh59CP+VaWz6QSo1OFYifQ
	XXAhq91N9DbiJtrTOjpe1aiJCD5NXN80QYKL+s+OekXXW7OjBQ273OWjJEpPbvynjss49Ml5QKU
	BWGI61alUoMwlTdMA0/NNxSa7rQdRIWckQ=
X-Google-Smtp-Source: AGHT+IHRqhss1VHoNOeBE3dSH85TBdQyutMEzLaeevjSPISD0eb6jad4c18gV5T9kZxrzRKcHgf2BSQwMPB2TaBTj0c=
X-Received: by 2002:a17:906:fe05:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae6fbc9275emr580496666b.22.1752297919256; Fri, 11 Jul 2025
 22:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151005.2956810-1-dhowells@redhat.com> <20250711151005.2956810-2-dhowells@redhat.com>
In-Reply-To: <20250711151005.2956810-2-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 12 Jul 2025 07:25:08 +0200
X-Gm-Features: Ac12FXwI74XFtOm4i3YUfybrD81gXwe_XUMrlDA403K5FZ8k3_E2nvLf9lzB7zA
Message-ID: <CAKPOu+-Qsy0cr7XH1FsJbBxQpjmsK2swz-ptexaRvEM+oMGknA@mail.gmail.com>
Subject: Re: [PATCH 1/2] netfs: Fix copy-to-cache so that it performs
 collection with ceph+fscache
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:10=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> The netfs copy-to-cache that is used by Ceph with local caching sets up a
> new request to write data just read to the cache.  The request is started
> and then left to look after itself whilst the app continues.  The request
> gets notified by the backing fs upon completion of the async DIO write, b=
ut
> then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
> set - but the app isn't waiting there, and so the request just hangs.
>
> Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
> notification from the backing filesystem to put the collection onto a wor=
k
> queue instead.

Thanks David, you can add me as Tested-by if you want.

I can't test the other patch for the next two weeks (vacation). When
I'm back, I'll install both fixes on some heavily loaded production
machines - our clusters always shake out the worst in every piece of
code they run!

