Return-Path: <linux-fsdevel+bounces-33159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4FD9B548B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 21:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFD1F217F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03849202F8D;
	Tue, 29 Oct 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ZxhVsnwj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aibpbMQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F53207
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235504; cv=none; b=pogWlrEs/MBeQ8ILPY10+i6ELz2xLBq0HJp3M08AkhGG7TbcyOXoww3ITzF0F81Ny8rnF5x/qFN3R6pMlU6MXbA+q+LbVz1ltyyHPLibvh7uw10coFsSwhHdUgub4jEp5GpDiO6LMgJGGjb8ObhdmWDw1dcDestAn1pyTP9Gspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235504; c=relaxed/simple;
	bh=EhWW8oj+v4IIHVO2Cd45r5az9t+0cLfl5gLNLlDy3Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUJ5eJXIXCbVC5Sxo3CoyV7kRFGbFmobc/gTZ9WLlhO7DqoZON105LuP5rZVy322OE67U6hLY9FWWw78+liFpd6+6ZCdwVenF69gTyrWF3IZ7evaAuuIsXCSV3210+lyb+qqnlBYphwDcQrGLgBACKuwo3NR6weiDIyYlWH+JMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ZxhVsnwj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aibpbMQF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E89C11400C4;
	Tue, 29 Oct 2024 16:58:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 29 Oct 2024 16:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730235499;
	 x=1730321899; bh=Z2QoYzTf3EjsBu/AGNM2GjjojNxMhnkbz3npQ5wTGaE=; b=
	ZxhVsnwjtm/aDhvuv7WAfOzi52M3AdI4k9PjvmaVlK9C9oXplcTCIhWWNRnfxv4w
	9i8wejud0zYUAfrVFYiJxwAkgJTIim9wQ226WLSuIqpZvrGFcAvs4D5ewIFB0Zwp
	zdezWoGghR5BegUBlf6sc6F4rSVc1Re2fJ4fxXOzi+6sKI1/J0Rt84anbDIvjeAy
	AgKyc3geRb6hCGBZBOtH4kFzlUN2Bf206Z9Fv7b+wvGyHu279WBPmuPKNyQGPX9A
	22qi3BjQSc+8C7ozSsogrFEYLxSEOObKrzHzdFHP0PixZ3MTt0x4LhttrUnAzmxh
	96H65CNXU4D3UsGMgn4lCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730235499; x=
	1730321899; bh=Z2QoYzTf3EjsBu/AGNM2GjjojNxMhnkbz3npQ5wTGaE=; b=a
	ibpbMQFs5nmdVjtYEcYuRTdNZSjTYaNKA/413AhB9wq07chiA9CG+ANkYUSRiAgV
	zzyrLmM/fsTr8EVn1lIOpwv4T88iSXy46BgLL4e1vXDwjc2jJYJBZ22EeiZ0N+jg
	ABBsUzNky75rhD+ReeUIWE8ubcsAmVzSxo9ouxgSuLqrki1akuxcggGl3koKnDvp
	snjR3PRb0/UAeYS8nRKwA/kgXSIM4Q7KQbSKDfVX4RqXm77IPrdYd6Bf/j/TRMCJ
	4fwl3WQYa8WlV73CdneX9sK54672GkQ/pe5A0/AGYxZan/lESbEL1YV49ter6qcj
	7qhhjm8vKUVMe8VJS3Fug==
X-ME-Sender: <xms:aUwhZ0prpHPt1_1poR8Bkal06iszF4cAOdCoH6V_EavdOR1qhVeqfQ>
    <xme:aUwhZ6pGlFHO0b64ZiWVENZkXB0Vuj4duJaFQEY_bcF60ypEebRb6lIq51QuBP4X3
    Xa6IKyp66jSwGsI>
X-ME-Received: <xmr:aUwhZ5Mqt3sXuU7yIERj0_MUIt32HbZGLgFS6uD9AevikI9Y2pMUQsuabvPwR3_dctcCxckr_mU9RRTRoWQnt3tkf0Uu7rQlOrz3J-hTTeenQtlQev_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrgho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:aUwhZ76epDtgiCj5D_Fr6h6A-LMsF1uEpd_qFM5eUW8Nl7zVdKrL4w>
    <xmx:aUwhZz4PIqPcn-9N8NMkHLkQWxSfrV7Jtp-FcSDGw1OdSsVifKXYVQ>
    <xmx:aUwhZ7jNQGHKeuvXCVfPJBUTbv_I1omuQUQVwjHhE8C8SHJtP7FdjA>
    <xmx:aUwhZ954qElHZHgtLyAeC1iUF2p5KaqlIOy8kWmoEMsldSADouWX4A>
    <xmx:a0whZ2bPpJYm56qw-QIoXNnuUIe54rQg8CUPEeA4wO-L0d4DxrL7k4un>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 16:58:16 -0400 (EDT)
Message-ID: <676b106a-d60f-46fc-848c-dd67a6e2d36e@fastmail.fm>
Date: Tue, 29 Oct 2024 21:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] fs_parser: add fsparam_u16 helper
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241011191320.91592-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/24 21:13, Joanne Koong wrote:
> Add a fsparam helper for unsigned 16 bit values.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fs_parser.c            | 14 ++++++++++++++
>  include/linux/fs_parser.h |  9 ++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 24727ec34e5a..0e06f9618c89 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -210,6 +210,20 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
>  }
>  EXPORT_SYMBOL(fs_param_is_bool);
>  
> +int fs_param_is_u16(struct p_log *log, const struct fs_parameter_spec *p,
> +		    struct fs_parameter *param, struct fs_parse_result *result)
> +{
> +	int base = (unsigned long)p->data;
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtou16(param->string, base, &result->uint_16) < 0)
> +		return fs_param_bad_value(log, param);
> +	return 0;
> +}
> +EXPORT_SYMBOL(fs_param_is_u16);
> +
>  int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index 6cf713a7e6c6..1c940756300c 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -26,9 +26,10 @@ typedef int fs_param_type(struct p_log *,
>  /*
>   * The type of parameter expected.
>   */
> -fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
> -	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
> -	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
> +fs_param_type fs_param_is_bool, fs_param_is_u16, fs_param_is_u32, fs_param_is_s32,
> +	fs_param_is_u64, fs_param_is_enum, fs_param_is_string, fs_param_is_blob,
> +	fs_param_is_blockdev, fs_param_is_path, fs_param_is_fd, fs_param_is_uid,
> +	fs_param_is_gid;
>  
>  /*
>   * Specification of the type of value a parameter wants.
> @@ -55,6 +56,7 @@ struct fs_parse_result {
>  	union {
>  		bool		boolean;	/* For spec_bool */
>  		int		int_32;		/* For spec_s32/spec_enum */
> +		u16             uint_16;	/* For spec_u16 *
>  		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */

Given fs_param_is_u16() has "int base = (unsigned long)p->data;", 
shouldn't the comment also mention ",_octal,_hex}/spec_enum"?
Or should the function get slightly modified to always use a base of 10?
Or 0 with auto detection as for fs_param_is_u64()?

>  		u64		uint_64;	/* For spec_u64 */
>  		kuid_t		uid;
> @@ -119,6 +121,7 @@ static inline bool fs_validate_description(const char *name,
>  #define fsparam_flag_no(NAME, OPT) \
>  			__fsparam(NULL, NAME, OPT, fs_param_neg_with_no, NULL)
>  #define fsparam_bool(NAME, OPT)	__fsparam(fs_param_is_bool, NAME, OPT, 0, NULL)
> +#define fsparam_u16(NAME, OPT)	__fsparam(fs_param_is_u16, NAME, OPT, 0, NULL)
>  #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
>  #define fsparam_u32oct(NAME, OPT) \
>  			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

