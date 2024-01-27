Return-Path: <linux-fsdevel+bounces-9204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506783ED5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808181F24127
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6525629;
	Sat, 27 Jan 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="DXtfnz6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Esw1HZNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B31E51D
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362732; cv=none; b=d9hR7EAm9g933vxRjsC+3RvNyn2N2CGM9LtjRz3p9eDPkNVv43GH+msCk/CxdofF1aXDDk9c00OKd/xfMTp3qDRTaDR2PIKLNPAcGxVP2CS21zqxnMiLhdWgoOU7EINyIJxVuA1FA7PyESBfI8/YD9KdkXFEb1WPD3BRPL5oHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362732; c=relaxed/simple;
	bh=ky2lRUrTGRNYa4yCRJJddsAUXy05JAhJ0+hyRr2VC1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFCsJYSfTwB0ydKmTowrpLbY6p8o6NKZDKLk08AHXIIjvv97xpAZKXF60wcEAGbsk7PVoJDwI4HHnH7q5NSCY+dQxUQzpXDP2CrsFhqj/tvXjzB7kXrXmkYD6Tf86AYj66EnkgNhobsKqE4/J+6WyTwC7FspjNA6/ceV0gHFL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=DXtfnz6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Esw1HZNX; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id D5D0B3200A09;
	Sat, 27 Jan 2024 08:38:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 27 Jan 2024 08:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706362728;
	 x=1706449128; bh=kJjinYe7BosFPSLNJHaurNdOVV2FFr5PJX1UFOMYAfY=; b=
	DXtfnz6rmq73F3r+/8BlbaSQhxp/hvUvdc71l22h5bBEag5EQX5vHiIpr++cuJSP
	K6SENNHucyyLBtxHkTjhc6zUCobBa58pMsRc81FVir0LakP5dnYHxWS3urjqLwzp
	wFN0ZkVoU5pykYZeeMq9M30aWyCc++0p5HlqRkTgPo6ZbL5dyb91phtgnKNiLbsH
	D3B++FuuSdi4FZcsE6+SnOeMiCLVBx13Y2DHKKmx+/UwoUUKsD1+saLPxrj4juZ/
	7FPRbZU69Jyjrfui1kh4Y+5rkET8fIHuOoT3WtDm0Uj/j4T6rM6CmxLjd7RmgkvB
	NFHUTjm19WDo39CzmjoNUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706362728; x=
	1706449128; bh=kJjinYe7BosFPSLNJHaurNdOVV2FFr5PJX1UFOMYAfY=; b=E
	sw1HZNX4Dps2Ai+RSZa7MSuM7luoM66C/EkNUqC62wZfmlZsLfO1Y1RNomb/N1TN
	5olmHOOS26blW/HI7thA7xq98cZIw/jQlp1lxrwmwBaKvbCBR7b0xeniNgA+q3Hv
	tEGBWisvEQtt02AnbwtXCCf9VxmnXIZc4WaZ4lRNy22HImNiJsKAzokJbOO7mY4o
	lwIOUgtD8hw9W0va+QInyiUxxk+NKWyTL2t1vMPDKObj7oNIWWO5vmhcJzpQyt4X
	EgAFsK3SkDWnhg+s9XBFUAYgH2Sdbg770gKJd4P3K39zzjtBtcHKiWmlim2OFnHV
	7M7/6Xauo4gtoIJ0ZUo3Q==
X-ME-Sender: <xms:Zwe1ZWohwwrf0fo3l8cyxi8yg8Fis9y3Vj2XpaUgh5pcC32vldB98g>
    <xme:Zwe1ZUqSyOYGhpEJ2NaFtjXzCkYlGI3Z-ntC-TIOMm8MZqugsx27rPTYvkaOlB9QG
    r4pcZcr9hCdWJfH>
X-ME-Received: <xmr:Zwe1ZbMdbXbHLkN3D6er5Cub0Io1-fLYRZ-pJ7dCZEgk3sRC8jE2dimKy_Ffc4qkxpouv1fCaTZ5kzGIP7FdRacC_JAFbXHpUCqaeuoMcpYC5-85yowQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhf
    fgvdeltddugfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstg
    hhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:Zwe1ZV7jC1V9tgXdCbQ1X0UoZn2qLdrA-NDdLkCzAfQTNjGlNGoH9Q>
    <xmx:Zwe1ZV4HQj80QxMrDwy7hFyUXSTn4FGq1ylqNpD5wg4iwVsvJTvkZA>
    <xmx:Zwe1ZVgzShFL31eNMk5j2-vP7-tpev7SpzsYktmZsPC9sVYf1kjGrw>
    <xmx:aAe1ZSu1Q9EubOxqUC_qnTw8dJ6rFRmK3Guu1Fo8wocgqEEWP6lFCQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 08:38:46 -0500 (EST)
Message-ID: <337d7dea-d65a-4076-9bac-23d6b3613e53@fastmail.fm>
Date: Sat, 27 Jan 2024 14:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
Content-Language: en-US, de-DE, fr
To: Yuan Yao <yuanyaogoog@chromium.org>, bschubert@ddn.com
Cc: brauner@kernel.org, dsingh@ddn.com, hbirthelmer@ddn.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, viro@zeniv.linux.org.uk
References: <20231023183035.11035-3-bschubert@ddn.com>
 <20240123084030.873139-1-yuanyaogoog@chromium.org>
 <20240123084030.873139-2-yuanyaogoog@chromium.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20240123084030.873139-2-yuanyaogoog@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 09:40, Yuan Yao wrote:
> With current implementation, when fuse server replies a negative
> d_entry, _fuse_atomic_open() function will return ENOENT error. This
> behaviour will prevent using kernel's negative d_entry. The original
> fuse_create_open() function will get negative d_entry by fuse_lookup().
> And the finish_no_open() will be called with that negative d_entry.
> 
> This patch fixes the problem by adding a check for the case that
> negative d_entry is returned by fuse server. Atomic open will update the
> d_entry's timeout and call finish_no_open(). This change makes negative
> d_entry be used in kernel.
> 
> Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
> ---
>   fs/fuse/dir.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4ae89f428243..11b3193c3902 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -843,8 +843,15 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>   		goto free_and_fallback;
>   	}
>   
> -	if (!err && !outentry.nodeid)
> +	if (!err && !outentry.nodeid) {
> +		if (outentry.entry_valid) {
> +			inode = NULL;
> +			d_splice_alias(inode, entry);
> +			fuse_change_entry_timeout(entry, &outentry);
> +			goto free_and_no_open;
> +		}
>   		err = -ENOENT;
> +	}
>   
>   	if (err)
>   		goto out_free_ff;
> @@ -991,6 +998,10 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>   	kfree(forget);
>   fallback:
>   	return fuse_create_open(dir, entry, file, flags, mode);
> +free_and_no_open:
> +	fuse_file_free(ff);
> +	kfree(forget);
> +	return finish_no_open(file, entry);
>   }
>   
>   static int fuse_atomic_open(struct inode *dir, struct dentry *entry,


Thank you and sorry for my late reply! Yeah definitely makes sense, I'm 
just going add it in and will also add a small comment. And as I said, I 
first need to address all the issues Al had found - still didn't have 
time for it.


Thanks,
Bernd

