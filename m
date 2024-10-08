Return-Path: <linux-fsdevel+bounces-31351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B999533D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C591C25654
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF01E0492;
	Tue,  8 Oct 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="muuMEyFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxeYqZmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC91DFE2D
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400879; cv=none; b=gWVBKVNrems2JCklbVpEXyvvIU8j0aA7MPFE7ilXYtyXoIwoOP4kLmha5CBc2Ohb81psUMM2zx43PxtAyXe4pigbUiLcT6No5/gc5abEJejRwru84ZS06QXA6KQX9VMHZOEU8zsDs5TkfMUp+bUr6eY92V7ACqMVP9EwKgywUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400879; c=relaxed/simple;
	bh=GWV0hehjFuSXgaQsyMrOJWOYqwbOeUvy9Ba2wtSuJ00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H203Mgzf4PlBbalt3BYmpY31PC6P0TB2NJTsbfZqEgwRF9/2Q7mpBqnhsPpNlovLBriok+PfCUdVxH2LJVrY9iOi7FIIcRiguF27Md/LhL+G1tHiEcan5O3rntG9stqWxlsWVrvAQJXRWBy8NxQtxPK5rgb2KZZHQNie5BYAr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=muuMEyFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxeYqZmb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AA6FB13801EE;
	Tue,  8 Oct 2024 11:21:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 08 Oct 2024 11:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728400876;
	 x=1728487276; bh=cF9k9uxSp1AfUcdDs/DzGmjM2LscyoiyNdvzB8wFrpM=; b=
	muuMEyFL5guyyLcVlehYOPxXqeHHE6/pOVdGeTSCZ4ZFfhqfmYZ0BEmNpK1tklTD
	tT+MaOndxYGY0rlAF4ll6OaZ84qF1BJz3td5fzdfLlGgIULsf6EG1rfOF1jb6xar
	uMXxFmOfjqt3Js1E3YRlvLktKFqS0kyC7eTGiYbf1XrYdMB/ZK6iTL2roC3JWXUl
	2jvxOlS8RK/NzOpIdFWfdXq+rpc9zJuo7okNPFYzB6RDYEa7vImk0pIs9+Rv3Gib
	HZZ+YtJCf8icTL3knhW41Owo9RhXkPhhnIUbWqXsGWS3YnKxQC/95Y2O2gVih7EH
	j2wsHl5k7FZxr1Op2PzeEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728400876; x=
	1728487276; bh=cF9k9uxSp1AfUcdDs/DzGmjM2LscyoiyNdvzB8wFrpM=; b=X
	xeYqZmbecav24eW9UORqcfl6QxOheP6VdiunSaH45AWerbZo+nWheu/i8iB1cL5v
	MtyAJD+UzBPoy1ZLZ1oVP1/a+9kY5bNiZDHHTkRXBSK98S0+x63vPtb2EpYBIQPS
	Chz7Poc0AOtUeHeEZFORMX8vQrKAKKZvS6n8giWMGcnZh7Wtr799W5nOdRKFjtOp
	CE2dvgM4AjxmkAxCrBInnOveUBecarHuVVVjcepttBtmacyboRRI0wbQ0N7U/cfK
	/wHpe10FaL6FcQD7oQ6aUCPb4CiBxWROnciJ7uIzEDCJEUikTQXZAEqjFSfX6H1F
	ZCoSQtEhT1T1AyrMdvAOA==
X-ME-Sender: <xms:7E0FZxL0JBoy7z7zsMN_J3MYhb-oiPaVDSQFFJR2Gurn7-TYXoq_2w>
    <xme:7E0FZ9Izkjk0Wbn_jTD-CACoszyrBpTRVQqjdAqFdHiQvG6jeRCK4gdf3Q-P1nk0R
    S-__TKs3ownEKsesJ4>
X-ME-Received: <xmr:7E0FZ5sUx7a08KZB8o6GVjMWQ17mMR0jwpFU_cVwIqAweyPIa01RpBBiprf-e-RkYxP9k8pCYKCk74bCc8bnkTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedv
    jeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:7E0FZyZ0Dl1ve-tNd0Nfz3VBDdE5Ijv-lQ13yVYR3fJ8h2FkqbwI-w>
    <xmx:7E0FZ4Zczd4-a6aF0zgJFx7smpYlCVJvEq0kY57kQA57WeW9Q7_g8w>
    <xmx:7E0FZ2Bl_16sOL8Yb7JH1ftfXfHV8V8tI_kIXTfTZBo88puJoj3JDA>
    <xmx:7E0FZ2b77w4qS6nyDRKJY7JKHUpcYDeUSTwo9ZeJgDQVNlWYQyLDfA>
    <xmx:7E0FZ_VQw_42QhKcU0W1sHs_Tzd69sVsO3Hoil2nxNcKfe47gHC8Bi8M>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 11:21:15 -0400 (EDT)
Message-ID: <15a48de5-d8d8-48f2-90e8-5b36486d2b2d@sandeen.net>
Date: Tue, 8 Oct 2024 10:21:15 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] hfs: convert hfs to use the new mount api
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <66accd3d-b293-4aeb-abdf-483a7d17b963@redhat.com>
 <20241008-fotos-darlegen-1d129828e6cb@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20241008-fotos-darlegen-1d129828e6cb@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 8:08 AM, Christian Brauner wrote:
> On Tue, Oct 08, 2024 at 07:52:48AM GMT, Eric Sandeen wrote:
>> Convert the hfs filesystem to use the new mount API.
>> Tested by comparing random mount & remount options before and after
>> the change, and trivial I/O tests.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> V2: attach sb to sbi (sbi->sb = sb) in fill_super as before
>>
>> Brown paper bag time, I really only tested mount/unmount, and because
> 
> We don't do brown paper bags here. Making people fix their bugs is
> the real punishment. :)

Fair ;)

>> I had forgotten to attach sb back to sbi (sbi->sb = sb) in fill_super(),
> 
> I already folded that fix into your earlier patch.
> 

Thank you!

-Eric

