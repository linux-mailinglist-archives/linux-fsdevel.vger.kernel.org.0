Return-Path: <linux-fsdevel+bounces-43346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71485A549E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043FB1674AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3508020A5D5;
	Thu,  6 Mar 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="e0cWLcGf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4eGzXEAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B3204C28;
	Thu,  6 Mar 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261569; cv=none; b=l/j6tPvqIFZ2O7IylI5sDJpZuJuDMYwGGGy2R+vajXnDNI7XokeDuBflOpga+FSwpOEXcTR6mGjoKuSczAMe8CYqllGA6Gs+HgfRb8LU4+1A4Xpd6XUaLW2QtsmMY2pJ4L8dH3Z9aOltUdC1ePt6V8gBcF/K0w+c04jMgxIu1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261569; c=relaxed/simple;
	bh=fikk4OfJh8Re4s/tiwifNRI4+LYO1cbB0cZq/iJcH98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzpAs9wql3DGJHHs2cYOxYbIU4FoV8bI08Jd94U14CeypoO1MkoT5w06kD21dlYBUl3zzEJuI4r/lg+KSy879BAF7+H09lDZiRNnfcWFXVdol0sgZlj8KppTElyvEQ2Yx6P1EQ2hy9FX94JG26kaXccfy+gh5ysn8VNJSGK2+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=e0cWLcGf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4eGzXEAi; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0FDE11400A5;
	Thu,  6 Mar 2025 06:46:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 06:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741261562;
	 x=1741347962; bh=AwuIB9uYaByewoRdOFYSOUa6qNsebM75Udoj90U9UyE=; b=
	e0cWLcGfap7y1aixSDuw1NCqvGLFJT9Id3/NrZ7ZuLecWwvgpzLtQrtTyw2oGW05
	yqFnR06UE5EKxO5Khxsfu+qPznruujwwa5Jyx9RQkb77G2TZ/3ni8UlY52voqJmN
	ByC9D03rLcx0aPCZ/CZ7VERAZNNiFIqqiozKz4kXv2G95Z+xB0v0Iwc0YRHvjzTG
	oG6RS3g9svr+9VJ66TFCj8gqIuwqilojaKnUFp40bCiDErMvx5ZOiJOTLIBsfhzX
	GTRkm086GYzcPRnKCI4uM9u9lhHvFHN37UDburonqHMTBePEJkefOGB72C2dIpnu
	YpX2p6L1j7vDY6cezT3/sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741261562; x=
	1741347962; bh=AwuIB9uYaByewoRdOFYSOUa6qNsebM75Udoj90U9UyE=; b=4
	eGzXEAiw0n4QhXiU6jmXG0x/u/ZgJbZ3z0avKgnLb2I2X+keTSbg0P27TgGfKV8E
	7MlJnT9RBZvCXDWBEfKOIIemps+Rv3prtB05N3Psa07Gof/2TRhLocIHaPJRV/wu
	kcX5dT9FUhzIN3TWGPMlqGsczeNZPEu7EFhh+t+eknjfFwPCQcDCHNAVWZn1bEDq
	4dcYR/WszSYSGYYw6e+kvZjR40JhDOp9axG7ZP3lhCoqYGlgScWVvruStYidQmIM
	neTvzaDYnV4A2fTOtxIuO0R4LuxHwv5LK/3u4iZF6M+lijSO4p5GFmi5hiT3dqVq
	FK5ZqS/Uob4Hl37YmM45w==
X-ME-Sender: <xms:-YrJZz5AhsFappgCSBYCXMBBZuwcIWDLo_Q_kba0MDaHKeNWg4LnfA>
    <xme:-YrJZ44q_0hzv1qj8UrEELtCP5yyR5Bc7tCfGQpyNn0Aya91ucDLDr8NJ6ztJgLgJ
    2syOXCjc-BwofQt>
X-ME-Received: <xmr:-YrJZ6cKKatnvNzXvUvAAV13Ljn5tP69MUckZR-eGaiuGv0jfrD0mr1qxuTDAStZM4mzQviWZBHBJE4TvSb8hqvg2kjkDwOV2QOaWpp_iXTOPgpWMbCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdel
    ffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhishesih
    hgrghlihgrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdrtghomh
X-ME-Proxy: <xmx:-YrJZ0L_4qgQkerP7KX4a9c0aUEct_rHS5Mao0EONqjlkrpi0vDeEw>
    <xmx:-YrJZ3K_F6NR7NND4DsTVChHwNsRBE9NtZvZNVbJBJUi1PH0kDQvYQ>
    <xmx:-YrJZ9yLG6Fcuv2QuYtmvzu_ZYzPp0f-mfM0_nEeEp25MPzS3llgUg>
    <xmx:-YrJZzLGz4HDHNdv05Xg_HGDsSb9N4N2qL8LHkdKPAV7of-fg0IsWw>
    <xmx:-orJZ9js3wKYjuBuf_d4rpqXb9KrEIkMGbtFPDQk3W4OAWPKej06NqRS>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 06:46:00 -0500 (EST)
Message-ID: <1dc28f9d-c453-42f4-8edb-1d5c8084d576@bsbernd.com>
Date: Thu, 6 Mar 2025 12:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never
 initialized
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250306111218.13734-1-luis@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250306111218.13734-1-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/25 12:12, Luis Henriques wrote:
> When mounting a user-space filesystem using io_uring, the initialization
> of the rings is done separately in the server side.  If for some reason
> (e.g. a server bug) this step is not performed it will be impossible to
> unmount the filesystem if there are already requests waiting.
> 
> This issue is easily reproduced with the libfuse passthrough_ll example,
> if the queue depth is set to '0' and a request is queued before trying to
> unmount the filesystem.  When trying to force the unmount, fuse_abort_conn()
> will try to wake up all tasks waiting in fc->blocked_waitq, but because the
> rings were never initialized, fuse_uring_ready() will never return 'true'.
> 
> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7edceecedfa5..2fe565e9b403 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
>  static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
>  {
>  	return !fc->initialized || (for_background && fc->blocked) ||
> -	       (fc->io_uring && !fuse_uring_ready(fc));
> +	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
>  }
>  
>  static void fuse_drop_waiting(struct fuse_conn *fc)
> 

Oh yes, I had missed that.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>


