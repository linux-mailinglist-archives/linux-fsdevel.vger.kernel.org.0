Return-Path: <linux-fsdevel+bounces-29057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC497445D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 22:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393EFB237DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31971A7AFA;
	Tue, 10 Sep 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="UzvMUksn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBacfdaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F193183CA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001715; cv=none; b=Ib2AOQajTYywCoHbp+wMJNdXB71NEcBrpkQRzK3PwHIYyA3I3/F7WdpwChHdH2kL0rvHi57AIhqzOu9Qrq/0cND/dSUoIN9OsqULmiC8LTJ7jnCBiJCfzvwPRmfmSq7aqQ6ehuKtssYzg1+BIyjhpakSsRETuNtlD610JNg+aLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001715; c=relaxed/simple;
	bh=Ls+MbwaQIFpsJ9f4AntpxT7bRLnhQ/XwNDCIccRM91w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqQzZl8GwZpm+qWxo2G2JrZfqZGctpWM+RGXp7b5b73PAJWWxd/44uqAK+prP5ZHAHoKw/TfGGE89c2Z4alvBilslXmy4Ka3LWTrQ8d5nquXlDwx7S39e/i7I/02vV/iZl7RM90ItPPgwxM7LbhdoCf4YKXqRfan7SAQUbfBmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=UzvMUksn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HBacfdaZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 51802138023E;
	Tue, 10 Sep 2024 16:55:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 10 Sep 2024 16:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726001712;
	 x=1726088112; bh=Ls+MbwaQIFpsJ9f4AntpxT7bRLnhQ/XwNDCIccRM91w=; b=
	UzvMUksnRXH36BQX9pzYHq0MhIhCQ+AT+xcFVP1vBEs4B314Sz5HfugWrNm0GcRv
	vkfiGfxoGsTYeceiRDSDQMvgfhA8WigUy9FsPhN9iSzqXsZYfKeGEXnSma6+hg0P
	LwR67jqhZWm9r9pTr0FsO+5Opls9LUNiv+cb3d0fjxRKZntOdmK8nFAf4kX9+LoZ
	NYeWLg/1tE+LA5BCNXwJFKNSim4EmxrenkTBQyRu8bTe5qJNMKauNs8RdQ7qEWMP
	b8UMcycYD/mJ0aIlGAldRBriocLFPDdPS+myVA0kn9V7vY0MPbMNVPsKwX4Ng7Y4
	tJPdgdJQxmF9LBqRjcvgow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726001712; x=
	1726088112; bh=Ls+MbwaQIFpsJ9f4AntpxT7bRLnhQ/XwNDCIccRM91w=; b=H
	BacfdaZutQucfTUZK9oe/U7L9c8IN+JLMCCOiKDNWsAld11Tee4amFN+9/rKpt8E
	rV0cHiLeMQhOodS3osu5JfWdiEwHa3XR33NJ1rzP7xSyq/pgsd7kE+MhzoYSZevu
	bmEwGmbO+P4z+6scjdSImUJr3JhSQcaeXb8RC118SrsctdVcUiiPdLe4yy82eVvy
	NdWM7hgR83kVFBGZp6bmHkuP9svRrvjW0fzJCWXlUKECE9ZN1Z08hom2VrlPXz+c
	aEGtgqSrNaEqwPCCObn/Hv4i4iUJVGoq98GFIggl0ziE/CFJpwXDFp8oUM5TxVaG
	OpGVZYUaixcyr2y6hiHzA==
X-ME-Sender: <xms:L7LgZrzMlmuYN5SGD7NhurGfdRoLqoZinpsuc0kwrOJMPdjlejCNWg>
    <xme:L7LgZjQwbFiU5SmciGWR43Hnl7yM0w_eUNa29GCHQ8gJ9rM9FuJ4u-LBCEO6oIAua
    49CIrMwC1Yv26y2>
X-ME-Received: <xmr:L7LgZlWWr1iQbm0_fuNOHUBaseBOe29Mpp_5zTDC-DukrHjrUc31lKFJpT1BPKLDhyOanykm0vEGxSYdA7MsJjngAXxxTMPCoZ9GPGvmEhcbELmYm_wn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggr
    mhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:MLLgZljMEhUzl00lLiDCB4TzIFZ12alMbk56obm7x6-8kbO8lg0MPw>
    <xmx:MLLgZtDV-8kOXFBi479UQPUH6oVjZHpD6X002sr_ZlEo0Th24sjFaw>
    <xmx:MLLgZuKF-T6IXrfUBA_pcG-bFgiKokT45e6dzQvYU5hLLDDmKFrLOg>
    <xmx:MLLgZsCefNlfOfK2b4QTsEQo_NA7StaiGgUs-bo2NaSYdYkgrTto8w>
    <xmx:MLLgZv3YgG_Fu5QFzKRxKywnxt5kXCFisKKoF6eYvM96t_fiFX7LGLWm>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 16:55:10 -0400 (EDT)
Message-ID: <609f469d-3f14-4933-854d-0c772b25533f@fastmail.fm>
Date: Tue, 10 Sep 2024 22:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] fuse: writeback clean up / refactoring
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, kernel-team@meta.com
References: <20240826211908.75190-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/24 23:19, Joanne Koong wrote:
> This patchset contains some minor clean up / refactoring for the fuse
> writeback code.

Thanks Joanne, especially after 7/7 this looks so much better now!

I'm a bit late, reviewed-by: Bernd Schubert <bschubert@ddn.com>

