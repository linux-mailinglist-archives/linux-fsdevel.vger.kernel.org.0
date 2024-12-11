Return-Path: <linux-fsdevel+bounces-37056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92799ECBB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 13:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68888285D05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08B1FF1C3;
	Wed, 11 Dec 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY7LPHQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F9238E2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918613; cv=none; b=bMAQcHlpgLlw59NU3NXAT6UUHD/Ft/H2z0/WSXhwZdy5u26R1WeOPSxuclKSEnUglUzHmu5mF/XNH5gj4Of5EvQcEQ+oJPJcCiHO1VkX5c+RlBmW8busYy2O2c0q3VVelpth65U8Iv7xNEVMEfcNtYdoR0DLCLXrxxgKzG1v8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918613; c=relaxed/simple;
	bh=IDTylzEPVvF0Xp8iAn5vp3cVEy9fXlQR07UCKTveY6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H28N5wg3FcXOoi9JWJKclWop4Ue4wQbom40Fii8VnEraegJ0NrJTZ0XqJRlEHaZH9ONYRRUxrZQIAyiDR8mLuLUDegQ/ZYgMm0ffU2GiNaH1wQwXJJeVeNG5ULR0i8wffQo76/Vk5HOnVW2Az04Wk3T+HthvF1bCGsxhZ+3G768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY7LPHQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DA3C4CED2;
	Wed, 11 Dec 2024 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733918613;
	bh=IDTylzEPVvF0Xp8iAn5vp3cVEy9fXlQR07UCKTveY6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY7LPHQ3+ofbnw6r2GSokMGHMQtLBD/lS7HSqDBWdIxV6vhdbEwKbCzJ+W6AxW/dJ
	 EAIUILquRlgH0w2g4NUPhcD1fm28bJ2FZZWz5tAcb2hi9oUGjOWcT0/xciGEhutAvr
	 YkTe9MSnJaoK21wN0R393hcoTFhk4DCn624kCHiraVZo14Fc7sLjj1ETmy8ATIDdbm
	 ZwAJy6ZkpPQ3w+u3hxhwUIyAHEsKtHGi/Q7U1OEPuyzq81Ko4stO3V4u9Ex4FvMLbw
	 YjvgSBCO24RfNr6T5x/UZo4hLCyNOo5mDudT4XwCJvSYhmr6n76WXeNN1JpUv5H1LU
	 N9VF5+3hsioBA==
Date: Wed, 11 Dec 2024 13:03:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241211-beherbergen-ortet-81922cb4d9aa@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
 <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner>
 <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
 <20241211-mitnichten-verfolgen-3b1f3d731951@brauner>
 <CAJfpegttXVqfjTDVSXyVmN-6kqKPuZg-6EgdBnMCGudnd6Nang@mail.gmail.com>
 <20241211-boiler-akribisch-9d6972d0f620@brauner>
 <CAJfpegscVUhCLBdj9y+VQHqhTnXrR_DaZZ6LndL3Cavi3Appwg@mail.gmail.com>
 <20241211-wachleute-sumpf-81627ef94a90@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-wachleute-sumpf-81627ef94a90@brauner>

On Wed, Dec 11, 2024 at 12:24:03PM +0100, Christian Brauner wrote:
> On Wed, Dec 11, 2024 at 11:55:37AM +0100, Miklos Szeredi wrote:
> > On Wed, 11 Dec 2024 at 11:34, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > For that the caller has to exit or switch to another mount namespace.
> > > But that can only happen when all notifications have been registered.
> > > I may misunderstand what you mean though.
> > 
> > Ah, umount can only be done by a task that is in the namespace of the
> > mount.  I cannot find a hole in that logic, but it does seem rather
> 
> Currently... I have a finished patch series that allows unmounting by
> mount id including support for unmounting mounts in other namespaces
> without requiring setns(). That's sitting in my tree since v6.11-rc1. I
> should get that out.

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git work.umount_by_id
fwiw

