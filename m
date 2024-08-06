Return-Path: <linux-fsdevel+bounces-25196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6B949B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F1B27046
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C8172BAE;
	Tue,  6 Aug 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hage8avT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1E374C4;
	Tue,  6 Aug 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984922; cv=none; b=rOu8drBhAG6ULK75IDm+3uXJpLTVmS1VPTi8p4CTeFc4F2hVGccQWWO+WQny2JF0ee1FadiFma6CD4uYmQipz83SnZRdENMRslaeLwUp/MsJh0Gj1DxUxZRRQLz0TbRyjw5IsyinbhwZx4WWUZG4t7tIHE4f9pm3ajujuZyqPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984922; c=relaxed/simple;
	bh=yTjx3e27PQdGOdPL6WPtTZou9RrwJpkYuxZME5Rzyow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lo72fPPej+yllk6CVUALmOxmwZfAZGSWN4DNWHnLIPzdGr3ofIsNZADLJ7ZOdn5YGu34ae0HvZUWrz2X48axdcaxpI1eJ1OOIh8515vuy+dGN+nuMwy1sz8FLUrvt+ORC1veK7xNpy+TKzBzz99b3dC4ZrZt8Cb2PkjRT89mbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hage8avT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so1388177a12.1;
        Tue, 06 Aug 2024 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722984919; x=1723589719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJriyameTutCwynjg3J1SanZc3s9oPRp3ig0wvs/eN8=;
        b=Hage8avTNR27QQuco0DzA0j7FJ5q46jAj7CniKc6mvYnTJTMNBivdNrDPk+RWZGSJv
         mLEUmTeQJ3+9g0iO1yBDM2dPYhCPQRrkOvjYsh7Iz69NKo50tX1Nkz4EkwsKKslXs1LK
         bllU8OE1eiLxVF15f1EePpepH1Zb3plh6N10U1YnnGJWq5gu1v+J9YeRaADseIpRCuN+
         LYgg2YClEE4eJtT18qIpbbwmYgUCbuuU7Gjir5YdbuJx1v7A1DFfpyennq7eBiuAnC25
         p/rL2GBe6VyfSUdP5mHXZK1Cj/RJfPH5+JBi4qhTZYVNklL6F0ayo9fvpPNj3O92up1z
         7Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984919; x=1723589719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJriyameTutCwynjg3J1SanZc3s9oPRp3ig0wvs/eN8=;
        b=BV5xBSj49jT77XUbsAJtyOK9nrj3Tvr9pCm/Ap5OAmK0xBBpVpZJU6QSTFY6dEkFQw
         pk+qgSsmClPUqO9bzQ7SzG6QTTOMql7aHl6mzn6XH3RHeOBWmQWGW3zvt/7lQ/bc7vev
         rSIGG7/ysIQm5V1oZg5y0ozOY0mRuOaGCrULYQ1HU4fqvmJxE33aHBt0CClMzpibQdy/
         1PJ3r3KIx4jGr3jCrx0BdHAr2xp/wsMSqM1a9zw4ZH6GxtOrxdOakU6jmTHT+As2633d
         ljV8LccXeuTvhlv1DZtHfUJ7UTmvl+4pXHv/l6uva9li/RriICQAYKu8jwWt61ZdwUgr
         KM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNp+Zba+k99rrv8mt1+UbCnVjJYChX7Qg8tElkMcl7Og0X6ECwk/X2l/QEi8Y9/5r+SubQmOolMonh2YNuU4OOyj3OGpAL8l1sRUaSZUe9U152/ax9La57+gjNwHj0VYxop5qLpg7t4Ox0OA==
X-Gm-Message-State: AOJu0Yxdf4/+itcVrnDtx/l3r5D1eSXOURk+Tr5IyDfsErYqI8p26/17
	W+kWenZOfd+h8LrLlI4/GemyRDemHLaidOSfFecGVKKNes+4hnHDGPyat+SoMOTsByK5mcmu2VC
	rCNZbp4o6eVFlHjVTCiGd6S8EyNc=
X-Google-Smtp-Source: AGHT+IF4nlOsNXy0nAckf/dpIIjWWfD9licBvajmKW7QaItQtDz8oK2iI9H1FJ52aWP4oEbaDdTHbpU1p4wK3tG+6Jk=
X-Received: by 2002:a17:907:7b85:b0:a77:cbe5:413f with SMTP id
 a640c23a62f3a-a7dc4db8403mr1222388666b.4.1722984919335; Tue, 06 Aug 2024
 15:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <ZrKo23cfS2jtN9wF@dread.disaster.area>
In-Reply-To: <ZrKo23cfS2jtN9wF@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 00:55:07 +0200
Message-ID: <CAGudoHEt-mmZaihzTYxmf3KF_LsEC=astL2fOB+SOWGMPOCcFw@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:
> >       error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> > -     if (!error && !(file->f_mode & FMODE_OPENED))
> > -             error =3D vfs_open(&nd->path, file);
> > +     if (!error && !(file->f_mode & FMODE_OPENED)) {
> > +             BUG_ON(nd->state & ND_PATH_CONSUMED);
>
> Please don't litter new code with random BUG_ON() checks. If this
> every happens, it will panic a production kernel and the fix will
> generate a CVE.
>
> Given that these checks should never fire in a production kernel
> unless something is corrupting memory (i.e. the end is already
> near), these should be considered debug assertions and we should
> treat them that way from the start.
>
> i.e. we really should have a VFS_ASSERT() or VFS_BUG_ON() (following
> the VM_BUG_ON() pattern) masked by a CONFIG_VFS_DEBUG option so they
> are only included into debug builds where there is a developer
> watching to debug the system when one of these things fires.
>
> This is a common pattern for subsystem specific assertions.  We do
> this in all the major filesystems, the MM subsystem does this
> (VM_BUG_ON), etc.  Perhaps it is time to do this in the VFS code as
> well....

I agree, I have this at the bottom of my todo list.

The only reason I BUG_ON'ed here is because proper debug macros are not pre=
sent.

fwiw v2 does not have any of this, so...

--=20
Mateusz Guzik <mjguzik gmail.com>

