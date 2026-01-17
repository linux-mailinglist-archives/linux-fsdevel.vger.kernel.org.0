Return-Path: <linux-fsdevel+bounces-74279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754EBD38AF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 01:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D093071B99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BF19A2A3;
	Sat, 17 Jan 2026 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YnJO1Jbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WB5kfiuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6AA2C86D;
	Sat, 17 Jan 2026 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768611311; cv=none; b=pnvc1X/r1GiLry8/5wxaxJeFS95D02PK2Gme6C16f8Nin+M9s5JX9MwCcwZONFoCZywkS6bD6+PkW3S7HJXL4L6O/JjwRxwsfnawIFwStQZ+FXhKxKysI5U6yvd84LYIOSUKJyCoFCGKoRWW0n63U6sQEMVM5NHgN7iV1Y1v590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768611311; c=relaxed/simple;
	bh=HLV0sGFwbqTeNex6ECZ3wCNs1IR52xB7CnkTpbC1UNE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s+n8LypP2JgMAgLek1W3EFo6V9B/tYYMtEcgZQAKBV8vnEWQeYPm4EZlMIW44l5jTuIcUeVFejb6WwxNPm+mFCCIig9RsjngS6vbFTU6jgyKveTGeWAjz24D4wUkGmbR/xIhrWFj5km+dw/tx2jrLRa1Q2DKBCCkmwQum+et56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YnJO1Jbm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WB5kfiuH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C55111D000E0;
	Fri, 16 Jan 2026 19:55:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 19:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768611307; x=1768697707; bh=Dbt5J78fOzTv8zW+0XPEHu3xcWqXJ0lx61G
	N7f7npDE=; b=YnJO1JbmgVOl69gDj291zcwaX+3ii9ZBvS4QHY5pDq76/Sq/ky4
	R8Xx7yB+ZbZ4BjZ1AjeEyFPX4zPPnys27dYwQwo00Bb9H841Gmn03ebXgLLOoMOT
	BhNFe8POuykCyFfinRuBQI8wexhlngG2E9YsGc3pVAyGLBJSbRh6EosgB1iePajx
	B4QEHVDi7UvJD+ehWMe7v9bhIwrGFDUPtdxOAOy3lu+3OxtTD+2x128r7IjMC5Xs
	hDnk7iLzJ8Gm1fFpRDhdgyelyJtkwXEZCxG+Xbc7NcebB/RdRr7cuEQWrQxUWEk/
	EaEWWQmvbXkVIix1iZOmgjlL/I+lSSDJo2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768611307; x=
	1768697707; bh=Dbt5J78fOzTv8zW+0XPEHu3xcWqXJ0lx61GN7f7npDE=; b=W
	B5kfiuHXXWor21Jm25f8VssiU0tvpdLETLEGWUgGWqgUBKIrCNQg/pAeCSGDc/8E
	zAnVmy5SRV8qgjEzfzeAdLl/gCms5I2vH0hce+7dAmqPITUwJO4rH5TogV3kyNtQ
	89y2zjSgS0M5fJmtjA2b8DCmhngDcXo6Ftw4Bt9KuVGZJM5KD0tUV17FH3NKWaPn
	m+MlGXnjV/g22gNTVpr2vcDgcD7nD2pUh+mUdBKMwltd/MHYAR3aseldXqNDePrr
	bfuUOwpoEjK7jEGHI5Ht/RcXEFyBAz6YThYaPbwxg+SgyuUHA5NgCabcFZd/CA9z
	orOnESfCwo64Bkfak+MYA==
X-ME-Sender: <xms:691qaWz-zEwtdwOe9g75y13wh8uUR0qhs2FA6-on2aHW-XBizLyDtA>
    <xme:691qaYTTb-xGB6Lvx85UrG0y_Wuzfs6SkPiocnXt6jjZ3nKTQDyhB4LUOYJB18NvG
    Scn7pY_sqsIIQVAKf53PPEraetlpmOCPmC6X0oM83sISAcN>
X-ME-Received: <xmr:691qaTIQFi2KzxcnEz6JE3r_mt9Wy0Dh_4PZi22e7oIjDA0jC-YdQWyo31sjqdd57wjzmLKt9fIALxxIRo4_7chdk1vpWZArLrVYZh48_kVu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:691qafXhexEd0T7yD_7gQsgALBOE6azeHVHdt5sAwLuaOOo-CN5Jpw>
    <xmx:691qaXQVGAwaxSqbqs0u_oXSDeC9KDFwAh896HfxlA7SIBMcLHq0DA>
    <xmx:691qaXDg74oqbDUzqAXGsE7I9nqnhXdGkbOcGkSRqW_AxCVu_BuXDw>
    <xmx:691qaWJzVaqCJMOSz8LQPjC3dHa7f9hCUspqt3OLSJi-c-TZAQwipg>
    <xmx:691qaQHsGLQJiEAyFGIdg_a9Obw_R3xeKsE-Gv_90KeZzxP0m2iGmVVp>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 19:55:04 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 4/4] NFSD: Sign filehandles
In-reply-to: =?utf-8?q?=3C9c9cd6131574a45f2603c9248ba205a79b00fea3=2E1768573?=
 =?utf-8?q?690=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1768573690.git.bcodding@hammerspace.com>, =?utf-8?q?=3C9c?=
 =?utf-8?q?9cd6131574a45f2603c9248ba205a79b00fea3=2E1768573690=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Sat, 17 Jan 2026 11:54:59 +1100
Message-id: <176861129903.16766.18207157056062198907@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>  
> -	if (fileid_type == FILEID_ROOT)
> +	if (fileid_type == FILEID_ROOT) {
>  		dentry = dget(exp->ex_path.dentry);
> -	else {
> +	} else {
> +		/* Root filehandle always unsigned because rpc.mountd has no key */

I don't think this is correct.
rpc.mountd always asks the kernel for a filehandle, so it doesn't need a
key.

However signing the root filehandle would be pointless as the client can
"PUT_ROOTFH" without needing to provide a signature.
So I'm happy with the root not being signed, I'm not happy with the
justification.

NeilBrown

