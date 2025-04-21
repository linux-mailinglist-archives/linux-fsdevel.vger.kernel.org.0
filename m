Return-Path: <linux-fsdevel+bounces-46794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C2A9503D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98DB7A63E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47182641E6;
	Mon, 21 Apr 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="mkt3Vpo1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhfXmEPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CC35961
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235214; cv=none; b=D3HHd1EwcxKaVKZsKW6JVMwO+6YgUsrHhXfk4x15DXGcTMBEolcHEi53inkKHO42G0l5c2Z1HEzTbQ/THSMyLfF68GNFDGBw2iSoiWayZP0uSCLzhG8dsQcY4ZvK8/vTk2UPEohSxX2Ye6HN0jZimhwpjvWyKqke88RVs+x62a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235214; c=relaxed/simple;
	bh=miCbCaA1b+eXGBuW6yWNtG2XjfgKBwx1cXM8/g0d0ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMhXM80yg5HDqGDykrq7KqXZLbSDzXm+OAhRrpcFpATSHE2ZhW3MWUVyqkoeHosjsZnhw/cxtbmagzxMVczyb68S+DMZq63qYvK642WxTiPGDhwukpN9aF6Jx1NRJJuYEVsVLvXWWVhGg+Gvqh1b2bENfkoU4O/TSRWms0QmfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=mkt3Vpo1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhfXmEPY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 21031138008D;
	Mon, 21 Apr 2025 07:33:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 21 Apr 2025 07:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745235210;
	 x=1745321610; bh=hfrTE0U4FvOXra7sJrb7PfYUgy6f7wjVO8H31gl2i9s=; b=
	mkt3Vpo1th12Z2yaMUELXoCAzUuo7HDqIpnp0568HA4926TNCMz6UaCVz9npXxbo
	5QYSbROXSHwgUhtoUEPgKFyPf1n5yzI1EvPFsuLBlXMaXHiFzQrZTQibdnyp+MGU
	0o3DVDmKeISAXmRaQpP8x9vkvEdy3vU62swBNEL2M/gMJF7w+I8Eg1rmgCV+HhLu
	u54XG5hJ27KjNStLxA0oIBYuB9crjZUWzwgxEdWvIa3gRi/sEQn53YiRVH1LpBQa
	5GTDsxe6xV3oqZvD71d82lgAELc3ij+DE40HNRvVyZ1lcwIKamw968Vpt4txgWgJ
	ye+M7WFkxrhksDbBwtH87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745235210; x=
	1745321610; bh=hfrTE0U4FvOXra7sJrb7PfYUgy6f7wjVO8H31gl2i9s=; b=R
	hfXmEPY2Pj4YuIr3NPfGjiTwTsWGgSxD3njmwpnza3dc0OeX5BwqR+FcSAggqXhJ
	Bb8gvPqPrce67g4buP9CIQSmDH6iRIkCo6/Q+Sxp3F7OUrnNn0YylBu3ver2VAQv
	vl6jQR4IH+MrXAPD4NLCHa2LnKlFhKd0N1Ioj38tDOjR2opHyc7WDvJdT/toyhwc
	MGmsplxCj+XSnwYQ3ImpoXy+y4Zh/AqcyP3Bxx1T1j+6jNFgMj4FZlB59JpeTTOr
	RKM/Z1YVhvR7qZfMMMbHAUVQigTrWSVGx0B+6B3k65HfUWmJyHn7MrtbAddYng4z
	WboIc88xOseh6FYJtULdA==
X-ME-Sender: <xms:CS0GaBGm-g0QiJdTw6MvdoLUg1F8UoTBxDykenxJ2Ycq7tIJlmC9EA>
    <xme:CS0GaGUXjkKNY-drhw2ujrs6cQ07H2u071KKfg_9rR64iLWhTuJzcvq5ccCMO8ITp
    9ngMVkgkzJwWFhT>
X-ME-Received: <xmr:CS0GaDIMAR4Vboahb3zHbJFtHsQcA_vfFMOWXVwCmF4IubA9TNkDhNpceiiq6vBF0aR8uC3WKR_VaLXAsF0ijVCxLA_DJLqxyPzsvSX19UNdPOh7sgOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:CS0GaHGJYpYZOZzuqEbJnV_5gDJfQJxTN1xBUTyZ8zxu8H_mNG_S_w>
    <xmx:CS0GaHXP330tTP2B8y39mNfq1uVW_TlGHkVV-8yuwlxnXvGxoqqZJQ>
    <xmx:CS0GaCMPceNLWzKajVtDIjs0iuLpFdNhAWPj5UEIvGUAyIy-qZ_EBA>
    <xmx:CS0GaG11nit0tvh6WDe2vaZEiXIgKjYmWAsZcA4zU2u54tICiHawSQ>
    <xmx:Ci0GaLDPqoYUxMrxqunr4qbefdX9ZEAHuAQTDrSFeTXB-82-0hPmrmUf>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 07:33:28 -0400 (EDT)
Message-ID: <4db92307-4e56-4b61-944a-80272119f11f@fastmail.fm>
Date: Mon, 21 Apr 2025 13:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: optimize struct fuse_conn fields
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250418210617.734152-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250418210617.734152-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/18/25 23:06, Joanne Koong wrote:
> Use a bitfield for tracking initialized, blocked, aborted, and io_uring
> state of the fuse connection. Track connected state using a bool instead
> of an unsigned.
> 
> On a 64-bit system, this shaves off 16 bytes from the size of struct
> fuse_conn.
> 
> No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/fuse_i.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b54f4f57789f..6aecada8aadd 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -690,24 +690,24 @@ struct fuse_conn {
>  	 * active_background, bg_queue, blocked */
>  	spinlock_t bg_lock;
>  
> -	/** Flag indicating that INIT reply has been received. Allocating
> -	 * any fuse request will be suspended until the flag is set */
> -	int initialized;
> -
> -	/** Flag indicating if connection is blocked.  This will be
> -	    the case before the INIT reply is received, and if there
> -	    are too many outstading backgrounds requests */
> -	int blocked;
> -
>  	/** waitq for blocked connection */
>  	wait_queue_head_t blocked_waitq;
>  
>  	/** Connection established, cleared on umount, connection
>  	    abort and device release */
> -	unsigned connected;
> +	bool connected;
> +
> +	/** Flag indicating that INIT reply has been received. Allocating
> +	 * any fuse request will be suspended until the flag is set */
> +	int initialized:1;
> +
> +	/** Flag indicating if connection is blocked.  This will be
> +	    the case before the INIT reply is received, and if there
> +	    are too many outstanding backgrounds requests */
> +	int blocked:1;
>  
>  	/** Connection aborted via sysfs */
> -	bool aborted;
> +	bool aborted:1;
>  
>  	/** Connection failed (version mismatch).  Cannot race with
>  	    setting other bitfields since it is only set once in INIT
> @@ -896,7 +896,7 @@ struct fuse_conn {
>  	unsigned int no_link:1;
>  
>  	/* Use io_uring for communication */
> -	unsigned int io_uring;
> +	unsigned int io_uring:1;

Ah yes, I forgotten to change it. There had been io-uring patch versions
that were using READ_ONCE and then I forgot to update it.



Reviewed-by: Bernd Schubert <bschubert@ddn.com>

