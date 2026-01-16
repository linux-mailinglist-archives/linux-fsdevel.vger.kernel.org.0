Return-Path: <linux-fsdevel+bounces-74162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E9D333CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A15B30B097F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3A33A708;
	Fri, 16 Jan 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+/R4RVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A323183C;
	Fri, 16 Jan 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577546; cv=none; b=UDnHUMTZ2gMyXJ/FeKiMK1TwkcGyqWyWu2z3aEvq1924Rv4wnRKaDYC1QWMrHgpcALz+CbJCZ27EpNCTUKYmPowSiJi5jo7M1wlbqDAbScX5NtAZO6F84KLZWujNVC/xkO6ZrdT9BzokiS3PQtvuBunCns7xW4Y+JH9ex7ekT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577546; c=relaxed/simple;
	bh=gcKMj5PehvGiOwOFRYzFYKU8jyYoYUrTRMxsdsAQtME=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WWJ89fq22C1UcXcq9F/wJHteOFGzdA9GazU+u8uU4crXuGEsKlyo9iARI2fNW91VynceM89+FKEKLyXZ9Nz9Y9PLLsqiv76mkUmXATDObd6OomeZlHMHkrSVbsEWm79gG6Nal2H6b63V2jU/ukUSSOSfMCUId83rCGjV6XZzGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+/R4RVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2357C19425;
	Fri, 16 Jan 2026 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768577546;
	bh=gcKMj5PehvGiOwOFRYzFYKU8jyYoYUrTRMxsdsAQtME=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=V+/R4RVzJYl+oqGv47qKKZC823xpY5QpeN4flMI1ay3EdeFrRaNsdLnXCijbOZ1HQ
	 bLwy0dRRiVn18JZ45khGu2RQ/PWbr1R/XJPuDYN/bsnZBfoZrglfwbJqJvJ0qpMOjQ
	 wBLTVC1tYwg4Bd9Je/QL6xH47dita2YXLJgiwyDDHkEkr5j9D9yAB/3EYxNn0R+SWG
	 5IwP8l5OWfnuaoRWcvAu+tYmHbR95bJMIUdttQpkCsPH8GuE04mJJ8B+jIWH0uEYRc
	 oB69c4K4ecRTxSqZAisKkzXwKIzqNIY7cVw5meyXXKI1gTGcazBLz92G4xU4gLWbKz
	 JYqUmapWc24sw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D6771F40069;
	Fri, 16 Jan 2026 10:32:24 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 10:32:24 -0500
X-ME-Sender: <xms:CFpqab0R1TaIh56OD-sAIwLJkOaq5tjzra02bhvxxQdFzRRTpNuEHQ>
    <xme:CFpqaU4vc-KkbFJFphEzYWbWEu-edOlzNxarfG3yk13r2WRd_lfuRnf-HPbONlqk7
    ptFqp0xYVsGiuMEvdPjoHsRo_zBkZpau1eqHhqIjr_LwzomaQHlPuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelfedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CFpqaS_7rfvHdltdd1KBInYvXtSPRHVZs8nX0W6hFpAjLVX4KWFmVA>
    <xmx:CFpqaeiXRYf9KrMy9ndVQHqiHcYS1VY6Zb8dIcboQB5rbu8R3RXIWA>
    <xmx:CFpqaTZXTSF0gs4_bpg7bZzoQfthI1i8Qhm5hD9PFFAR9vMu5zAJOg>
    <xmx:CFpqaT_jvhauOnO1rSGbCKaawEIu-Uik7brJn8jQUwskQNTQtiiP3g>
    <xmx:CFpqaVPyD5biere05GAFEXbgVpXpq_8cMItkmANBaGJ343Bd59BYQ_7E>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AF1F0780075; Fri, 16 Jan 2026 10:32:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvP9FmYbHXHN
Date: Fri, 16 Jan 2026 10:31:28 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <15993494-ddd8-4656-8815-2693ee3b7fb3@app.fastmail.com>
In-Reply-To: 
 <c8735411d66dd7db9c5abb2b5a1c4d9b98ea174a.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c8735411d66dd7db9c5abb2b5a1c4d9b98ea174a.1768573690.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 1/4] nfsd: Convert export flags to use BIT() macro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
> Simplify these defines for consistency, readability, and clarity.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfsd/nfsctl.c                 |  2 +-
>  include/uapi/linux/nfsd/export.h | 38 ++++++++++++++++----------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 30caefb2522f..8ccc65bb09fd 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -169,7 +169,7 @@ static const struct file_operations 
> exports_nfsd_operations = {
> 
>  static int export_features_show(struct seq_file *m, void *v)
>  {
> -	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
> +	seq_printf(m, "0x%lx 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>  	return 0;
>  }
> 
> diff --git a/include/uapi/linux/nfsd/export.h 
> b/include/uapi/linux/nfsd/export.h
> index a73ca3703abb..4e712bb02322 100644
> --- a/include/uapi/linux/nfsd/export.h
> +++ b/include/uapi/linux/nfsd/export.h
> @@ -26,22 +26,22 @@
>   * Please update the expflags[] array in fs/nfsd/export.c when adding
>   * a new flag.
>   */
> -#define NFSEXP_READONLY		0x0001
> -#define NFSEXP_INSECURE_PORT	0x0002
> -#define NFSEXP_ROOTSQUASH	0x0004
> -#define NFSEXP_ALLSQUASH	0x0008
> -#define NFSEXP_ASYNC		0x0010
> -#define NFSEXP_GATHERED_WRITES	0x0020
> -#define NFSEXP_NOREADDIRPLUS    0x0040
> -#define NFSEXP_SECURITY_LABEL	0x0080
> -/* 0x100 currently unused */
> -#define NFSEXP_NOHIDE		0x0200
> -#define NFSEXP_NOSUBTREECHECK	0x0400
> -#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - 
> just trust */
> -#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients 
> expect; no longer supported */
> -#define NFSEXP_FSID		0x2000
> -#define	NFSEXP_CROSSMOUNT	0x4000
> -#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use 
> */
> +#define NFSEXP_READONLY			BIT(0)
> +#define NFSEXP_INSECURE_PORT	BIT(1)
> +#define NFSEXP_ROOTSQUASH		BIT(2)
> +#define NFSEXP_ALLSQUASH		BIT(3)
> +#define NFSEXP_ASYNC			BIT(4)
> +#define NFSEXP_GATHERED_WRITES	BIT(5)
> +#define NFSEXP_NOREADDIRPLUS    BIT(6)
> +#define NFSEXP_SECURITY_LABEL	BIT(7)
> +/* BIT(8) currently unused */
> +#define NFSEXP_NOHIDE			BIT(9)
> +#define NFSEXP_NOSUBTREECHECK	BIT(10)
> +#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - 
> just trust */
> +#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients 
> expect; no longer supported */
> +#define NFSEXP_FSID				BIT(13)
> +#define NFSEXP_CROSSMOUNT		BIT(14)
> +#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related 
> use */
>  /*
>   * The NFSEXP_V4ROOT flag causes the kernel to give access only to 
> NFSv4
>   * clients, and only to the single directory that is the root of the
> @@ -51,11 +51,11 @@
>   * pseudofilesystem, which provides access only to paths leading to 
> each
>   * exported filesystem.
>   */
> -#define	NFSEXP_V4ROOT		0x10000
> -#define NFSEXP_PNFS		0x20000
> +#define NFSEXP_V4ROOT			BIT(16)
> +#define NFSEXP_PNFS				BIT(17)
> 
>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
> -#define NFSEXP_ALLFLAGS		0x3FEFF
> +#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
> 
>  /* The flags that may vary depending on security flavor: */
>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
> -- 
> 2.50.1

This might constitute a breaking user space API change. BIT() is
a kernel convention. What defines BIT() for user space consumers
of this header?


-- 
Chuck Lever

