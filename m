Return-Path: <linux-fsdevel+bounces-56378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA69B16EEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30DD1AA64FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13821128D;
	Thu, 31 Jul 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQhqlVGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54129CEB
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955142; cv=none; b=k0fFlpIleGQdUVsmlpWQFJ8jZgYl+YMjVml32CZaQvjpmoBcXEy22x24LIS6LfcZlMB/TLSgxQQvH6OPBQovuPhRDy3Jl0DjbnyrsRPEGY0POO+H2aFGUUnxuLnBoVUA19uuQ90i/tBiHxX1AF9+Jo/spQOf4QuGD39a3AXqFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955142; c=relaxed/simple;
	bh=FeI2o7gTIR05xGfoT5R6580/fWNytPTYgMJ1bRA2cak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFAIHAw7u/QRG8l3OdgA3A9+HoDB/dkzxhRbOM00vPrBQDDWUb22R+9/vJUbBsIhXmb8u6SzuPSXy8waOwfYBfy1S+TLXulzWFhGEU9nsnZdS0ASgoNZD4eKWGWRNpPSaoG71ZwOQ8Y/aJ5O3cdPfM/lmCHIeMhJQ3viKee38DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQhqlVGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBBEC4CEEF;
	Thu, 31 Jul 2025 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753955142;
	bh=FeI2o7gTIR05xGfoT5R6580/fWNytPTYgMJ1bRA2cak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQhqlVGB8HtBCirPCSV7QVCPOavtME4lC41v3FBvhzf/lkYymMw6/7r+YkMz2xyhZ
	 WMdbaf5POiiamUnrSWh7CHN6KZuJi8xVJhfvYmGuHjYY3g39gLVQApck2d1ThJwPob
	 9iH9ZpbF30rtlnoaxF9EGcc4icsb6Jn+eCOYxOFkMpMlKi2pveKBX53Wau+8o9H4YE
	 D+3oKdhHLwMi8CWOcGlR4pkgls6L292cVo60Yok9WhsgA1jaGw69Rkzjpz0HaQ9tfk
	 e1kTuCCrhmGkteokXnggY2Zp0lTaEpl4bxDiNwH5j+u3Nmj/rW07mmXu91ZzAJbwN2
	 eEwtBJaID5DSg==
Date: Thu, 31 Jul 2025 11:45:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250731-dackel-auskommen-c066d3eb985a@brauner>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <20250719003215.GG2672029@frogsfrogsfrogs>
 <5ba49b0ff30f4e4f44440d393359a06a2515ab20.camel@kernel.org>
 <fda653661ea160cc65bd217c450c5291a7d3f3b1.camel@kernel.org>
 <20250723153742.GH2672029@frogsfrogsfrogs>
 <96df21fad772cfe2dbe736a22aaf18384c6a5205.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96df21fad772cfe2dbe736a22aaf18384c6a5205.camel@kernel.org>

> > (That said, my opinion is that after years of all of us telling
> > programmers that fsync is the golden standard for checking if bad stuff
> > happened, we really ought only be clearing error state during fsync.)
> > 
> 
> That is pretty doable. The only question is whether it's something we
> *want* to do. Something like this would probably be enough if so:
> 
> diff --git a/fs/open.c b/fs/open.c
> index 7828234a7caa..a20657a85ee1 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1582,6 +1582,10 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
>  
>         retval = filp_flush(file, current->files);
>  
> +       /* Do an opportunistic writeback error check before returning. */
> +       if (likely(retval == 0))
> +               retval = filemap_check_wb_err(file_inode(file)->i_mapping, file->f_wb_err);

I think that's a bad idea. 90% of the code will not check close for
any errors so they'll never see any of this anyway. 1% will be the very
interested users that may care about. 9% will be tests that suddenly
start failing because they assert on close(fd) I'm pretty sure.

So I don't think this provides a lot of value. At least I can't see it yet.

