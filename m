Return-Path: <linux-fsdevel+bounces-40141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFAA1D707
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC1718823FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18651FF7CC;
	Mon, 27 Jan 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="NmM/c1JJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Dy0LGi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8D1FDA84
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985297; cv=none; b=EL/HjvvoXpTbtN8kgzTibMjZ1xnjix2j+z15nGFyv+/jvcAVguIVU6bSGCPumpB/QWomMcytL6rl1+8dCSFwZk3UmIYTqCOpS24tBCBL1vy5ek7Gsn3XrzraVOWR9uzymYUpjDbwIfu4boojWyzwwza29y8MmC/Y28M+ke/aw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985297; c=relaxed/simple;
	bh=ouGAJ6qZsiAsqOFNw49is1ctFHcMrSyhX1wya9HIr5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n27iBWKtMljt7zuzRLDdZfg6l93kEiSs9ijRLnSY2yzXxVad8lZrt8PDz0KuKBrywziteQbg4qx4jCFncB5CVGhSVuhZUASSar4zNX6NkTc2L1g3NmbHKSCe3Xqe9v0X0q8vywVdSNQ1TF+w2oK9duCUa5b6gXugb3/dQ13vSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=NmM/c1JJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Dy0LGi9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3938B11400CC;
	Mon, 27 Jan 2025 08:41:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 08:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1737985293;
	 x=1738071693; bh=YkHoIYMh1ucQr1euCNFqtGABREJ0tzwKmcvOBFJoae0=; b=
	NmM/c1JJ0EtLnYazFfa9uZfs68x+6EBBxhk9AhAvXmq5GeG0GjNdwqev7hStp7x4
	vD5eOFsjMIiuUAvoUmH8Q/ZKIhPooa10G5pUyF2MEbB2VKbnPVmI3HCTkSjhnw6Y
	chyQXE60wfZT90/xHCYzWtlPXBVy3OBL2D5Foi2Az/vw7uZekTXi78yPajlGDfAW
	FTUspe+fZoHlRczVO/P+cQvJ0qUhYEkV3jlheoOJ3+O0NkkNHxXSJ9juGwEQoS97
	1suLe9VozsaX+mpTmWa+/ML+2TUjwKUwbcNuR9qQ+LCVNRj7fZMDd9wTuFEMdXIe
	4GIFN53pPN1bzPaBH529YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737985293; x=
	1738071693; bh=YkHoIYMh1ucQr1euCNFqtGABREJ0tzwKmcvOBFJoae0=; b=1
	Dy0LGi93XGIACSD5D+MgBBYI5JGcinf23SPsgc6h63uN+boR2HZ56PvQPfmHtDQX
	8dAt9wrcDsm5b6raGVU1QqQ1D96h4YN0EUz/erisCFDreRxneR/6I32lMyKpGCeN
	bX0zQcSzbBy8MzMMd/JPiIOa4HJhmSQSgMJn/Hl3s41E7RuT3FJFlrf/ViceZvZy
	LXquRnKLI8EKLeLzE/tr4I/sS00sWReoBQF/q6rUOSVGayM4imNuGHtqmaK8cx20
	gAA97xRlEQ60g/0Ph5drOC1u0ueqZmqpiXQPwG8VsGm5ZG47pmBuRzybzmbdR5xs
	fYkdigMLLlW7OstjdPqJA==
X-ME-Sender: <xms:DI2XZ9z-WXk50AMbLyLsTBnU77WeCmlY3lIEttIB1ZFavbVlxYDqxg>
    <xme:DI2XZ9RHEYmzLouhI2U9bondcp4USldpFOKfQavh24ehhZxaifaJSQVR-jVc0QCA1
    Y5w-jWlk3NZd5IE>
X-ME-Received: <xmr:DI2XZ3VltOlEH8lWA-xd3K_BSUQxlTljcRIY6Dqi4F2_76EAcdXjjhPE6WvajSxn7W9v0XzxP8ZqtWo7WxE9fx-QSz2dtwiKTRSkY3s5OMKDsg0kQclX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdel
    ffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhupdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtgho
    mhdprhgtphhtthhopegrshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomhdprhgtph
    htthhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgrnhhnvg
    hlkhhoohhnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DI2XZ_i8tddzEAH989g-CABboZ1QbGZv_i4zg5UnVIAXPVti_uaqiw>
    <xmx:DI2XZ_AJDKHFekyX30cp6crwJzOfNocrx8QhZq66x3Qmo67pcZ269A>
    <xmx:DI2XZ4J3NC082GbbCQg0jyOO57QTejHFbUF_wM-vTc2cKU7-1Uldpw>
    <xmx:DI2XZ-A_K72ZXheQati4-1x6aZbaq27M8qRgPf039qNUHDqjBxuq_A>
    <xmx:DY2XZx3T9CoYN-SMDSMQtpywRAeUI9HbhL6YpqyeiJxoJfbO1aacGM18>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:41:31 -0500 (EST)
Message-ID: <4a771695-a198-4ee5-8fc7-0c8cc87c48bc@bsbernd.com>
Date: Mon, 27 Jan 2025 14:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] fuse: Use READ_ONCE in fuse_uring_send_in_task
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques
 <luis@igalia.com>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-4-7771a2300343@ddn.com>
 <CAJfpegsN3nybf6iTbMPUJJ6Tdv61ngG8qfTwQ+8UYucHA3XQPg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsN3nybf6iTbMPUJJ6Tdv61ngG8qfTwQ+8UYucHA3XQPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/27/25 14:16, Miklos Szeredi wrote:
> On Sat, 25 Jan 2025 at 18:45, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> The value is read from another task without, while the task that
>> had set the value was holding queue->lock. Better use READ_ONCE
>> to ensure the compiler cannot optimize the read.
> 
> I do not think this is necessary.  The ordering should be ensured by
> the io_uring infrastructure, no?

Yes, definitely ordered, as it is called only when ent->fuse_req was set
before. So yeah, you are right, we can skip this patch.


Thanks,
Bernd

