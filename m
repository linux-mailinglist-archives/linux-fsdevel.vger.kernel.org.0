Return-Path: <linux-fsdevel+bounces-32650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB8F9AC8A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452541F2254F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA11A7ADE;
	Wed, 23 Oct 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTjHx+SG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FF136331;
	Wed, 23 Oct 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681895; cv=none; b=tss/J0ylhhvWTmMXxHhnChCPA2C1Pszq6nvNuoRyOR4IanjVqM1k2p0YmpzbI+o0gCIJ2uxHyMxj3a60s5Tq1/VSjFxM/a/ROna2oNsonVIfaiFdRyiRXaTqjzzJe/h3l9Z9cAeNsOtC7gel1Tgou6QXtnmkoDIY5R7QsHR+dqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681895; c=relaxed/simple;
	bh=qVyuFJmjgg9fPMwZdxxV7x/VyKeD4f16AAlu5AmfvLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRqmQbVcKfg8QgQvdjcdUlHtxUW4krH7BLHWYifX/chLMl3MagW4E9DPWFJTKWZSlY9Cypkl7OmcYoZqUwync/AFec93LYYYH2GJ9sgIEs+MObyvirz7jdxu8IkKKASPx/VJyX+PyQz73f0NwOisco2uxEtHMALitrOW4Wzc5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTjHx+SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475E9C4CEC6;
	Wed, 23 Oct 2024 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729681894;
	bh=qVyuFJmjgg9fPMwZdxxV7x/VyKeD4f16AAlu5AmfvLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTjHx+SGniyfno5hzpUEOCE/uEIe3TFzXFsKZNLdKXLsv7qqwrJDTfFL+Pc1AQ4Op
	 6Wo8Y0YfPu9pt5rKFfHBrx+CcAo45fK1+JKCQ2NkYs10ClHKYGUl3t0esQtzXualdg
	 2R9UizqKV6jLKZ5CPIxUVIDNeECNX9nloOOVyMcq5/MZCycIEqpVmIrfaG2FunBEIo
	 YDMzQ2N3h1vbURHo0Vw3Q4+2gJb5n4TTuaxIT20SIoJrtNKTXz+OAC/L0rXr8v74C8
	 Q2H8rD4pnL1zeuuiLfh1oukp9yH9oRVkJRmbWRqqgxoLDjsAIXDkP8O33fV7BH18jC
	 Jrn+BXs7Gqr6Q==
Date: Wed, 23 Oct 2024 13:11:29 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Joel Granados <j.granados@samsung.com>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] sysctl: Reduce dput(child) calls in proc_sys_fill_cache()
Message-ID: <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
References: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>

On Thu, Sep 26, 2024 at 10:20:34AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2024 10:10:33 +0200
> 
> A dput(child) call was immediately used after an error pointer check
> for a d_splice_alias() call in this function implementation.
> Thus call such a function instead directly before the check.
This message reads funny, please re-write for your v2. Here is how I would write
it.

"
Replace two dput(child) calls with one that occurs immediately before the IS_ERR
evaluation. This is ok because dput gets called regardless of the value returned
by IS_ERR(res).
"

> 
> This issue was transformed by using the Coccinelle software.
How long is the coccinelle script? If it is a reasonable size, can you please
append it to the commit message. If in doubt of what "reasonable" means, just
share it to the list before doing your V2.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/proc/proc_sysctl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d11ebc055ce0..97547de58218 100644
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
> 2.46.1
> 

-- 

Joel Granados

