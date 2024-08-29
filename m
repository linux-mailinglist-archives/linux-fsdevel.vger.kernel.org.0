Return-Path: <linux-fsdevel+bounces-27793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DAB9641C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ACC1C249EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4941B4C2F;
	Thu, 29 Aug 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Yh1AbI5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C91B3F3E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926899; cv=none; b=bwbXvKDG2ftnVzTgPE+ivSduB9ndxJ1IWBWQnw2DLcb1rphApfkL3cRfY5c4xpDyBAx026GQvw61H5sgAiYLzqV/K0u+FzaWK+5ADgywcFlir75TBS6fIJdutZR/oEv71UNHd2JIiV7qzvWrfaPceZG73qkpEbHTiBsOvRbKHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926899; c=relaxed/simple;
	bh=9vA75LhJBfVmUDmGMyCSstvfn04OQKOQ8fRcO7z91vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZcuggBNqspuFYVByPDFfEgO70mmOzmYGo5bZ1NUEuUj2rElnfdUmFycsj/x85zFdDaFxAPiKezHGb9OjkAFCtBSiAQQLVL/vi6SrUn0IiunRq4xrUIoznRBcHpydh6Gi1+THJJ4apr51quIC5Mp1xqSL2J2Hm1MZSi4fU1zZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Yh1AbI5D; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86883231b4so46166666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724926896; x=1725531696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vA75LhJBfVmUDmGMyCSstvfn04OQKOQ8fRcO7z91vw=;
        b=Yh1AbI5DgEICT4qd/vLjvYW2GBAgPPbCXQk1tJXjrzcB5rqH86L9CjISdmPMzw8fMu
         dQ0/HBz2/41qmR5HQM7FSvCB+nafM3Vq7JBXolwY/YRWNT3iop9+gCEmPEFuiboH/xTP
         JGqB9+fa491nWRm5ObsJPVBRyMZnh2APN8H5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926896; x=1725531696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vA75LhJBfVmUDmGMyCSstvfn04OQKOQ8fRcO7z91vw=;
        b=RU0HY3vqpNgM5Xd2UXoGKsVQEuq24itKtwbjK6iD6QYx6Gz9EWFAsS8OEAn98GBKvY
         hXY8YfIksBM2RMrfoEuMGn3jKyyCbinN2hpfW8ugcbta6PZBuruy9eCdlL9rGA2JHNbV
         kYStZDt2NJ5dF9yVwboJ0PIwFy9fLbZ3MUUBK6ll62jyiIZpF74PlClWqEYZPHFPcqvh
         rqXhUyvRPOpOcTQJ9lUQBWpwWQtSF+XBUKMOwNzGit2V3sCKOe/rprTa2y6U0TQAB9xi
         /S4ZnTDnXFMr549rjm2AstNH/T4HIXNbeBK7cyl0q7SG8iez3A3+5rKyRSndvL2F6TQJ
         LDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhJTx/XCPtGr/5TXmauyq1YrudNTMTUM0jkzFYssSIGkFlPME5+D/YPD5ibMLQMzZkrzPk3q2CP0FK3d6x@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJIDmgc6PH9EvPxQzNO7zukVnXYtZ8p1jKzB8Ec7xMbahOaBX
	vEVMmMpVLeFxj1KOnkWMMdlI38e2wgeDsnNjFdvMK9R66vohIyp4Ud1zpZQwp8/Rb02jO3Tzt48
	yY22Rt9hjmfnpCMbfSaBE/dDCodkvdw47HQgg8Q==
X-Google-Smtp-Source: AGHT+IE3tvLAYiNw1fJaTefRcU+j3hAFKM3v3QQ73ErW38NOMEcP8rd2g73VKXTahUyySgUiBWr/kLx11Yx4nCzKq40=
X-Received: by 2002:a17:906:db05:b0:a86:7cd0:fe27 with SMTP id
 a640c23a62f3a-a897fad3666mr176300566b.61.1724926895757; Thu, 29 Aug 2024
 03:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
 <CAJfpegsbZScBZbN+iaydOD2SKPgfnfj4t=EJz8KyMBX5X3yJWQ@mail.gmail.com>
 <28f37d0d-6262-4620-af89-b70ab982f592@fastmail.fm> <CAJfpegtjZ_iE4bemsVJbxucsMitVZV25JAmno7x+z0YfKYQfdw@mail.gmail.com>
 <e8d2ec2b-8753-49e4-b51e-aa4fe0f7802a@yandex.ru>
In-Reply-To: <e8d2ec2b-8753-49e4-b51e-aa4fe0f7802a@yandex.ru>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 12:21:24 +0200
Message-ID: <CAJfpegupwAKhaJkorZzzQfPZkD+f_ffwSs+5pQpQeUvfCnd32w@mail.gmail.com>
Subject: Re: permission problems with fuse
To: stsp <stsp2@yandex.ru>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 12:16, stsp <stsp2@yandex.ru> wrote:
>
>
> 29.08.2024 13:07, Miklos Szeredi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> Just one note: "allow_other" doesn't require root, it just requires
> ability create a new mount.
>
> The root is needed to edit /etc/fuse.conf and enable
> "user_allow_other".

No, it isn't:

$ ./passthrough -oallow_other ~/mnt
fusermount3: option allow_other only allowed if 'user_allow_other' is
set in /etc/fuse.conf
$ unshare -rUm
# ./passthrough -oallow_other ~/mnt
#

Thanks,
Miklos

