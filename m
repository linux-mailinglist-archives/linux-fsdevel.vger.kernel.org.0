Return-Path: <linux-fsdevel+bounces-57941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A7B26DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288433B09F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5220309DC7;
	Thu, 14 Aug 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="goBT1LrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F81A5B9D;
	Thu, 14 Aug 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192641; cv=none; b=l9EgwNQoiHlB5PWEl7e0hMNX/deP4Wk8smTLhyhaaBx2tZMf82iUwqsFdOItQMS2MTfgZ75LvBZF2vhfffOUevxY+njYpFy2A5YiXHtfEeFGp/Hhb8yjuR3MfllHX1tEiekcg1As7ugrk6nLk7kS5UY9/OzRFUQcGWA85DYA7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192641; c=relaxed/simple;
	bh=H6neeYM82el/Ssu+mFGNlraY7xk7EV41gVT18Ts9YBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mszCfo0xy+JKvF35LenQJefNG0yr0XFCr+ZE67Bc0U8E34O16cv3nPP7dcocD4QivbBa1y/grVyWXWjDHl72tLSLouAk+Fd9/+F7FgVkqjAEtqCJZd7MWxtmyPJy1o5wrdoDu6VejQm3+nuEJi0Hrw97lT74abgFq52y3fUS4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=goBT1LrE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W3tGjM5kjziqW+tUCbJw8O1t10ELI2fYifPxbDikHvg=; b=goBT1LrE30UB1yovDGt2lwcIRU
	bAutr3rKVeAjf1+SZWg9RnhTs7D5tQpQ0EhJrBN8P+Y2H86T3nE9jtNdEjeITMjymuSb9Z5E/lbP/
	eeBnkSHPT13tcw7S7GLthq9bBOr3Gb6N8aNrLss9IPRapFCCacPGWh22s1DIlv/PyK9tcqHztJNBj
	3+bD6Y6VTNGfd7OXUqjWetCfIs7sQKkiRz1pzrPqRq1aa5kz6LQjJKT1r0VPB/xC5CrkOINv8XXpu
	JPFITQVaTQqHHIQxOffuw//sVcZ+qnXXtE7S4D9MveFbgnxg54+fZoKD34ZFCq3pb4uPtvZukWKMu
	oyy9SqJw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1umbmd-00EEEC-Fv; Thu, 14 Aug 2025 19:30:35 +0200
Message-ID: <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com>
Date: Thu, 14 Aug 2025 14:30:31 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 14/08/2025 14:22, André Almeida escreveu:
> Hi all,
> 
> We would like to support the usage of casefold layers with overlayfs to
> be used with container tools. This use case requires a simple setup,
> where every layer will have the same encoding setting (i.e. Unicode
> version and flags), using one upper and one lower layer.
> 

Amir,

I tried to run your xfstest for casefolded ovl[1] but I can see that it 
still requires some work. I tried to fix some of the TODO's but I didn't 
managed to mkfs the base fs with casefold enabled... but we might as 
well discuss this in a dedicated xfstest email thread if you want to 
send a RFC for the test.

[1] 
https://github.com/amir73il/xfstests/commit/03b3facf60e14cab9fc563ad54893563b4cb18e4 



