Return-Path: <linux-fsdevel+bounces-43258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE14A4FEE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C88D3A7DE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA89245032;
	Wed,  5 Mar 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2P9I5Bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F1205AB0;
	Wed,  5 Mar 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178555; cv=none; b=E5zS58wOU5nMqbdiZQpT6oQMBQf86igEmvKLPPzAH6qlA6jIbq6WxQ+oDgAVV6WMy3PDRgg1C+Ndvj46t79JpN/V++/E1K7kDBIu6uxCJj509TSNcg+ef3mvmlzsOMaKcWLvCCr7fdyuqABNNQkqRbTQ8ewFYWi4x3mfHQ/8I+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178555; c=relaxed/simple;
	bh=DRGtcUD1Vbpa16JP3K2UzI5c9GSYi1XK9xSUmDdu/xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TatZt/9vkEG/I7UIbNJOm+A7RimV/2GDY1GADhD4Cp8s5E3TWWevNcqYIx5iWnryFfiIpzcsaSBFWQgBgcaJjE4QlNq8VSaO5J4TXazRSKFfSR16AMVgxXFKKuuw8OMWHCdhWkU/pMBVwRYiWuMBRIP+vBndNpMrt5opOWzdY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2P9I5Bk; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6003b679812so40880eaf.3;
        Wed, 05 Mar 2025 04:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178553; x=1741783353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRGtcUD1Vbpa16JP3K2UzI5c9GSYi1XK9xSUmDdu/xk=;
        b=I2P9I5BkupfAk+4q3fk5x/PDslC+3DhVXzvO0JbOm0fRi5Jo+Fgnn91BnSSBlzMMtZ
         2Z/WeLmQCQD9Ab9l06whe16TB7g1icmIBAob+uawtcQ6QkMYkQYTh8gVDaA+de3//2d+
         +fQhUFI50BEAg16UWdqb66U7XNtydB9gIE0Tu7k3vk+x4Oqh9XgSncD+/UYs5oD4uqCd
         P6uac5byM2X1eEUKDyKaguGEoolLMwOGq68KWvvNeJM6d6Ybx8vuJ0eq7xGuXHw3dBSY
         E88jXCbNb5PJElmg1BaKll2SR0Yhq/3Jr/C5p53Z6ABMQUJgb+0e5Xl4lbBD77PhV8Bd
         a/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178553; x=1741783353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRGtcUD1Vbpa16JP3K2UzI5c9GSYi1XK9xSUmDdu/xk=;
        b=m7zpmjPxMGEUYnMWAUwyhZHvVP83gFWkEI8S+pwMVawmpagBG6QMitfdzREEY5RNjK
         XmbsrHwXLStv+BTcMwreOgx3AGJY3c/wLw8U826v11UScN/dxrdVzsi2SYQ4NeKkoiXg
         YtuXOJtORMaLUnS186yiRMA4nesoRMqdKp2621dyebNU0Ags5YH+8hP8RZdCLTfzgVAn
         0VFLr5fIrTl0YcXSS7wi7pzqBUN+wZBiCRWoLj2xiN9tfJAO6LuqzTTD4AjDkCV/AboM
         lUgBJTRWj0uswhOQcKtW47VYTYGR2XMeaNpQTQvCuhy9wB8iCO1I7iQUfXUwNyfkF7M1
         yR+g==
X-Forwarded-Encrypted: i=1; AJvYcCU/KtTOzcLkY4iYo4JxOdT1qMbN1irOxFgVknOmlsGHufmSGSyDgN9oi9Ze2thwKu2Kb8uLjt7rWc0YNhNT@vger.kernel.org, AJvYcCVgAzxnS1fK5N2t2rdgR7d/NMDeCAT1sqe0ahqoRr2fMliOh61fr7AT6u+TYEorQhVcjZ9wrUwsiDlBV++m@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWLKiX3mv8E3yVURrQqIQOgG0ABbVrWhqPW8HxwIvl8oHuEHx
	yB/UD3I1EoojCHVduxXR4xmkrraHAbJ91u8QMjcpqBR9jOUNno/eSVTkF3bVwg95xkAx8aM43NC
	rpj8L5I18il2A/pXEJp6132opdwc=
X-Gm-Gg: ASbGnctY47ygbUvZVaRY7HPRsUQVkVlbDLMlfqjmwh6ydBJ8Ev7KkMSlXXj7j/C/Q04
	1lZPyJHUE3Jc56s5KpqFlV29IQ6xzxnPR5X67M4GtI3VBWDigevgzDTbxM73+uFxuljLhLhLF0a
	Gc1QnBvcIGP5qzhU7Cu7ahURi2
X-Google-Smtp-Source: AGHT+IH8lsrvrDzJqM8aKTieKvcsW2tjj+X12MGd0Mu9B+u7+BJpXj5gYOm5oxOXNtz1vB0FMjVdey/z5l6+DQPZSw0=
X-Received: by 2002:a05:6870:9111:b0:2b7:7abf:df6b with SMTP id
 586e51a60fabf-2c21cdb2988mr1638765fac.26.1741178552643; Wed, 05 Mar 2025
 04:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304183506.498724-1-mjguzik@gmail.com> <20250305-sofern-visite-70a6134399cb@brauner>
In-Reply-To: <20250305-sofern-visite-70a6134399cb@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Mar 2025 13:42:16 +0100
X-Gm-Features: AQ5f1JqUDRpjSlGsw8z1UTF2NdDIUgAPkfZ2OhchQYB9wAP2J7YgZJTvrMvNtyo
Message-ID: <CAGudoHFQioKFuxXesPbfHbjdWpqTs-_J2Ss0dVrr218ih0XPtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v v2 0/4] avoid the extra atomic on a ref when closing
 a fd
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:38=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Mar 04, 2025 at 07:35:02PM +0100, Mateusz Guzik wrote:
> > The stock kernel transitioning the file to no refs held penalizes the
> > caller with an extra atomic to block any increments.
> >
> > For cases where the file is highly likely to be going away this is
> > easily avoidable.
> >
> > In the open+close case the win is very modest because of the following
> > problems:
> > - kmem and memcg having terrible performance
>
> I thought that was going to be addressed by Vlastimil, i.e., the mm guys
> to provide a new memcg api.

afaics this is for kmem only, no memcg support.

There is an old patch which sped up memcg, but got reverted and it is
on the table to bring it back, but Vlastimil is dragging his foot.

> > vast majority of last fputs are from remove_vma. I think that code want=
s
> > to be patched to batch them (as in something like fput_many should be
> > added -- something for later).
>
> We used to have that for io_uring and got rid of it. The less fput()
> primitives the better tbh. But let's see.
>

I would say a _many (or whatever) variant is pretty idiomatic, but I'm
not going to insist. This is a side remark to the patchset.

--=20
Mateusz Guzik <mjguzik gmail.com>

