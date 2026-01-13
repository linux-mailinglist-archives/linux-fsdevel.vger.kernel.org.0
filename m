Return-Path: <linux-fsdevel+bounces-73396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DAD177C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F18863020251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028463815EE;
	Tue, 13 Jan 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnYA8E2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B33815C5;
	Tue, 13 Jan 2026 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295105; cv=none; b=kXfxl1LfTnznGS2RJCoOGO/MC4bJWLETrTkBWEewkqKIuCAqXP2NImTvm+abelTN9PQ07IZHbbsV7HsE8KmRbBJ0Z4xtwQ7zcnK7enLqq9jUdOiRuc0jroPLPc0U+IMmOgWg4B0BhrPK14cTbD8XWRSCtmXhx+5L6G9uNT+C4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295105; c=relaxed/simple;
	bh=JI/qrCCxv4pysbre1tzQVlevGeAvi+n57KXP24R0MJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqJsw86YNVunkbbTqeKCrHQ3LvMHjKjvSsmFsOT0yBIL9cF/xestaVLWaZ9F1ZYPhHGeC9j+ByDxNPgmhed3dUeUa2q1NLKbSss1eFBMt5AGkgc63A8oCmaltBvkqhf8ujDkI1SHdk1uU1fSOyU7uyo7ZtlH5Kesa0dXCDJCpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnYA8E2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590E3C116C6;
	Tue, 13 Jan 2026 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768295104;
	bh=JI/qrCCxv4pysbre1tzQVlevGeAvi+n57KXP24R0MJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnYA8E2Gu31DQPhrYzsWX1t22ob14451gLqFOUSl/SinV1rCBAzfiU2sahsoSGqOJ
	 VBY02ntXi5Q5SDRV6HiepZptbFX8F8AdQP9xqgFf93/WwlkU+hWr0R4I5VjLMPKGGh
	 U63jcqRtJja7FTR60WIPOokx5BkhnvnMPEzZ6j/MWTva/UYy8Ec6zsUGcxVJ8qBV3d
	 J0Pn7u7oEcRus23vOvWhgT6/IhNmgT+6zo1fnbZqkL3DArx+SuMnTVPWXLBOzp6o8n
	 DGLZDjd1epIDdLleBOrWoaUzY0JtB4p/+CMsY57fIDfjqu7TMsTaI0xiwXgeHkL3Uq
	 h5R7PZE9FG1xQ==
Date: Tue, 13 Jan 2026 10:04:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: vira@so61.smtp.subspace.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 00/16] Exposing case folding behavior
Message-ID: <20260113-vorort-pudding-ef90f426d5cf@brauner>
References: <20260112174629.3729358-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>

On Mon, Jan 12, 2026 at 12:46:13PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following on from
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> I'm attempting to implement enough support in the Linux VFS to
> enable file services like NFSD and ksmbd (and user space
> equivalents) to provide the actual status of case folding support
> in local file systems. The default behavior for local file systems
> not explicitly supported in this series is to reflect the usual
> POSIX behaviors:
> 
>   case-insensitive = false
>   case-preserving = true
> 
> The case-insensitivity and case-preserving booleans can be consumed
> immediately by NFSD. These two booleans have been part of the NFSv3
> and NFSv4 protocols for decades, in order to support NFS clients on
> non-POSIX systems.
> 
> Support for user space file servers is why this series exposes case
> folding information via a user-space API. I don't know of any other
> category of user-space application that requires access to case
> folding info.

This all looks good to me.
Just one question: This reads like you are exposing the new file attr
bits via userspace but I can only see changes to the kernel internal
headers not the uapi headers. So are you intentionally not exposing this
as a new uapi extension to file attr or is this an accident?

