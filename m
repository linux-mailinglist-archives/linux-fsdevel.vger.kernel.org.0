Return-Path: <linux-fsdevel+bounces-21446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E17903FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F01C24CE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6565740856;
	Tue, 11 Jun 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Qju2Fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C23D38E
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118364; cv=none; b=LzcjnIM9yLgAdbBgtBlPFT5oKE7nDqAMiO9VQLGfK0OPYUkP0heW1oydJR5u61dpAWl0cJmTkia+4CCKJaKeJYXF3Q8iJ6GllATEqZU1Fcp/UjoKnELbxA6o7odOHI0FPkjDL7uI8pqaJu/gzH04FXjmQmMgumy5gpDxDItThUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118364; c=relaxed/simple;
	bh=sGrn3uo3kRFq6eRj0uHeZFI9a2Wrj353StAhI3Dx9zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Ud3SXER9naTPIpvbBU6n8mqfKO55B4f2MkSXaxcjYZZR45YkbHcXn0bM4xl3+qADvLuTe/xcENpmdOFZ8L8IWxSjNQ421xL2n2Sd7/xJCrBBYWqYJLVkFVcxsxcaV4V9hXIKadxbUWLXGKVi99IJ7VmgMH8yYj+n+8/GvrRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Qju2Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9350C4DE00;
	Tue, 11 Jun 2024 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118364;
	bh=sGrn3uo3kRFq6eRj0uHeZFI9a2Wrj353StAhI3Dx9zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+Qju2FcsXsOPo35tyUJPd1MbtnFFk9DIRJTpFuTqCg02IP7KE3ktS73xcgZp07j0
	 smRtPofr4GR9+3DXkLRal6brnj0HAZtkhe5uWQUw9BBWwV9l+jCP2mQ/a4FUpKtAHb
	 o8qgXqb/R/fH1AjC3+3EdMWmV7kpPympUBBMaXOL6ZgS2d5j6HWzVBTr6aZjSjpo3h
	 Y/3W+J4Ff7W6yavjUF4WhabMqn6s3Xrs8tLzg0rzsSgqEEKhRTjH8GoTkEHn55KQjj
	 r1MdsfykNoLlz3ACNGdCogQjYOq8dTikYQ5JM/38NEakgLFOsgK/hSZ/I4zULCmdDI
	 mcC5ZcFIdfnpQ==
Date: Tue, 11 Jun 2024 17:05:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH RFC] fs_parse: add uid & gid option parsing helpers
Message-ID: <20240611-granit-amateur-820745d37012@brauner>
References: <8b06d4d4-3f99-4c16-9489-c6cc549a3daf@redhat.com>
 <20240605-moralisieren-nahegehen-90101b576679@brauner>
 <2508590b-54db-4f52-ac55-e5014fffabb9@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2508590b-54db-4f52-ac55-e5014fffabb9@sandeen.net>

> Perhaps it's worth getting this far, and fight that battle another day?

Agreed!

