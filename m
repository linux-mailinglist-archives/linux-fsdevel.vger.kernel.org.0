Return-Path: <linux-fsdevel+bounces-17314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4F8AB5DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286E91F21CBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE013D24E;
	Fri, 19 Apr 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="MndrY2dl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA764F;
	Fri, 19 Apr 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557059; cv=pass; b=H+1gpRA7tiu0mc9Iw/j7CohxUEnDO4d0GnFFsgwzl3v1xI/oE13qWkkIMJMWk/eza1aVJb/4tDfsNSsjVTNywRCVCeukKi0iI5Tl18ymJUGrnc5mGNaSar3v87rPyEENVbUTdrnjg8aMhBcsFIG6Sa5T0ycA6rH6cJ9lVgSD6KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557059; c=relaxed/simple;
	bh=nQRHbFf+whsAutgS8E/DEWI1hSQ98s6TxkcRXoiAsaw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=UjNILivOAPShxuG8onYczUWfn6vYXpaa95VonD61D+W4DWDEhEl3G2TrWAzevNsUwBFNRmq8N+7NG7CFMX1tyzzQK5j545TF7+tu5XzzPpYZeKQgyh5bSuljXNAnPt12hOXxn8U2aQZKqCfSgp329URvgeWJgJS8Sxz8KG7/M6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=MndrY2dl; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <5d354377e2ba2f8f4ed249bf7633fd71@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1713557054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrV4npIoXrOukeNblskQI/a7RrbB6geAAv/9nYneVY8=;
	b=MndrY2dlBclKUU00zjjlwYecdn6Yf3Gr+rCrQuMUENn95CjZ0EM5vxFh2VS/V0DK+hKwhJ
	CXHZKDcsfMRoPpkpDnjLLzTiIO8j9v7jzfBnByI1xFwACv62OMyWIV0RDK6OLzU0374lbc
	ntppXYiygNOd40PECVRFMliM/TXW8uhMBKOgDdSzHyTNXbv5Q8e6y0an4Te9V2/XR6b2X4
	pUOooqkwZbJeqG0LF/sbFcxuyIfLVwBZkLhbA0UFFz3HzoWgX7tZ8NC6fQWh2Ao79gYrno
	n90xWTdv4sx5qFcsUkg8CeoBJVQiNmmsLHkOp4yOftarkE4m4dC02UtlUk5RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1713557054; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrV4npIoXrOukeNblskQI/a7RrbB6geAAv/9nYneVY8=;
	b=eic3Li+gaORjGGNXtWjzNpGkcOinIzBZbkO+HFgDDxfbgk6OCNssWIIWKGl3sc03HxY8Zh
	fYvtm40swjUirgUKrN9Rk/LtzXmdjutMkD2BqkAAGgJMWKoJRVf07YmWsbG7/gw9La06pQ
	i2n0gFMq5IOaXLMgamtXGEJQcn2KTontt1ciJhj4hDW6RvcHFPfdJVpTXzPMmnjpoK2DxD
	axWyOT6PboT6j69YCpmRboDdeLEG89IvtsjdINfV2msGo5qxp/do1igC8yLbYfsKUZOo+C
	hvUMuXD/ufk+1Xb1kV9ROPp3cUCrQ/cUQacjHSnhVEtoMYT+uFtKQiuYbdYWPg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1713557054; a=rsa-sha256;
	cv=none;
	b=EEOh5ZIo+qn/E/U+YuyEsSXtxoNM3/Ot32BrkhnY2l0t/54cywhXFucFm9s08I/OiC0Efm
	kBtd3thicAe/Mc4vy2N9zxjxxQXE6+LBd7DX4ZyCaRoFIu1Pxr1TX5QyQZYgPHhSwowTfo
	hvvXmIYaLvDDZ66ygJd04jy15cnPMRQjuddxBCcCjBYGwbsj1ap2N0sH49BeL/+bB0bl7d
	TmquLpz0lMLteLK1lj9qDOCB7PaecYmIhR03EJZ1k4/KwW5Ce3oiOGqcd0MEJ7Beto7be7
	eoVtKfG2vJdmV2dLcejnzaSULAwxGqrP+y5vne46Twrx49IBEUgtpDKXjPbW/w==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>, Shyam Prasad N
 <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live
 connection
In-Reply-To: <564520.1713447839@warthog.procyon.org.uk>
References: <59c322dc49c3cc76a4b6a2de35106c61@manguebit.com>
 <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com>
 <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com>
 <3756406.1712244064@warthog.procyon.org.uk>
 <2713340.1713286722@warthog.procyon.org.uk>
 <277920.1713364693@warthog.procyon.org.uk>
 <564520.1713447839@warthog.procyon.org.uk>
Date: Fri, 19 Apr 2024 17:04:11 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Paulo Alcantara <pc@manguebit.com> wrote:
>
>> I don't know why it was designed that way, but the reason we have two
>> different superblocks with ${opts} being the same is because cifs.ko
>> relies on the value of cifs_sb_info::prepath to build paths out of
>> dentries.  See build_path_from_dentry().  So, when you access
>> /mnt/2/foo, cifs.ko will build a path like '[optional tree name prefix]
>> + cifs_sb_info::prepath + \foo' and then reuse connections
>> (server+session+tcon) from first superblock to perform I/O on that file.
>
> Yep.  You don't *need* prepath.  You could always build from the sb->s_root
> without a prepath and have mnt->mnt_root offset the place the VFS thinks you
> are:
>
> 	[rootdir]/	<--- s_root points here
> 	|
> 	v
> 	foo/
> 	|
> 	v
> 	bar/		<--- mnt_root points here
> 	|
> 	v
> 	a
>
> Without prepath, you build back up the tree { a, bar/, foo/, [rootdir] } with
> prepath you insert the prepath at the end.
>
> Bind mounts just make the VFS think it's starting midway down, but you build
> up back to s_root.
>
> Think of a mount as just referring to a subtree of the tree inside the
> superblock.  The prepath is just an optimisation - but possibly one that makes
> sense for cifs if you're having to do pathname fabrication a lot.

Thanks alot Dave!  Great explanation.  We also need to remember that
those prefix paths can also be changed over reconnect.  That is, if
you're currently mounted to a DFS link target '\srv1\share' and client
failovers to next target '\srv2\share\foo\bar', cifs_sb_info::prepath
will be set to '\foo\bar'.  And if you mounted the DFS link as
`mount.cifs //dfs/link/some/dir`, cifs_sb_info::prepath would be set to
'\some\dir\foo\bar'.  Yeah, a lot of corner cases to handle...

Anyways, don't worry much about all of this as we can handle in
follow-up patches.

FWIW, patch looks good:

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

