Return-Path: <linux-fsdevel+bounces-33016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59DF9B16F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F681283295
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07191D1F7E;
	Sat, 26 Oct 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glL1RGL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650D192D99;
	Sat, 26 Oct 2024 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937685; cv=none; b=h2lQSj/tHoED4mc05tKpaxJdzs+BrXv3I1iqxiaJ3rCz9ZFpw58PsZZsKYr8iMTeejJ3zM96kfVvgyzP7PbktLf9A/vd+NP5d2fbBlOql0ynDZwmijVd/ADc9KiaWUpIGSWgljkkQzqIdZqfTVMcP8K0DgAusGMuCcJqpIW/81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937685; c=relaxed/simple;
	bh=X180r3VolNsDSEAseUUHv1wHkhm8QzJhMimrE/RUOAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkI1WrFMs3+WByMvZsDaeSj0aOcLMaStrRxP7vHjck8KoYDkvNjBEZmBl01o6vp0Bh5DdC3hTHobcdzOyG6qG8aV9ZV59xoUndTiLGtDqaBjgUtP4pLBejo8rwDOdePVcfKIDNLTW2+Wcaqdx/uX1IJItzLb5h7wZ5OcoYVv4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glL1RGL3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e33c65d104so26116037b3.3;
        Sat, 26 Oct 2024 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729937682; x=1730542482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71gq41Y8t4bQ3f//2CCau8OMlyvglDpBna9x3oSUIX4=;
        b=glL1RGL3e+DXR3edc99czzwXk1P0PJUb6ITjcJ47tDU14YVUBgU4tfowI61ar0lHzK
         UXpacbPjxlq6DWPyD0jfFnBYpGtXjKWYJzVikNbM7wiVjWGjZSs7KPNbS/6Keda0mKlg
         Wma15N4XYtvp/8StBRZZaJF2sRZ6JM+ebYdHlgPFbg6vknAZbnK9P7S8l9GWgEBsGBaJ
         IffaH8m9awtCnj7HVODIINT09Q0klzQxHhdppeK8yhG61X/HYzcXNcpewLcfjfKvHiSR
         QSspj7iUmCGzLn7i5J6pPIPer0K96FMiIpN2bjT+nOo+MGGS3Nr+n3U7xBsIRSbds6lZ
         b0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937682; x=1730542482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71gq41Y8t4bQ3f//2CCau8OMlyvglDpBna9x3oSUIX4=;
        b=C7pBzdqX+m/EFVloLXbK1001FZ8ZMWFQ2fRzrFLwVR374lPjvt0PcPrNiMds5oR/9t
         XMdSY6rzW0M0aMw6kekP0WFOdXm1jX+LfcbYO215nwp/tJpQbQ1e4msI/4tI7DC7jjY/
         GKYATuAPmRO1/VAHsEvnIgCBiPIr2JkG9NdhJGCDEtJ15yy1XnRAKqDaGOu9mGj+ms+8
         Bi9qh4m8DhD28ZS68WijyI8p9fNdQr14QMohUrFve24D23eCp0j1rFZDpMMz5YRDe+if
         RwNvHoQkdwS4K5tIe03GUvMx61knv3NKsGvNVcjgXinYsKvMy/Bhd9fj45Hjyq6Tuw9b
         ys7A==
X-Forwarded-Encrypted: i=1; AJvYcCVwXH2HBWe5t/SqJksKiYhWFrGSUmLx/Oto8PO2i+PH+/dCNHZTBXKn5Ef4xaexSRABAhcfykfWEebC5UMl@vger.kernel.org, AJvYcCWYW9JFzOyeURIs0+QWtbSZyN6f8O0804I4EtE8sWMckRwDGhjHqxfVugbVfOZTdPMkGKruqXo0@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2gIKpN/ZcAlhozz6H98lnTRfGGYZL7rnY0PA8VYVOHkrwSIH
	hU4pQLa8BmNPh+uKuxnSiJ5k1CMB4WWm6Z6Umz3lNA3S9z/iSUI0BX0oe0xyjE/4oLNhZksqgfa
	cgQOeZeEXlPgWxQFO39UbMQYz+2M=
X-Google-Smtp-Source: AGHT+IHrgQPbn8ROQAWlohxEuBSu2wy1ei+3mir8xASPD+3lG8R+l571NyrAlVicQR2fdSZ5GwJtG/1/T9mfa7mW7/4=
X-Received: by 2002:a05:690c:f10:b0:6e3:8562:fc0 with SMTP id
 00721157ae682-6e9d871679bmr22807357b3.0.1729937682017; Sat, 26 Oct 2024
 03:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
 <ZxwTOB5ENi66C_kq@codewreck.org> <1921500.ue69UQ14vC@silver>
In-Reply-To: <1921500.ue69UQ14vC@silver>
From: Guan Xin <guanx.bac@gmail.com>
Date: Sat, 26 Oct 2024 18:14:05 +0800
Message-ID: <CANeMGR4E+MDKDudtfjgTD5yvc-HiC_L7tzsQm=2EbEH1RyPoYg@mail.gmail.com>
Subject: Re: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack size
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Eric Van Hensbergen <ericvh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Sat, Oct 26, 2024 at 5:36=E2=80=AFPM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> Guan,
>
> it took me a bit to understand why you would change this constant dependi=
ng on
> maximum stack size, as it is not obvious. Looks like you made this becaus=
e of
> this comment (net/9p/trans_virtio.c):
>
> struct virtio_chan {
>     ...
>         /* Scatterlist: can be too big for stack. */
>         struct scatterlist sg[VIRTQUEUE_NUM];
>     ...
> };

Yes, exactly.

> However the stack size is not the limiting factor. It's a bit more compli=
cated
> than that:
>
> I have also been working on increasing performance by allowing larger 9p
> message size and made it user-configurable at runtime. Here is the latest
> version of my patch set:
>
> https://lore.kernel.org/all/cover.1657636554.git.linux_oss@crudebyte.com/
>
> Patches 8..11 have already been merged. Patches 1..7 are still to be merg=
ed.
>
> /Christian

That would be better! I'll take a look at your patches.
Please ignore my patch for the moment.

Guan

