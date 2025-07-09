Return-Path: <linux-fsdevel+bounces-54359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4AAAFEB8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6239A4E69AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C92E613B;
	Wed,  9 Jul 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RU2Hgw1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9Q3AGEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9E2E5B21;
	Wed,  9 Jul 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070202; cv=none; b=U6uAttSt0/Qehn7OVbYSfYtbt25jkgEn24lzyiKYeeBuH1QwjaH70bUCgZyWj6b8JktfAt0A5wtiAppARBRJfnsB9VWfqyRSAO5TiwoLaqDZ8PQfzs3hnAaUFlxqhO4WGNl6p2O/WCvE8zhjLPWBs0q4E7Cx9Kkj2U9YZCJ/X2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070202; c=relaxed/simple;
	bh=m62TkjTTmCz9G9a7tBMmsOZHwwbtguD4Ia1+JlyvOro=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VfyZBVxtwv+QeU45Vnm9fQRvU503Yov32jmb7DppX855qT/Sum6HQqIZKCuc3bwhFlht5pStb6d7TZgJvP+vSx6N6RU6PHQT35yeEsMFJ/5V1ImbYk3XgdHqTEQPFL1N7ogs7VP3kuARBlKrUUhzlb4MpGmG2HZ2AbaQ9tdgdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RU2Hgw1M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9Q3AGEz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C1842EC04E8;
	Wed,  9 Jul 2025 10:09:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 10:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752070199;
	 x=1752156599; bh=OXiuJfa6GzzwWykYEMepJESwQapIIKQPPmHJ+Tf85BQ=; b=
	RU2Hgw1MuM8b2gVsM5NxXSn7wjdJEuabk3tdZCwVd9Y5SSD1DgZOmCjZgTMeAm8/
	Hifn/RJOq6PaGfgCl9V39D8zyZC6ZZQX3mCzllQ+njxcTYTiqcIlnC8CQ7IO2RU8
	hpJg4w1ntaLGXOioYOH1NtXONC+94Ds2KRxYa0M7EWsKywkNKHnfkMgX8xGY+42U
	bIddLRdDdecU3JzbvwXnvKT3OC/nmBjBJG26EV6fr0kqI3hWx5QiJOnWl23ejk9S
	URMoM96nbPolOSo372vR+HI5eOfcN77YfC5jJyp9CxEh8cFRB4qS13tLayBXpnhG
	5L7dmUuyTc/vldr0OwupBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752070199; x=
	1752156599; bh=OXiuJfa6GzzwWykYEMepJESwQapIIKQPPmHJ+Tf85BQ=; b=n
	9Q3AGEzMpSjTI0dCEGaf/0MZQw5OEUMcMsnLpP4IM3M5hmtgHiSXhCuzs8mJXHlX
	H8l2Dxg6tBjeeawP/oYPW9PhFOCL08im0LkMa3FDnfHIJWV8o0k0LZl27NWi28ec
	thIN4M6um3zt90IMcPozFNklW9dZXZoNjWHe0qm9/iUSjLCao581xHYw3X7W6OtC
	zZcZWjmAyQsWLRJxTMtjvZEm4Ad9NtTL8QbaGXlkCGlZ5buBEJJhuZN8NT5Y1M7Q
	geTMwiTonTMVHNPXTjgh/nvUE+avsoTbMjQx1wJorCHtIKjoDN9QvZHNBRNpaLMu
	GlL5GAWGBRuzkRMFw5WiQ==
X-ME-Sender: <xms:NnhuaLGNSpYSHqJVnMiULv2h0ByQ5qAww3mrZPb-KWk_64bi1PpGNQ>
    <xme:NnhuaIV2LV44mWStCa-ZwX2laSsrhz7JvmZmRM_kFXeDSQnXgifjZoL1FFDrKtIHL
    NQHcy9HJRrEqBAKw0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    grgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhord
    horhhgpdhrtghpthhtohepsggvnhhjrghmihhnrdgtohhpvghlrghnugeslhhinhgrrhho
    rdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorh
    hgpdhrtghpthhtohepnhgrrhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdp
    rhgtphhtthhopehlkhhfthdqthhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrgh
    dprhgtphhtthhopehlthhpsehlihhsthhsrdhlihhnuhigrdhith
X-ME-Proxy: <xmx:NnhuaOC3XXADYW-FsyPw-X5u6Qq5HKgoZ0V7N97HVOXeVgVXQTX4Jg>
    <xmx:NnhuaOTS5gAWkDPz0h6urrY8qLKIn-AbqiOtanzEdU-op6_jB-2bDA>
    <xmx:NnhuaPrx88Gi5Z0HpJNfzeNbDNymXSJSLp9-HwbRCkcNHIle_V6lTA>
    <xmx:NnhuaHWK0Ke-jQEy3F6nTSgH0tvn8A5dIwt1T5okM-EGcuxc_cjyGA>
    <xmx:N3huaFviz_ZIc3uK5VG5NJtYuRyA08PK23qjjhuZLall_bACdCY7Ixs0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 772AB700069; Wed,  9 Jul 2025 10:09:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc5542b2421753b41
Date: Wed, 09 Jul 2025 16:09:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "LTP List" <ltp@lists.linux.it>, "open list" <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org,
 linux-block <linux-block@vger.kernel.org>
Cc: "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 "Petr Vorel" <pvorel@suse.cz>, chrubis <chrubis@suse.cz>, rbm@suse.com,
 "Jens Axboe" <axboe@kernel.dk>, "Matthew Wilcox" <willy@infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Anuj Gupta" <anuj20.g@samsung.com>, "Kanchan Joshi" <joshi.k@samsung.com>,
 "Christoph Hellwig" <hch@lst.de>, "Christian Brauner" <brauner@kernel.org>
Message-Id: <61787165-8559-4ad6-90db-5ab6ee5e6fd9@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYs=3LHdf1ge1MiCoCOUpW=VjPdVWrNJX8+wi7u6N18j3Q@mail.gmail.com>
References: 
 <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
 <CA+G9fYs=3LHdf1ge1MiCoCOUpW=VjPdVWrNJX8+wi7u6N18j3Q@mail.gmail.com>
Subject: Re: LTP: syscalls: TWARN ioctl(/dev/loop0, LOOP_SET_STATUS, test_dev.img)
 failed EOPNOTSUPP (95)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 15:48, Naresh Kamboju wrote:
> On Tue, 8 Jul 2025 at 18:28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> Regressions were observed while testing LTP syscalls cachestat01 and
>> other related tests on the next-20250702 Linux kernel across several devices.
>>
>> The issue appears to be related to the inability to configure /dev/loop0
>> via the LOOP_SET_STATUS ioctl, which returned EOPNOTSUPP
>> (Operation not supported). This results in a TBROK condition,
>> causing the test to fail.
>
> Anders, bisected this down to this commit id,
>    # first bad commit:
>        [9eb22f7fedfc9eb1b7f431a5359abd4d15b0b0cd]
>        fs: add ioctl to query metadata and protection info capabilities

I see the problem now in

+       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
+               return blk_get_meta_cap(bdev, cmd, argp);
+

This only compares _IOC_NR() but not _IOC_TYPE, so LOOP_SET_STATUS
is treated the same as FS_IOC_GETLBMD_CAP, since both use '2' in
the lower 8 bit.

include/uapi/linux/fs.h:#define FS_IOC_GETLBMD_CAP              _IOWR(0x15, 2, struct logical_block_metadata_cap)
include/uapi/linux/loop.h:#define LOOP_SET_STATUS               0x4C02

I checked a couple of other drivers using _IOC_NR(), and it seems
that they many of them have the same bug, e.g.:

drivers/accel/habanalabs/common/habanalabs_ioctl.c
drivers/block/ublk_drv.c
drivers/dma-buf/dma-heap.c

    Arnd

