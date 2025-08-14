Return-Path: <linux-fsdevel+bounces-57926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445DB26D2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217B7A05C64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CE230D1E;
	Thu, 14 Aug 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="m9CBxGQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdpR2zJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A41FDA92;
	Thu, 14 Aug 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190524; cv=none; b=YYPErdCplhFjnp7dSfpDCc1ndGZtf0LOeX2wFE6OH8ml9dzrg5XA0M4NQog9tvGk7N6A8u56DhPpe494OvC6nye6sl4wophvLwf6agLah1wtEK2wX5pRSC/eZUc8Wnr3liNYquLPz5t2zDHhFc3OOe+AeCAKdJ2Yv1vjmGsXl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190524; c=relaxed/simple;
	bh=C1zyM9JboEL1dq8fts6x0fFqBZMYuVpZG5QoyF45iS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npwHnIkFNjrDeD7V/Uf5p+tDDbXYv6ziJlj3W5iYHlUAK0mh8HLe1IVfa14BB4hiQXJQka+KjM5qV8OcfYxm714nCJUExS4BuTyakLP/WunDEmGiOBiIkntV0wR1QNaY4KIeIXPpRq6BBT340Hd7+gFCIy3q4HbfH3gv5fbh+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=m9CBxGQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdpR2zJg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6931A1400141;
	Thu, 14 Aug 2025 12:55:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 14 Aug 2025 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755190522;
	 x=1755276922; bh=SQdSFE3oYuJi6nGLbaOS61HME2o+m/ap/i/7e01/+Wo=; b=
	m9CBxGQBfyDJ6aczgpzjsN5GG9uLqJV/ogyIDZut1KofCpxeBYJpEdHRLUFYSWJm
	ZFX6djtz2JyRM+s6bHzwHV9kAFkqKQ/+7jtoTBAo1Cx77BH5++aZ/0LtHq1Y6ife
	/joccRcPkEjRVByRYW3egdPzwMh1Ycx17onw2Jbtelk1Uf0zMvH5bjtHX0u3Ismd
	PK0cF38eyszkVFwisyQsnteSvHKqe6OG38FAvv1NqZrFcOCT2u8YW0agRl2ZbZht
	bKq6TW65+9+odVitqDgDdcojGUQ2VYaldFjxIGiM7WIz0SI6s56R7ig+1lD72+Vn
	SD9ly8m7ejgC4aWK2b6x4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755190522; x=
	1755276922; bh=SQdSFE3oYuJi6nGLbaOS61HME2o+m/ap/i/7e01/+Wo=; b=T
	dpR2zJgq0eTCIwoXFbSFvDuiEVnBs+MYOm9+chs26lZyInEEo3q/bZKOULsOW27D
	Yfuq8DLu1jGhW5l6Vb4Lytm/cB/hJHUpT5aBSRWtYKG73usk89O0dOkKZoDEChcZ
	0FRQiRBHxra7hG+/Qr/M+QfSp4odRgkC5sAQFiSNqWt8ac6akWsHRiC6Il+dN2pt
	7azdsPa6mIHyZNLcL7wdm15Z9VQWIyQ5+SgYRhIm2KZdiDU4OwWxXZXRU89BqQDT
	Sf9hs4h+x/2aq9GMW9/s4Db79POb9pJhqUh5bdfdyeKLVLtpaE3usrxqQJi+QxE7
	N9SfN14CH4dAxReEZ3ZzQ==
X-ME-Sender: <xms:-RSeaIWSqwlbx1ybZDEGnJrQPiZzj9v53acRwkcqYfH2Ij9wHYH7UA>
    <xme:-RSeaJ9JDUAG8i2hNNgKyHE-KBCJEFNcMS3uB8eMngmdCbkruRccmawP-WYjQmO67
    PJCW89UNw66jzkF-R0>
X-ME-Received: <xmr:-RSeaF5D07jrn5YNwQ119WB-7yhNqMNwql7Xi7g1P6Rh4KMffcf8I0NR0TIW5OaiBytK0QrLcF2YDWVEgu1h2Ne8eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcu
    ufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeu
    lefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtg
    hkrdhorhhgpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhk
    ohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtg
    homhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:-RSeaCnlnKguemqyiDuE1pG0FIAlPKou-uBb8VdUeDcDJIcKkWQ8VA>
    <xmx:-RSeaIHu9PJ3uSZYvBIONnVQy7h8eOaPOlDgHmxznm218BtemWpEpQ>
    <xmx:-RSeaJ-2yzT1Pw6VkLQTkavN1cjDMoyAWnVhbOjiNbs7YwnDl4LddA>
    <xmx:-RSeaJluSLTN9wMFOZwbbS63WbPBl0VfYXC7K5vLIvo2vDdOot_PcA>
    <xmx:-hSeaMQZGJb8CBKbSG9B5u-XK5WDpHvX27qq0ra1hCeElephilPsxVJp>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 12:55:20 -0400 (EDT)
Message-ID: <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
Date: Thu, 14 Aug 2025 11:55:20 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: asmadeus@codewreck.org, Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, dhowells@redhat.com,
 Christian Brauner <brauner@kernel.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <aIqa3cdv3whfNhfP@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 5:21 PM, asmadeus@codewreck.org wrote:
> Hi Eric,
> 
> Eric Sandeen wrote on Wed, Jul 30, 2025 at 02:18:51PM -0500:
>> This is an updated attempt to convert 9p to the new mount API. 9p is
>> one of the last conversions needed, possibly because it is one of the
>> trickier ones!
> 
> Thanks for this work!
> 
> I think the main contention point here is that we're moving some opaque
> logic that was in each transport into the common code, so e.g. an out of
> tree transport can no longer have its own options (not that I'm aware of
> such a transport existing anyway, so we probably don't have to worry
> about this)
> 
> OTOH this is also a blessing because 9p used to silently ignore unknown
> options, and will now properly refuse them (although it'd still silently
> ignore e.g. rdma options being set for a virtio mount -- I guess there's
> little harm in that as long as typos are caught?)
> 
> So I think I'm fine with the approach.
> 
>> I was able to test this to some degree, but I am not sure how to test
>> all transports; there may well be bugs here. It would be great to get
>> some feedback on whether this approach seems reasonable, and of course
>> any further review or testing would be most welcome.
> 
> I still want to de-dust my test setup with rdma over siw for lack of
> supported hardware, so I'll try to give it a try, but don't necessarily
> wait for me as I don't know when that'll be..
> 

Any news on testing? :)

As for "waiting for you," I assume that's more for your maintainer peers
than for me? I'm not sure if this would go through Christian (cc'd) or
through you?

Thanks,
-Eric

