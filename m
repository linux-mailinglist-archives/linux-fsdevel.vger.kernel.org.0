Return-Path: <linux-fsdevel+bounces-32000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4B99EEAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57101C21335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088F1B218F;
	Tue, 15 Oct 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtjU2NTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AE14D283
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001119; cv=none; b=cSbL0GGXdEnTUH/VyPLeaN5gdXNaG6paJa0dkvW54BZ4GbwvWYPR8+8n93qbDMLtpaAwbzqcIT2GQrorfN4fZ7AC1EFjV1+8nofiRSw6QZW6P6q2noLkMtiH2hhHlAj1WPgzFcu29EC60JHLoxhP0jcU6bhoOZBEn+D2GbmH/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001119; c=relaxed/simple;
	bh=7uWH0NLW7vYGbmiUslJetTm+mzxP/fkBAD9zQE/jwkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsYlA+BbHuCbYrfdIIbOwOjhvEke8cVnNLk0+Dqlqxs/877YLXTebNdxZrYiAewTHgO5GxPYJ198l4WZtB/DcZRD4IiRR8BtTjpSbS+Wq5COK72hrtvD/Eb8NzkWonkccceILII3unJEUrPB3DPrIzTXAUA2CzAyZ6UTvkzeVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtjU2NTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4723EC4CEC6;
	Tue, 15 Oct 2024 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729001119;
	bh=7uWH0NLW7vYGbmiUslJetTm+mzxP/fkBAD9zQE/jwkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtjU2NTWyz/hLPMOKEPsgctZ+D82QE1AmlONu9D69y3a/ATpMqOLzgLuCExaL1wXZ
	 YCVt3dJTVPPEOM67g0u5vk3LOjT3dommL5GDUllVLGvOLg91kpJZwVtPzE8Gtwq3mZ
	 l6K/CSoKq+M4jMCq/e57+ivOeRgI/6WY/iUzu6sEvZECmB1LmRDOuWwz25tPh+Eu7v
	 NYH467WGSgWcgT09vf1HPt94NvBjgro7AXCaZrtr00/iuFK1HXhUsYu6EFYngga6c1
	 aNQ36ujixXvOBTs1m4xJE74JJJUdw8AV1eVXVlQD246KSx95QGPlS+Tv2qDkGvkfDG
	 2Yg9tublqundQ==
Date: Tue, 15 Oct 2024 16:05:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241015-falter-zuziehen-30594fd1e1c0@brauner>
References: <20241009040316.GY4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009040316.GY4017910@ZenIV>

On Wed, Oct 09, 2024 at 05:03:16AM +0100, Al Viro wrote:
> [
> in #work.getname; if nobody objects, I'm going to make #work.xattr pull that.
> IMO it's saner than hacks around vfs_empty_path() and it does very similar
> logics - with simpler handling on the caller side.
> ]
> 
> Semantics used by statx(2) (and later *xattrat(2)): without AT_EMPTY_PATH
> it's standard getname() (i.e. ERR_PTR(-ENOENT) on empty string,
> ERR_PTR(-EFAULT) on NULL), with AT_EMPTY_PATH both empty string and
> NULL are accepted.
>     
> Calling conventions: getname_maybe_null(user_pointer, flags) returns
> 	* pointer to struct filename when non-empty string had been
> successfully read
> 	* ERR_PTR(...) on error
> 	* NULL if an empty string or NULL pointer had been given
> with AT_EMPTY_FLAGS in the flags argument.
> 
> It tries to avoid allocation in the last case; it's not always
> able to do so, in which case the temporary struct filename instance
> is freed and NULL returned anyway.
> 
> Fast path is inlined.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> --- 

Looks good.

Fyi, I'm using your #base.getname as a base for some other work that I'm
currently doing. So please don't rebase #base.getname anymore. ;)

Since you have your #work.xattr and #work.stat using it as base it seems
pretty unlikely anyway but I just thought I mention explicitly that I'm
relying on that #base.getname branch.

