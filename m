Return-Path: <linux-fsdevel+bounces-54457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9561AFFEC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D613BEA56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77A2D6615;
	Thu, 10 Jul 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U48+wTGE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aS7MD8ca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42A2D6404;
	Thu, 10 Jul 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142308; cv=none; b=u+3XvjIBdp67tFMH+aJmqpX0M7F7mJHyIDcDWGqAo/wPXSfenM5T2Cjc0GS2Ka5MVwZpX9Af6SBPPqypTflt4uJPOWF1BpQU7W8Ret8d04NAWPlJbd9WV8fEhIn2AlWfJ4viHodRzloEOHR/6Mqd3YuVQSiHe4y/9EiEG3KKwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142308; c=relaxed/simple;
	bh=IF+FueXXPhxbQmMzZ8TSJEEChMnwlObkIVgzWrxskaQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NzoOPamOv8nJoWQb6vc+Z8quu+z8FWXP+MOf6SfgJgeM2FB3D2sSHJ/En80UwZun0HQrYRGeAsv2LIQuB7zInPO/QT3sCIMvjOUwCKaYWwvm/RPMKsRCB6O6w5J3AX9pgAxgWUOAPGWKFD6QAmJO0lvHdB2EJ7Gf94SFI8vf0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U48+wTGE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aS7MD8ca; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 748CE1D000CF;
	Thu, 10 Jul 2025 06:11:44 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 06:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752142304;
	 x=1752228704; bh=ydaHlBV5gJlTgiENGrFYzr8bwPeWnPe7RkMn21aUeIM=; b=
	U48+wTGEOnDa0rOSVjCylRWZ4mgOPikGmxnGn6zgNKihmazbvsr7U0+UFWyvvrcw
	yW/7gfnf5XEPb7Z1stemw3LEdlE8jLr09LjTJLzm8tVuPjdgUDQP3BH5J6yuqQbz
	/xLvSJvqW0HxlAcMByG7jEhQI5tRmDJlpHyydLePkvUbdGWumU6foJMxdJLn4dcG
	5GLZT9hbAhvtoBhtBWuJq3Q2JdGjN/aUD1JFKy4fXr6xrJiVdlytoLHSAJQe+1xh
	XVOUYlclE7eChY3XX44no8J+8n3g9E+kxAbAD+KkLRRVFgf8bdHnNgsTrEFphPrW
	/WiNfXeGTgKIPcRwofBj2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752142304; x=
	1752228704; bh=ydaHlBV5gJlTgiENGrFYzr8bwPeWnPe7RkMn21aUeIM=; b=a
	S7MD8ca4kgudog25pPsFOzlN0Cg5w82G+y2083q8RY7l+scyECuzWqa5rZX2SgvN
	+J+jNYkaotWVW6wpJlkV2zVM59cGFKb2hQuMvl2kfbKS0p+pmBh5Zorhar1YzCP7
	4m3E+AU84M/gt+2ki6Do9mJv/t36WkXm6cUPYXgbbWjghYAjiZankWtNY6NgcpRi
	OZywdA9R6bnG/5NFqi+L9VYowuxINHEeCt2ZKpyNYY3tDCF2MeF2QFKUL2WRKQXy
	ASLS+GZGDXiLQnOUZwWS/OXQV5KQWZKXSBRCtQDGXbiMKlK+4tjeGuWyDm+Wu2gP
	5sGQavnvyltc3+9h9+pKg==
X-ME-Sender: <xms:35FvaDJFn-2y4V7KEfI0Uh8UTKDqPcODQ7KU_jVgLuxQ4Giqyahk1g>
    <xme:35FvaHJ-CbPByJZGY8DchBoPuZjBRroyUbdiS_0jLArK4dKAetXE4OjHTiMTF015H
    W6eYJUyI7fF_h5LAsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddujecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:35FvaCltc2zsvaaY_Md0KzCHB0PMLi4OisOpT4_ZCT0g2MVeVmWK7A>
    <xmx:35FvaO9EYyuoJqzan-TGmKsPz1_3lEWLrdnwjEaKCin3aDeWsDmW6Q>
    <xmx:35FvaDnrWPRhBYPyGervbtbFavwcCCIlGk8rYgBvqIqdtF_dqPvygg>
    <xmx:35FvaMmlCWdmTnvRpMa84ndCLVe5M3Ljd_d_-19qvs8bYgax4FYmCg>
    <xmx:4JFvaL6SHoLpYaV_TxPFRoEf_GlqruVC7gwsoNTvNnHh8X-YO7M_5h7V>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 27641700065; Thu, 10 Jul 2025 06:11:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Thu, 10 Jul 2025 12:11:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 "Anuj Gupta" <anuj20.g@samsung.com>,
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
Message-Id: <d2e1d4a9-d475-43e3-824b-579e5084aaf3@app.fastmail.com>
In-Reply-To: <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 10:00, Christian Brauner wrote:
> On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:

>> +	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
>> +	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
>> +	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
>> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
>> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
>
> This part is wrong as we handle larger sizes just fine via
> copy_struct_{from,to}_user().

I feel that is still an open question. As I understand it,
you want to make it slightly easier for userspace callers
to use future versions of an ioctl command by allowing them in
old kernels as well, by moving that complexity into the kernel.

Checking against _IOC_SIZE(FS_IOC_GETLBMD_CAP) would keep the
behavior consistent with the traditional model where userspace
needs to have a fallback to previous ABI versions.

> Arnd, objections to writing it as follows?:

> +       /* extensible ioctls */
> +       switch (_IOC_NR(cmd)) {
> +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
> +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> +                       break;
> +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
> +                       break;
> +               return blk_get_meta_cap(bdev, cmd, argp);

The 'PAGE_SIZE' seems arbitrary here, especially since that is often
larger than the maximum size that can be encoded in an ioctl command
number (8KB or 16KB depending on the architecture). If we do need
an upper bound larger than _IOC_SIZE(FS_IOC_GETLBMD_CAP), I think it
should be a fixed number rather than a configuration dependent
one, and I would prefer a smaller one over a larger one. Anything
over a few dozen bytes is certainly suspicious, and once it gets
to thousands of bytes, you need a dynamic allocation to avoid stack
overflow in the kernel.

I had already updated my patch to move the checks into
blk_get_meta_cap() itself and keep the caller simpler:

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 9d9dc9c32083..2909ebf27dc2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -62,10 +62,13 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
        struct logical_block_metadata_cap meta_cap = {};
        size_t usize = _IOC_SIZE(cmd);
 
-       if (!argp)
-               return -EINVAL;
-       if (usize < LBMD_SIZE_VER0)
-               return -EINVAL;
+       if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
+           _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
+           _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
+           _IOC_SIZE(cmd) < LBMD_SIZE_VER0 ||
+           _IOC_SIZE(cmd) > _IOC_SIZE(FS_IOC_GETLBMD_CAP))
+               return -ENOIOCTLCMD;
+
        if (!bi)
                goto out;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..af2e22e5533c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
                               void __user *argp)
 {
        unsigned int max_sectors;
+       int ret;
 
-       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-               return blk_get_meta_cap(bdev, cmd, argp);
+       ret = blk_get_meta_cap(bdev, cmd, argp);
+       if (ret != -ENOIOCTLCMD)
+               return ret;
 
        switch (cmd) {
        case BLKFLSBUF:

Regardless of what upper bound we pick, that at least limits
the complexity to the one function that actually wants it.

> And can I ask you to please take a look at fs/pidfs.c:pidfd_ioctl() and

PIDFD_GET_INFO has part of the same problem, as it still fails to
check the _IOC_DIR() bits. I see you added a check for _IOC_TYPE()
in commit 091ee63e36e8 ("pidfs: improve ioctl handling"), but
the comment you added describes an unrelated issue and the fix
was incomplete.

> fs/nsfs.c:ns_ioctl()?

You tried to add a similar validation in commit 7fd511f8c911
("nsfs: validate ioctls"), but it seems you got that wrong
both by missing the _IOC_DIR check and by having a typo in the
'_IOC_TYPE(cmd) == _IOC_TYPE(cmd)' line that means this is
always true rather than comparing against 'NSIO'.

Overall my feeling is similar to Christoph's, that the added
complexity in any of these three cases was a mistake, as it's
too easy to mess it up.

     Arnd

