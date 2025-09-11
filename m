Return-Path: <linux-fsdevel+bounces-60983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECAB53F06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 01:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230901C24E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 23:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BF82F5328;
	Thu, 11 Sep 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eTgmkfYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFxinI8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3405156F45;
	Thu, 11 Sep 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632831; cv=none; b=YHu0ESGmbaV/1ke9mhGKFcCewjyPXfBrjn4E8EZQ54SzU/AwDhTYGt66Nt3F0dlO4Jk9p3TLbJHZI2SnrVOPN9NxHk4AN1k7ZjPsJBYjazF6voirqjOSnDw4T7hv9jv7TxxdX85F12bjbGWRMBlkts1ivXRHRXmiK/AUL0c0byY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632831; c=relaxed/simple;
	bh=L/CC5PB/WDUGIpDRa6XS5CxyC+16IinvkD2by2YsX1s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mPTGZO7sdtQ6BaDnmxyToHlvh/LrtFCeTGOScFjPr4v0ErcLPiGSCUIEJQvqVl7xJcNVkX64T/qtpna24KilyZbFQDdcyfFqim4xrj+BO5q8cm/xVMKgi0/EnwlAHbYNDv3Oxxnu1OrcNwHgk6bKfcTwyjpu8f+TKp2l+wseiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eTgmkfYc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFxinI8P; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4B0114003EB;
	Thu, 11 Sep 2025 19:20:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Sep 2025 19:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757632828; x=1757719228; bh=95RnDNWVInCD+CQpxhoLEm5Qb+SCmpzq6Nn
	d6FPeMPM=; b=eTgmkfYcTSmoJcbG9Kr0MzLpIr0glR57+BikfiKfP9/zl/KPY86
	uBNjUconTL2KVRSVl3/gnM1gv195Zy/tFjKYiEOLV4y8vK8A9iDevn8pDNX48txT
	rwXwFb8pLBiALxMoQYHMoi/5shYqayJB1umV5Y9Z+k1m1+Q4hbdiy2IoZHJ70a3F
	dKhMviFUk9i4ouA0GPSULQLaNbGqj8Dv3gbsg3O96Nk24b4xDVPAbPlPuTDNIQUJ
	z+4Oy8GOV1Rmbo2FWWNc0Kb45owBQOemJhh5zK2T9ygEK8TwfjlJ9MPNxnk45+5f
	xUF8Otj7MbnrNLIZCFxhtLKj3geQUlAMqGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757632828; x=
	1757719228; bh=95RnDNWVInCD+CQpxhoLEm5Qb+SCmpzq6Nnd6FPeMPM=; b=X
	FxinI8PhCMOEgI6Ahg92gGPTbbn55a83t7jRGDTvwZMaL/r91kLMP/MZPBIBmlyP
	x1BTAnHZEeIrCJ59eQFTVgrCCH/wQfdy9WTF9e1vUhJW7NQ1Qd4VWE7kmVm67QrQ
	6wCEnLIhQDeiz11mX+SncAWLrELm9kgbBipWonLzmzC/7LKGimhpw4yQuEILJpHt
	fi1szh05VlDAi6s0s2KiJ+gnKPWFlcs8KsdGU62BL2tSQAXvGfqrfQQ+hkpC87WK
	XcP7oLISuPnxNKOf0oxlqManfyZbuy5JsneqPzHlemn4p6V23fpmmNcseCBmI/Ff
	/ipSZTZ08F21B8Jo0OQeA==
X-ME-Sender: <xms:PFnDaBmJgoXQWV9VFUwbT2BETOJDg2qO0qlNwp3glf65e0vnPz5CmQ>
    <xme:PFnDaIVo39M_mmMtDjmIzGbn014q2_rx5aOnAtKrlkYfSSO-_FHIUl1tTETu9e4vo
    DKcmYMBWfsoEA>
X-ME-Received: <xmr:PFnDaOEoRCTCqiNZbkeSYCrSUJOsOTmVVGg3EsAmXn8O8R8aiWYeMmmtSRNxGzzsl1A71vNRcsG4TMjoMGAlXYKbJcp4Ib5NtTxeo7k0HSso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghfhrvfevufgjfhffkfesthejredttddtjeenucfhrhhomhepfdfpvghilheu
    rhhofihnfdcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeetieelgfekgfeigfegleejtddthedvjeettedvgfegheekkeeiuefhtdfggffgveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilh
    gssehofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PFnDaMdKQbC119F7mOL3y2C2ZacSCIRZziuXp--d6LhhXr8EtvFazA>
    <xmx:PFnDaHL6azr-mcAmSOumzCukDRrLLmOPQhtbNsPq5ECXLcBtJtu2Mw>
    <xmx:PFnDaJFWTfag18ifO1fJMcMwYRXDBL8ZHZEREgjldUfeTx3jSdPzBA>
    <xmx:PFnDaCBj0d0-H5RC2viS5m_kW0yzbOkF0DQzwDNaSALz6krUjaxtFQ>
    <xmx:PFnDaOUXTyMAEIYPilLpuBpj0m57GmFU1a1me5EUYJ9lKesFMla4I6My>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 19:20:26 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
Reply-To: neil@brown.name
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc:
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org
Subject:
 Re: [PATCH 4/5] nfsdfs_create_files(): switch to simple_start_creating()
In-reply-to: <20250911224628.1591565-4-viro@zeniv.linux.org.uk>
References: <>, <20250911224628.1591565-4-viro@zeniv.linux.org.uk>
Date: Fri, 12 Sep 2025 09:20:25 +1000
Message-id: <175763282518.1430411.16686769143755274607@noble.neil.brown.name>

>  		inode->i_private = ncl;
> -		d_add(dentry, inode);
> +		d_instantiate(dentry, inode);
>  		fsnotify_create(dir, dentry);
>  		if (fdentries)
>  			fdentries[i] = dentry;

I wonder if we should get rid of that if (fdentries) test one day.
fdentries is never NULL.

NeilBrown

