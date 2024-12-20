Return-Path: <linux-fsdevel+bounces-37923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF319F90FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E2B1888ED7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CC1C232D;
	Fri, 20 Dec 2024 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="sp7QKj8r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5k7jANgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A219C56D;
	Fri, 20 Dec 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693210; cv=none; b=DVTFVOlRo68CvvTT5uiurA17+8f+r7jnGdL9CmpxckQh3seMaRJEA9XXP6Fhl9TBqLPT26LpqqhubC8cxQ1hgVN4l/m8K0nE4+CWNRLQ8R3cfNE2bTpytX3u8abMhg+/d78b/yEClecUXPcYxzN1AoFDOCPqD54IlLKuoRPuHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693210; c=relaxed/simple;
	bh=3X9lPqxVGhRAQRNQ4adCuJVCm8NzuLMZKabw4dgQMpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaHaODB9hVrgcIVOGVu1yu78C0JvRCp9ZEv4QOsomiavU1lJ/ONs58JxieNKZUejDh08fvhaPe53uenv/5JACMCZSzRhvCy6sm2Jp5US0rcnnHL+CeZyV7uW0gsRl897xZIZRnz6YLzq3uPos7eCOUs2o9s359dEsXH3Gxqnon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=sp7QKj8r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5k7jANgN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61B1E114015F;
	Fri, 20 Dec 2024 06:13:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 06:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734693207; x=
	1734779607; bh=fJKmBYZgFq2zq57c43y1QXL1v3pj/4Z2PAfnM7ewV7c=; b=s
	p7QKj8rs/FRJM8ZzNobx0SgEvPOzXaEpfh63ioALfx7kcBYAIxMcEfkNrnHG/8m1
	Bn69PtG+6kYWcnO4E6IEHs6S2JiER3Aq4eHrgRPQzP0xxKKRlWuTYIzBNB8RnAg/
	T9BAzqiAYa5LLsYvropCWSm5Q8INDvZhrIDdtfo/GQmLWAaFbRSqcOiL5AV6DfJN
	7rxueLP2ktFzh6qOE1/M3utCFmiKdMYk6gosN7KVWdZ90YoeOuPRTSYb3IYr+XJv
	DeXFYO5QQZ/vxaj51B+G+Hq6EcCsfaPeLk/wykBfGtE1eiT65zHNQfycyA/g84MD
	+MZRJkFUR3h2Ry+6ZRJwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734693207; x=1734779607; bh=fJKmBYZgFq2zq57c43y1QXL1v3pj/4Z2PAf
	nM7ewV7c=; b=5k7jANgNb+WxPNTUm2JOfJMkebYICsaPYDO76bt7q7MbvCHvZLc
	9eqJp/8U9DZxClXSB8Hn4iGVVp4DCq42St1E/syX0f6AK12nhsMC+oxSSFsJtMKf
	ZocJ5xNPtZCRU0phAKrOvpoI2kVvSabhaX1wHsuULX+ULSrcxCy3HMEji9pHlJFD
	Ymzs3KgZFMOz5lGrUVF/e81lTUY2pW4ho1uFwQ50HMnVjr565bb2dYbu43GnsaDv
	1ACkksCEmP0xsUoDJsxRNs9jEgM5Yc86B6KcO59fc6ZjLL2cNCmSnIzFQ6LIQp8D
	/PA+40/9zcC+vP1z/08VLzyhdaVx5WXATgw==
X-ME-Sender: <xms:V1FlZwZLi5HOJFhUJNf5p-g8LPc6YXrQfcWwqNDyBgRDejt3dyZJMw>
    <xme:V1FlZ7ZxNMOXLY47p3Jiz7xBnDOs5p1iq_lvehyA9Jj7YIEpwvBnxPUxlk0EbNxb9
    POEQo86aLdFw6vpTWI>
X-ME-Received: <xmr:V1FlZ69GptrVYrVWflMBt5ZV4RTEKkRlo7Zzf-xNMwI3gTeHH9ZNUQXtlwIDJzUOmP7P8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdho
    rhhgpdhrtghpthhtoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    hiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhh
    grthdrtghomh
X-ME-Proxy: <xmx:V1FlZ6q-hKz0POwruqfx9F-RPWmoR_UKn9iqXLBgyd8SWYghr-P92A>
    <xmx:V1FlZ7quzSSNIb2yniyQFOohE1mbbGpFNFpJNgxoTJ9IBhcPejtZ7Q>
    <xmx:V1FlZ4Qd7VamKjypfHVBBdacn6GHTlSWlUBRUJUs1PhA_Q4HYEripQ>
    <xmx:V1FlZ7q6xyvS66l1y71IpP-z1AGxr_XLF9LAxswkFXwB-M7MxnBpAQ>
    <xmx:V1FlZ_c4wK8-Po2APIYYrMMjl5hTTXfFtooFYKQDYlrley7_dBoHHUv2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 06:13:24 -0500 (EST)
Date: Fri, 20 Dec 2024 13:13:20 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com
Subject: Re: [PATCH 06/11] mm/truncate: add folio_unmap_invalidate() helper
Message-ID: <e5rdpzjosbzrddun7vx66dlb522pyo35qpcchaw6eywa3ylxkz@noj2be2j7vjl>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-7-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-7-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:20AM -0700, Jens Axboe wrote:
> @@ -629,18 +641,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  				folio_unlock(folio);
>  				continue;
>  			}
> -			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
>  			folio_wait_writeback(folio);

Any particular reason you drop this VM_BUG_ON_FOLIO()?

> -
> -			if (folio_mapped(folio))
> -				unmap_mapping_folio(folio);
> -			BUG_ON(folio_mapped(folio));
> -
> -			ret2 = folio_launder(mapping, folio);
> -			if (ret2 == 0) {
> -				if (!invalidate_complete_folio2(mapping, folio))
> -					ret2 = -EBUSY;
> -			}
> +			ret2 = folio_unmap_invalidate(mapping, folio, GFP_KERNEL);
>  			if (ret2 < 0)
>  				ret = ret2;
>  			folio_unlock(folio);

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

