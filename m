Return-Path: <linux-fsdevel+bounces-54694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2534B02455
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB96C1C44FE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC62F3620;
	Fri, 11 Jul 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="TtnBW8U1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQrucWTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF92F198D;
	Fri, 11 Jul 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261120; cv=none; b=Q/5LtB9PN/Tea4YayyCMvNiWYX+i9Ix5Mpy6DpPdnp3V2pw+vvuksXZrwuURC7Gt7H4ecPCRO2IYyqtNI3Kzyke3uibSz8hSHyZMlGfAlPYulYo9j7qCUf4mGJEMOjYSXuRrsRETFuTB+9tjVsUYbCSP7TCXmygs3eE8CmohSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261120; c=relaxed/simple;
	bh=0e8R2PrthrK/SFv9yIf8Vkme9Zi+R6yx2rCbVY7wspI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI0syQc0I4kRJL1LOEA2E7/w79sgluJcbzmgoGOQ3tVIKmjssqf357yp0HewXn7vrLb9EeGc5ntlZmyJuEMMSQRpowKkVw27Tf4DHzLTY+qmdlD1IYtsom0aFcsad4vYa2vasnMR3BXdUoB4/0HK/Qw87rtpt/Frtv7ZReWVOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=TtnBW8U1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oQrucWTv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F7A8EC01D1;
	Fri, 11 Jul 2025 15:11:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Jul 2025 15:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752261117;
	 x=1752347517; bh=n0n44eSEWf2iCFKSmbvT8+ACpGUajgTORpTGpsfY0lg=; b=
	TtnBW8U1z7CC7tDIXo00y82VJ0mq4I1fLgXTys8VrJ5DcBC7fmkfjaxcgUpfBAqO
	DMdmYj+frbjT3PeFdH7nysBecQ+v5QatEsYfjnrx2qy5oMSkyVuK5Ctb9Zh3eltR
	io8vefBvWY0WT7K//vEKwKSH790XKSxHjCtdUgG9Bqhw3auE7mjaMPeYgOGqrl1o
	MmBSnMF0xteB1aSXbRQqO/j6e0B0Nfhg9xndknQVGoPiGA2Eoa42J5nCuNzjhPhd
	0l1BvLelJ/tPBFR06SIAHGBfT4BjC0RHtyYa80JhHHdOePZBN0tvUVIUBXZGMxo3
	j/fZ7OiOVKuQehjD3QOLyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752261117; x=
	1752347517; bh=n0n44eSEWf2iCFKSmbvT8+ACpGUajgTORpTGpsfY0lg=; b=o
	QrucWTv2nMVm/jwADUis9GXiNCPWIJd+zFXhIUyeGNcA/ttgwveF6UuE80t//F2L
	4ofqQBsH4Tzi5CTFUdbl2ndT3jXuuuyHqqHqfynWCk50qmYoa89nZeWd8kun4uVx
	yAu/94dxHIwWjplTzy9JRfQYWGha1vT12OxvyXHJsw3Zc2GMYCOZDNxFFU90ZfHC
	PwUzAbi9kusYk2kZjd93LVDQ4bkBRLcphaFiVDLwOQyPMZmkHRVIERmUHcGQQ+pH
	9tkX4ctLbvFYoOGciXHk370PSeo4n80/N0mNntVQYT8vSoMChMLS8IAy69aCqx0n
	UGLzipi4Yz5nbH2gnauTw==
X-ME-Sender: <xms:_GFxaNejPC9fXiMM8kzItk9yLa_QDVwJFwxH3tJpkB_j7u-dT5UZ5A>
    <xme:_GFxaFr60d2SaBbMrm8Z9X2mgAJ4qrUJwVJ7F0_DhJB9XUOq3TkAvkYz4d-6KAmND
    0uiz_0A4faEet5t0Y4>
X-ME-Received: <xmr:_GFxaODytkLx7nHY9VNGFPSrj-fcita0m_LytsolW2W_vC0tYVRB4aqVAYP1-wPdDLtJWgRNvKWCIxJZa2Ui2zom>
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
X-ME-Proxy: <xmx:_GFxaOfKimlUpyL0IJZF2U99QElfIq_0CrSjA8xiySQJyVf0V7LnJQ>
    <xmx:_GFxaOuNxWZdeh_ryX41j7Swu8rsY5L0XjysS1_Wde20Iy8RPEkqBg>
    <xmx:_GFxaNiZLHeAdskdTArEIHGqVxm7ZUAzeN8aYhdDOyVFZNIErjWY9g>
    <xmx:_GFxaOvc_wB6vca580yMfd3cKxEF3NiZrBCRFLINDi7QTBMuy29Wfg>
    <xmx:_WFxaLyCLE6OP08URBGBQF13u6es-we_w3YOgesej-T5OiwuBJfpqTsg>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 15:11:55 -0400 (EDT)
Message-ID: <2f39b26b-5c1a-438c-8433-e4af494e8be7@maowtm.org>
Date: Fri, 11 Jul 2025 20:11:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for
 .L
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
 <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/25 21:43, Tingmao Wang wrote:
> [...]
>  
> +struct iget_data {
> +	struct p9_stat_dotl *st;
> +	struct dentry *dentry;
> +};
> +
>  static int v9fs_test_inode_dotl(struct inode *inode, void *data)
>  {
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
> +	struct p9_stat_dotl *st = ((struct iget_data *)data)->st;
> +	struct dentry *dentry = ((struct iget_data *)data)->dentry;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
>  
>  	/* don't match inode of different type */
>  	if (inode_wrong_type(inode, st->st_mode))
> @@ -74,22 +81,74 @@ static int v9fs_test_inode_dotl(struct inode *inode, void *data)
>  
>  	if (v9inode->qid.path != st->qid.path)
>  		return 0;
> +
> +	if (v9fs_inode_ident_path(v9ses)) {
> +		if (!ino_path_compare(v9inode->path, dentry)) {
> +			p9_debug(P9_DEBUG_VFS, "Refusing to reuse inode %p based on path mismatch",
> +				 inode);
> +			return 0;
> +		}
> +	}
>  	return 1;
>  }
>  
>  /* Always get a new inode */>  static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)

Looking back, this function should probably be renamed to something like
"v9fs_test_inode_uncached" since it now no longer "always get a new
inode".

Actually, maybe this should be merged with v9fs_test_inode_dotl - the
behavior is basically the same when inodeident=path is enabled.  Maybe the
approach could be that v9fs always re-use inodes (as long as qid matches,
and when inodeident=path, the path matches as well), but if in uncached
mode, it will also always refresh metadata?  (Basically inodes has to be
re-used, even in uncached mode, for Landlock and Fanotify using inode
marks to work)

Doing so does mean that if one sets inodeident=none, in a pathological
9pfs where different file/dirs have same qids, the inode will mistakenly
be re-used (like before be2ca38253 (Revert "fs/9p: simplify iget to remove
unnecessary paths")), but given that the user has specifically set
inodeident=none (i.e. not the default as proposed in this patch), I wonder
if this is acceptable behaviour?

>  {
> +	struct v9fs_inode *v9inode = V9FS_I(inode);
> +	struct p9_stat_dotl *st = ((struct iget_data *)data)->st;
> +	struct dentry *dentry = ((struct iget_data *)data)->dentry;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
> +
> +	/*
> +	 * Don't reuse inode of different type, even if we have
> +	 * inodeident=path and path matches.
> +	 */
> +	if (inode_wrong_type(inode, st->st_mode))
> +		return 0;
> +
> +	/*
> +	 * We're only getting here if QID2INO stays the same anyway, so
> +	 * mirroring the qid checks in v9fs_test_inode_dotl
> +	 * (but maybe that check is unnecessary anyway? at least on 64bit)
> +	 */
> +
> +	if (v9inode->qid.type != st->qid.type)
> +		return 0;
> +
> +	if (v9inode->qid.path != st->qid.path)
> +		return 0;
> +
> +	if (v9fs_inode_ident_path(v9ses) && dentry && v9inode->path) {
> +		if (ino_path_compare(V9FS_I(inode)->path, dentry)) {
> +			p9_debug(P9_DEBUG_VFS,
> +				 "Reusing inode %p based on path match", inode);
> +			return 1;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
>  {
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
> +	struct iget_data *idata = data;
> +	struct p9_stat_dotl *st = idata->st;
> +	struct dentry *dentry = idata->dentry;
>  
>  	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
>  	inode->i_generation = st->st_gen;
> +	if (v9fs_inode_ident_path(v9ses)) {
> +		if (dentry) {
> +			v9inode->path = make_ino_path(dentry);
> +			if (!v9inode->path)
> +				return -ENOMEM;
> +		} else {
> +			v9inode->path = NULL;
> +		}
> +	}

I realized that this leaves v9inode->path uninitialized if
inodeident=none.  The proper way is

	v9inode->path = NULL;
	if (v9fs_inode_ident_path(v9ses) && dentry) {
		v9inode->path = make_ino_path(dentry);
		if (!v9inode->path)
			return -ENOMEM;
	}

Same change applies for the non-.L version.

>  	return 0;
>  }
>  
> [...]


