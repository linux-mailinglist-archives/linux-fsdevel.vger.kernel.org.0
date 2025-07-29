Return-Path: <linux-fsdevel+bounces-56228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936FB147AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E4F5438C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0523D289;
	Tue, 29 Jul 2025 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr9Zy4kI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084223C4FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767334; cv=none; b=SH3LdyoI0cS8UtUTcVwuZ47KIoR2WTdQIqcoOQXEExTg7L+cJAyNOqkDlAwh38TQeRJlXeAMZvv5+oSBcoW+mCvCSqJeeJBTJXtmThlF1vbQFJ/ao7ICaaz46k21PYsbcaPvsJPWzwqYOmE0hO5t8XIgDwMpG8PQ9ylY279DwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767334; c=relaxed/simple;
	bh=1eyn1z6D9wmKr4tD0xeaDeyDq+hx/Shwwp3ie0Z9+jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqR8vgGtRsqrRUobFibbDfbrTImFqx2XeuMAKPvCK2WuFFvaNTkOLGlxoUWlC/w8NVSFDngfjdJU9LZ4+BYbGiogP7rLexTf7GAXK+OqRVYwkJqbzK/LCXWXtjCmsvlbo6a9DeZ9ljLynwgkuOi3RtAlQFio8cZqF9gE1OJ43nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr9Zy4kI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C66C4CEEF;
	Tue, 29 Jul 2025 05:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753767333;
	bh=1eyn1z6D9wmKr4tD0xeaDeyDq+hx/Shwwp3ie0Z9+jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dr9Zy4kIrI9RKxSSpkLpRjN/MqTWI7fP2NuAy8H+AhZF4ZHw5qDbQTW2zvaLMXfzU
	 2NZx4cg+tvEHgmHy4skOCSKkFFiMMn49p3alHbXvMuV0o76j3OyEsHE+zhNsnrVO/y
	 7RI6mT4HvSdQBLuUnBLmcbSWgB8d70CwV4DEY+wmkdz6r89JDUjrtcHh7bTPhjl4PQ
	 WY6gDDul4ZpOYzzOhoSiL55BVc/0ujaMJZDt4EkIW63o6/c5WCeqbujXXxvgluA1fy
	 qL4Uwpu4QQ4KvWZC+0o2FGWSqKBpvtQRT8/1rK7SKKQJ/y7tqaPrklc/VXv+mJ7dUq
	 Z+i6cCFbMCSJw==
Date: Mon, 28 Jul 2025 22:35:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, "John@groves.net" <John@groves.net>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
Message-ID: <20250729053533.GS2672029@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
 <20250718155514.GS2672029@frogsfrogsfrogs>
 <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>
 <20250723175031.GJ2672029@frogsfrogsfrogs>
 <CAOQ4uxi8hTbhAB4a1z-Wsnp0px3HG4rM0j-Q7LTt_-zd1UsqeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi8hTbhAB4a1z-Wsnp0px3HG4rM0j-Q7LTt_-zd1UsqeQ@mail.gmail.com>

On Thu, Jul 24, 2025 at 09:56:16PM +0200, Amir Goldstein wrote:
> > > Also a bit surprising to see all your lowlevel work and then fuse high
> > > level coming ;)
> >
> > Right now fuse2fs is a high level fuse server, so I hacked whatever I
> > needed into fuse.c to make it sort of work, awkwardly.  That stuff
> > doesn't need to live forever.
> >
> > In the long run, the lowlevel server will probably have better
> > performance because fuse2fs++ can pass ext2 inode numbers to the kernel
> > as the nodeids, and libext2fs can look up inodes via nodeid.  No more
> > path construction overhead!
> >
> 
> I was wondering how well an LLM would be in the mechanical task of
> converting fuse2fs to a low level fuse fs, so I was tempted to try.
> 
> Feel free to use it or lose it or use as a reference, because at least
> for basic testing it seems to works:
> https://github.com/amir73il/e2fsprogs/commits/fuse4fs/

Heh, I'll take a closer look in the morning, but it looks like a
reasonable conversion.  Are you willing to add a "Co-developed-by" tag
per Sasha's recent proposal[1] if I pull it in?

--D

[1] https://lore.kernel.org/lkml/20250727195802.2222764-1-sashal@kernel.org/

> Thanks,
> Amir.
> 

