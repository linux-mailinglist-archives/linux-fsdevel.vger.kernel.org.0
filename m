Return-Path: <linux-fsdevel+bounces-46574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35365A90819
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3A21907EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131D20FAAC;
	Wed, 16 Apr 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Q3aiAyJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ape697iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AABA50;
	Wed, 16 Apr 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818948; cv=none; b=Na24k6jXO1ME7M9A1bHXNFShgLLAX+ljFoRGRmbIXpgqxS8uUndPLUizarvhZ6E9PZtIZgR9uXljX+9rkO1hikmzj46A4B3ggyeQWdBhI/aOkdo90XAl/sc3YMSAPDC9319Bi1Pk9vAwac+vEcK000K+oqGueOxKstRat2zbpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818948; c=relaxed/simple;
	bh=9pbg4C0z8sXp7KkEc5RFY+hZQ1L/rGu7X3Ow2EVMjqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhswA8SbBJgH3zxu1QQlEe4guEJmwOUbpmdVVdh68PR8thXaYM2bdHkzVqAtaAAfVca0u6vvjQT+rglZkRryvmcwx3JACvFhwnirSEH51VhqNJGFTE65XNBxvjUwPke0bOZwAz22ZqS1G+6Vw0I8Jce15Ph8Lfcd9UIWShvfC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Q3aiAyJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ape697iD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B70A1140293;
	Wed, 16 Apr 2025 11:55:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 11:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744818944;
	 x=1744905344; bh=EVsUq8vIHVHSJ8OpZq0XMo4UVFNqeRv0Sm7W7t18X/s=; b=
	Q3aiAyJsevWE/ISVeky1rPGQZFQI8JAxruyp32pE43BHMbnOi8EUxnrQU4HWg8CG
	QmRb0xNvOgk9MFQQZ5Ah5HMN0LjyQpYDmZ7ydY4rHKmyxl0iH1WTw/eBssZk02VL
	+8y53bKuP+BJhMTieMK7u7TRUyZWbCfTbJjuOucek3z9kMTEHBWwbhAu10XvCoF5
	iu+wX2zHaQpHbozF0GzbPz7X6B+y3CKdEahr5/GYyPLT0vKyc+Bh4L2NhkJBgIqB
	poFY3OCN+QjR/Mefy67IFwkr7hr6nek9MgLwUD/5+o51ysCPAteJXH2c1INubG1E
	bDCX6nyWGi7C6KBP0+v5VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744818944; x=
	1744905344; bh=EVsUq8vIHVHSJ8OpZq0XMo4UVFNqeRv0Sm7W7t18X/s=; b=A
	pe697iDAH3rFm+RhD2cv8csyY/ecTvQOGunw0sH11LheoKs9EVCJgiwKKeXneP4S
	ACbCpWWhacDZ4juyUDt3YvUvDSJNEY7a7Xbe3BbQOHQfBt5/SL6+UhoNTjK1mSHq
	1ICm4Y7Tk344V7WJtxqH+9oT8SJulM/DYVH7A2ZBninXcxQV6VV1Ml8+PXbPlfTv
	/puKBiEbjK6AkAYKGqLiAr5RoOqLk+inCHunenrSefG3chI02lPf0bekagOgc+iG
	G7LjE1G2HqY5BSpAD0js0vPC7KsLea70WQiQsX7UfACuw23NdFNF2mTTF3c+iJWv
	gxDpw8AWHZgW1oVdD2ceg==
X-ME-Sender: <xms:_9L_ZymCMPyx3sQqJ8O0VYwakETCEdUWOeazsvE2I2At18aj8ULrVA>
    <xme:_9L_Z51dWsmSL8qEx4kkDeoXGlSzpVleUBkyzgEL6UlWBiYh-M1VLGyssNxPpXdHd
    kGT387b5GdWALM7>
X-ME-Received: <xmr:_9L_ZwpCsVXXJQWDewPEPA6W3mnkh8QMZPEgCeyQlyt3u7FSJenIVQhB4br7HT-c0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeijeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdel
    ffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhishesih
    hgrghlihgrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdp
    rhgtphhtthhopehlrghurhgrrdhprhhomhgsvghrghgvrhestggvrhhnrdgthhdprhgtph
    htthhopegurghvihgusehfrhhomhhorhgsihhtrdgtohhmpdhrtghpthhtohepmhhhrghr
    vhgvhiesjhhumhhpthhrrgguihhnghdrtghomhdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvg
    hlqdguvghvsehighgrlhhirgdrtghomh
X-ME-Proxy: <xmx:_9L_Z2mG6Y8EWSakQ2eOTPLXAbZ2wkjoCTV6Senykb8dNzK0X7tVng>
    <xmx:_9L_Zw1VQEhPa7Id0NAYVP6oajSI_YnaZZaeT5X9uuEx62bfY12_9g>
    <xmx:_9L_Z9uAsL5nDn0rKRJf0avlsMo76RCvm4dlJuhq_APW7ZVPpHpG4g>
    <xmx:_9L_Z8UwbessxYtPJdcW_Q6Ni3wBzqMAzR2c7Vue4pkIdZgjcV5jjQ>
    <xmx:ANP_Z4YbEQpKEhs-w3vEhYs18WpKis_HJ_65h8Dk_U3ltomd_8ueLXyb>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 11:55:42 -0400 (EDT)
Message-ID: <89257861-9f17-4c07-8358-f90392032983@bsbernd.com>
Date: Wed, 16 Apr 2025 17:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] fuse: add optional workqueue to periodically
 invalidate expired dentries
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Laura Promberger <laura.promberger@cern.ch>,
 Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250415133801.28923-1-luis@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20250415133801.28923-1-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luis

On 4/15/25 15:38, Luis Henriques wrote:
> This patch adds a new mount option that will allow to set a workqueue to
> periodically invalidate expired dentries.  When this parameter is set,
> every new (or revalidated) dentry will be added to a tree, sorted by
> expiry time.  The workqueue period is set when a filesystem is mounted
> using this new parameter, and can not be less than 5 seconds.


I will look into it tomorrow. I wonder a bit if we can extend it to 
provide an LRU and to limit max cached dentries without a timeout. Need 
to think about details.


Thanks,
Bernd

