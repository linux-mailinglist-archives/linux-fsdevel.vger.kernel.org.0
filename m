Return-Path: <linux-fsdevel+bounces-64216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF589BDD2BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019891888C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E3306D48;
	Wed, 15 Oct 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HeQj2jaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLbnibNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D5263F4E;
	Wed, 15 Oct 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514018; cv=none; b=e0GLF3vT6z4oxasRKvFkVmhLBbW2+vFPikKl1bSI1lNtgMnAWsq5Ft5koQTLfmmWkTC/WOjJhAwxZfewzXn24TKwS9jXbW76nnhYLTv4isKNe3kydbMAqJ+GBgJuLUSHOWSTc2NmUGsc/MQfC7jH59Va6iiDEEGVUY4pVqpUZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514018; c=relaxed/simple;
	bh=F0VKENaBvovfiSlT8xKlI6nQPaA7vokKgfJZteYn964=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oTZBUXQ3Gt1PKSgAkmKH4lZFc1Fpv3Kg58U/AC5xJ/r/1bCopGJNn7etETxilodzxVK0Ta6qP0txopyhpZESNVMViGKpijZD6kqNu5tFtYP1wgWff20OK5BrjaBzr6wN4actfBRo2lbRJmalXh2vaT0E7XwDmCwedZy30dW1lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HeQj2jaf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uLbnibNe; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 231051D001CE;
	Wed, 15 Oct 2025 03:40:15 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 03:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1760514014; x=1760600414; bh=mhTvKNjDWORy40SOn/DpL+Jsth7I0286
	Q518PgEEowk=; b=HeQj2jafkF0vTfOTyfDFcbDCaAJv5ndMmHcjmcubECs792VI
	++8nFLzWgFy+p+7YBNFfama4/+iKAfI6WQkhXGmyuOgA9U+twL1peq3rCSUtbRia
	FzJb/y+xMV+x8wdrhwKL2BZzsaUYks2Pxy7u+VGcivpqLvX9NmKe+8bJ1KhkmoLS
	2SwBvfdVYNyKyF3kRhONNLTI4dHAQEPC7erbdCnpbFwQ45BPO1+tHH9UL/JDU1ms
	hqID6V6U8tGQG/2oYoBXYYRWiH1qdqRQlRx4wn4kBKK15poaKV8oupQTtxURcipJ
	gHk5WgYPpQ4f62jTcA4w0dRwtlSsIrX0ZrZEzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760514014; x=
	1760600414; bh=mhTvKNjDWORy40SOn/DpL+Jsth7I0286Q518PgEEowk=; b=u
	LbnibNegX1nlLwH+tYItt+hl0UMp6N1A18f5ba5ndZY4AICwwm4oGq7HWaJIuaSK
	O6DWsHeTkQ1xdsxjfLI3ge5pA015tVTAlL+M1ZdHs4cI07BXcUgAfpZTgEpbSalr
	8zuHwp0FJnhYTjJOHbEotaKMslP2gYFe6QMApFTLxlGgVtITSa1uGVbhZKJVb72D
	rhJYqyZDl2jTiK5AvLHROvly1M6lL+C6TlTKdHsa7LdHNOekkzvfO85bi6BLTgMK
	5f9T8oWRTi540muNaLXeeGofgsUiA08j6T5sU+Vx1uqEgACmjX9Me7qqCGoHNFw3
	OhmcrBBU8jjS/7G55g2Hg==
X-ME-Sender: <xms:3k_vaOCHSszB2XjJaNKKkzyTR3AyDqAMXn5feq4-D7KHkcLEJ0aaeA>
    <xme:3k_vaDXu3U8ADuZY4BwtSII_zcAIPgTupwyQSLfNUtGKQEyyjQ_aKqPoKcXjhtIA1
    juEboi_JLEr4R8f4C0X38xZx3A-At5dxI34Smqkqh6EN1zRsnvnV6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepgfevvddtvdegheekgeegvefhleevteeghfevieej
    hfejhefgtdehleffvdevtedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmh
    hmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3k_vaED22WLve9jZiRv2Gjd-J-HYJYE8ydeBbvatr8ZxNmrjNBO6KA>
    <xmx:3k_vaBd4O_zaJtJpqgihPa4y-ceRwHSJXEjg7I1WzucCnxwVniWN-Q>
    <xmx:3k_vaGlCc4i_kAC05bIDWeuukZyctAy3gC5hLjaeEiQrwrYbGDvTmg>
    <xmx:3k_vaAGhV-z4d_pxOz7Zydve9MbRj-yvf0Bo_TirkVHQbzPF9tKpPA>
    <xmx:3k_vaAysEYc9reCf7lk8Sgxq4DeVmNi9WFy9hEjZ3Vkr_YpK6yMaMLpZ>
Feedback-ID: ie3994620:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 53EBF2160065; Wed, 15 Oct 2025 03:40:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APftQYjyEKps
Date: Wed, 15 Oct 2025 08:39:53 +0100
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Darrick J. Wong" <djwong@kernel.org>, akpm@linux-foundation.org
Cc: linux-mm <linux-mm@kvack.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 xfs <linux-xfs@vger.kernel.org>, "Matthew Wilcox" <willy@infradead.org>
Message-Id: <d2b367ae-b339-429b-a5e7-1d179cfa0695@app.fastmail.com>
In-Reply-To: <20251014175214.GW6188@frogsfrogsfrogs>
References: <20251014175214.GW6188@frogsfrogsfrogs>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 14, 2025, at 18:52, Darrick J. Wong wrote:
> Did your testing also demonstrate this regression?

I have not reproduced the issue yet.

Could you check if this patch makes a difference:

https://gist.github.com/kiryl/a2c71057bec332240216cc425aca791a

-- 
Kiryl Shutsemau / Kirill A. Shutemov

