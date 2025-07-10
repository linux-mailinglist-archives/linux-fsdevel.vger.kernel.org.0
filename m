Return-Path: <linux-fsdevel+bounces-54467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8FAFFFC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868155A4FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560312E0B44;
	Thu, 10 Jul 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DgfJaqBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnmjG3mz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8F2D8768;
	Thu, 10 Jul 2025 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144758; cv=none; b=LsfntI6LkBhk3SZzZ7NZqbFKmY2DvfS0Eg0heuXwVqYqq6+XMsLEB6oMyzloTgWWXLkEu2PoUveWeBKwP4FYOzcQzycL3qT6qhm5EMlmd59Yorsj3Qa44hT+IvKCJZgyiSt34suIQ4WAd/QytTSeY2xkYKEoFt6BgvexMsBxKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144758; c=relaxed/simple;
	bh=KvdGXFpbSMeTAvNejdLx45i4cdmZM1wVv1dWAgu3PIk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FiOHTz9rCPvtoeM5X1v7Fqniq9lhxjfp7rtT2t4BkF7DxmJ3pCI+4+IAg8kTvTgWnlc1FdSi9VB+xY7r6Q1ivQaW1nF7ac5KRG0SY8XEKH+TydPyOpiLuoXd+E3vq2rkFicGMYr35wkoOsLFkExCHv6iOUdGgfQ+UL36CieG4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DgfJaqBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnmjG3mz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 163291D0022C;
	Thu, 10 Jul 2025 06:52:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 06:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752144753;
	 x=1752231153; bh=0gfneUvxMhMOudwcTkveb+Z5iH50FPbib15VirueTyI=; b=
	DgfJaqBEjtIWo2qVEqkhwea8XYJMPKrVGxlbUAi9PIu03TiZf7gJl3Zut9N7BKQ6
	qtZGybcI0toS7/KR5vVAjR7KbmO/MvBHGKdcndbniM5NgWipl6bX226HPiEsXUe+
	pXTa23UkM+VtnRuW7Ws5hJyVCKpN7RVb5KyOf/Ak0s48xr3SOIo92E6BbTwcPWCx
	Ta0KPigiRSTDtj1UIT+yjKBbUY7VhGHTlrv6GqRH+2AwlWDv/OqEX8SVuMEGlS3e
	5iFZO2oZJtSKndxmAOR5jhz2wi+BJVU1PgC97r8M/afkcR6dyf7t95+JtTTo0Zew
	Uehu2qceNyMAqAIat9n5cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752144753; x=
	1752231153; bh=0gfneUvxMhMOudwcTkveb+Z5iH50FPbib15VirueTyI=; b=E
	nmjG3mzp5sEJUZnbnQkz+hdKdkkioCFPR6lKGFY5qWNfnFMCsaZSHHsYeu9j17Kw
	FKhL0UCBDQRBLWSIOUFK1BpX4iB4NQJ856cXHbH+Kp9VHDFsGUEYxseeKJRE1ozf
	3yJuHUcaLnXi009fu34OUcyuKUNs/2ClWaanfE/GffphxmP07A2d/djGxiJ/2B2A
	RDRlYHWje9y9Z6IvSWikW66m7qc/VPiXT9vo/19F9BcmskS0Zr3MVBAtpyARG5Bm
	oW9XkC0tF9O2HhyMkY4xPchv5Gw0Z7CPKBdegZ8R3uhDXKnU/OTHNRlZwn8ze4JB
	L5oqs+zU+wQHN5YrwwIxg==
X-ME-Sender: <xms:cJtvaP005eWpEdmFaymEdxcaAJGkzaz37r65MTMJAr4lHADwgcBiHw>
    <xme:cJtvaOH5ZFfTGN5VZVK0i0mo_CvhVMsaInJ-0G8uzwtLfP1HfULVAqITYYNxp8mGS
    CbOqv4SDcVab_RwToY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddvhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cJtvaAuqYlQlUJeKbet9nZFqgeMjEc0kOTwx088LF1qDjgKX5pD10Q>
    <xmx:cJtvaLIBWFqS9N-t8QW8M71CJ0Lo1iRci2SSJSr348iIK8fB5SfBSA>
    <xmx:cJtvaGM7cjVb2gvoebFnm7vkAvq5-ugmuPKDngwpOg5yN7A7dKafaw>
    <xmx:cJtvaLZcDAY_5q9FQvnhQByEAPz7-_IdJ_KFU4S1su_9Dql8BgBnTA>
    <xmx:cZtvaJS1pwPhZ921JckyTbzO7XnBE8E9IQ6WPHQMs8CCnqftNbveDcwy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE797700069; Thu, 10 Jul 2025 06:52:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Thu, 10 Jul 2025 12:50:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
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
Message-Id: <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
In-Reply-To: <aG92abpCeyML01E1@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 10:14, Christoph Hellwig wrote:
> On Thu, Jul 10, 2025 at 10:00:48AM +0200, Christian Brauner wrote:
>> +       switch (_IOC_NR(cmd)) {
>> +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
>> +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
>> +                       break;
>> +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
>> +                       break;
>> +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
>> +                       break;
>> +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
>> +                       break;
>> +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
>> +                       break;
>> +               return blk_get_meta_cap(bdev, cmd, argp);
>> +       }
>
> Yikes.  I really don't get why we're trying change the way how ioctls
> worked forever.  We can and usually do use the size based macro already.
> And when we introduce a new size (which should happen rarely), we add a
> new entry to the switch using the normal _IO* macros, and either
> rename the struct, or use offsetofend in the _IO* entry for the old one.
>
> Just in XFS which I remember in detail we've done that to extend
> structures in backwards compatible ways multiple times.

There are multiple methods we've used to do this in the past,
but I don't think any of them are great, including the version
that Christian is trying to push now:

The most common variant is to leave extra room at the end of
a structure and use that as in your 1fd8159e7ca4 ("xfs: export zoned
geometry via XFS_FSOP_GEOM") and many other examples.
This is probably the easiest and it only fails once you run out of
spare room and have to pick a new command number. A common mistake
here is to forget checking the padding in the input data against
zero, so old kernels just ignore whatever new userspace tried
to pass.

I think the variant from commit 1b6d968de22b ("xfs: bump
XFS_IOC_FSGEOMETRY to v5 structures") where the old structure
gets renamed and the existing macro refers to a different
command code is more problematic. We used to always require
userspace to be built against the oldest kernel headers it could run
on. This worked fine in the past but it appears that userspace
(in particular glibc) has increasingly expected to also work
on older kernels when building against new headers.

Adding a new command code along with the new structure as in
cc68a8a5a433 ("btrfs: new ioctl TREE_SEARCH_V2") is probably
better here: While this does require userspace to have code
for calling either version, building an old program against
the new header still does the right thing and works on both
old and new kernels.

Christian's version using the copy_struct_{from,to}_user()
aims to avoid most of the problems. The main downside I see
here is the extra complexity in the kernel. As far as I can
tell, this has mainly led to extra kernel bugs but has not
actually resulted in any structure getting seamlessly
extended.

      Arnd

