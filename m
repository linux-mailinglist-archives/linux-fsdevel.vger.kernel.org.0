Return-Path: <linux-fsdevel+bounces-50371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45540ACB90E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D022E188A398
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDD2236F8;
	Mon,  2 Jun 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="YCpnVtE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qemG5lsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E31ACEAF;
	Mon,  2 Jun 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879458; cv=none; b=F1MEc6/z7QEQI+cR5ZdiGko3CIZlkx2T+jeQ81CRNnw8j46hmqCPowqjtestzE0SXMT3yOw32H4kB7cA/SezwiIp9TL1OtB9sYyUb/LOG1HJoG1YJxE3RI6grzHZFSN1riy4AYOT8p1Z2xNleK1Y9Q2Fq2pscgrh6XQ5koiP97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879458; c=relaxed/simple;
	bh=Q9CM5k4oJ/nmKWsQeroSA28ODbk+exz6kaRb+r2x7qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL/CtIMPpxwBgaNCyZhBLRDdcXOp5QQqPq6wey6jv49KVdZLG3BpzuXX57lGthoXdYgnncpE2GqRYmdPUBdM9XcBbk6/iiGVqnNnrwnSbJmy+hv2bRNFzTVP+NFkG+ZHt59psBeXDRHW1u0zeJBntX/lRRuy9MNOer9zYww4khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=YCpnVtE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qemG5lsW; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id BFAAC2005B9;
	Mon,  2 Jun 2025 11:50:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Jun 2025 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748879454;
	 x=1748886654; bh=ECtcKLbK8c4DaaUNIeCZvRoLrnqb0sjqKj+TVBnd5MM=; b=
	YCpnVtE0/pyuTPAo2dUvlNHyIRQp7CHCmumKiV4wfwZrMpKynIqCRMi+p1/fH5ki
	dj4E9tYR3TXOZPU5t4o4uq231s9oha8SLHh8CQyqQyBALR8a/A2n+Vx+H7X+Q9Sn
	4ViHCvQ+jDpY1ADZJhYZOd0rga8bV2PNb5l8i5cQHJI++ZlV7jX97e503FVyTCD7
	j9a5w/cvUwsafKwtV/zrt1Q3kf750UNmYz8ITYWJf+FB1ExoeN4skydEd3q7rxoR
	feKziDyh97pABpZ5fLlQXcFoXsgxnfaICi7zMZ2D8toOxbS61HHSS6p8FLxbe4J6
	MhejaeOuGfov8wiSRSgi0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748879454; x=
	1748886654; bh=ECtcKLbK8c4DaaUNIeCZvRoLrnqb0sjqKj+TVBnd5MM=; b=q
	emG5lsW68M9FqVhhIEhFON2CaL0suvIwrG82ESHJpVIu1h3F/i191l9hV+Dbzq2K
	6XbF2zYr9jTBC1UrwkB3ellb0/A+EYiudo0Eb/FvWwMOlm5klcdWq7LCWxNije/t
	mxfhG+dmqTcPiclnja7pOoXEAWSEZbgBHjFyfwNoMVSgyHOQYgQmOOTE4O+oZgSC
	laHY3LCBhpMnCsw39vPQujbi3SoZggk0SN27jw1FE2mQRTc2OH+q6fTfh9ZFVEEw
	PFsDIa8JF1LBia8YhzqwxFRv9h09aCTenlxMHU+Kw1W4v5MBfwjJBsYThMYAC0if
	jZoJMt5/e30D8q85LL4lQ==
X-ME-Sender: <xms:Xcg9aHIhY2nO5lH8xSqkRB0qRpNVxH7F9H8X35iKjKkKv9e4592r1w>
    <xme:Xcg9aLLFT-gsWHFts7phYKRLeyQKosLvuUeIxaQZ_Xex-ABQF9U31yE_HRiPWWPcW
    -nVoJiQ67Rdu_Fb>
X-ME-Received: <xmr:Xcg9aPtwDSmii5shQTEwaj3Hk_CD7B7Ab-NIrviAtjZQLJG7zOCUJoOst52df_3RcRkZAE_dehwWs0C34G-dT629jehro0BVCMfkBvgMgZFmAoHsjy29>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkedtjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuc
    eosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnhephefhjeeu
    jeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuveduueegnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggv
    rhhnugdrtghomhdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehkuhhnuggrnhdrkhhumhgr
    rhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehjrggvghgvuhhksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghgrh
    huvghnsggrsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Xcg9aAYJgqQmz_0i6NtyVbZeSTGQGdJbmubSjYWHEVPRSrWWEFEe6A>
    <xmx:Xcg9aOb_RKHyzMZjYao8mke_FVbcL-v2Df80QDBAD9sHg1hMl_H62g>
    <xmx:Xcg9aEA1OIXT30KKLzhLz1yXcjGGIsyU3yFQA4fZuvUdfeXXw9_nOg>
    <xmx:Xcg9aMa9Y0JhTXQUDvr_vzbW0j29L6GR1gk9r4Y-9wRdu1Vgoir90A>
    <xmx:Xsg9aFsYPtxDkjvPEIFtUlbaHsrqiDCTwy0xjaUHsIsFVgwYTdTJ-5lT>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:50:50 -0400 (EDT)
Message-ID: <99f79383-479e-4df1-9650-61fa3c600171@bsbernd.com>
Date: Mon, 2 Jun 2025 17:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] fuse: add support for multiple writeback contexts
 in fuse
To: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
 trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
 amir73il@gmail.com, axboe@kernel.dk, ritesh.list@gmail.com,
 djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
 da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, Joanne Koong <joannelkoong@gmail.com>
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
 <CGME20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea@epcas5p4.samsung.com>
 <20250529111504.89912-11-kundan.kumar@samsung.com>
 <20250602142157.GC21996@lst.de>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250602142157.GC21996@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/25 16:21, Christoph Hellwig wrote:
>>  static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
>>  {
>> -	struct backing_dev_info *bdi = inode_to_bdi(inode);
>> +	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
>>  
>> -	dec_wb_stat(&bdi->wb_ctx_arr[0]->wb, WB_WRITEBACK);
>> +	dec_wb_stat(&bdi_wb_ctx->wb, WB_WRITEBACK);
>>  	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
>> -	wb_writeout_inc(&bdi->wb_ctx_arr[0]->wb);
>> +	wb_writeout_inc(&bdi_wb_ctx->wb);
>>  }
> 
> There's nothing fuse-specific here except that nothing but fuse uses
> NR_WRITEBACK_TEMP.  Can we try to move this into the core first so that
> the patches don't have to touch file system code?
> 
>> -	inc_wb_stat(&inode_to_bdi(inode)->wb_ctx_arr[0]->wb, WB_WRITEBACK);
>> +	inc_wb_stat(&bdi_wb_ctx->wb, WB_WRITEBACK);
>>  	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
> 
> Same here.  On pattern is that fuse and nfs both touch the node stat
> and the web stat, and having a common helper doing both would probably
> also be very helpful.
> 
> 

Note that Miklos' PR for 6.16 removes NR_WRITEBACK_TEMP through
patches from Joanne, i.e. only 

dec_wb_stat(&bdi->wb, WB_WRITEBACK);

is left over.


Thanks,
Bernd

