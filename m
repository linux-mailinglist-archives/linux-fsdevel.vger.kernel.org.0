Return-Path: <linux-fsdevel+bounces-70490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E258FC9D4EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 00:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B48034844E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B292FBDFB;
	Tue,  2 Dec 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q0TfdZsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289382FB967;
	Tue,  2 Dec 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717226; cv=none; b=ZSghxap+1yH/eO5lbPIfgXE12f/KwvVtNeuA7RE/U2whxADmSvBxo0qiMvBd3HbX9+aGNZAL+iXi44Fjl//Tc2OAkawhduroX9daWqLBqlYutdf8knk3+1AEYq5pMG7B0d6TA3luWdGy3vpNxiPMGY2S5DKRohgU3faz0N+cZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717226; c=relaxed/simple;
	bh=d/vQItVpbFXJ3AStEch1ievS07v/3N+c0O46dM+ws+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8FYOvj5huiu5gqieaGa+ilyaDYCwVFW4xhiZtyNJr4EYhQrvRc9XgFgPU/y6q66SxFQEHJte/1WqG2cQ9P5MwYjD1LRG9lVHAq8w1kijaXEfNoth1KC75PmqIl3GiG/EJyaFl+uoCs9HlTKyNwmHWyuaRDEGEtsZrNQzBYlzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q0TfdZsk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=doJ/WS7/uOH7hqFqqqx/KHro2bmltzIs5o0219e8Ta0=; b=q0TfdZskkBIbs+pwBYjYKDIgRO
	ONZ+RdAcfUPmVlXsEuoAF+gSLz+pV7DMnWGaom2MOifvGHkp5Kj6KX1ePLvzrKVwOYQL6FA26eYL7
	0monFQQrbvIDFmOPJb+wqWJpRRRaWHZFCUfX5uBjqCBlr370LMnliGU20hGPboa7CwapVbzMgTxGD
	gsDwz1oA8r1Q3fbEAKD1PnUjYTzJJSBJzu7dxE3Gka69gRPg52NaB8NrggGPgDaS0Z4y7adcuD3Y6
	p8VVQ8A4wPA4hy4EnKgyv0bvlVkgOqpSNZyEo8LKSkbt8Mi+uLZBkOswXEielmroKZnRGkn0uE1o9
	pwxIHmuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQZZA-00000006SXX-2IAX;
	Tue, 02 Dec 2025 23:13:52 +0000
Date: Tue, 2 Dec 2025 23:13:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	asmadeus@codewreck.org, linux_oss@crudebyte.com, eadavis@qq.com,
	Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
Message-ID: <20251202231352.GF1712166@ZenIV>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 02, 2025 at 04:30:53PM -0600, Eric Sandeen wrote:
> commit 4eb3117888a92 changed the cache= option to accept either string
> shortcuts or bitfield values. It also changed /proc/mounts to emit the
> option as the hexadecimal numeric value rather than the shortcut string.
> 
> However, by printing "cache=%x" without the leading 0x, shortcuts such
> as "cache=loose" will emit "cache=f" and 'f' is not a string that is
> parseable by kstrtoint(), so remounting may fail if a remount with
> "cache=f" is attempted.
> 
> Fix this by adding the 0x prefix to the hexadecimal value shown in
> /proc/mounts.
> 
> Fixes: 4eb3117888a92 ("fs/9p: Rework cache modes and add new options to Documentation")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 05fc2ba3c5d4..d684cb406ed6 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -148,7 +148,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
>  	if (v9ses->nodev)
>  		seq_puts(m, ",nodevmap");
>  	if (v9ses->cache)
> -		seq_printf(m, ",cache=%x", v9ses->cache);
> +		seq_printf(m, ",cache=0x%x", v9ses->cache);

What's wrong with "cache=%#x"?

