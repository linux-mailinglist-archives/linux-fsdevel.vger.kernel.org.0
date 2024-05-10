Return-Path: <linux-fsdevel+bounces-19238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8BF8C1C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA6E1C22637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E413B7A6;
	Fri, 10 May 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7igZdW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD52137928;
	Fri, 10 May 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304327; cv=none; b=WquPga2GpcL1GteOXMltvg7vlafxxrFbSy064x+UCqEtk6y/e7xzvjaoIh5MZuGH4ztjJidSKQL/76leOvPczs2yujHjSo63BsvQc41Y2FSQZCn6ItB7Q+z8HygyYcr7IRRpwRo44wukkvLZdOS+haCDSNaQZN3owgPvOCZg968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304327; c=relaxed/simple;
	bh=z6usap/sG4pNmXnz79zMaYcGqNYRG6xfvcprS7cuFkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx0oCmtGQVJcLl2PGvRDqzAAhf1A8em5uTMJOIr9597O/Oe7k+Hhj3dbuY/fTP7fZXyjuRo4AEbuvkmKRrITQsCYGNvsTi7PK1MMGYurQYb32j+AiDOgDc3XjHputhLzs596kfCCI6B3FQASNiZ+yagn2pWcEpn3lzH0fhtHyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7igZdW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062FC116B1;
	Fri, 10 May 2024 01:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304327;
	bh=z6usap/sG4pNmXnz79zMaYcGqNYRG6xfvcprS7cuFkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7igZdW8tgYu0o8kPCfFrxugMADMEZ0lCFEu9UoLdURi8eu138yKWg/2ootT5zu5c
	 T0G/fZU941SH5WD8Qw18MiyQf9ftFYRJhvQ9C2K2KlOnzroGfZu0/+HyFi9T6OFzZ9
	 p1yG48T48Ps161PumuwbBGRRTLoaQwftCeRzdqgO5Dm8ZzWnCBepTI9eO5/4/BiJdt
	 JD1Q10H+z7UBJBoyGG5LekBosH0bGwkOQu8gb2bnP0QdtGMJbUKh6Xn+2O/1Emu5q7
	 NfBWu5Kw7Rut2ZpIJll8V3BkstRTm7H83eEP4/JxwnV8ZtmhADiqsGocmx25eiDheN
	 3GBs0ueg7Ijag==
Date: Fri, 10 May 2024 01:25:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de
Subject: Re: [PATCH v16 7/9] f2fs: Log error when lookup of encoded dentry
 fails
Message-ID: <20240510012525.GF1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-8-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-8-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:30PM +0300, Eugen Hristev wrote:
> If the volume is in strict mode, generi c_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

But please fix the typo: "generi c_ci_compare" => "generic_ci_d_compare"

- Eric

