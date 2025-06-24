Return-Path: <linux-fsdevel+bounces-52750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E957AE6333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B5D7A4136
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD5D286D56;
	Tue, 24 Jun 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="QhdYlYB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n0jKip/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7419F480
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763026; cv=none; b=lOBfa4qekkneqAmW1JMNv5QAS6zDFogw5Z4hzM3Ao4VDZg92mWZNnSr1Td69jaLMtwqgJ3HHkGNYBn9A1iAE9g6MzHN6KJcyL8+kWewrTgyYCZUn08zzJ1CGz4mJg4/8iShRoG5cDP99XyMRD5fp9fQI/1jYaDdc/BvFY/wr4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763026; c=relaxed/simple;
	bh=4CegfEkKvABjJ7L/h7fe4HEIXLyTW5qw/mN69+NBrMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bATpETkNF+bNvY4QArY4PGy+buICO/ssohqXpr5xVgHEY7zO8nd/hz4w3KiIHKq1SUCJUoWncFNJ2T1n58tbJjHu/5WXMmQZk+fSsryic/rAOOXKrj5P3fXIo7/YJEbsGEBuBlMdImTRAaCxdYtkrNcYDeRSJeyKuQ4+PkUC51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=QhdYlYB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n0jKip/D; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CEA4114017E;
	Tue, 24 Jun 2025 07:03:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 07:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750763023;
	 x=1750849423; bh=mKdDcT6nPMv0lOyJCXJhNetcEX8t8wEb5+Ehzx1PdSU=; b=
	QhdYlYB3irR/qAxVqvAze7lGABpzaDH00YO+P9fysy/4+CM7isQIPV8xDfko1vos
	b3L3yCGhN4O03ipXWimrRq2RI/v/JbUMW1pjQnZtEYAAfLPHJSHOZRTUbVros9k+
	8sBVkBDUHvhXyHkqpYjNG3x5251Q656zSEpw+bg6SJ4NN0rt2yM4221aJj91A/qp
	8Xv1irIfKBahsHjyfdlt+rXOseuUGpyYLmZ5MbJ0Qjh/eDUxcrU95dS3V2nKz4UJ
	1AhaWfkPOtkYcCvkeWSwOSDnqs2EUbx7QCwUWVVE79He3NUChoYikaEMEmILcfdh
	NaN2cVU8SQEpV/ZXFvHyVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750763023; x=
	1750849423; bh=mKdDcT6nPMv0lOyJCXJhNetcEX8t8wEb5+Ehzx1PdSU=; b=n
	0jKip/DwXQvAL01EuqxmHWwLGx2SHJpjGY1/DrFI5xzXCIEP/UqrA5v2+uvrcnC1
	GKeAzYsdKfP99Mq15ERybjB1lPUasVbbUkbQPGphVZQnZtKshu2HSuhMwFC4x/ge
	utJKcqjkbVZ27LFPtXVoQ7+AU9+HN0NW+p4mKYA5fb6a9ICDmFgh42xO7rNu7M9g
	5/ygOOAK+Wfbrm0oA8qerZ6Y4PqzVxm18Z+aJ0MjmL1s/qRz0NpLMFKn60KlwVmO
	jL4pKyC/uD2BA9ebjHxVi7Doy+bTusZOF+zoHJIRG4ag8QB0nAL9DliLMEFwXHOa
	T6CI0A8/DXDkISho+3L1g==
X-ME-Sender: <xms:DoZaaP6xNex-VhTaBHs-36SuDXxYkvw7t-c6rNWU5FoOKV3SqlBZVw>
    <xme:DoZaaE4Z5XIVr3ICf_lFQjbK9n1q9xR0WNyaKAP7DYZ3tGdbemfVpmoltqT8UiKWV
    Nn-YSgyRanF>
X-ME-Received: <xmr:DoZaaGcykK8VFGikIYuX59pn2uGHSQRdai1bILw8a941ettCAlRj8-UCbgocrNNoZETofwSUPEWL5-rPrL_yx8iKsazbNn09MftDaQgX3e-6AdVur-I9vEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeefke
    fhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrd
    gtohhm
X-ME-Proxy: <xmx:DoZaaAJshVsaNFD7lvJ55uwGhngVxatOCaiLYJaWhedavO5ohZ5Hrw>
    <xmx:DoZaaDKN9GCZBZ23vRycv_E7ONqpQQzpkRNoNWTyD0KxjJJk7d3Rpw>
    <xmx:DoZaaJym-QWbd8KSRQE7GMojN2CHdxGFcW90IUTfovXJllZvNCyWFA>
    <xmx:DoZaaPKpaSlx8BxOzra_-aDuK731-AjO6sT0f_Ok3vntvEphbXyLwA>
    <xmx:D4ZaaCKz4E0yo7pmhi8XUQTGPUAaaTd0tp25t7bKlpf7ycIvm0DoCPN2>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 07:03:40 -0400 (EDT)
Message-ID: <caf39678-8e83-445d-9340-d75b74c22f74@themaw.net>
Date: Tue, 24 Jun 2025 19:03:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>
References: <20250610081758.GE299672@ZenIV> <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
 <20250623185540.GH1880847@ZenIV>
 <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
 <20250624070533.GN1880847@ZenIV>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250624070533.GN1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/6/25 15:05, Al Viro wrote:
> On Tue, Jun 24, 2025 at 02:48:53PM +0800, Ian Kent wrote:
>
>> Also alter may_umount_tree() to take a flag to indicate a reference to
>> the passed in mount is held.
>>
>> This avoids unnecessary umount requests being sent to the automount
>> daemon if a mount in another mount namespace is in use when the expire
>> check is done.
> Huh?  I'm probably missing something, but all callers of may_umount_tree()
> seem to be passing that flag...  propagate_mount_tree_busy() - sure, but why
> does may_umount_tree() get that?
>
> I'm half-asleep at the moment (3am here), so maybe it will make more sense
> in the morning...

Yes, fair point, maybe it should be propagate_mount_tree_busy() only 
that grows

a flag as it's the function that gets called without knowing whether the 
caller

holds an additional reference to the mount or not.


Ian





