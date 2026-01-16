Return-Path: <linux-fsdevel+bounces-74181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC5D33800
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44F7311CF4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2980394474;
	Fri, 16 Jan 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGPOT19X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435261E7C34
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580846; cv=none; b=EJ9r4emQ2lc1AEuSLVL4+BLIukDp/KrtoMpo2mApZZIDtFxzLISl0RysKc7Y/Sve1BKCPCiMM8s2EumXBNahwRPARp6Knb68y4q9JbthEheX8nuMZmxamHROlj0teNloxYj9uflW9Ypw9sWkGwA0aakDlcERKPz3tjr76oeZ8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580846; c=relaxed/simple;
	bh=AL6Giw38F2WPJ/EkNqVNcsYBG8zOQZ5DGnyd9MVyZWA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Iq3vOwnf5MQyCPT6zzM4HLEkSLuMC+YhaLaN/hUV36Sevb8VybexXZt02js+VbBw17J5VyRYYJz4PkybiEniMo92v4tJbqNGRV6FhHphmO0OKZ/yPoZUBIY3mTWUpSv32WaTrJfYT9VoiYOyLgTc6tDQFxXVjtVth9uMhrWsUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGPOT19X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46DC116C6;
	Fri, 16 Jan 2026 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768580845;
	bh=AL6Giw38F2WPJ/EkNqVNcsYBG8zOQZ5DGnyd9MVyZWA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nGPOT19XcOyAX7o2K95ZBZwx32RNQClc0dMiYJfUnoKkjEFHuQ5dR8dPQWo7zK9E0
	 6H1OfOoBS0J597a/YXlF2VuIC19SG6tGFU82mdUT8FAUUWi4bJKrOjNTONqMdhaesw
	 qBnMULr8VrbvPJ2G47ySiwM762dq7g8Cne/knJg99ssoZ0+s2TthXutOHIhxp3i/9+
	 Y0kBG93KJA0mk3ncgFrrj/imIazAspVBnXLcE+c6Esmpe8Wtjq/LxU6Qkyy6dcDo+M
	 DtntfpmENjs/Q4JaOecuTe3zhscJvcKi/eVCcM1+wDgAbfLacPNQy1YYDuOAY4mGk/
	 OQ4NZ7AuxajJw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6BA72F4008A;
	Fri, 16 Jan 2026 11:27:24 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 11:27:24 -0500
X-ME-Sender: <xms:7GZqaXuh3VOeTjhS5bAsZhCI309xf5mHXVxwVYgQKEGLtc-f86-kow>
    <xme:7GZqaTQXZTdq0xH7b7z3BOTnt_Nw7ZCAfJTkv66XhUS5WySByyaI69yQLr08gFuqt
    FcgN6h35wI2G42Y58Kr2HUZgwUykUqN0gt501rUWQASie4pvM3GzfTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:7GZqad2pb4r8xmBjttwkgKjIRZbSkgc9cYiOG8GEuhABrUGJpiqKbQ>
    <xmx:7GZqaf5LFT9wMpkUcvn381y-AcMpAjZZN5JuPRe-IcLZ0k5dJZMRDg>
    <xmx:7GZqaZTI0BjgH6JFTc6_gpMPaj4PEtjsFoPs1wB13wnF16yRXfypzw>
    <xmx:7GZqaUWcOJjtF2j1vRVNmCO5WWYkGuUO9GqyzMpJes_ZqGYGtK29YQ>
    <xmx:7GZqaeEdp9iWUfw8FQoHN11zzZpR11Cacrgc6lHV2eS2Dc2XiHbW2Xnm>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 44B69780070; Fri, 16 Jan 2026 11:27:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ad7T_HfoJT77
Date: Fri, 16 Jan 2026 11:26:44 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <69621716-f4f2-481e-b0af-0339f21bb139@app.fastmail.com>
In-Reply-To: 
 <455770c55ed3500a65a0d5d30133f5f23515a1cc.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <455770c55ed3500a65a0d5d30133f5f23515a1cc.1768573690.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 3/4] NFSD/export: Add sign_fh export option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
> Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
> NFSD uses this signal to append a MAC onto filehandles for that export.

Same comment on missing "why" and the use of a Link: tag

Also, let's see some motivation for re-ordering the export flag
table.


> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfsd/export.c                 | 5 +++--
>  include/uapi/linux/nfsd/export.h | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 2a1499f2ad19..19c7a91c5373 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1349,13 +1349,14 @@ static struct flags {
>  	{ NFSEXP_ASYNC, {"async", "sync"}},
>  	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
>  	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
> +	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
> +	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
>  	{ NFSEXP_NOHIDE, {"nohide", ""}},
> -	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>  	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
>  	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
> +	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>  	{ NFSEXP_V4ROOT, {"v4root", ""}},
>  	{ NFSEXP_PNFS, {"pnfs", ""}},
> -	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>  	{ 0, {"", ""}}
>  };
> 
> diff --git a/include/uapi/linux/nfsd/export.h 
> b/include/uapi/linux/nfsd/export.h
> index 4e712bb02322..6a73955fa5ba 100644
> --- a/include/uapi/linux/nfsd/export.h
> +++ b/include/uapi/linux/nfsd/export.h
> @@ -34,7 +34,7 @@
>  #define NFSEXP_GATHERED_WRITES	BIT(5)
>  #define NFSEXP_NOREADDIRPLUS    BIT(6)
>  #define NFSEXP_SECURITY_LABEL	BIT(7)
> -/* BIT(8) currently unused */
> +#define NFSEXP_SIGN_FH			BIT(8)
>  #define NFSEXP_NOHIDE			BIT(9)
>  #define NFSEXP_NOSUBTREECHECK	BIT(10)
>  #define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - 
> just trust */
> @@ -55,7 +55,7 @@
>  #define NFSEXP_PNFS				BIT(17)
> 
>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
> -#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
> +#define NFSEXP_ALLFLAGS			BIT(18) - 1
> 
>  /* The flags that may vary depending on security flavor: */
>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
> -- 
> 2.50.1

-- 
Chuck Lever

