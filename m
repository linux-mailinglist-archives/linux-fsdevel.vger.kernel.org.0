Return-Path: <linux-fsdevel+bounces-54390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA2AFF311
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0AD3AFBB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7F24677E;
	Wed,  9 Jul 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GzVYg66v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iT/xiKGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57C23BD13;
	Wed,  9 Jul 2025 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093076; cv=none; b=oPH6fxGyy8JiFclfUyqL2TxD6xxaWDAz7GMMx8QE3+FGiK/ytSMJnNfaTkDN+sTJ7dRMAH2w9IW8PT3L7MQ9jArl28orlM+5j+6VJhN2P6CnW0cXzeyv4XBc0hKtDoROuu+6QOdwyEgRlZ4wLbl/w4vCqv8Vh43Ob3s2/s58D5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093076; c=relaxed/simple;
	bh=6Tz614NpehH6aczQmxQyMihVZ7CmfcI4Z562x5DJW+s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u6Qe+mMPcFWGkXUgnB+kwDC4FvZsjKWgGPiIXQ+8bMq8EfQ/FBYfB4KlbsrB9ove4iAiajt0jPkd8wt6LB36WSX/DrLzOp1bivpzhzVdst252IdcWwueHs3ecEcVPLLiq6qsyBsc/4+5PRLeexAWV7W5wFjRwd2DQ4JiAMU8XQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GzVYg66v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iT/xiKGb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3B4C7A0026;
	Wed,  9 Jul 2025 16:31:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 16:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752093071;
	 x=1752179471; bh=llWN7pp7aG8O86Zdueocuq+HHi9GtObRXw5Q6xFES9w=; b=
	GzVYg66v0Kt4dpjX55f7iOuq5EVY2oP4JgRptCTQcb5nzz3i7Fjzvyh3AyTS8jrR
	xkJds4514NzxlftiOAQpGI5K3wqlL/qh4bsRR3szkwbGi2O5eFuXLBng8WxtxBYt
	OM8rvADWIEHyGFofs+2Rz9YRWoNLLET3/PzjPuOAX+pUuX++sanAquruw8OXeaOP
	p4bEJft9Q2krlf4ZzegRYZtecJ+xUZp9TwMAZDNRhQ9M+glyO29X4mTEggx2vUkD
	gOMuYAvRqfIwNP6BsWlSoE2M6+YjBiabBIziatnKcIZcLOpUCqGiQ8JljIooc62v
	p7J7qS1FsgoOgBu0+VAygw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752093071; x=
	1752179471; bh=llWN7pp7aG8O86Zdueocuq+HHi9GtObRXw5Q6xFES9w=; b=i
	T/xiKGbREElYeICO1GVUd8Wbc9/JdYb7S4JmpTpoWkZIga+XJ+7Cym/uMEvqNLCp
	pQVrO1GfTBYwku6kWCcjkoPbb/Aw82ibuV8b4NVGYT2oGnzfli2qSJW46Yo0nU4h
	4OzgEiAi+LGy13vMdyjNViFQNSgQVS5tvaORatsyWgcMoA2dBoWphLJ1fO59TYjs
	JnxS650QpAD2JO68ruY8FbQJsKbNoGLJhY/DI+8hXoP9lBeyvGghdCWoqDFMdbm9
	u5ILFbAdPFZfuW32a7xSs7rU9OkgCLXkNtqnB9FO9g1YJ+0yCBWN7SJX2QUonbGE
	Bz7jQQi/r713VZiqLSaiA==
X-ME-Sender: <xms:jtFuaEelBli-5kOnOZB6hhPcG6fCxWVNB6rHWs67jQaJpKUZKB6dew>
    <xme:jtFuaGNFvKphXetz-u55UIOwy3Z_psjqLhWAqia69D2hjdFWgNg_8mjjLLqNgKr1H
    ch_E6h4MhZoJ_xSa3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomhdprhgtphhtthhope
    grshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomhdprhgtphhtthhopegvsghighhg
    vghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrd
    gukhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghr
    rghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdr
    ohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlhgrnhgusehlihhnrghroh
    drohhrgh
X-ME-Proxy: <xmx:jtFuaO6_FMAkDNEIbADE6FHbTV5t3LEdm25z6UdKWn1S2P48ExFB_A>
    <xmx:jtFuaNCADNtE1ya6ZR9w3QASJia8WSPQujdxLUarZzB7CgJvkqnpog>
    <xmx:jtFuaAaQnxw7iVxXR1yNvntVrGI-hWB1n-KYgVMrIbWGx8ES2RChyg>
    <xmx:jtFuaBL_Kbi20z6ONoLdImTLKa8rvSCSVC8ruSu5T5Go51WmS-C6Rg>
    <xmx:j9FuaKudRgcrBp3K67bNCujH_k1ZtWuyRy2tn6FLgBReOHoOiMT8hM4b>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65A0A700065; Wed,  9 Jul 2025 16:31:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Wed, 09 Jul 2025 22:30:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Darrick J. Wong" <djwong@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 "Anuj Gupta" <anuj20.g@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Kanchan Joshi" <joshi.k@samsung.com>, "LTP List" <ltp@lists.linux.it>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>, rbm@suse.com,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Pavel Begunkov" <asml.silence@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexey Dobriyan" <adobriyan@gmail.com>,
 "Eric Biggers" <ebiggers@google.com>, linux-kernel@vger.kernel.org
Message-Id: <290c17df-1bf2-45b8-b0c2-7a1865585d0a@app.fastmail.com>
In-Reply-To: <20250709182706.GF2672070@frogsfrogsfrogs>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250709182706.GF2672070@frogsfrogsfrogs>
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 20:27, Darrick J. Wong wrote:
> On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:

> though we probably want a helper or something to encapsulate those three
> comparisons to avoid the SOMETHING_SOMETHING part:
>
> #define IOC_DISPATCH(c) \
> 	((c) & ~(_IOC(0, 0, 0, _IOC_SIZE(_IOC_SIZEMASK))))
>
> 	switch (IOC_DISPATCH(cmd)) {
> 	case IOC_DISPATCH(FS_IOC_FSGETXATTR):
> 		return ioctl_fsgetxattr(filp, cmd, argp);
>
> Assuming that ioctl_fsgetxattr derives size from @cmd and rejects values
> that it doesn't like.  Hrm?

This may work in specific cases, but it adds a lot of complexity
and room for error if we try to do this in more places:

Ignoring the 'size' argument as above would mean that
each case now has to add an extra size check in each 'case',
which then defeats the entire purpose.

I should maybe dig out my notes for table-driver ioctl
handlers, if we want to improve the way that drivers define
their ioctl implementations, I'm sure there is some
infrastructure we can come up with that can help here,
but I don't think 'same as before but more macros' is the
answer.

joydev_ioctl_common() is an existing example doing something
like it and gets it right, while snd_compr_ioctl() is an
example that looks completely broken to me.

>> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
>> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
>
> blk_get_meta_cap already checks this.

I had thought about removing it there, but decided against that.
Maybe a better way would be to have the full check inside of 
blk_get_meta_cap() and use the -ENOIOCTLCMD return code
to keep the caller simple:

   switch(cmd) {
   ...
   default:
         break;
   }
   ret = blk_get_meta_cap(bdev, cmd, argp);
   if (ret != -ENOIOCTLCMD)
        return ret;
   ...
   return -ENOIOCTLCMD;

       Arnd

