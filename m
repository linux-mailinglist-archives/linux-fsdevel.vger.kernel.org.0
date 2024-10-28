Return-Path: <linux-fsdevel+bounces-33045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9029B2B70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503C71C21AEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13A61D934B;
	Mon, 28 Oct 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1HGmVJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF81D89F7;
	Mon, 28 Oct 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107387; cv=none; b=RyLAYZkV9YKQ6AkFIKMVeQEIQfchLhzQbAkV5TdywLX1CRj41ZRuBc1qWpqHqDEcALWzYrsTzKanaQaPG748AflrIrqg1bf5tRVf3LEchxr5gtjWoCeTLotRXC5TE19HKC1oN++Rm71WiPDkdL5LIdtZHJ3gOjou9O2dos+jino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107387; c=relaxed/simple;
	bh=wKoWSet6DVEpE0W6MSLUyKXITne8n04ArzRUPEn81Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPEzqNiaBhfuSazuF7FJwCnoiccrswUJklDjQeShG+sFsIKDlz7UXVTaJWkydMwpyOZW2+2H7ToY/ueB0t7SQWiNk1lXbzqlR4KQ4bMK4Afr2bKuhyBNQaxW/pJNBfeQ3VNEw4t4IXlfS/T2ZH4JiGmcTutzNzIeprjFvn96Mg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1HGmVJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F34C4CEC3;
	Mon, 28 Oct 2024 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730107386;
	bh=wKoWSet6DVEpE0W6MSLUyKXITne8n04ArzRUPEn81Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1HGmVJkriajQWsDSFlP4Xz2RdbrqgpIudZ9ksouc0Fmfv1ycYKmIYQmvMdiZ9sfC
	 jskaDg2+zAQ34HLvRqY1AXRWwBepNwRZ3qaVYzAXF8n8kE+z4nMS4+9j0puVtffBUt
	 TJSfKQ9vPpB9P9vdytkA1i22dF00+pM7S5UldRUuhtxw2TfjjDcrZNDZ2da7jKsFI0
	 1RPoZcmwi8vq+hsy+YA3rZJl/QN/+dXy47olF/qWoaVz3rBF/Nf0vAaU5qCViNo3DX
	 /bXkOafaBN31AUo8JK503+ta4hwI1ux9aNuYWlxnd6awtM0komF9nnXm8jO3qsN+Uw
	 0AryuuHxISegg==
Date: Mon, 28 Oct 2024 10:23:02 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v2] sysctl: Reduce dput(child) calls in
 proc_sys_fill_cache()
Message-ID: <fpyvxkkhyv7gqbwayxmcglf2jh6gs65brbtojxxtpief4nm35g@l2jq7oab7p3p>
References: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
 <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
 <3a94a3cb-1beb-4e48-ab78-4f24b18d9077@web.de>
 <t4phgjtexlsw3njituayfa6x5ahzhpvv6vc2m6xk6ffcbzizkl@ybhnpzkhih7z>
 <582379a6-dea3-482f-86e4-259d4b23204e@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <582379a6-dea3-482f-86e4-259d4b23204e@web.de>

On Wed, Oct 23, 2024 at 05:27:11PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 23 Oct 2024 16:54:59 +0200
> 
> Replace two dput(child) calls with one that occurs immediately before
> the IS_ERR evaluation. This transformation can be performed because
> dput() gets called regardless of the value returned by IS_ERR(res).
> 
> This issue was transformed by using a script for the
> semantic patch language like the following.
> <SmPL>
Aren't you missing a "virtual patch" here?

Is there another way to run it besides this command:
make coccicheck MODE=patch SPFLAGS="--in-place --include-headers --smpl-spacing --jobs=16" COCCI=SCRIPT

Best
> @extended_adjustment@
> expression e, f != { mutex_unlock }, x, y;
> @@
> +f(e);
>  if (...)
>  {
>  <+... when != \( e = x \| y(..., &e, ...) \)
> -   f(e);
>  ...+>
>  }
> -f(e);
> </SmPL>
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> V2:
> * This update suggestion was rebased on source files of the software
>   “Linux next-20241023”.
> 
> * The change description was adjusted according to the wording preferences
>   by Joel Granados.
> 
> * An SmPL script example was appended.
> 
> 
>  fs/proc/proc_sysctl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 9b9dfc450cb3..b277a1ca392e 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -698,11 +698,11 @@ static bool proc_sys_fill_cache(struct file *file,
>  			res = d_splice_alias(inode, child);
>  			d_lookup_done(child);
>  			if (unlikely(res)) {
> -				if (IS_ERR(res)) {
> -					dput(child);
> -					return false;
> -				}
>  				dput(child);
> +
> +				if (IS_ERR(res))
> +					return false;
> +
>  				child = res;
>  			}
>  		}
> --
> 2.47.0
> 

-- 

Joel Granados

