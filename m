Return-Path: <linux-fsdevel+bounces-57232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C877B1FA1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48359174A9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3802550DD;
	Sun, 10 Aug 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcS9IK2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B3229B36;
	Sun, 10 Aug 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754832318; cv=none; b=fBmrk0/l79Fy4L6HdxVsbUXm+xfHJ+Z7gfzuH5xe8wcXufLg9a1vx7w2EAHiZ6QQqBvf40ACXkSD+sqfVDrc/wb60J0yGRp/Bh9to51cviKBGl+CPjoaKHQferDlkNSWyVehp/HUHxxx5V7Yv96h5kfBjm5sTKoo2g4BA+/upw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754832318; c=relaxed/simple;
	bh=Km5gcCVceWztQI650A0mp1I8HulI/vmgBxVOIuYNWns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7Xfqx6YgXXaqJe0nR2mF5AxzWXjmi6wdboxypZ6PkpH6apzUN7C7BLHzqSzCTDHutWdzwb/LIeZorD2ior1r8i2I2bEcrbGe9TUXLppAt15vOAbQefl9GlsBcNotCnh5YGUogt2R3i+9ONjpD1jIEjIfWsMtjEhpTo8c504WpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcS9IK2r; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so4197893a12.1;
        Sun, 10 Aug 2025 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754832315; x=1755437115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km5gcCVceWztQI650A0mp1I8HulI/vmgBxVOIuYNWns=;
        b=JcS9IK2rKEFYa3b+o8sQ4k9RDdUpAiv6WZQDHbAo9rY+5bcix3AWMd1c9BIX812fI0
         1/ZUpZa0oZ2br7p+rLR64rnG7iCBUJnY9pfT2sktolrBpJ0f7UTsOvxFccTp7rViXP7M
         Eu6cq7Bpi0F8LqRINDhUODw5GekwahxtEcFGLcC4XQoaXXYrYTZSbFwyItAdJbIo5KSC
         RFRqJx2YleBsan1wqR5qc4kxbdu7GcsTnCL9eouBNqyTJuRXKENqQfm6G2xA//KC7dA+
         Ojzmkz1O3FLVjS1jSlw6aCgSoWZUBrj8LoV0aIcDLsNnyfBuaWtszHlwzdcHVWvuud97
         PSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754832315; x=1755437115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km5gcCVceWztQI650A0mp1I8HulI/vmgBxVOIuYNWns=;
        b=BfavUsY+2gtD9JDZqjTh8b8ff2PmPSvq4KiAWwbbUnPSYX/1mhau7DO67FL3lHJMV0
         KIdUwOZQuwBLV1nyXwjMylxlnp+kzRd1UfU8keHv4Jc5Ut5WVY4W5UZkhLn2dRuedqlr
         AgM1g46zakJz8IKei6I2drJRtEiSNidUMbZD6tMiYN3hCUnSDzDG/XJw7GuQ8gV2t0g6
         DJpnrzudLN3DtOoCW6X1jBYzHyAFGJIkMxI8O8kVhmdc0EUDVhUIGZlZ3wAvaM3il1ds
         41JAlfIO0Yi93VCpfVfo+UuFA1dVgsflO1IrwB7ynuT+UPK7ky2SSy0pcdt95vVwik0h
         15zA==
X-Forwarded-Encrypted: i=1; AJvYcCW7/5j4MdOSGWqKMacmwKXtsXtB11fikA9Mpl6a5qUrNjlkgT9ByzvHwQXuZ55NybKr4feS12X1N7niwQsk@vger.kernel.org, AJvYcCXfmZ9YioAjOrTjH01ZngKKSlyq6I8IdZKIPuaKnaYgfo4eP8kH8hE4riXVv8ghTF43JmdLNFuB+IauND4B@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQt/GO+vYWLTfAwnffm6vhCzhPnHNBfRkD6v+zJ8n00AaCcP8
	bYoD35+D6DVnO3APP1kp5CkcSkUpennV9O0MvBKSZC3+UOFNIH9kH/oqaLNCPtZDDpv8lrcht5k
	TbQK7XH8q+q4gg+Qo4FLUAqC1mjHALb0LtUbnuxM=
X-Gm-Gg: ASbGncsZfxhdbOJNSLVoFBFEGZ3OLMNEcWOaWRCqMQZFPPlOYjpdZ1p2c7M056XH6F9
	iYg4k1L+JltSLGSm+p4oZm2cRJEcWZr4xLZZFTtr3BjRRzYyiRpCPCNl8IHPMAoYEcVlccCXJJU
	p9TzZaOnvEnLG9qluhRHzUcaL77nOr4QW31zn973zR7OkdMeZYEY40ahRxNG0cnYlHPZKbtAjkF
	h8WYtk=
X-Google-Smtp-Source: AGHT+IGH/YhNs7ZPh9Ppy7izd55Uzuv4yl3ahzURUGm48TK3UaAS5/72+Z6WZzH8XPnMi2c9ah1CecmLAeKfeJx58nY=
X-Received: by 2002:a17:907:3e8c:b0:af9:2b35:a8b with SMTP id
 a640c23a62f3a-af9c633021emr1002194066b.3.1754832314435; Sun, 10 Aug 2025
 06:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
 <20250804173228.1990317-1-paullawrence@google.com>
In-Reply-To: <20250804173228.1990317-1-paullawrence@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Aug 2025 15:25:02 +0200
X-Gm-Features: Ac12FXx04-e9BdriTZclwPTFoU_aAoOzlFpBwZXQdsZIGAGqSJ3Y3xASZhvMSiM
Message-ID: <CAOQ4uxiFVt8eVmP5hUkjvascK-rVNyZzAec_tiGQf7N0PYDdTQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: Set backing file at lookup
To: Paul Lawrence <paullawrence@google.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:32=E2=80=AFPM Paul Lawrence <paullawrence@google.c=
om> wrote:
>
> Based on our discussion, I put together two simple patches.
>
> The first adds an optional extra parameter to FUSE_LOOKUP outargs. This a=
llows
> the daemon to set a backing file at lookup time on a successful lookup.
>
> I then looked at which opcodes do not require a file handle. The simplest=
 seem
> to be FUSE_MKDIR and FUSE_RMDIR. So I implemented passthrough handling fo=
r these
> opcodes in the second patch.
>
> Both patches sit on top of Amir's tree at:
>
> https://github.com/amir73il/linux/commit/ceaf7f16452f6aaf7993279b1c10e727=
d6bf6a32
>

I think you based your patches on ceaf7f16452f^ and patch 1/2 replaces comm=
it
ceaf7f16452f ("fuse: support setting backing inode passthrough on getattr")

Right?

That makes sense to me because that last patch was a hacky API,
but then you made some other changes to my patch which I did not understand=
 why.

Thanks,
Amir.

