Return-Path: <linux-fsdevel+bounces-35320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16869D3B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 13:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9EEB22579
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCCB1A4F19;
	Wed, 20 Nov 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7rDMHJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F31991AA;
	Wed, 20 Nov 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107241; cv=none; b=nmD799d33ZLsG/pVEkvAk0gmiRyvxxhEp3k6/gTl4hCQ/JY1ksSMw1MWiA/M9/1FgBMkUHluv1tQr8/NSVR6bs8T9M53LDDQQjPcT/czQfzpNTU2IgdZGe4uSVaVigHnk7gwXl1fsiAyF4lmzZSIiNEMmWPSfHeOLHkIbBHYIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107241; c=relaxed/simple;
	bh=Cf+A+DhKDyMUlVitgWBjgzEXAtDZpWZUoLr4r7ASY0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O26Eyd/JZDgJCh08EJZdGrCdE6j2JXgn3khGYwUizoQhgUSQ0LUdCqD6y8GrC56gqLxxmcsdIVdzZKmjeulp3BaDe9CRryGYpS/AhiDruUNtsVRWbAZqEKB0VaEoXm77nOjPFbXrOP9kywEdU9VY5zEU+fgQaN4RmT/elG/CKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7rDMHJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9340CC4CECD;
	Wed, 20 Nov 2024 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107241;
	bh=Cf+A+DhKDyMUlVitgWBjgzEXAtDZpWZUoLr4r7ASY0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7rDMHJ1BeyrSWqAqJuId7NEzbaVndXG9WkvuWdfWQu9qWUNYq/AMnY20tOEoNLor
	 G88UM5yCaCRsVi9F7b/0rPqWrGcUUjdBF6LnjinbXht2dvyax3+EaWUd6+Eu06+684
	 sh91lAmwqQ12eUkKadUZ/R5S540NQ4SfXOmWt0a1bE3NpjksiHPsl0MVUxlcBMyiS8
	 QTbs3/WNEVAajhvMItaIIiYQde9NwNb0CCHR8c8UZL4gSyQIo4b5JQdBoJHnlIWcOK
	 9E5CD30Il/vMGqwA7D8P8pzLG1hM54X1gBg5mO+uk8/AbDK/VaUFO1RvPa0B849Bfe
	 JCoFao1GRCRfA==
Date: Wed, 20 Nov 2024 13:53:33 +0100
From: Joel Granados <joel.granados@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 2/3] sysctl: Fix underflow value setting risk in
 vm_table
Message-ID: <4ietaibtqwl4xfqluvy6ua6cr3nkymmyzzmoo3a62lf65wtltq@s6imawclrht6>
References: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
 <20241114162638.57392-3-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114162638.57392-3-nicolas.bouchinet@clip-os.org>

On Thu, Nov 14, 2024 at 05:25:51PM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
> vm_table") fixes underflow value setting risk in vm_table but misses
> vdso_enabled sysctl.
> 
> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> avoid negative value writes but the proc_handler is proc_dointvec and not
> proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> 
> The following command thus works :
> 
> `# echo -1 > /proc/sys/vm/vdso_enabled`
It would be interesting to know what happens when you do a
# echo (INT_MAX + 1) > /proc/sys/vm/vdso_enabled

This is the reasons why I'm interested in such a test:

1. Both proc_dointvec and proc_dointvec_minmax (calls proc_dointvec) have a
   overflow check where they will return -EINVAL if what is given by the user is
   greater than (unsiged long)INT_MAX; this will evaluate can evaluate to true
   or false depending on the architecture where we are running.

2. I noticed that vdso_enabled is an unsigned long. And so the expectation is
   that the range is 0 to ULONG_MAX, which in some cases (depending on the arch)
   would not be the case.

So my question is: What is the expected range for this value? Because you might
not be getting the whole range in the cases where int is 32 bit and long is 64
bit.

> 
> This patch properly sets the proc_handler to proc_dointvec_minmax.
> 
> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48f..37b1c1a760985 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2194,7 +2194,7 @@ static struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(vdso_enabled),
>  #endif
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
Any reason why extra2 is not defined. I know that it was not defined before, but
this does not mean that it will not have an upper limit. The way that I read the
situation is that this will be bounded by the overflow check done in
proc_dointvec and will have an upper limit of INT_MAX.

Please correct me if I have read the situation incorrectly.

Best

-- 

Joel Granados

