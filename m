Return-Path: <linux-fsdevel+bounces-22645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB62991ACD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FD8B26DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0B199E94;
	Thu, 27 Jun 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr2Zh7Yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7428198853;
	Thu, 27 Jun 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505826; cv=none; b=PbGaj30/jewCLr41oyst+rtfqdMJr90ryw68F+CYHs0scyATh9r3YAnFR+xi4wYAPmVoNfLi6Cw5XN8ORFA1YaDr62n91lUJ4S4mQpvhZuFb5+7EQDAKtVzQEOVwq7bPku4OnBxAc7NKbPtGA2zsAqOrNgSizSnu7qE7GQTjEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505826; c=relaxed/simple;
	bh=x0FKQrzQkootXOnVHEqKCwBIY1nchsvZL5gHYctmEQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA2XpSiwMfChcJLvA27504loxuZ3Pf8IJxj6EOovPFNNPw5UlnNwV+orzAsKEj1a9SptLY0pNWaTLJ6uNRASOF9NOGCAMnBztyICGj4/HxWvAlbeRav6ar//Ony1NNVMkN1O5gWrkGkVkjkigsOFI1A2D7d8vYh7fV+7XU9US3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr2Zh7Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A83C2BBFC;
	Thu, 27 Jun 2024 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505826;
	bh=x0FKQrzQkootXOnVHEqKCwBIY1nchsvZL5gHYctmEQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr2Zh7YwFWj9faie/q9Ci8hTY/QiXT/fPFco+a5RNJqjG6QiB+LGFnabscfQ2ZeB5
	 YpWYRyB0ykPKGhJDsLraqeTKjPaIsEOcRnI12+nCGyAZzQKw22oUZCBuYMO4HyAX82
	 a800/R5HR3fgQg2/76mgswBV2QEUUJH/Y1y9tHPGbKDnRYHFTLmYCYmqP0h6WXe/ei
	 Xs6fxAoPZ4LpfOUnFPaeTQ4C1NwZygyuqTnwSRrkbAgPJ4znU+T85zNEsEBuE67yuU
	 xGQGVfn46pCpwEX+28GV2oLHd7ay8ldYdDaUaCQv5Yh7sy6hRIgvYC6qayLOeSxDKa
	 Gd5EDU8c+6ywg==
Date: Thu, 27 Jun 2024 18:30:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: rename parent_ino to d_parent_ino and make it use
 RCU
Message-ID: <20240627-bekommen-fazit-59144d1745cd@brauner>
References: <20240627161152.802567-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627161152.802567-1-mjguzik@gmail.com>

On Thu, Jun 27, 2024 at 06:11:52PM GMT, Mateusz Guzik wrote:
> The routine is used by procfs through dir_emit_dots.
> 
> The combined RCU and lock fallback implementation is too big for an
> inline. Given that the routine takes a dentry argument fs/dcache.c seems
> like the place to put it in.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> this shows up with stress-ng --getdent (as one of many things)
> 
> build-tested with first adding d_parent_ino, then building allmodconfig
> and fixing failures as they pop up. by the end of it grep shows no
> remaining occurences, so i don't believe there will be any build regressions.
> 
> scheme borrowed from dget_parent

I like it.

