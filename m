Return-Path: <linux-fsdevel+bounces-28090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15B966B0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C471C21DCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66561BFE11;
	Fri, 30 Aug 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="e5tqFRwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZtg5KXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0ED1BFE0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051628; cv=none; b=raIpLeJnwctqnoXWYhFhUSnvE5oW7ES4aiM9nT31iYurZNPAwlZzk72XfexzAmXdw4ny/rveFnbPvdfcZl3p55e/xXU0KPWYfDdwlabeMwv/r1L377xfp2RIoMr1VhA4EkQKJPSydoNhUg4rYCEr1+uDnM46Wfhnh5lochrmWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051628; c=relaxed/simple;
	bh=YKfTu1mRiMzaL0OOXdSv8fkmvutR+TawoWMVxD2sW5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq+70CrHfCfG/1spUi9V4jmHv4K7vpQKoe3GEDr84Erp3q+jBWEUJeaNTFMMMZFEmsckRWKUUYpHQu3PXSJiX0nAt5yRDhpK0nKLxU1iDLnH4YjkNIPj0iZbLmMe2C/2vaazR2ihtImXHAY00Li2FuyE7M9WhOJ7+vAr9NVW99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=e5tqFRwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZtg5KXS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5522B114025D;
	Fri, 30 Aug 2024 17:00:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 30 Aug 2024 17:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725051625;
	 x=1725138025; bh=UVQr6IE/zrPI8n+Fhao2tpCa1eBa9OcMUViwTcSNsos=; b=
	e5tqFRwf1lVsLEhy43ilvIswoVxLoaiHl8iUbRRPXhyROYw5fhgkFlMnbfOqdqV/
	psBfe2yWm3EbUTZT7QEhNu5ri4DS1iWdSBaZV4uelgzYt2rV5U9UDAxladfje79t
	w+eJW7d5xuijmUPGS6NU3yJ61eNIuFxuAqNj+dYvslU4OJqyeA6IWdCOOPArxLD+
	f0dibsCst05nXMsx+74u77UtBCgmuD3ij6cjOcp9t4Cj0yuObcxTO2FQUIJ0n3ml
	+naBrZl+cubSxNhPkgm4A4GTbAMbBYFN3zD3OBkKpi+0frJuk7sD5uHlu06cfDkk
	wQPADR//IXS8drPZ5P30PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725051625; x=
	1725138025; bh=UVQr6IE/zrPI8n+Fhao2tpCa1eBa9OcMUViwTcSNsos=; b=Z
	Ztg5KXSFRRN4EM4kJLG7KWRi0P+b+M7Ct6ZNxJwE3dVfzwE1wqmsFqG4r4h0bOb6
	jkNN2pyqq8Z9YYtVq/CQ6wqlDXbL8X+gyM1vXAWrwYSxNh9h28eOYYrKRjYHHiCF
	u/IUG8YhO1+rNG7HGS0kb/G8LQZ2bH4GNVkTEl+AWA7DeU28WmnKG1cbdSw0BMZQ
	Pddxm0uHSllCENVKAbjCc47UBsk1KUDoW5hAKcN+ful6rKqnRAu5iaP0CbS5CuXN
	DaiRXQmloSQJhv8CstkTWWJkCPsgfvZmNnaTydq2+dGpopIzHX3TvCaVp++dMPcI
	V70445iUVBLZFL2taAhLA==
X-ME-Sender: <xms:6TLSZiPLkqccxlIAipvRIJ1dOal_AY0fct06IWJQMFK5bzKhj9o38w>
    <xme:6TLSZg8MPCIxxqkfAAYCk6GpnvSTXjcCRWVeQvv1kYva9FyxGfxN_WQ9DRfgQ9MWw
    AYLgimpKvTTRVWpsG0>
X-ME-Received: <xmr:6TLSZpT0mp1OUmuOuToFB5cwHI0qLHbbeJ21aSvBsZVyU_wZ2thcLIqUdywi5pjuylMN7mVJ8cGjd-qdhSVnC7UKlbDJCgHKqqf6UJ3Fbvp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepleehieegueeljeevieegudekfeevleff
    vdeuteehtddtuefhkedvkefhiedvfffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghn
    uggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhhohhnghgsohdvvdeshhhurgifvghirdgtohhm
    pdhrtghpthhtohepjhgrvghgvghukheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    hhrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfvdhfshdquggv
    vhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6TLSZiuHCmggiEpZSszY7Fz6uABS9q4E13KTXkpDqetiUjpYDONMMQ>
    <xmx:6TLSZqfz0-PU-D01o3sC4Fqf3tCHQtnqFq4WMUxwIqbj_9AdoiaSlw>
    <xmx:6TLSZm1kAV-aaDQT2U3dpIGnWNit2lNeQE0foHR85ny65HZ9PRXxqA>
    <xmx:6TLSZu9B60BiICm9KVXIUvBGLH77menkSIkchEgSD8AFyCp_Ft3_9A>
    <xmx:6TLSZgu4jDKDy4d-0XoeQ0haQMAnROXcCLrcg-8E5WqzxzGwGKIqv5KU>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 17:00:23 -0400 (EDT)
Message-ID: <c55d435f-c06b-4b99-b6db-b21f495b4c32@sandeen.net>
Date: Fri, 30 Aug 2024 16:00:22 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] f2fs: Add fs parameter specifications for mount
 options
To: Hongbo Li <lihongbo22@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
 <20240814023912.3959299-2-lihongbo22@huawei.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240814023912.3959299-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 9:39 PM, Hongbo Li wrote:
> Use an array of `fs_parameter_spec` called f2fs_param_specs to
> hold the mount option specifications for the new mount api.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/f2fs/super.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3959fd137cc9..1bd923a73c1f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -28,6 +28,7 @@
>  #include <linux/part_stat.h>
>  #include <linux/zstd.h>
>  #include <linux/lz4.h>
> +#include <linux/fs_parser.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -189,9 +190,87 @@ enum {
>  	Opt_memory_mode,
>  	Opt_age_extent_cache,
>  	Opt_errors,
> +	Opt_jqfmt,
> +	Opt_checkpoint,

If adding an opt_jqfmt to use with an enum, you can/should remove
Opt_jqfmt_vfsold Opt_jqfmt_vfsv0, and Opt_jqfmt_vfsv1, because they
are no longer used.

Similarly for Opt_checkpoint_disable_* symbols.

>  	Opt_err,
>  };
>  
> +static const struct constant_table f2fs_param_jqfmt[] = {
> +	{"vfsold",	QFMT_VFS_OLD},
> +	{"vfsv0",	QFMT_VFS_V0},
> +	{"vfsv1",	QFMT_VFS_V1},
> +	{}
> +};
> +
> +static const struct fs_parameter_spec f2fs_param_specs[] = {
> +	fsparam_string("background_gc", Opt_gc_background),
> +	fsparam_flag("disable_roll_forward", Opt_disable_roll_forward),
> +	fsparam_flag("norecovery", Opt_norecovery),

Many/most other filesystems tab-align the param_spec, like

...
+	fsparam_string	("background_gc",	Opt_gc_background),
+	fsparam_flag	("disable_roll_forward",Opt_disable_roll_forward),
+	fsparam_flag	("norecovery",		Opt_norecovery),
...

but that's just a style thing, up to you and the maintainers.

I'd also suggest making more use of enums (as you did for f2fs_param_jqfmt).
I think it can simplify parsing in the long run if you choose to. It avoids
the "if strcmp() else if strcmp() else if strcmp()... pattern, for example
you can do:

static const struct constant_table f2fs_param_background_gc[] = {
	{"on",		BGGC_MODE_ON},
	{"off",		BGGC_MODE_OFF},
	{"sync",	BGGC_MODE_SYNC},
	{}
};

...

	fsparam_enum	("background_gc",	Opt_gc_background, f2fs_param_background_gc),

...

and then parsing becomes simply:

	case Opt_gc_background:
		F2FS_CTX_INFO(ctx).bggc_mode = result.uint_32;
		ctx->spec_mask |= F2FS_SPEC_background_gc;
		break;

When I tried this I made a lot of use of enums, see
https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/tree/fs/f2fs/super.c?h=f2fs-mount-api#n182
and see what you think?

Thanks,
-Eric


