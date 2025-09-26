Return-Path: <linux-fsdevel+bounces-62900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D16BA47B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8453AC012
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DB223DFF;
	Fri, 26 Sep 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVykgIaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654FC15530C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901682; cv=none; b=p2nN7K9MoOwDKgxLbB2hqHtmbEquTGk4zX9CqV6Au1sL/mllKRmlu9Q2j+nuioTBDSvUJZfBOIvRUn9GsHfoe9A5MoAeBG7S7N1qf6k35sf4LC0MqfTcuXsDS0N3ia572OyPzY39uiehghAW1nTyP3qPFiuX559tgn2OKrxvcp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901682; c=relaxed/simple;
	bh=3oPDSFUJ0lyja2RjyxHKZDYFVvUU6sMYbOL+xVaLgXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKUIleFyCTFFSWIE/d1RyTt+zRzoJK71UMZ6R/SSqRgOPcI7XJxaPxvHpRvVYTAbcFaRUpYtUhTY9vtsw6EMES0hINqJJYpjxCpnHhawaM7KdimLaFot+48rwjMGRdKpxxXRVZPUf3ocd5uA173+Dw6MEtbkoMbQ+ANot8mYzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVykgIaL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2d92b52149so467700666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901679; x=1759506479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klXEiQwOC07mduQthD5dYDmzUkII4CIPfD13syHRtGw=;
        b=OVykgIaLNt1J2ANV/KfKKaXG6Z0fV0w5ko/sn0eNQets6KplboEJSyoP4YWDRRWfiV
         AJ/Y1w7Q6njYTzfhY/E4m8uOfEpnmE+nTaXbCwL+eRHke2xe4lG4+DOdKjKf4yd9ElDS
         VKPNo3Ane/P8j9RdHSfARNEUHPbI2cnTwn7vPe1gdmP0emXBcEvXhrEAXURCmJ2GxWer
         UgOtN3gbguCNf7AeE+ahG/LOGY3vQ5/yJqZq/lB3kCwysO4oQR8/cZkPfwBNaAyKewGf
         Zs+QoxCzONe9V/nJHvDOSrz7wNo1CAr6YZqeC+8o1cZsEQQSD45rkwLK4g7koV/fdql1
         bjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901679; x=1759506479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klXEiQwOC07mduQthD5dYDmzUkII4CIPfD13syHRtGw=;
        b=sa9XfGyMaSqYlo+fOsULy9OrYTcmKpPakQYd/tAbZ2mO+0TUoILhnAqxhxr1H7Ykh2
         ODEWt92oL0goChDk1qHFAD1ahlG5EuoZq24WHLo4BlasjN5ExSiCX6RmSpgTGPelynTr
         lCkmEoj4/ObZAGov4GYclIADZ3ryn8KPjy6wxPqjYn2Hf2gKAGnOH7IA/iZUS7ZhGwWh
         HStH6RlQxQlKbAaCZujBmu/ZlLwUlvlYC6mFpGFp2+ppcECQEtiSTUC6xu7s3Vmjjv1H
         3zfkB1x7eqOB313GWMJ67GZ4kuNYaIsbiazoXgQ5XTQIJjuY9sRp0Y3e3/QCXnfg8vYC
         HhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAUKeeHaAsv3WqPENIF6N+oBgCDrUlNAky3pa/OSKDbU9KwfPSfexL0beE5TqeDBb7MfyTUzMIRhvlthSq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hf9SBKWCXnpJUUhexdbOfBtw83N1huuBput+uviWvYQSNorL
	Y7ioz9+D2hL+aCbvSNziM54e0lOAl/iHZHC02zhkY8MtLXOMYhtT/enXRmkMm3oW7m33NeEfLSo
	TWvnx9US6GFB4y2e3ETGMMsSwUqN25bE=
X-Gm-Gg: ASbGnctMeOjFAfLxu3iTRrN8NvVfwdRf466mt+1HG+zty/zeW34AaxbPor6R77IQjxS
	Z8FJjXqlfo9SN6lct8dZJgSSVlnsKcDo9AiB9KLCsgCKdj4lKeCNLRLJRvQeBe1VcX+3ptfuE4s
	DnfA1y77uvwg7kt49E4/sLLKv2XjzhWQTyaIkAG+W2fCGhGRs7WyjESxMlPFlV2o/BrKqHqpQQV
	SHHkLGCeI5Y5jw+IXuJDQub31lJBZvRgu2drg==
X-Google-Smtp-Source: AGHT+IHdOXiPucslloAUUiiiyAUMj+ohe/e6na6Rez1580AV41MXzucvD+1uDdrYWalAA27Ihkivj+rE46/XuOnAOto=
X-Received: by 2002:a17:907:2da7:b0:b30:daf3:a5a0 with SMTP id
 a640c23a62f3a-b34bad2253cmr909891966b.42.1758901678534; Fri, 26 Sep 2025
 08:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Sep 2025 17:47:47 +0200
X-Gm-Features: AS18NWAdVeBYjIHAvAl47A3RQm6oXzfRe2fw8RpZ3dkou8_fOIeOTwp6H1h351A
Message-ID: <CAOQ4uxhr+pFGa+SW-pJgeNpK5BYPxr6VVvq5LLQV4M59UBrVbw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Create APIs to centralise locking for directory ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> This is the next batch in my ongoing work to change directory op locking.
>
> The series creates a number of interfaces that combine locking and lookup=
, or
> sometimes do the locking without lookup.
> After this series there are still a few places where non-VFS code knows
> about the locking rules.  Places that call simple_start_creating()
> still have explicit unlock on the parent (I think).  Al is doing work
> on those places so I'll wait until he is finished.
> Also there explicit locking one place in nfsd which is changed by an
> in-flight patch.  That lands it can be updated to use these interfaces.
>
> The first patch here should have been part of the last patch of the
> previous series - sorry for leaving it out.  It should probably be
> squashed into that patch.
>
> I've combined the new interface with changes is various places to use
> the new interfaces.  I think it is easier to reveiew the design that way.
> If necessary I can split these out to have separate patches for each plac=
e
> that new APIs are used if the general design is accepted.
>
> NeilBrown
>
>  [PATCH 01/11] debugfs: rename end_creating() to
>  [PATCH 02/11] VFS: introduce start_dirop() and end_dirop()
>  [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and
>  [PATCH 04/11] VFS/nfsd/cachefiles/ovl: introduce start_removing() and
>  [PATCH 05/11] VFS: introduce start_creating_noperm() and
>  [PATCH 06/11] VFS: introduce start_removing_dentry()
>  [PATCH 07/11] VFS: add start_creating_killable() and
>  [PATCH 08/11] VFS/nfsd/ovl: introduce start_renaming() and
>  [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
>  [PATCH 10/11] Add start_renaming_two_dentrys()
>  [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs

Overall looks like nice abstractions.
Will try to look closer in next few days.

Can you please share a branch for testing.

Thanks,
Amir.

