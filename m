Return-Path: <linux-fsdevel+bounces-76219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNHdKXFAgmlHRQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:37:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC72DDB1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFF6301DE25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8A352942;
	Tue,  3 Feb 2026 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="nHh+xSuC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9O2AQw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE30284895;
	Tue,  3 Feb 2026 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143614; cv=none; b=So+gw+wW9UcLSZQTNptaVSpHPmnzbP3CP5+jarJFiMOfwh3H9HBko4KO5ozNOCaXOZ6TkLXZzqrkEfrB7+5zFra32S5DVOGVOBiRexMXqazlOqakLIfam9IERPqr2iJLtZRDe6WomYTMseFXrV9anyuuUYXaULdq+vpMHYg9G5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143614; c=relaxed/simple;
	bh=naUh7f5512BFwps1fVHy+tQxH77uU0++cTMH/wKA1as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOV47YtILlxIeYuWCvvFQOwvKUx+CtgpASt5cwc3xkqt5srwkYHmbcPvBlV0QS+kdyrNz4+sx+10naAslD841C2XK9sNCDdwTvDd4nlW4d7nYTiODr6RTyfmcIIiMuYyvBSzTV6KTBjHwgRF+cUO5tvoa5pcJXh8zbknmssut/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=nHh+xSuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9O2AQw/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 56BD41D00126;
	Tue,  3 Feb 2026 13:33:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 13:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1770143611;
	 x=1770230011; bh=Cx6B3wqMgm/Ba9Y+x0q+7riqBK0WyPG28g9DRObIDn8=; b=
	nHh+xSuCorg7xgpOVL1EZcD5ham7+6UCmT5D+uS0dDIu7sWhMpQTSz4l1Bxh0Zz+
	nmYD967kN+rDuhpZAkaJGKRVCpmdlSP2j3Kj8bfIDP0VWiEUWRKShzjD2NOrVZSE
	A8FXMGP1drKM7bYOiFJ3XreAl/SeBtzfWIWoFCTMZSKnKG6kRj8qFXZr10xZFfwS
	1/OHDZbWOYTlzZn4Dvq2fO/wm18MMr68c5BMPeeo16K2f1ApiPWsLLxhTQYjXz0u
	u0NdGmKYdDALA75t+1Cp5kZ7l1HXmJWOw9T8nyOH+dg6HrbNhSnXwRoJ6l4g5ix4
	lHD89poCoAHESG8R4pdBOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770143611; x=
	1770230011; bh=Cx6B3wqMgm/Ba9Y+x0q+7riqBK0WyPG28g9DRObIDn8=; b=A
	9O2AQw/3Fc6TodriELGhXpjDXtxFpIdG6oa+2uVVE/2Kkw9uSP7vIBWryf7HsbJD
	VyrhLkdJrCqGOHRp7emfyV3pScadtOOAHal8x0klb+XPQ329rMYW0iYEbraO9UBc
	CkSudpAz5CUAUr4z7rhbi1PU7uPqmV9IuATn5AK8tFxyfn5I6k6jk4pV0PBO4GGs
	UB09nc2K5hNqNAow+thL5DVOPXR2+ILRwILdfBdDibouB+YsLdKbI8C5iupSyH/g
	kwe03IgzGLelnnDnccLCaJRmAxxZpm43c0FccyHP2LH19ks8j0FJpiuaMTpelbxn
	f/9BrWsYGdUG2YVPM06yQ==
X-ME-Sender: <xms:ej-CaYqfHd6jtALvi2q44qPmSOD65lZGXnqtn7c5v8rnnvvJGoIn-w>
    <xme:ej-CaQIUzHSYrBi8eMfu01UTpnYYyxrvRwfco16ilqfKX7v6xG2NptWGNXHEWikUK
    7hC_FA6u_70ut16_DSxhd9XxLC-Zba_N4-ZJIEzAXVN5Bp_52id>
X-ME-Received: <xmr:ej-CadQNzHfgxy3NxsZNbad9qLd_ESgq7JdSNfakfk2sQbXuaVI7LDCfGS70KJ9cyjZTkIXGuUEPxd_IzVP4awrSchd4fYDRKqyL0z96rMPAO2Dj9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeiihhgrnhhgthhirghntghirdduleeljeessgihth
    gvuggrnhgtvgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhu
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopeigihgvhihonhhgjhhisegshihtvggurghntggvrdgtohhm
X-ME-Proxy: <xmx:ej-Cafu0uvHyUM5JZltpjLrDjhKWUrudfn6Sb9HiRc9XoqTqKxwFLg>
    <xmx:ej-CaebYtYLZXUwQtkmrFptcj560lzXRaFPauiVtQSAID-TcpZ-HyA>
    <xmx:ej-CaVE_xWe4Ux1DJB-bHwMfKTI0UfPSPsE5dL194W9ZqV_ReGdfcQ>
    <xmx:ej-CaSwWTktC1V6q9DSFCZw9HhSsjyLjxBlC30R_VbHJ2yVtuM-ntA>
    <xmx:ez-Cadne-0jBRrmTebhJPatVIomAvm6H_Qmy1paqXJIdUdL4kzu-qcms>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 13:33:29 -0500 (EST)
Message-ID: <4f66008e-228f-4e49-a860-314dd82116ad@bsbernd.com>
Date: Tue, 3 Feb 2026 19:33:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: send forget req when lookup outarg is invalid
To: Zhang Tianci <zhangtianci.1997@bytedance.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>
References: <20260202120023.74357-1-zhangtianci.1997@bytedance.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260202120023.74357-1-zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-76219-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDC72DDB1C
X-Rspamd-Action: no action



On 2/2/26 13:00, Zhang Tianci wrote:
> We shall send forget request if lookup/create/open success but returned
> outarg.attr is invalid, because FUSEdaemon had increase the lookup count
> 
> Reported-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> ---
>  fs/fuse/dir.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4b6b3d2758ff2..92a10fe2c4825 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -578,8 +578,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
>  		goto out_put_forget;
>  
>  	err = -EIO;
> -	if (fuse_invalid_attr(&outarg->attr))
> +	if (fuse_invalid_attr(&outarg->attr)) {
> +		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
>  		goto out_put_forget;

goto out?


> +	}
>  	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
>  		pr_warn_once("root generation should be zero\n");
>  		outarg->generation = 0;
> @@ -879,9 +881,13 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out_free_ff;
>  
>  	err = -EIO;
> -	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
> -	    fuse_invalid_attr(&outentry.attr))
> +	if (invalid_nodeid(outentry.nodeid))
> +		goto out_free_ff;
> +
> +	if (!S_ISREG(outentry.attr.mode) || fuse_invalid_attr(&outentry.attr)) {
> +		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
>  		goto out_free_ff;

goto out_err? fuse_sync_release()?

> +	}
>  
>  	ff->fh = outopenp->fh;
>  	ff->nodeid = outentry.nodeid;
> @@ -1007,11 +1013,13 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
>  		goto out_put_forget_req;
>  
>  	err = -EIO;
> -	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
> +	if (invalid_nodeid(outarg.nodeid))
>  		goto out_put_forget_req;
>  
> -	if ((outarg.attr.mode ^ mode) & S_IFMT)
> +	if (fuse_invalid_attr(&outarg.attr) || ((outarg.attr.mode ^ mode) & S_IFMT)) {
> +		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
>  		goto out_put_forget_req;

Same here. Might make sense to add a new goto target.

> +	}
>  
>  	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
>  			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);



Thanks,
Bernd

