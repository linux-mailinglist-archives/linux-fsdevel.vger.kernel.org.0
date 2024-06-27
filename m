Return-Path: <linux-fsdevel+bounces-22679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6091AFD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51A71F230FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CE19ADB3;
	Thu, 27 Jun 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cauf3q+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB52D047;
	Thu, 27 Jun 2024 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517798; cv=none; b=Khu8/JErbouGVBsJ0z322iRMPwJx9xwdq5igSf7nvNFdLe8duszbFpdIt0EC1uWtTzY7fSDi8qKjx/OgqXUF93CiZyzPCcx54AVglnTFyY95GVb7qC/JxvOvo/3PWsYfgYZMf69aypdlnUBJbWfVBwO/TibuAk0l87N8G7UezOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517798; c=relaxed/simple;
	bh=LbeZhTvrMZr4xHjYq9W0eB0sW/WT+bIkqEA5WOLp22k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtyvzNzP7wDOZWA6IZepYSdOXXHWSEL7XJQhMLPp74N2Sb++dEmKNgYcFEOyv/6MPvh4UyNxZhM61bzP0vKCbAKbqmuAEWPXQDFENvEItuJLwposkmHGudu0p0j53LuMZ/TUHzlywPbL+R6zLOZF1iURe6OTtTxOeDWsrKBZdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cauf3q+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDACC2BBFC;
	Thu, 27 Jun 2024 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719517797;
	bh=LbeZhTvrMZr4xHjYq9W0eB0sW/WT+bIkqEA5WOLp22k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cauf3q+KQYQjNPaWrsg141tb/JEl1S5eiFZkngyocugydl8zul3a8txXte+5vZT0Q
	 APKXcBSW++K4W+64pTyLr5fWbELUd1NW6zSmglSdH1VkmXVFQqqdo0KXchv7ZtsiDz
	 8UH5y8U65YJ2fjGubMXRy1SI2C8V1o8DM8sm2qPaD6OLaP7kD3/C8PvHyj7n+YuBuG
	 Q2eq4zrCFhU58tBYCGS/vE4JuG1Avfu8lhGWVh3tMeMfKaPIcN/hWIssBrJjkhbbdZ
	 gk7manOYTOm8Ekl0a7XeEfK35ISq9GFOvrsxLwdpJIuBjUNRftEAit0lx4OOpQSmZL
	 M9BicI/lma1hw==
Date: Thu, 27 Jun 2024 12:49:57 -0700
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] exec: Avoid pathological argc, envc, and bprm->p
 values
Message-ID: <202406271248.622193ABB@keescook>
References: <20240621204729.it.434-kees@kernel.org>
 <674c2009-4c55-421c-ba57-10463e00fd62@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674c2009-4c55-421c-ba57-10463e00fd62@roeck-us.net>

On Fri, Jun 21, 2024 at 02:44:05PM -0700, Guenter Roeck wrote:
> On 6/21/24 13:50, Kees Cook wrote:
> > Hi,
> > 
> > This pair of patches replaces the last patch in this[1] series.
> > 
> > Perform bprm argument overflow checking but only do argmin checks for MMU
> > systems. To avoid tripping over this again, argmin is explicitly defined
> > only for CONFIG_MMU. Thank you to Guenter Roeck for finding this issue
> > (again)!
> > 
> 
> That does make me wonder: Is anyone but me testing, much less running,
> the nommu code in the kernel ?
> 
> mps2-an385 trips over the same problem, and xtensa:nommu_kc705_defconfig
> doesn't even build in linux-next right now (spoiler alert: I suspect that
> the problem is caused by "kunit: test: Add vm_mmap() allocation resource
> manager", but I did not have time to bisect it).

This has a fixed pending:
https://lore.kernel.org/lkml/202406271005.4E767DAE@keescook/

> I am kind of tired keeping those tests alive, and I would not exactly
> shed tears if nommu support would just be dropped entirely.

I haven't ever used the nommu builds, so I don't have a useful opinion
here. :)

-Kees

-- 
Kees Cook

