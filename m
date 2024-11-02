Return-Path: <linux-fsdevel+bounces-33571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C469BA268
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 21:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B071C220E0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC21ABEAC;
	Sat,  2 Nov 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="WQZqGS87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19824EB50;
	Sat,  2 Nov 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730578823; cv=none; b=azhmeUWKvN+6Rx6/he6hvPDIcoBanQ9ekpfArdwdi5mjW2arvh1je7wAhDr1UzQR90Y2j6+NWIu6g2fvNxLnLpPB4YAGlkY+azycX20zCpzq34nJiQwO/CZHSwXVG42gAvqHNydd6rvz8IDGCL2U/JJRH0QQ/24QK5drmCBfBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730578823; c=relaxed/simple;
	bh=MCQ3fDQH1zb0wCaMg7Jj/z86jg/r5zXBrm9w0LNaa5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol+bX0cbRkFTu4oxFN1ZmaCxF2GWR+DMVpJWCzKuR/AesgsSa+8OrtZ1/9qd4RrY/H6unsyzdeFF6ug2CDu+kCHPmM0MkzclU5JU5FfnpjoVt+yzUmODP3Z0IuZUXGFD+MwhYDmM5KL1Cq1YnnPDSGGM+waZXJ49jpleR9RwX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=WQZqGS87; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 04FD71770FE; Sat,  2 Nov 2024 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730578821; bh=MCQ3fDQH1zb0wCaMg7Jj/z86jg/r5zXBrm9w0LNaa5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQZqGS87fNtHQE/POPwg9D6SH7OeHuuxCiKV2c07DkbEhstJCoq3h12Q9E6RVavdn
	 NiBXy77Qz2k25T7O6RzgU/ApY4rYBiRzxDdVlhg2jIh/QMA0gkxIlRhVModiGtwSDl
	 WOJVB8JJQ7cVwIoM3OhWwtOmFg92w9+A/QQMnTnPRuPdjF4ReRgRi9RerILbF13GQy
	 5LtYvtLfpexyfqA/7ILWdIPBg/YuqF7NNqpUUgpqPa56lUKzJKiPBTyo1lZbJsDZ13
	 lA0cEPwscK9SBiYK/37ZrVt0TMYzwQ90nfkyiXZ17oG6uuPH0l0oqDGrVqQQidVWrY
	 huOYTe46LeNHQ==
Date: Sat, 2 Nov 2024 20:20:20 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Kees Cook <kees@kernel.org>
Cc: ebiederm@xmission.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: move warning of null argv to be next to the
 relevant code
Message-ID: <20241102202020.GA51482@lichtman.org>
References: <ZyYUgiPc8A8i_3FH@nirs-laptop.>
 <173057792683.2382793.11435101948652154284.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173057792683.2382793.11435101948652154284.b4-ty@kernel.org>

On Sat, Nov 02, 2024 at 01:05:29PM -0700, Kees Cook wrote:
> On Sat, 02 Nov 2024 14:01:22 +0200, nir@lichtman.org wrote:
> > Problem: The warning is currently printed where it is detected that the
> > arg count is zero but the action is only taken place later in the flow
> 
> Applied to for-next/execve, thanks!

Noted about the warn once, and thanks :)

> 
> [1/1] exec: move warning of null argv to be next to the relevant code
>       https://git.kernel.org/kees/c/cc0be150ca0e
> 
> Take care,
> 
> -- 
> Kees Cook
> 

