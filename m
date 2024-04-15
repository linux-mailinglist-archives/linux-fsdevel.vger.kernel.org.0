Return-Path: <linux-fsdevel+bounces-16926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7A8A4F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738ED1C2121B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0071B4B;
	Mon, 15 Apr 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="KNzP4DSs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRYI3TGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2771743
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185332; cv=none; b=N0uPUOliS22HrJBfavZVxh0qh5pet3i8SMcK+XiGtoSpyNQFRCF24mdcHC+u7mBV5aqTg2GyDKti4vhbftjyv11MpovbFijXK2ssRz7kO1EmhVGv2wFaGe0DKV3HMLTCETCXxk9cKqb57yfnCd1cko9GITmEF+lB+SEO+oGUaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185332; c=relaxed/simple;
	bh=reBOG7X1R/RttQuCJA2phGigVcV5DEidIUPY22Ke3Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur+HU5PONMnO0sGCaND4HwDVZlTmHM0iVl8kgDQ4YTatNKA/yHaHmPoSG2rxeua1a87mrpwmy41KodR0+Mvxbq+l1oL7xz/vhW8pAJlcFyUUcrrw/7hSWRDzQuT79o/3WQbD+k3hQrLCvnoHbMPYpbXoTm8HxSg9DVmPCIIbn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=KNzP4DSs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRYI3TGy; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 029D81C000F5;
	Mon, 15 Apr 2024 08:48:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Apr 2024 08:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1713185329;
	 x=1713271729; bh=6Ry3JixC3Gozc7wA7Nc14oDY3ZuSM+SEoc/wI9/w8DE=; b=
	KNzP4DSsykkjVHxlDtsPGyiSdLmKY1CUWP3qno5jUUWuDZBZUNroQ/90nXDvEfqc
	aKCS5eyujREhnQmKBa/6gxuxyvDtDrUD1d+CLVjmC6wmVuL4A1huKfoZZv5htSO1
	YIvo9ENjmuI2izf1kMqoUxNI9kpuJHT7BpTOTL1aqpnGIjSjCuCMJRp3auA7TcMG
	0W+fxyotHiLHrrkrsbbgmXA4YPJX3d7qwDOaHPNe56vrYm3uUsB0NJ2byXVydjrl
	zTPugqw1v7H1vIAd8iYPr/IhAckRKrYoZ9n1TP4ihr7N5C1NMK9hiRGTn5a/xKPw
	/87p308vy19urhXU81fa8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713185329; x=
	1713271729; bh=6Ry3JixC3Gozc7wA7Nc14oDY3ZuSM+SEoc/wI9/w8DE=; b=B
	RYI3TGyu9K4iq/MV31+u713dIfzVdwiAqn6StDMKIn0s2V/sYLvrOov55XzsYf0I
	+uYsrlge2FILbaMBqzfFXfs31hn+129KgbXkay2qVEordwp3UmRhyR3k++55FQJk
	/0u96qRXdMyxnPEWbozJdiEzy9SjqkJyJIarrpjuGr8GWMWDdnYwZJ/5Au8TWTKA
	Vp7RJDWExZC8KUU+dFR/3nu1uxG6WbT9lBmLo/LOzPoPHg2IX5DEaJ+LRXyF/Zpp
	32SpW3YSWbrDVdfOVrjTe/FU61Y3285lk2ZK1xEe5JweQGG1t54PHJtE/93bMciZ
	9Qgnn2hSsDHfJY2EkJ1Ew==
X-ME-Sender: <xms:MSIdZjBEpVr4wQ-4M7a4rPcsJrZD0M-PBXFpjRlasC4fk604qH8_tQ>
    <xme:MSIdZphE19fdMv791Y10lyT4SIM_o_kQIAjr2qpqrcNeqhKeTfJYgVRQFWq6JVe3U
    wPp5cVcB_c3Jn95>
X-ME-Received: <xmr:MSIdZukcyVFF-kt3yMQoOebaYlTiTyqAgA0IL6ahzDlzyjjjlLTQlTD1tLP3ZNHeNq7wj1AMNqfr0YTc9XzeADOiSdouSLMXOyOmm4VtVqUirYOIIjTy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:MSIdZlwRSnxjLT9-Zq9Iki2FpMlLXZQDpxsjSlLXkHO51HJPhn09Zw>
    <xmx:MSIdZoTQNXxbA3fLBhkZ75V5my0jBiWYxnn3krzAP8opeKi_1JTzyw>
    <xmx:MSIdZob81m5D3jwT_f8TEbgBerSgdE-jbp-NP2mzLLfslbUQE45OIw>
    <xmx:MSIdZpR6j8oSMoS1ZhmU59dKb1LiND1Ljr0nXXGKXtoI88iblo_UNA>
    <xmx:MSIdZucslG_vHx30P9znPrqa-SmmCwmAQ4Wonaj2IXt1XevCPTYn9io0>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 08:48:48 -0400 (EDT)
Message-ID: <ee855d85-ca4a-4dfd-a763-03c6c6d8fff5@fastmail.fm>
Date: Mon, 15 Apr 2024 14:48:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Convert fuse_writepage_locked to take a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
References: <20240228182940.1404651-1-willy@infradead.org>
 <20240228182940.1404651-2-willy@infradead.org>
 <13cbb507-45b5-48fb-a696-cb43ad14a5b2@fastmail.fm>
 <Zhqr8Kj0rraBCJDY@casper.infradead.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <Zhqr8Kj0rraBCJDY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/13/24 17:59, Matthew Wilcox wrote:
> On Sat, Apr 13, 2024 at 01:28:31PM +0200, Bernd Schubert wrote:
>> On 2/28/24 19:29, Matthew Wilcox (Oracle) wrote:
>>> The one remaining caller of fuse_writepage_locked() already has a folio,
>>> so convert this function entirely.  Saves a few calls to compound_head()
>>> but no attempt is made to support large folios in this patch.
>>
>> sorry for late review. The part I'm totally confused with (already
>> without this patch), why is this handling a single page only and not the
>> entire folio? Is it guaranteed that the folio has a single page only?
> 
> Hi Bernd,
> 
> , filesystems have to tell the VFS that they support large folios before
> they'll see a large folio.  That's a call to mapping_set_large_folios()
> today, although there's proposals to make that more granular.
> 
> If there's interest in supporting large folios in FUSE, I'm happy to
> help, but my primary motivation is sorting out struct page, not fixing
> individual filesystems.

Thank you Matthew! Especially for your quick reply on a Saturday!

I had totally missed mapping_set_large_folios. I will look into
converting fuse to large folios once I get to performance optimizations
for our file system. For now I was just going through all recent commits
and had already wondered about the single page folio before.


Thanks again,
Bernd

