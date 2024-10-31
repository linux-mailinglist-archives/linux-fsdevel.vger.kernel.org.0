Return-Path: <linux-fsdevel+bounces-33335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E39B7889
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 11:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B815285D3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FB199231;
	Thu, 31 Oct 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+H/9k2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8A195F28;
	Thu, 31 Oct 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369979; cv=none; b=HNTGn8pcb5c1L+hdkm8BZd2ZBQ7CbeMlcLcHuXu1BMxRpAY4u5/FuQE+bYuzuyPMamdbqCmjSH/o0yzk/YBq4+BeJGNKskXNVVBJ9kaAE4DL+uDW6ji2wnh84GdGdP0jh1H1NaPxSEycyCYXTVh02bt4/vZUCJ4GTCBP24s/GdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369979; c=relaxed/simple;
	bh=HKRz/SHmEjtKuZrR+qUEEamtgN87CawYOO8zIncd/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idkwoT7qCaMiSayP3T6qyIPY9aiEZVc7jnodpEKc9/bFmdRFcSpFaesvgDZqImoJVRWXD0UmThIJ/TFKC+XewgCaR4mPbJvEGb0FdVD8isShz++wPNWymFyFc4iU3CxJCWFES5rcYgtIh60OAhcDmgmjuIJfcGj9Xsvf3/ilBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+H/9k2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D824C4CEC3;
	Thu, 31 Oct 2024 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730369978;
	bh=HKRz/SHmEjtKuZrR+qUEEamtgN87CawYOO8zIncd/I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+H/9k2e93/q+EILIZXUrtUPAqec5XC9BcY1VEcki8R4h+eMGbMkD9WVSOJNeslvX
	 JY7hMv+dEx6tbY2eV0dR9hrFwq8ve1s8PhdXMXH8KpDuO6tFuMUitunhaQj5cuGl31
	 taElyP8FA5DQPVZYi/8SFHg1QcP8S9ZwjVQaP4AbJMwcqFfGVioco5AquLBLsJdVTk
	 fiegZjM9XLH2r9LHaji+1W6qT+5rfLQbgfnKtiUOtOgowAiB91cJOplkkZhOOfGB+p
	 Vw7fJ+Ri7xDtmvDJ+o80qZysJpYSSx7AgcJQR309tfBx++7//L7RHXgKYHh7tpXw4p
	 HI+YnOEJqEkNA==
Date: Thu, 31 Oct 2024 11:19:33 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v2] sysctl: Reduce dput(child) calls in
 proc_sys_fill_cache()
Message-ID: <3vjfwmskssuqoqrj6s5l5jlppogttiaqaqu37i7ax56ffo3lbh@lz6zmfjzpe77>
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

Small comment: Remember to send out a new patch-set email in order to
make it easier for tools like b4.

> 
> Replace two dput(child) calls with one that occurs immediately before
> the IS_ERR evaluation. This transformation can be performed because
> dput() gets called regardless of the value returned by IS_ERR(res).
> 
> This issue was transformed by using a script for the
> semantic patch language like the following.
> <SmPL>
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

This looks good to me. I'll push it to sysctl-next.
Thx for the patch

Reviewed-by: Joel Granados <joel.granados@kernel.org>

Best

-- 

Joel Granados

