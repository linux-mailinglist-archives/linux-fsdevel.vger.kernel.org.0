Return-Path: <linux-fsdevel+bounces-25894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D29515F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57A31C21129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B213D2B2;
	Wed, 14 Aug 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="UxgO7wir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y35f4PEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6333BB59;
	Wed, 14 Aug 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622417; cv=none; b=qLxMLymFfQTpbKUrCrqLgY4U6dFSd7SW6UND0hyWOfSNy5WknWUpPwLMHzFHfSffEvtNqXGn1/DuwXzRHRzA7693/+ci2SktEn9LUT+0JxahYHsmaErvzYhwlK7UqLDIiy2droLEaLkQZDPYy871JmISMGChyuihAG6kwnm/XLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622417; c=relaxed/simple;
	bh=upYfMYxBsOchjs998xcox1lv5yKBThiWy8w6XZLUv38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxwG3bqDV/6iJYIyRr43dmCqHQLoDM86syIm1qZxnPrAo4ZqrjogNL9Dt3l5SwqpPMAM37rsOR1v6PBQEZ8Cl01Sj1HBDj9jzmOGQIdlJlekL0C+t8LeY0jTqSoiwgFrGL8K+Q31hp5cTkmZLpk0WsINXDdZuPPg1l0MScu1Tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=UxgO7wir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y35f4PEQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7654138FD10;
	Wed, 14 Aug 2024 04:00:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 04:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723622414;
	 x=1723708814; bh=b8j+zzW9AgMgFUPW3X+ImFRZLd2nxJo4Pyue7VTayh0=; b=
	UxgO7wir/s7jA1z5nKZrKpU0UJHI2SFFVuVpSlgl2iBovywhwZpm2zrOW87YDeSu
	SkHvVn2ArqVzwJz8eY9r4YTT4UF/dnPPmENi1djkDz+kqW2gKO8mF9Wu6OewlaQC
	XqUljk64hfO7ClCXV8od7cCI00yGfJTuF91ARxI8DZZQ0MISjFEo5lXtdyviWita
	tyEStkrTwAlrM2gXX2Z+G+uoA9h09WMtP1v4MUdPUm/UkmHTD7qycdZ3iE9nO8kU
	wODwWrYDrxYCYBF57fUc0J0WWJZCmozM0uoCZjSJKiaJnQAqwlnZj2hOldTLw34F
	OYgpOkhSQTdyQ5TT5ztZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723622414; x=
	1723708814; bh=b8j+zzW9AgMgFUPW3X+ImFRZLd2nxJo4Pyue7VTayh0=; b=Y
	35f4PEQdL8i791Vta0LTpqE9ARr94lThnNmMlDdYKP3K2mCcbgMjyjkMvWRM6++B
	wYxpEKt2ceh5PpQ/e4f67r0xPQGWxv3F06VzE1LIxpptxoPuT6mGPyHku82TH3oN
	TQEHHTq14xyIQ4qtGhqjQQKFVj1RONhbyQjKRcOJXsu9f20lXFL6WZRq+QJjpmbz
	mGTvzKkeLZa3x7rOFkSxRr3yVSrLwtDivjc8Sn5Rqe4uq7qPq8vYLetI0e4kHdW/
	NRcRHPYSW5JrP13hAXVyHwX4er42UHC/6l7hjQ5T1LHtn6t6zJPgGIoA+ig6IeCy
	C27o3EBc/gIlLrlAKeAGw==
X-ME-Sender: <xms:DmS8ZhK8abLDVLB6RHVK3QN7RYgYrGpnlOjjnmFtlS_hDjsX0aQp3w>
    <xme:DmS8ZtJbizrjfRDAcYoE5ZkFade3xSLNPqkQXflwYPXbNDsb0_sMDqzoLYQTgky7S
    -mSCWe92uxK>
X-ME-Received: <xmr:DmS8ZpsczdozNTLLUssP2Bb9J5L5kEEOqJrg4dhEK6VZEJbpt0Ug1OKF8naSk1CavYHLTtpb3oXWMnSOafMugEC58MBLGpF5D-MS-IZEGkl5_NGbGBNiBQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqe
    enucggtffrrghtthgvrhhnpeefkefhgeeigeetleffgeelteejkeduvdfhheejhfehueei
    tdehuefhkeeukeffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuh
    igrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DmS8Zibcz37vd77kqvDyx0t45GgZMDiO7s9q8H4CReh_5F2iP5qMZA>
    <xmx:DmS8ZoakluHnKGNKXe_7JEF9OeP8hpcYaCEVP2ZOCVFxmyRsg_zmvA>
    <xmx:DmS8ZmANY8V4s_P82cVm1DHtrK-Vl0OK_vZpasSEWE_7mW2A7bCxoA>
    <xmx:DmS8ZmaDThBmymIAzEy0zAHRr2hAkdNogbxzTXx8Y1wqIY0wlZ-I2g>
    <xmx:DmS8ZvXYaoq9F8ZjsdT0QXSUhw-7BDskdegQSyeY1w8q5NN8KjLza5c6>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 04:00:12 -0400 (EDT)
Message-ID: <da8706b9-f1e5-4f88-9250-d05f33021cc7@themaw.net>
Date: Wed, 14 Aug 2024 16:00:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autofs: add per dentry expire timeout
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240814035037.44267-1-raven@themaw.net>
 <20240814054552.GR13701@ZenIV>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20240814054552.GR13701@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/8/24 13:45, Al Viro wrote:
> On Wed, Aug 14, 2024 at 11:50:37AM +0800, Ian Kent wrote:
>
>> +		inode_lock_shared(inode);
>> +		dentry = try_lookup_one_len(param->path, base, path_len);
>> +		inode_unlock_shared(inode);
>> +		if (!dentry)
>> +			return -ENOENT;
>> +		ino = autofs_dentry_ino(dentry);
> Why can't we get ERR_PTR(...) from try_lookup_one_len() here?

Oops!

Thanks Al, I'll post a v2.


Ian


