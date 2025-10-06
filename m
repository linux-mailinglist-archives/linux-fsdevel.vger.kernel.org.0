Return-Path: <linux-fsdevel+bounces-63483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB677BBDE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32AD134ACAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90728271A9A;
	Mon,  6 Oct 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BCFXrJgc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qk/OTV/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5720FA9C;
	Mon,  6 Oct 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751050; cv=none; b=CtMrQ4lCGHdHnsYDaXvRa3c5dreu5pGsgcKrg4uHmr9WdaStVMlva3JK8qFGfVEtlKp2/V8G03bkpwfJhSilt6wEp/o+4W+87GIluyxUUpfpfEkGMTOd7jHoCPLspWN/MtS8u9RWuX5CD2+Fw3LM9Tya88Y7bZ/nEe6CYB/YCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751050; c=relaxed/simple;
	bh=otQKP70KlnBh0oPv+s/IaXMAdniFxCVmv+JtCuWTse4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cAmtih9bvICUSGTUuEV8dPudR34caBeJmSWpdr+y4/aO1drKUj2blAhWdhq5eEZZBGTl989LWasvc8Q8zDmDh45IKJM4ma5+m4i5FPAUVa58Z4XlrIcfU4oSRvLbInOsvx5GSuu/tx8a9KZialomXjTELR5z85DwQPV2k7CLTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BCFXrJgc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qk/OTV/q; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DEA0BEC0184;
	Mon,  6 Oct 2025 07:44:07 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 06 Oct 2025 07:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759751047;
	 x=1759837447; bh=flakQEfUiEUN5ds2CAe6wrYLb2nSlfUGGYC1oqEWYz0=; b=
	BCFXrJgcRNqvMK+YqeQRQeLlZq2VMZpYw0B64tyZHwPg2K0E6s+VFCPGj2ICwKeS
	cO2u5XgjmazVKL7+x7swKiuwMzKm9Qw5/6kaEAT5Ky5LqvhIa6FHQRxqfsZtm0Ii
	M20eUvoi9/qJCdXNb81nAbDUtRMh61EF2cg7XsUjb0DL67Otcb3Kdggrj8Hr3DiG
	5NCA93VE5cyEpc+WnXwFDjnwIg+1tJKlNnZ8aTbBX6rthOg5WI/uJ8a4i8thi+p7
	L/7+MfV2qojACgZhIu6B+nQIdAQ/izio8RHP9PuA7tmeA6HvABdb8Kxh7Q0JiY7+
	1PSdohK3oNaeA5D1gX8MNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759751047; x=
	1759837447; bh=flakQEfUiEUN5ds2CAe6wrYLb2nSlfUGGYC1oqEWYz0=; b=q
	k/OTV/qgAbdd9TiA95ChHcR7hJYYZ3AhmWGzoTig/deJG1voH4prGlX1W/vgFeNh
	gwc+w9VTUVxnwFW47+Xn4J7TN9T9HDpMAggAUhnS3XXtp6zLJzUyRpKFz3YeOYsh
	UMlqAcHZxJlsrcZJN+3qaKNpAzU4f0dZ2wY5M3ACuzE5ke/CnVm+NE2c4fED/Itm
	7sFNVHm2w/fe+3QP1aJ4s+u2LFsOuLBJdBkV0C74+6wYX1LrsSlgC6wFTqI3ieLW
	sf7NEHOufaFYrewoxososI58Ayo9VjsJWJaL+dchxj5bsNFBf+kIZ8xsqOFCa1sA
	tH2HPmYY9pWk6ylnRRgJA==
X-ME-Sender: <xms:h6vjaDMz44akIQONm5DUFv1-EmNoXytZAeIcBdu5MiS6len9TCRl2w>
    <xme:h6vjaIxyT9dTGAysG2gWho5D0qi26B0Khg7tQewyDVGI-BvgcVoTfT2BqlVEu1csQ
    4Tb54XhtrsvWZw0MTfMa1PvsJ56rLT0Dn_uUTuGOzv7898a-yUex8lS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    grlhgsvghrshhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghliheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    uhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegrrghlsggvrhhshhesrh
    gvughhrghtrdgtohhmpdhrtghpthhtoheptggrshgvhiesshgthhgruhhflhgvrhdqtggr
    rdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:h6vjaHLO1tsojGdjr7zu-jniF9JQhLh1pBhoBfEtnU6BFjG-5S4DMw>
    <xmx:h6vjaKl2b-ChJrLqdv-_qKFHeckcSTPFxTZ1mhAz0kOVpjsNgMRmfQ>
    <xmx:h6vjaAxhCDrsamzFWG_-Dsto0iIomoYE47pyf0yoNuRxw1fXFgQoZQ>
    <xmx:h6vjaEuNfE8XssWgoUqjMQph1AOC566aA1Xn2I7qUNn36uFPCKC7oA>
    <xmx:h6vjaCC-e3Z7EAY-jaOC4w5KZbx5u1dXWrDp3PBbcMVHcZgiVGM5CLgj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EFE27700065; Mon,  6 Oct 2025 07:44:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1b8DCvSJbEV
Date: Mon, 06 Oct 2025 13:43:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Slaby" <jirislaby@kernel.org>,
 "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 selinux@vger.kernel.org, "Andrey Albershteyn" <aalbersh@kernel.org>
Message-Id: <69094222-d918-4108-877c-51a666b53707@app.fastmail.com>
In-Reply-To: <a622643f-1585-40b0-9441-cf7ece176e83@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
 <a622643f-1585-40b0-9441-cf7ece176e83@kernel.org>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 13:09, Jiri Slaby wrote:
> On 30. 06. 25, 18:20, Andrey Albershteyn wrote:
>> Future patches will add new syscalls which use these functions. As
>> this interface won't be used for ioctls only, the EOPNOSUPP is more
>> appropriate return code.
>> 
>> This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
>> vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
>> EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
>> 
...
> dumps in 6.16:
> sf: ioctl: Operation not supported
>
> with the above patch:
> sf: ioctl: Inappropriate ioctl for device
>
>
> Is this expected?

This does look like an unintentional bug: As far as I can see, the
-ENOIOCTLCMD was previously used to indicate that a particular filesystem
does not have a fileattr_{get,set} callback at all, while individual
filesystems used EOPNOSUPP to indicate that a particular attribute
flag is unsupported. With the double conversion, both error codes
get turned into a single one.

     Arnd

