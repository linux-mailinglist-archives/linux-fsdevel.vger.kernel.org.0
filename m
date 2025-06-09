Return-Path: <linux-fsdevel+bounces-51065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52EAD26FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 21:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4AB188F957
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96821883E;
	Mon,  9 Jun 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEAwstOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76810E3;
	Mon,  9 Jun 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498466; cv=none; b=VKIPcuh/l2rk2qPPx0MlccpJmgw1OftiSjQBEbyJcJrPQ/cZ9YV6upY6jyOxobzCA9iWlUDT3BVwVra9HbPRKku+OuJYgPhF3iTzO7vx6SXomc2wv7PbaHpteMBJ/wRdtSafNyOjIGGfl+sVycTdnWxm94eVa0znH+P2/0nJKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498466; c=relaxed/simple;
	bh=wXsqpnBGPQPgJowAd3PGOUC4gBkxwAWv1C8iUeUY/y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtPQ4tg93fBDQRBqPnO4o8xMMaBhVCZjZMa+UT9qZnQFfX8F5jNYakotubW6x6H0AffkbdrX8h2WmKqAsixkjPyRYdisPte13jPaeqCB9ioQ+c6RiZxPZf14eLVE9MWF4HUnczpsItgYE9kUbq0TLBIM5ZyT8C6qsI2COgvZHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEAwstOy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-48d71b77cc0so57879561cf.1;
        Mon, 09 Jun 2025 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749498464; x=1750103264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXsqpnBGPQPgJowAd3PGOUC4gBkxwAWv1C8iUeUY/y0=;
        b=WEAwstOyCowiehQP6Ovqk+HzWvBN/vdfb7HOLWLKfkJGl1+ZM9WwTkvB5T33/jqlBj
         3O3zM/fDADP0PiG5Jpz/xIHDYrKQ10aUIZpLT1Y3LkETUBmf7Y1geiWmMOj6QpLl/acv
         kAD1OaQzQsfgw3Ua/1+usF3xCuDl1i+0fzxe6atMXMGXKe7hlZ1Xf7Ol65S5dE4xKrm3
         bklN9B6FiKb4BL0ml+lsuFCDHdpsnR/bi2a0w2daJd/Vm5vepcq/owzvIdjPgbAMn9s3
         VTcUrVCb8Zk6t1h6cirDylxKg5tdoQwb1Ut63RHh7kadR6Nz1dFw6vxhBl+qoGYaQj/I
         s7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749498464; x=1750103264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXsqpnBGPQPgJowAd3PGOUC4gBkxwAWv1C8iUeUY/y0=;
        b=e/fI6L/H5FRcS5eHaz7r3xqt3K+5QsXgyRPt73a5jqFUc+bX9S2FF9/P+L7z6ob9PR
         NGy4f2ednFbj5CBCbaxRFrILsbhPua0WleY+JQPwZV2e2KYvzrtRq9gAGY3MKgk+skq8
         IJSQ+gzeaqKGnuTTxlPsIO0YLDV/TArUNcVaA3ppHQ0BslzzTw5dB2BzyVNAnl8MXpaL
         B0VnTqJFzWJOHMrc9OBm24EUIUqfVrt+QMS5w+c4IOA4BlspTBCLNovXbmpiOafq6M2y
         LYgVbqlSiOWJoxIEz334R1Kj2pwAXAO+cMP0kGXxno2/Wwg8e9dJ7sqqFalsWUQ+oImL
         k1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVhVuxFTUJ5SBflmnMYo/Kgm6x20LBrXGoGOiUZckfkWOqye9od2J+0pAdAooUxmQSYQY4amvGSz/7SZISf@vger.kernel.org, AJvYcCXCdRmjnyF6GKVlV6NQCCVMneLtziCu8O7SOg5qC46AZDK8u40c9dQKomM5IF8OLqRF6XEkEEad+B8r@vger.kernel.org
X-Gm-Message-State: AOJu0YyCy3yHn0jfg/RP7daB7d1bPNj0Cmy+KdH2JbqUZUlMyyGkfFXw
	ZoMS4Wpv8VZ7/Nm6tAkSzaj9gvvAxkQw+m65AEkgYnsKs4QfTLVshnj3DlACNF0ACpD8nAByReH
	CqJyPMxX2R3DyNZMk5SW2s8E32tIdNBw=
X-Gm-Gg: ASbGncunBMYyxYqIwerpo4ES0c/XnO4WYl32JtxoZWnF3u8yan1I2eYpusAbE7u0BRZ
	pSAUTXpvfhl+zqXzzDELYQe4UlIgQvoRIr8Rmm1wBFfyKEI3FdQ1IQ+IfKdgeEeHAEhGXMtSe81
	Ck23BkdNQUR/Ef/udjT+HiH5BVmphF0af15M7ti5DiVro=
X-Google-Smtp-Source: AGHT+IHy7G/JRFVyiIGjC4wYGMVj9gQ0qYBWcEK6p0u6Z74TtoZNAq3u6gleCH0o+8gq36SjTDWrh7KlxgAbkDgoRE4=
X-Received: by 2002:a05:622a:2510:b0:4a4:41fc:cc29 with SMTP id
 d75a77b69052e-4a5b9e005d8mr262075401cf.1.1749498463625; Mon, 09 Jun 2025
 12:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <aEZly7K9Uok5KBtq@infradead.org> <CACzX3AsfbJjNUaXEX6-497x+uzHptrxM=wTUnDwy_tH6jAEMTQ@mail.gmail.com>
In-Reply-To: <CACzX3AsfbJjNUaXEX6-497x+uzHptrxM=wTUnDwy_tH6jAEMTQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 12:47:33 -0700
X-Gm-Features: AX0GCFsYyT99nfUI-tRkm7K4fH5cwRf_rfdLUEhsXAHU6JhwUuktk08jY-KhVH8
Message-ID: <CAJnrk1aXtMcUsmZPCjre1u2=mDPhk5W5Jzp8HOS+ASxkby1+Lw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu, djwong@kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:39=E2=80=AFAM Anuj gupta <anuj1072538@gmail.com> w=
rote:
>
> On Mon, Jun 9, 2025 at 10:10=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > Can you also point to a branch or at least tell the baseline?
> > The patches won't apply against Linus' 6.16-rc tree.
> >
> Yes I had a hard time too, figuring that out. FWIW, it applies fine on
> top of this branch [1]. It would be a great, if base commit can shared
> in the next iterations.

Thank you both for looking at this patchset.

The commit I'm on top of is dabb903910 (" fuse: increase readdir
buffer size") which is the head of for-next in Miklos's fuse tree (the
[1] Anuj linked to).

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log=
/?h=3Dfor-next

