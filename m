Return-Path: <linux-fsdevel+bounces-7268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25422823762
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F01B2895C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B31DA38;
	Wed,  3 Jan 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD7VXYE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE01DA28;
	Wed,  3 Jan 2024 21:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8238C433C7;
	Wed,  3 Jan 2024 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319137;
	bh=Lfw/gZHq3F/5AfUkw9ZLkKesfdYnFOXFvfp2chRDLQs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dD7VXYE2l4DD3k/oNHtL5+9DJm0SWk3axjpxGdp0iZlzgfrB5OJVsE/BS/Irb5KNI
	 IG4tY/X5LCF2FnqSh347rROtopQ2Z+/VfF36gsTE3AE4H/wg+ZfPlQA2J8CtqLbcjb
	 3jWTXFlFINDOAyo/yqd0CZErPhVyMn2syY4aNKUcNGhu7zDfyW+RfixDuMImqv4c1u
	 D9t5tMGSIjJUaXsIiIe2/9LTCDV89ofdsr3QKH+H/1RGZNrdQwYkDyJdtdHsM59sbz
	 5WL3AexKbilAcLxC4Tp2ZSUHqx02VVLScXnBVe8HUidScbsAK8J/jMKzbRqGTjwoXC
	 uEriQMHrESuGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5F36FCE08F4; Wed,  3 Jan 2024 13:58:57 -0800 (PST)
Date: Wed, 3 Jan 2024 13:58:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	quic_tingweiz@quicinc.com
Subject: Re: [PATCH 1/1] fs/proc: remove redudant comments from
 /proc/bootconfig
Message-ID: <d5519475-013b-4c63-9f09-03b0260674fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1704190777-26430-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1704190777-26430-1-git-send-email-quic_zhenhuah@quicinc.com>

On Tue, Jan 02, 2024 at 06:19:37PM +0800, Zhenhua Huang wrote:
> commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> 
> /proc/bootconfig shows boot_command_line[] multiple times following
> every xbc key value pair, that's duplicated and not necessary.
> Remove redundant ones.
> 
> Output before and after the fix is like:
> key1 = value1
> *bootloader argument comments*
> key2 = value2
> *bootloader argument comments*
> key3 = value3
> *bootloader argument comments*
> ...
> 
> key1 = value1
> key2 = value2
> key3 = value3
> *bootloader argument comments*
> ...
> 
> Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Good catch, and what I get for testing with only a single bootconfig
parameter.  :-/

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  fs/proc/bootconfig.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> index 902b326..e5635a6 100644
> --- a/fs/proc/bootconfig.c
> +++ b/fs/proc/bootconfig.c
> @@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
>  				break;
>  			dst += ret;
>  		}
> -		if (ret >= 0 && boot_command_line[0]) {
> -			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> -				       boot_command_line);
> -			if (ret > 0)
> -				dst += ret;
> -		}
> +	}
> +	if (ret >= 0 && boot_command_line[0]) {
> +		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> +			       boot_command_line);
> +		if (ret > 0)
> +			dst += ret;
>  	}
>  out:
>  	kfree(key);
> -- 
> 2.7.4
> 

