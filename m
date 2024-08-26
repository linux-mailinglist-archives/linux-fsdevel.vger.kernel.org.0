Return-Path: <linux-fsdevel+bounces-27103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E3595E9DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78402816BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1484A2C;
	Mon, 26 Aug 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VStFuT99"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35779DE;
	Mon, 26 Aug 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655930; cv=none; b=bdUu5FOqrOUIWWNjguLc8SptoMNagl0KMNnoBepcRINfAxVqikZikglZmj9tX0x4Tmb7k52tdEIAqFTM/6iYOA39wpGlS0RoblrzJs1+oY3rVnx2wRtTy7LiSHqggaK+7tLrKSPnFH0mpDoHU8ba5adAaWivbbp7Z9xT5zeEc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655930; c=relaxed/simple;
	bh=ujOJ9o0GABnjmX4VsDIZLHYlJjz6IfbPCNomeHPuhg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9n3nr684vmD20+KoLfjdRHtc4R+Cxd9PWgvXD+gXJzpwzUiVdp3QpmAhxWbaG7K37P9Ocxv07hoXTZny/nNTFlDSpeukHJXu23W5YC9NLi+vjq7UNu6QXDarsA3X5ysAE5JUcd2Dc/Gqr2Zw1hIWTwC4imkbL/34GZ/88Ptpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VStFuT99; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a869332c2c2so580131966b.0;
        Mon, 26 Aug 2024 00:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724655927; x=1725260727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujOJ9o0GABnjmX4VsDIZLHYlJjz6IfbPCNomeHPuhg4=;
        b=VStFuT997dhQzh9BDPcZkafn7XyHZKWjUNlEbjsv1sRc06j5h+JYpij0HHzVpqHDLK
         7LgbtaGtOKxi326vn04DPF5HGr1YGc2Z/SvzjALHX+CIivp3Go0+iGAIb349Gs6xFOqI
         XhXs7llaWWOOL84eLzzb1HnosuoDbzgbEaVl6syrixHZBulpfoP+GEMvB3jow0qHo+tk
         JTA02sXhyQiEVyOymeMjF7wnItLXtCkvVl9IczkSu6vYyfnalrVNSrvWioNanFIZVOwH
         ylzS8Lx7Y6tK/dnrWPLo2+k4EhDyntwh9F3Du77UHxlDfD7UtniuUQCS8dKZp8Y3k3k8
         Cyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655927; x=1725260727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujOJ9o0GABnjmX4VsDIZLHYlJjz6IfbPCNomeHPuhg4=;
        b=oqVRPGpB06N4WDwNFnULKlQS6C2/moResM/dJHnwO30r5+urfVsDCsvkc1csvEFgXF
         boDh60mYXK4jLwObiWNV3aKMh+/F1LU5CPMXme3sGVuyqtjjYyS6UuHaUjY7tLwqpbxR
         Hq51iY4BdxPSKWjQHJUc6liVzkPTQyyeYSgDgQor4VFY/xTaH78TrQVT1SJwqcnSjFz5
         3EZmhfrxx5ekqARsT/EkVHszo+vZmnCA53Ew78b6xQlIhos+CKOQbLQ/bIkvL5IKzIZk
         yFeGl9dAdqZnFboypWVuQk75KO9ynQmcILMfa1wQpN2jhw8gWUqA76sD6w7/zBpeS7x+
         csuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4R7uSEtx7MaK9KEKwpNlD44+iJMUN6wzYXFJboH4j2pl0fSGSJ7RDMueL3Elh5VEP8Sbquko/@vger.kernel.org, AJvYcCW0/nYmMJoUtdQ8a4gIyTb8IWZ2OIifiirkeTT+NLSI0pj77yNWd6K5RJB4/TMcIsKKY/mZBJAQyJ31Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNGlS6g3ezR6T2jJu4Ijg1S42gKhETGW1SprXlK6DsQC/VgJt
	ljvtyoJGEMZywNH4tkk2GJx7FXdz2bWmETE5bKJWF0eNQ665KTs/YosXd2XVOtP0iq7mIXS2o0J
	n5ienlXNrB4Zf15/gGtPwnsrqUH8=
X-Google-Smtp-Source: AGHT+IEHoceLx9JkZLnntrfxUgsOUHXNxDNks2yb+WAxgrLatcWBzS+MdMlzDQ+nGrRSq305WgI/YzNsrNmLFTPuPz8=
X-Received: by 2002:a17:906:c144:b0:a86:91a5:4d09 with SMTP id
 a640c23a62f3a-a86a309ae59mr800136666b.26.1724655926868; Mon, 26 Aug 2024
 00:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823130730.658881-1-sunjunchao2870@gmail.com>
 <rvorqwxqlpray26yi3epqpxjiijr77nvle3ts5glvwitebrl6e@vcvqfk2bf6sj> <e8c68d82d7209fc64823bd25eee3175c2a7e8ec4.camel@gmail.com>
In-Reply-To: <e8c68d82d7209fc64823bd25eee3175c2a7e8ec4.camel@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 26 Aug 2024 09:05:14 +0200
Message-ID: <CAGudoHFhSD=nXgrx+zz2iOFntiGH-MHUbTyOzVMHEVtkvjcbCw@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix race between evice_inodes() and find_inode()&iput()
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	david@fromorbit.com, zhuyifei1999@gmail.com, 
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:11=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.co=
m> wrote:
>
> On Sat, 2024-08-24 at 06:54 +0200, Mateusz Guzik wrote:
> > evict_inodes() fails to re-check i_count after acquiring the spin
> > lock,
> > while the flags blocking 0->1 i_count transisions are not set yet,
> > making it possible to race against such transition.
> Alright, I think the issue is clearly explained through the above
> commit message. If you insist, I can send a patch v2 to reorder the
> commit message.

I'm in no position to insist, merely noting. :)


--=20
Mateusz Guzik <mjguzik gmail.com>

