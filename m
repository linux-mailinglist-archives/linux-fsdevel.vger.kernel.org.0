Return-Path: <linux-fsdevel+bounces-37049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960119ECAB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B22837BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5411C5F00;
	Wed, 11 Dec 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V12qdoHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD2239BC4
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914551; cv=none; b=b2PsojrTYMs7s2WsrBm7qY6LJO28WDE8gAN+86MTicyWPrnUk8bivBXUVDzktHjFlDEL9f/1clMBWwlhn1Qo8wspnqh+oxtZkvRpyn+PL+WWScsnz8n6COPhh/yHQhOBGtg6SbDRWiq5R/q5sn9fcaoLQjR0mtpSArrZBHzPAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914551; c=relaxed/simple;
	bh=1SJ2YN45XkAqjDjkv3ri+MlBrJYeDoDQ9k0InPLtukU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIRQAppaKl6UC5mCUefZffx3ulHKLF0G+DE8uhEBSwOsLNjPOINtN9C2tjeNbpLDXb+nwLua4ERFhlqGsWX4yl/mPFTSKjplYhF9NRx/EM8Som14IDX5g1SlI17WDR9EBodVwAtOxJ+hCyk2XaGxfbU150NWfn/4XwjJKRgi338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V12qdoHg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46769b34cbfso44003591cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733914548; x=1734519348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p++x+pgiA4rW3nIQeEcaehx+Y/+W+PCbiHoN/tSu4Ds=;
        b=V12qdoHgShm6w0NlUWscwh0EEGAu0EZU8r9QKI7pIqkoKEfv3nxe+quz3RPClzF1HA
         Yf6PxYtqWEJhOLPtkOsOHrshILN0tgyAdGQhKuZ6zqYu26r1DG/dBes1iQNsbzxeKjdt
         vbfLZX85gHpF9xbgWOTTinBYkNhvZ2aCvhnDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914548; x=1734519348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p++x+pgiA4rW3nIQeEcaehx+Y/+W+PCbiHoN/tSu4Ds=;
        b=KUw3Lhs5nUZew6oxr90Vn5GY7wQM1o6NP7+T5VfQfJeV6tGHEySkF+WRfxrJeivI26
         /WAnVrypgff+704EFZRXIBanXJJMcv/NrBFDoSOuxc5endJe5WZOjSKhaUgaQEZxp+ev
         sDJ8Z7mFMoS4VvOUfr5ZJrxYPaMdDUaCizyBinNPzyEZpkMHn8u4We257f5we6fWUD7O
         3n2nmvjRd56X1Gf+WDF5siu6p67v3q9zn+Xr3ndYdXkYZmC+m3h3qHSla5qMKK+Xjomt
         WrWLPjBjgJCoVEmVOov3XLgii4/HT6msa9GbZQin+OVo+dj8ipDOuozDFFovoJmCmjgG
         RHDw==
X-Forwarded-Encrypted: i=1; AJvYcCXpCgPe45/SxR2hl5nzRc2XFJ9IDP1ks//9wek8GIOchmcJEzCMg4m2E8xkH67cXCBJQZHDDL3VSiL4Ib/2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfd0Bgzd710sA9TgThUPLFtqSXcFLxVDf8wKSJ3aljHXHht/Fa
	8cfOqnYKihZe0PB8OTkSExKLwLQQTuRqudcO2d4RPndddFTKXJsuG022XKtnTyeVRfO1OD2kJ6k
	aNb/Il8rB8X14L8ZIW69Id9HOnOlks8lMxoJr6Q==
X-Gm-Gg: ASbGnctWgPBjXjm+Mxh5fah6zPhxbmxwDNORGs2QpTD2Ug3P8muTpzds6VVYrbsuRb9
	Hk3jez6Cwmqwhcq8kFz2hogS0iQd8u13zzSs=
X-Google-Smtp-Source: AGHT+IE9PAyU1J3JvjfnhW8MqLiE6hMk9BiBVtvUm1iStPcKAgyOVzsKWzgWWEFT7K3cnikt8tPWfE2WBN4yjPSx05c=
X-Received: by 2002:a05:622a:5448:b0:467:6226:bfc1 with SMTP id
 d75a77b69052e-46789309ec8mr46944251cf.29.1733914547806; Wed, 11 Dec 2024
 02:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206151154.60538-1-mszeredi@redhat.com> <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner> <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
 <20241211-mitnichten-verfolgen-3b1f3d731951@brauner> <CAJfpegttXVqfjTDVSXyVmN-6kqKPuZg-6EgdBnMCGudnd6Nang@mail.gmail.com>
 <20241211-boiler-akribisch-9d6972d0f620@brauner>
In-Reply-To: <20241211-boiler-akribisch-9d6972d0f620@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Dec 2024 11:55:37 +0100
Message-ID: <CAJfpegscVUhCLBdj9y+VQHqhTnXrR_DaZZ6LndL3Cavi3Appwg@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 11:34, Christian Brauner <brauner@kernel.org> wrote:

> For that the caller has to exit or switch to another mount namespace.
> But that can only happen when all notifications have been registered.
> I may misunderstand what you mean though.

Ah, umount can only be done by a task that is in the namespace of the
mount.  I cannot find a hole in that logic, but it does seem rather
brittle.

> Probably, although I'm still not too happy about it. Especially since
> umount propagation can generate a lot more events then mount propagation
> as it tries to be exhaustive. I guess we have to see. Would be nice to
> have proper test for this.

You mean performance test?  Will try to think of something.

Thanks,
Miklos

