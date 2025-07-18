Return-Path: <linux-fsdevel+bounces-55449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64102B0A92A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB4CA862A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1772E6D2C;
	Fri, 18 Jul 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="a83fcaS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxqD7b8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9392E6D00
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858642; cv=none; b=M+bDdnj0Fpfd7HCyLYCrySDjJRZeIq9b/n+33++8L66ytTkRFz0RGMtNpUbzB/aG+cit33DMWcBzLbYfq3bGrjIK9E9W7HmMR6zgH0kF1mrO85ocB2BjxDhZxtpHOlX7IlEucTyf2zWmWqTrQUSNLJVViL+IT16YSGPUCxElPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858642; c=relaxed/simple;
	bh=ccoktd/JcTj8KLLnlR1IKrDfymInNKbBYwVHrsc8VaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktfpgneWTpp/1w/c+5GCm4RJRnRPOCC+KtJlwXWzjcTx1UP2PM6YQ6S48+23IxuONTpO8S0HXI9CU7Ct28nWJ5EY4B5oB46ceKp9oByHKDPBrVodx3u/F5o4/aRRYvRafrfkM0SmFRuD2PTdeQlE0Ms+Q76e8xYctgOuUy3NoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=a83fcaS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxqD7b8p; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F6297A0144;
	Fri, 18 Jul 2025 13:10:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 13:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752858639;
	 x=1752945039; bh=5apDdwG/sHF4rKP/j0HvLRqQdpdoz2t+ySR7NjE7IPY=; b=
	a83fcaS48ontHEurBXJ4N4DOVCA3hRBVn/LghIsTnHCdv2nQNeWHpbGT3801z3QH
	+Oz2NALW4P4U/XosX2tYPXw3YWudZii3PfLykkIcP3A/svcPj2WdGM3Y/pP7LM8o
	d7UyqFOJHq8wCbzo7XpWvxewPu1nVeY2DAO3fwRAaH6q8g36EkoOIGY3FKaCzSFU
	R8YhL4y1JQgzVVVvobhlyhXo+u+O6mBXChLqgtmH2x6DWqjf0AA6vdJ4mKr87HJl
	3tVhaWioUwqo4ETRWSq4UTY+wr/iZF0n1i1i3SbwnFR++lHKPnnF7bM4qm4+DCg/
	aMBR/SS+dG4P2RCl1171Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752858639; x=
	1752945039; bh=5apDdwG/sHF4rKP/j0HvLRqQdpdoz2t+ySR7NjE7IPY=; b=W
	xqD7b8pdWmBlw54kqLBJU87OOm2ZfZvk3LoxNuvu1+aAS9KHboIj1b0WDRY5gVkg
	FkBev8q+Gu8hBHw9P1OOzVjhVYcGLqjlR5/UI9KkexCJPJJcDIic9po+IoXnZkuN
	Zic9tcRaZs+W/Ef975z7MzGSEgCvRb8en89Y0c7r0Z2jfoI8fbadD26lQySjkSpL
	J0WVJtCokg36hZY3w6ei3USSNW/9ScnY7LQv2beWXe4Op7+vgGEEY8N3t+OF7GO4
	bRtVQ+C3hWftBPnvD98sxpZQxTXSkgPvh5ymHTXHEg9huR0ZaWZNToFBNVhkNTrk
	I0/E/LFkEmJ8Z85BsjyFg==
X-ME-Sender: <xms:D4B6aOLRSzBGqh-n3vRWiheeiHL3Zr-g_lWTTVnMfErvgBPTCr1XwQ>
    <xme:D4B6aOnD9G8-58VAaeTEC8pECxWFISLtZ4HrHcprqJgQMgk2TZmprmpiYRKF8gs95
    mwmV_enMGRFlYYN>
X-ME-Received: <xmr:D4B6aPIv9B_OpF29X5bZqDQK4zu-cdI7g5asRAUVPbs4KpxdmI_xj12YlhX8oAr7QVPS2Qwvwugy9ISeC0IZ8sjk_6AuKCVLNU2ce9UpMIaaMajjsGDH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeghffgueduvdeuuedutdduhfevteeiiefhtddvueffhfevffefieeuhedu
    kedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdr
    nhgvthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoh
    epjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:D4B6aD6lmXNs_MKIP3gLYLiezGWfw5WR4tVOU2q6rvdcZuMya73Mtw>
    <xmx:D4B6aD0uOeuoCm9VpHHoEkkfFlP16xYZxxcy8ZjJRPVAtNWW9OSg1w>
    <xmx:D4B6aJf0JxvgzPdIvpla9_bZz-LOu5lJYtk4B6bI12hxqBMFwX5h-g>
    <xmx:D4B6aJfSxOEY3ztbNlopfmEXxHswVzGuqDZ7ha6LOOkuAf-KYRIqMQ>
    <xmx:D4B6aJHr8YJVj5jbCXXbUtZ-vNnXsuanbxpNW617tfsvRVo_wAk2ebf9>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 13:10:38 -0400 (EDT)
Message-ID: <3f65b1e1-828a-4023-9c1d-0535caf7c4be@bsbernd.com>
Date: Fri, 18 Jul 2025 19:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449522.710975.4006041367649303770.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <175279449522.710975.4006041367649303770.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 01:27, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The fuse_request_{send,end} tracepoints capture the value of
> req->in.h.unique in the trace output.  It would be really nice if we
> could use this to match a request to its response for debugging and
> latency analysis, but the call to trace_fuse_request_send occurs before
> the unique id has been set:
> 
> fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
> fuse_request_end:     connection 8388608 req 6 len 16 error -2
> 
> Move the callsites to trace_fuse_request_send to after the unique id has
> been set, or right before we decide to cancel a request having not set
> one.

Sorry, my fault, I have a branch for that already. Just occupied and
then just didn't send v4.

https://lore.kernel.org/all/20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com/

The updated branch is here

https://github.com/bsbernd/linux/commits/fuse-io-uring-trace-points/

Objections if we go with that version, as it adds a few more tracepoints
and removes the lock to get the unique ID.

Thanks,
Bernd


