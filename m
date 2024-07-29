Return-Path: <linux-fsdevel+bounces-24415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E13193F1D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C897B242F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4913142E7C;
	Mon, 29 Jul 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHPJRe+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868D13C69A;
	Mon, 29 Jul 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246652; cv=none; b=rcOf60V3YpuPRSxNj1uUuNVqM9x4R/rNH/ikkLamYpBo4iXAtQgvtRb4PmHPO41GC3HePYSbEKb2kpf0a6iGAqgHzXQ64uU/Dn2F00kUiNeWKKG6JURrlmyknOY/cPjd6+sjgJGpPR+xJ2o9aNsGApYYoMaBu09MHyDbdVlgoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246652; c=relaxed/simple;
	bh=aDzycB1nmXWzCEAEuxI2SOOWUPlByjcWswXnTPpHFmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Rt04FTGconpepqK4cTlIydgGeQfdJbFtK4v5oc30nOCShzoqDYQSd6QNYJUPBPuYQEcDljaSzRWsdRnADOdmpYMpr1YP8L2XcpM5UU+XD/gJrzjtNC/nLnCjuB1ksygz9bmmFMTIAdzCP/bNmOfDB+01DKJQkgrTUO9kezskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHPJRe+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84729C32786;
	Mon, 29 Jul 2024 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722246651;
	bh=aDzycB1nmXWzCEAEuxI2SOOWUPlByjcWswXnTPpHFmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHPJRe+98phjPyMGpvYK8l6qUNqPvFulzqfJXg98rUPj4ROIi9DKlpXug5X+EG+9r
	 mj3ThvOB9QoX2tLxm9HLgpOADXR6y9aLcgT9kZjy3xlBsRiSdFD1cMQXOfBO+Yo81Q
	 moNY7te8yGIJFJ8GZzcM7Y9a03A+RYx65BUO95qjjx2grHMbeasv/BYM9154kY8h3A
	 KlRyzECHqJp9CCr0PDomULrd+bp/hYhWgoT+Klm0izbc3cvk+4n1XH58ts1PJDo63G
	 lcNMeSt6kyNMCm0YN27pETb/+9XJoygvsjvhBkOPowU6Zh8Da4biG+KcGQd3ESEuIx
	 Dlbv1f8eSAUFg==
Date: Mon, 29 Jul 2024 11:50:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Why do very few filesystems have umount helpers
Message-ID: <20240729-abwesend-absondern-e90f3209e666@brauner>
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>

On Sun, Jul 28, 2024 at 02:09:14PM GMT, Steve French wrote:
> I noticed that nfs has a umount helper (/sbin/umount.nfs) as does hfs
> (as does /sbin/umount.udisks2).  Any ideas why those are the only
> three filesystems have them but other fs don't?

Helpers such as mount.* or umount.* are used by util-linux. They're not
supposed to be directly used (usually).

For example, umount.udisks talks to the udisks daemon which keeps state
on the block devices it manages and it also cleans up things that were
created (directories etc.) at mount time. Such mounts are usually marked
e.g., via helper=udisks to instruct util-linux to call umount.udisks

Similar things probably apply to the others.

> Since umount does not notify the filesystem on unmount until
> references are closed (unless you do "umount --force") and therefore
> the filesystem is only notified at kill_sb time, an easier approach to
> fixing some of the problems where resources are kept around too long
> (e.g. cached handles or directory entries etc. or references on the
> mount are held) may be to add a mount helper which notifies the fs
> (e.g. via fs specific ioctl) when umount has begun.   That may be an
> easier solution that adding a VFS call to notify the fs when umount
> begins.   As you can see from fs/namespace.c there is no mount
> notification normally (only on "force" unmounts)

The first step should be to identify what exactly keeps your mount busy
in generic/044 and generic/043. If you don't know what the cause of this
is no notification from VFS will help you. My guess is that this ends up
being fixable in cifs.

