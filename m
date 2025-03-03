Return-Path: <linux-fsdevel+bounces-42941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7CA4C5BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7357A2F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD421481D;
	Mon,  3 Mar 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="jU1ck6Ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLxJw+Dx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FD2135B8
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016974; cv=none; b=MwuHVokzh4RVvkUworYzwpzltI0obCjv8hpTUkUleDkbzqmrUAFBzBjtwEnI+KCHoA0vl53Pq7pZngZrgTXmKRg1t2zH5J+5Mc8rMslCgDus4oPfeNBtOVCJdzxivceFVhlvl1xuvJUwSh0RUddZQmUCk0/2mqwvG3DWPyVMKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016974; c=relaxed/simple;
	bh=ub+LM6XpH2GxFEwLz+uLd5J7rpmh5qOFTz2cabjJ5uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkKKebrIxcLDikrUhWNvPv4dWQYdbWQRNjkmZq7PxIt3iqogxAPJRdpIg6xLzPn/cY3DMaTvZENpSnu6ZIcVvbtL1dLLp0Fqlw4U7sfQ1oSwC1PxuIUnubSQmrI2dIbGCtvWa5AlpzewcRBUnzMUF9Z23judnU5JWViPLqL8PHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=jU1ck6Ch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLxJw+Dx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC35D1140170;
	Mon,  3 Mar 2025 10:49:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 10:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741016970; x=1741103370; bh=KEq85t+puG
	esTWoiVP+1p0SkXb9ibKYKLeiNO/Xhv4g=; b=jU1ck6Ch/cCvrS3SL3hNZHhm5f
	N+UBTijaAjooDoCC/6pkmJbgn75Ck+1/bisC7lvIILsGepsApIvyA8rCscn+sIUE
	rNSLBoecwSR5986R1YqvOnjb77QsbYQ6UqRGe26+cp91xGEdp4UyK6dVz2hftPce
	3RawoDj5zWKW6X5GLwDOsW3JTzL+O0yVeAQI/ulTgeUvj3yU3qDOTLx8KDAvITgJ
	oWLs2S5vSdqYm0G24e14KUcWaG1MYUvf41j8RYLXcFBLJr5R5ipIyLFkhM5kSxrC
	yWQDvf5L/+xxpfjwUoGYzck6QyhupchsFfF3ymIJUln08Xr8C83KfO+/wKYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741016970; x=1741103370; bh=KEq85t+puGesTWoiVP+1p0SkXb9ibKYKLei
	NO/Xhv4g=; b=nLxJw+DxlJ25laWnWQLz2eTgR/WJjBg4BwJplXYwu2EDMMCbkY9
	fU9DX6DyuMRv2hOK4VBg87854GgWH1CqYOAdVGleAts4fYcjI8RseVhivqSmc2xp
	UDbZfrVQB0WU3+t2tImYcjbgYStICH/dFVR4SbUmVan7NIqWE8cL8jGaiwXHlRcC
	+VRwW4tC2Ap42DiP3PxuEWM4jkB5mGzvAClbg2avxKAYtAKBUm4+/oZqzEaZdSri
	4CCNvq0o5fX69dkvTHLq2C4X/5eQAbHOgCtsdgGH4EBuGBNAR6fHln+Yd986MZZQ
	7Brl2V8UxueY++VdwQaCCiB8ZlxMQh6NNuQ==
X-ME-Sender: <xms:is_FZ0lQ8XYFjQlGo-eHkhAyce0GHIBhng-RKCj_3psDuF2kjFKvag>
    <xme:is_FZz3hIgyJeW1l1SvKkfTD4UteT2onyuc0oopS0In2TTa2f-LGs-OBXnF8_y9uF
    LJhkcoD1750d44WbIw>
X-ME-Received: <xmr:is_FZyoN0wLKmwtb0Rlg-ogRLz_7CoExObnJyrRDomwPPeSOxIFqgPBgYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvhihlvghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedvhedvtddthfefhfdtgfelheefgefgudejueevkedu
    veekvdegjedttdefgfelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:is_FZwnDS6UJODxKrbChnF9nIFI3JzbArKs9AEvxvozn17M5quYg4g>
    <xmx:is_FZy3lC0mnHV-VQbp2VTfP4iDDqQEV6hEm-UBLoDWIIblSlwAdRg>
    <xmx:is_FZ3ueWZZeCUSCQ-Kb0bMH9dyUrDaAxd87a0HCJi5M1NPlPFUMcg>
    <xmx:is_FZ-WNjL6OT4_QdB6VP0Gbxej5CQYxMvh6RYkyNd3yXTwEHwRQ2Q>
    <xmx:is_FZ3w4az1WjjzjJ1AYCZ9JT_QuofDKktJ1kEyArMfNaJtgQ0UHDLqV>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 10:49:30 -0500 (EST)
Date: Mon, 3 Mar 2025 09:49:28 -0600
From: Tyler Hicks <code@tyhicks.com>
To: Eric Sandeen <sandeen@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ecryptfs: remove NULL remount_fs from super_operations
Message-ID: <Z8XPiCF4SkjY5uw0@redbud>
References: <5dc2eb45-7126-4777-a7f9-29d02dff443f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc2eb45-7126-4777-a7f9-29d02dff443f@redhat.com>

On 2025-02-28 08:31:17, Eric Sandeen wrote:
> This got missed during the mount API conversion. This makes no functional
> difference, but after we convert the last filesystem, we'll want to remove
> the remount_fs op from super_operations altogether. So let's just get this
> out of the way now.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Acked-by: Tyler Hicks <code@tyhicks.com>

Thanks for picking it up, Christian.

Tyler

> ---
> 
> diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
> index 0b1c878317ab..e7b7f426fecf 100644
> --- a/fs/ecryptfs/super.c
> +++ b/fs/ecryptfs/super.c
> @@ -172,7 +172,6 @@ const struct super_operations ecryptfs_sops = {
>  	.destroy_inode = ecryptfs_destroy_inode,
>  	.free_inode = ecryptfs_free_inode,
>  	.statfs = ecryptfs_statfs,
> -	.remount_fs = NULL,
>  	.evict_inode = ecryptfs_evict_inode,
>  	.show_options = ecryptfs_show_options
>  };
> 

