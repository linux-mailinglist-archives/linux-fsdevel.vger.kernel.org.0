Return-Path: <linux-fsdevel+bounces-63749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF58BCCB5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDC189EA1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05EC2EDD69;
	Fri, 10 Oct 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQLENQDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212624167A;
	Fri, 10 Oct 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094700; cv=none; b=bHO1DNnpeZyx5ClUIPDBtAm8xtAGgYhCULiZHA/UDnqiyiSZTOVt+HKzPKn+I3XU5d5Qj4gtV2blF81SFtdnA41YwLSKXcbhPjZPvPa/fhaL/WEj1ixsE+ZzNjjjpj0aV7MACar6Mb9p8Gv8iD2NlxTU+dUrUdmR6CkgHgoNbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094700; c=relaxed/simple;
	bh=KnTonfeAeDzZex73ySnSdP5VB0O9K458mYdNsoD4DTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvp62mP29EMgnwO2EkpARBVHjxHMH01C+7VuI6SxmvIG3ivz2uW81pL7CsFDBDfKIWLZia8NxwxcNTub7h9+QEmAa2oz6GgFv/c2Amt6TLlVWjxun2lmtgO8vo0cSAti3wFlEkE2cS+mmxksybObTfvqHY2R3YNf9saXLvhvouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQLENQDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4976DC4CEF1;
	Fri, 10 Oct 2025 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760094698;
	bh=KnTonfeAeDzZex73ySnSdP5VB0O9K458mYdNsoD4DTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQLENQDLK2GoMxkfu4tKWlffqbUlk77SyEy5KfApLVwYE3Ejap1kgWmcChJGKqR4R
	 HJ3WMGzNG3ATr+MAw/SqFXMofdDDwi2ImWiWc+4v1qU0eebO6xmsLQ2Zmof+OZYrxA
	 Ehy8Gcoz9DgbIQCuOFSPma6U3taW6ZoJUZ+gSEmz3LxNCkzUJVlu/JridypZSFKfZC
	 u84AysqDxvo/Y3qTJGvdGn34gqB/GdPWVL31DF6xVMJcdgUwME7LmnJpSJlhWgnebi
	 8NWOWqggdWsBRBvGSsLZNkuxwGzm7HCMVExv9a2n6maclkdkJKX4LEpJm5wl5gkzW8
	 om9k2sDQMKtGg==
Date: Fri, 10 Oct 2025 13:11:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Chuck Lever <cel@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Volker Lendecke <Volker.Lendecke@sernet.de>, 
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
Message-ID: <20251010-rodeln-meilenstein-0ebf47663d35@brauner>
References: <20250925151140.57548-1-cel@kernel.org>
 <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
 <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be>
 <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
 <87ldlrr8k3.fsf@mailhost.krisman.be>
 <20251006-zypressen-paarmal-4167375db973@brauner>
 <87zfa2pr4n.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfa2pr4n.fsf@mailhost.krisman.be>

On Tue, Oct 07, 2025 at 01:18:32PM -0400, Gabriel Krisman Bertazi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Fri, Oct 03, 2025 at 05:15:24PM -0400, Gabriel Krisman Bertazi wrote:
> >> Chuck Lever <cel@kernel.org> writes:
> >> 
> >> > On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
> >> >> Chuck Lever <cel@kernel.org> writes:
> >> >> 
> >> >>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
> >> >
> >> >>>> Does the protocol care about unicode version?  For userspace, it would
> >> >>>> be very relevant to expose it, as well as other details such as
> >> >>>> decomposition type.
> >> >>>
> >> >>> For the purposes of indicating case sensitivity and preservation, the
> >> >>> NFS protocol does not currently care about unicode version.
> >> >>>
> >> >>> But this is a very flexible proposal right now. Please recommend what
> >> >>> you'd like to see here. I hope I've given enough leeway that a unicode
> >> >>> version could be provided for other API consumers.
> >> >> 
> >> >> But also, encoding version information is filesystem-wide, so it would
> >> >> fit statfs.
> >> >
> >> > ext4 appears to have the ability to set the case folding behavior
> >> > on each directory, that's why I started with statx.
> >> 
> >> Yes. casefold is set per directory, but the unicode version and
> >> casefolding semantics used by those casefolded directories are defined
> >> for the entire filesystem.
> >
> > I'm not too fond of wasting statx() space for this. Couldn't this be
> > exposed via the new file_getattr() system call?:
> 
> Do you mean exposing of unicode version and flags to userspace? If so,
> yes, for sure, it can be fit in file_get_attr. It was never exposed
> before, so there is no user expectation about it!

Imho it would fit better there than statx(). If this becomes really
super common than we can also later decide to additional expose it via
statx() but for now I think it'd be better to move this into the new
file_attr()* apis.

