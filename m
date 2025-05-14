Return-Path: <linux-fsdevel+bounces-48965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17806AB6CC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2771C3B8944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE827A91E;
	Wed, 14 May 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="QnE1iPjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5mVPAWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0A1F428F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229553; cv=none; b=ZcTuLl0ruXYFVd9E3Sm4yof3h2Vs+Ib82LYoyOShbZOSbERlmY3lzSIDLxU/1SFQP/VRI8mSmdu9UA0aA+hxlXaETFfoie6Xjqlr7lqq4Kj0iyvMUCfvXPIl5/cH+85fZtWm+Xz6NRLNM7DpAz0DU+KNc1j2H2vQXuynM155cx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229553; c=relaxed/simple;
	bh=Z+cjmMMVBPsdVJLGzPDvollu/LvI7Mdc4Ixq+RP8puo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9xfXXum6Ef+1vmqUqOXtJGaAC2lvHM9tGQO75X/1gHoVlCc/L+EM2v0yDQ7yxpljvPtHJ84LxEXjX+TOUZnsZyEN/fDo/mBRrqOUtvp8ljO854RjhAAYyg7SHOR9s2V+AZia6vH2zlk4gvT6jXk6ObZTVaqOuxOTRpLVBGJj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=QnE1iPjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5mVPAWI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73ECB11400FA;
	Wed, 14 May 2025 09:32:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 09:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747229549;
	 x=1747315949; bh=YPwMhKjAhCFPAvnl76Pa2dZR+liQ3hemsxljAIvRN7o=; b=
	QnE1iPjHMKx/25UESW0qF549wkQ5cdCsTGMSJBaP8KqxsEHpIuXZVVfDutxyjhKc
	1Cgw9tMINHqCgzbhKC6seC0OO12InCPE4XEpmHxPHnwjeIj/ZZysxlHyBb6vdL9z
	svzRmJn9a83p5C0vs1UGxU0AuoMdfompSjvPwsS5I5vU9++xXn/V6ufdPZG59nLx
	aL0P2hn6M13yp8eqxGjO/Uja9YAZ/UdUOPF0ihA2rdHro684zkLedHwmcjQLbFAj
	PDueV0RrbWg8T+MCZl6txc0iZ2ZYTAPE3tP1s+YkDAsCv2XXyzvqwGw1isZN/m6J
	mdCFKhQ7znoRJ0nPGLhSqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747229549; x=
	1747315949; bh=YPwMhKjAhCFPAvnl76Pa2dZR+liQ3hemsxljAIvRN7o=; b=f
	5mVPAWI5bqb5fVqsFSvcrUVpMYF5GZAMgT6VdkE9dgXk7/iWWwPD0wsjfzqa0PeH
	XQL2b6252zUARg7jygO6XBUriNbY6IOPCXVFN7nZL2bua8CXaVuYfQeAcpsW8Y4d
	bg1gCQKO1nJrss+SwgSbGJbgDSlEVqOYRBvK4TkTdYdV4dG/jmleHZgKGAP+EW4e
	adEtO0u/SXrB92uDCC3pYOb1QjL8Yn3oOS1CFC87KgrJ19IY/nFBqKWrjZfNjjKW
	qp2ZOqzTJynqzrCfVgW6zwvt2EOePfTQcSrsMwLhr/OVIScDGWyRTks0bmpr249w
	67Oa2NhWrnpDvooZusmzA==
X-ME-Sender: <xms:bJskaKahTnVSQBIiG5g_NfYyik5si2PNYaN-MKFqDjrWCY6RctXwaw>
    <xme:bJskaNYTtNjFeOQHL2_ZbHd1FtRAA0g4E_SLn0FYhbYQpVbCHIDkOD9Nx2W0xw7GF
    hK9uYbA8RgmYFn2>
X-ME-Received: <xmr:bJskaE8OJ-Mj_GbtUhCWhsW8-jiuXT4G5G8BqR5OW_vEscPsbAiE7QVF-ULIpzH8LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdel
    ffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhlihhsoh
    hnrdhkrghrlhhithhskhgrhigrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhk
    lhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhssehrvgguhhgrthdr
    tghomh
X-ME-Proxy: <xmx:bJskaMp9M8YA58xcDa8Vz8GAVbhhD9zuU8Sjyy_QBQD40u4gUU4b9A>
    <xmx:bJskaFrPawVCrcYcPxdFxgyshdMqO-pmG1DrLvikqaJCHAhh-n-ADg>
    <xmx:bJskaKTBEN87JUT9C514JQvni6zhVOfVGoNjYKtR06unvMYL2wfp_Q>
    <xmx:bJskaFpc6TXlwJq3sPfFXgwOisiieNKbomUM2VA6UUUObEB5IWJ4aQ>
    <xmx:bZskaMgarCmMnFem2jN1TmAWesvm01wLB_NOlyUDw6FSwFfltZsOLL_D>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 09:32:28 -0400 (EDT)
Message-ID: <664ccbcb-0c75-4673-9a5d-85ee45f3e2c1@bsbernd.com>
Date: Wed, 14 May 2025 15:32:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, lis@redhat.com
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20250514121415.2116216-1-allison.karlitskaya@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/14/25 14:14, Allison Karlitskaya wrote:
> FILESYSTEM_MAX_STACK_DEPTH is defined privately inside of the kernel,
> but you need to know its value to properly implement fd passthrough on a
> FUSE filesystem.  So far most users have been assuming its current value
> of 2, but there's nothing that says that it won't change.
> 
> Use one of the unused fields in fuse_init_in to add a max_stack_depth
> uint32_t (matching the max_stack_depth uint32_t in fuse_init_out). If
> CONFIG_FUSE_PASSTHROUGH is configured then this is set to the maximum
> value that the kernel will accept for the corresponding field in
> fuse_init_out (ie: FILESYSTEM_MAX_STACK_DEPTH).
> 
> Let's not treat this as an ABI change: this struct is zero-initialized
> and the maximum max_stack_depth is non-zero (and always will be) so
> userspace can easily find out for itself if the value is present in the
> struct or not.
> 
> Signed-off-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
> ---
>   fs/fuse/inode.c           | 4 +++-
>   include/uapi/linux/fuse.h | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index fd48e8d37f2e..46fd37eec9ae 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1497,8 +1497,10 @@ void fuse_send_init(struct fuse_mount *fm)
>   #endif
>   	if (fm->fc->auto_submounts)
>   		flags |= FUSE_SUBMOUNTS;
> -	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH)) {
>   		flags |= FUSE_PASSTHROUGH;
> +		ia->in.max_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
> +	}
>   
>   	/*
>   	 * This is just an information flag for fuse server. No need to check
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5ec43ecbceb7..eb5d77d50176 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -895,7 +895,8 @@ struct fuse_init_in {
>   	uint32_t	max_readahead;
>   	uint32_t	flags;
>   	uint32_t	flags2;
> -	uint32_t	unused[11];
> +	uint32_t	max_stack_depth;

Objections to make this a uint8_t? In fuse_init_out it just had slipped 
through in review. (And I wonder a bit if we should post change it in 
fuse_init_out.


Thanks,
Bernd

