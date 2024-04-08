Return-Path: <linux-fsdevel+bounces-16334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E163289B5BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 03:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029611C20D95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 01:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913B184F;
	Mon,  8 Apr 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX5eumPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520415C3;
	Mon,  8 Apr 2024 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540927; cv=none; b=A23cBxHyJC/nIFPHAgydaE/E36QvcaGa6sDnzjmi9zpHUEu1ZhMr9Af6V/olohbe1Po0jQ34fdQL8zTHqG3t3eR93+49PxmxjlRJqbD6bIf/430GefguIOqTuCuTrFFekWQhJ0S5a2OSHDhYZTI3JUWR5KnlaaoneIpvGhYf7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540927; c=relaxed/simple;
	bh=cGQTlO0CLDvAYncNza6I9EJcZIywUmmqjrc8SyZUTtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjPK47g7f4joL8uNPlmYofLmbS+tdjMS/ZFuX+4jIwOLwW0PsuOJFrfkijvu2zdXET9GoSkEqp2dVtjTzB4kRSRTFbemhazzL9k+H0W7evG1VzMpZueGRG1Wiyo6MNPxHZKJdxDt/J3TotpITSONTNcIM7hLgCb5bBteX7A+9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX5eumPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB83C433C7;
	Mon,  8 Apr 2024 01:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540926;
	bh=cGQTlO0CLDvAYncNza6I9EJcZIywUmmqjrc8SyZUTtg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OX5eumPweGKOzUL97OcSUi/e69Ao5Ef9YvXQXIbGMIEGY37H4APURqjyN76pe66PS
	 K4/P+2idyeeor0zXj/+M+cCkZRgoontUkr6XTvBm6A1EkpFOeWOQtVosz/O8oWJzNp
	 l10t+CHAVGRXAizapecb1LeIvfPqKGeFxqYBmRsVD3sDjoxSaE+wU7QCOdY8mRyd98
	 ITEe4CQB/AJafwWOc8Vbxj/jJNPoP0sHO6m44hMH3+fDwhsFIAaoQehSM2orQwYzYS
	 JbDAi2tf92u0Rbn/TnsRx0mPQq6ZSnEH7pAIVWLVfHX5gr9rL4vfHtgoMGL2mca6XW
	 tz6A497sCOF/A==
Message-ID: <99a8d3ec-1028-44c5-9fcd-01598a40a014@kernel.org>
Date: Mon, 8 Apr 2024 10:48:44 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402101715.226284-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240402101715.226284-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 19:17, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
> 
> 	opportunity for str_plural(zgroup->g_nr_zones)
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index c6a124e8d565..964fa7f24003 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1048,7 +1048,7 @@ static int zonefs_init_zgroup(struct super_block *sb,
>  	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
>  		    zonefs_zgroup_name(ztype),
>  		    zgroup->g_nr_zones,
> -		    zgroup->g_nr_zones > 1 ? "s" : "");
> +		    str_plural(zgroup->g_nr_zones));

Looking at this function definition:

static inline const char *str_plural(size_t num)
{
	return num == 1 ? "" : "s";
}

It is wrong: num == 0 should not imply plural. This function needs to be fixed.
E.g. it should be:

static inline const char *str_plural(size_t num)
{
	return num <= 1 ? "" : "s";
}

Please fix that first and then we can apply your patch to zonefs.

-- 
Damien Le Moal
Western Digital Research


