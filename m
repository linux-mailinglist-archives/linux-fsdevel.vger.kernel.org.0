Return-Path: <linux-fsdevel+bounces-54695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833DB02457
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5851E17C2D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65FD2F2363;
	Fri, 11 Jul 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Hcrvk/tO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kraO2Ads"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAC1DC994;
	Fri, 11 Jul 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261147; cv=none; b=ikQKEvQCyg58N9w6hKMu/APsjfTFR+OQDzB77Ys98XwDlZsFXhJ8FphpzSqkTYLh3eNpU0vOZa6DP51zx0meSFPVpnvcjaPe73HTZ1mlNJu2Qh6t0odXqWrnDaGHIl9NADD/7rwh1tVKuoynMQHHC+YJyAh7GtLcz5r4CTS+ghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261147; c=relaxed/simple;
	bh=rxuC3DYfIihkMGRWid0/95b5xRXInoMsXxFl07v//OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExL64pnF9SzjMyJNJ1f3AFGwQham8pPoBkxy7D4E8qBKRe2dpiTWNZh02J/y5bnwVSSwZj8ApoQcbBEqRafbi7AjeLShw4V9ROZk1iqyjHCd2cPX7KoYKB1mX9IOeBn+3dehpG3tE0qKu3/67/Szb/8Kvu4otUL/lJoT4OsS1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Hcrvk/tO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kraO2Ads; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F03E3EC01C0;
	Fri, 11 Jul 2025 15:12:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 11 Jul 2025 15:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752261144;
	 x=1752347544; bh=zjPK/FCP+kKnHEo09SHf0P02m4TzE5mzjvDr/scCHWE=; b=
	Hcrvk/tObcZPqit56EEG7bt1yaBnClyJSoAvCpZoAYbieeSFnupGPfwciDyWKtw0
	caPmx2BxUQsjhat1i0nq/0MZbXqcR8FkOmmMfcc8LJ+3cNEgn4CP1p8nWQoNYzAM
	tC7S/OZS4mx+vUtRxmxx/D3/DH4h/GleU3lmm2l5Ymczatml/oRX63NNvsimdKw7
	y7tEv4ZPu7NRuGacbHMO4r0A3pT4TJodcq8TYip65nnTSuzcHYPXUPkqD2uJbvAW
	8TRk/zjoSryRVDyWtrHRgBfwpcxMxABktjBe6c46xhwa/VH6Z6upb3mw1gSbmgRk
	i6d6EtIs7Ncqt2PiPtohOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752261144; x=
	1752347544; bh=zjPK/FCP+kKnHEo09SHf0P02m4TzE5mzjvDr/scCHWE=; b=k
	raO2AdsVKm1MeYxgO7YtlyFZRVU+kcyvnSsUQii6O8U3jiSuOjQzTiZDYuIb5V8T
	fL1V9y6Er/2Xaa55/NvX5zct9D1YYdUVA+HEDV+/1Dl5Erm/5xev1Ok5uBF4LVv0
	DM4YFbFUS7d1AoQXQFAKMow6yF3teWQk5YDJ7wJRzHlZ6rv18kWRbKpDyTFu/Nj+
	IwEz7UTuKlqLi+dqfc3zuz0mxs+Re7VRp8MIiDLc2a1OAwRxsIjezX+JTkuElnKy
	h6dmVcQNLvfwlisuxPRu97wYSOp/E2QWldpxQzjTnz18z6dKHy3Q/QBTQqS30JXD
	6KiA5XYXTMabXKU1SPxJw==
X-ME-Sender: <xms:GGJxaHxIZWSBRdHsnb9oUMin2BF4OlP0Y6TmNSgEi070IWuWinkGvw>
    <xme:GGJxaJtSKOKsWVQw6UxqrzQPeJFtK94R9GS5LMFrbsN4N1JKLh06SFBfGnjcIgSKK
    _Q992yqrXIOsasp244>
X-ME-Received: <xmr:GGJxaI3ssGjftP-F74HppGsJyyV0Zdzx1hQgR2_fkoYjKLacYJwEYY7EJj1BbOaidKsj0QQNyndHBT4_GHXVWSPx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeefvd
    ehleeutdfhlefgvedvgfeklefgleekgedtvdehvdfgtdefieelhfdutefgudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsmhgruggvuh
    hssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhv
    rdhnvghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomh
    dprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:GGJxaJCHx1z3fOj3AOypGPeVgFlHakzY8ExhZvFkEbrZrCfwx7aHJw>
    <xmx:GGJxaOC37QLg5Yl1VZufakZrla87x7P1kXjXTZIIMJtOKAPVtYiwlA>
    <xmx:GGJxaCmV1C0LGG9ahAQMJjTF8omLT0B-wUrH4TaIVK7nYKENk1FnUQ>
    <xmx:GGJxaGik_J6qd4ZqzNXeQzqNteBHCzsrp69Qht_cyvwg1m4kgPZ_ow>
    <xmx:GGJxaKF0xvGSis46pfXaF9HN6qVfwJLQDvXuUwgFweFCXgii_nSGOKVL>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 15:12:22 -0400 (EDT)
Message-ID: <a50cfa74-1858-48b7-be27-89006001f39f@maowtm.org>
Date: Fri, 11 Jul 2025 20:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] fs/9p: Add ability to identify inode by path for
 non-.L
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org
References: <cover.1743971855.git.m@maowtm.org>
 <90f6c4c492821407bf0659e5fd16e94db8bf5143.1743971855.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <90f6c4c492821407bf0659e5fd16e94db8bf5143.1743971855.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/25 21:43, Tingmao Wang wrote:
> [...]
> -static int v9fs_set_inode(struct inode *inode,  void *data)
> +static int v9fs_set_inode(struct inode *inode, void *data)
>  {
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_wstat *st = (struct p9_wstat *)data;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
> +	struct iget_data *idata = data;
> +	struct p9_wstat *st = idata->st;
> +	struct dentry *dentry = idata->dentry;
>  
>  	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
> +	if (v9fs_inode_ident_path(v9ses)) {
> +		if (dentry) {
> +			v9inode->path = make_ino_path(dentry);
> +			if (!v9inode->path)
> +				return -ENOMEM;
> +		} else {
> +			v9inode->path = NULL;
> +		}
> +	}

Fix v9inode->path uninitialized if inodeident=none, similar to the .L
case:

	if (v9fs_inode_ident_path(v9ses) && dentry) {
		v9inode->path = make_ino_path(dentry);
		if (!v9inode->path)
			return -ENOMEM;
	}

>  	return 0;
>  }
>  
> [...]


