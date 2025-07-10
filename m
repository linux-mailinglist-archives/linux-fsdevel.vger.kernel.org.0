Return-Path: <linux-fsdevel+bounces-54478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D81B000D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38BA3AD408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77424DCF8;
	Thu, 10 Jul 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H5g/QZFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OPezGPcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD3248F7D;
	Thu, 10 Jul 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148403; cv=none; b=pqMDoxN3IQoEjkW+a5rEnB09FO6oLp0yi7AfUhdt1jnOqrm1wKtAh2pNbW1Jq3JyPZE1U8aeDNo7hFsb/SJRSzfPtlEHTqablUVI5Bt/o7QCX4Sb28ogFzO+UFzxqVNaiyFvswGK1HZWiS5oRO3E3dX53Yn5iLHaq3Wbtn9cAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148403; c=relaxed/simple;
	bh=0rNi0NWwAGS/m3tH+/mj7RHCQBBaydL72v9Fg5u9Ueg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b7xEH8shOpIEjSp/03vE93wecRIMZ14aE5qplVHg+BLzjU3KLfhTpNKTc2FObca0xeF2PtPeSd43ZXTzi0vD+9eoCD5CWtyTiRxP76MqxDmdyB8TmJVPVB/3mCGZ8537m0a+0urMrjVcZpAxi/9jWB5Q9NITWot8a/zbmFHiAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H5g/QZFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OPezGPcZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 240371D000FD;
	Thu, 10 Jul 2025 07:53:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 07:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752148398;
	 x=1752234798; bh=sje5hVMNJ8lPTMZdAUbJxjg9+p9H/ddbEIFabV5Qvsk=; b=
	H5g/QZFUxQ7xVn9yddlLHQ0YjxLDnqSf1BIV8mBUShvFeRMBDKhXER5GYcjHDGHd
	1fu88NUSLA5oyMVQRmQWMz1B7+4l9ejbI+srWjmtrTrLWXDQOpKyDL9MmErGWz61
	Se0y3wkbZ8xrJG8Dux+VBRUXWjvTMER0jxMNvpSriT8f/nY6/YURf69x7/YA0veZ
	jNolUp6MYMkGsJzyWOMrD52NUhyxW7XFRDftUTHcjHTnnFHB5YPw5Hh1aNA/R1nC
	+xDVH6GSJwS6MFWri1nJVOm58y+5ng76NnLNtWAXAgAWHLErjF2+Su5HLSNwkDim
	xRvgj/F+iSQg7w4UZ5BakQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752148398; x=
	1752234798; bh=sje5hVMNJ8lPTMZdAUbJxjg9+p9H/ddbEIFabV5Qvsk=; b=O
	PezGPcZCPi7/YI6RyX0H7hEWY6gO8J+wGDeVAv8ZJNDoAK9DK5xH5s7hL8PxkjCA
	2Q2Had7guZJC/veJIiFvpld6N2QkbQVd5zUkX/6kwgL+XLSgVa1/Pu6sxiiu/AZO
	Ug/3hVOYqetr6DcvUbuGcKkvTlgiuFJ4Ny7pSsK8z7nUnsOQxYd2fBVvrDwxM+tj
	6e6XjA9stwjgjlsXj++o68ZAOUMgn4UBQiCR1EwpXoEdKl9ysMIxh9BDEOxR/IY8
	1gzoFt6GaFcLmqtEFZSLiyEnWZyO8iTEa+nOCgT1kRGw0ZFzhTCt4Dr2Lh5RZNwm
	1HeSxPKYkwIXtnyfgio4g==
X-ME-Sender: <xms:rqlvaIL-OWtGobJ1BygHkArXG8NxhDInoaWQkevKsHA7E038cYk2Pw>
    <xme:rqlvaIJFKGavDtgfz1irQKtYLyk-9KN7jUFP1eDfAaVXq-jOCmvuWO7bN7R70Nt6-
    SB2zWaItmBeF_FGN9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomhdprhgtphhtthhope
    grshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomhdprhgtphhtthhopegvsghighhg
    vghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohep
    rghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:rqlvaJgth2K4VWfvfXK_ydRAItC1dpGByAKUCbDdSiaZcbVLkOagTA>
    <xmx:rqlvaLuyELow4oH9maxfs-PYJk0tTRDa9z1vpUQQNzGdumf9o2makg>
    <xmx:rqlvaDiyb-hS6MjVhM7nn1HGTWos7O7P53HGbsfC_EI6u9pCX8xfmw>
    <xmx:rqlvaGdTFzdFQOPw6oZ3qgf08FBCwlB89Uvp3NIzEqAQUoD-Mo747Q>
    <xmx:rqlvaE2LP-vm7ChxAYptsC5zW5BZrB0ztKgF6gt4f-68g-j3q0sERj7d>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F28FA700065; Thu, 10 Jul 2025 07:53:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Thu, 10 Jul 2025 13:52:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, "Anuj Gupta" <anuj20.g@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Kanchan Joshi" <joshi.k@samsung.com>, "LTP List" <ltp@lists.linux.it>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>, rbm@suse.com,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Pavel Begunkov" <asml.silence@gmail.com>,
 "Alexey Dobriyan" <adobriyan@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, "Eric Biggers" <ebiggers@google.com>,
 linux-kernel@vger.kernel.org
Message-Id: <50e77c3f-4704-4fb8-a3ac-9686d76fad30@app.fastmail.com>
In-Reply-To: <aG-dI2wJDl-HfzFG@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
 <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
 <aG-dI2wJDl-HfzFG@infradead.org>
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 12:59, Christoph Hellwig wrote:
>> I think the variant from commit 1b6d968de22b ("xfs: bump
>> XFS_IOC_FSGEOMETRY to v5 structures") where the old structure
>> gets renamed and the existing macro refers to a different
>> command code is more problematic. We used to always require
>> userspace to be built against the oldest kernel headers it could run
>> on. This worked fine in the past but it appears that userspace
>> (in particular glibc) has increasingly expected to also work
>> on older kernels when building against new headers.
>
> This is what I meant.  Note that the userspace in this case also keeps a
> case trying the old structure, but that does indeed require keeping the
> userspace somewhat in lockstep if you do the renaming as in this example.

Right, it's fine for applications that keep a copy of the uapi
header file, because they can implement both versions when they
update to the new version of that file.

Redefining the ioctl command code does break if you have an
unmodified application source tree that unintentionally uses
the updated /usr/include/linux/*.h file. In this case there is
no benefit from the new header because it isn't aware of the
new struct member but it still ends up failing on old kernels.

   Arnd

