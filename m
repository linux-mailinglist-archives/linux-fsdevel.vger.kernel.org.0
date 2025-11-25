Return-Path: <linux-fsdevel+bounces-69848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A33F5C87763
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4766D4E873B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90032E2DEF;
	Tue, 25 Nov 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dY3jONc5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xZXwcRzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487614086A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113444; cv=none; b=niXhKumhpbJcvA7G6IjIUHVyJHbFQs3+VUR5NRt9KFzL5S0NmlKrqfkeuRC7dh6h21Xz38LQyDedwPdl0THOcBVgmaDYVP4XSRNlhlaQCUy9JmAzXS2/3XQ08KvbZa3sfRGerd7tk4gksqPbtIGRYIAW2iKixPkmwjuHMQSeHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113444; c=relaxed/simple;
	bh=metLIQ+DKY/br7Qh8y0SHgE5n8mwg8x16xEJEA9yDzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3WmNkWnLVRrpiETp2jWYF3CQtfm05N1nOq9smHeuZeR7Rhlb5p1E8yds+64a55PY4BeZkf6xtP5X3QWFMml7h8UICR9G5dlibhL9ZzSnXtEUIbecXTz3vti7THm50FkYJB64irnwBjIvfmh8otW36OOr23GzgwBkF0nrPbClck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dY3jONc5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xZXwcRzG; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 45B731D00251;
	Tue, 25 Nov 2025 18:30:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Nov 2025 18:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764113441;
	 x=1764199841; bh=nlyisD2DoWvfJ2JWOQuBBQto+OFD9xdhpzDO5Al9tlY=; b=
	dY3jONc5ASFASYprEsMZutAZnZXRXoBlhPu4ecQnzKjS+Pb/O+N0/qbnNVKKk13+
	2raDv7d+O1mfduDfKjQzROxtXxXBIS+vIsHDKMQF7VF5myNN5QDfF/uMQQkON+wS
	IRuU4HwhwplE2icY3QTMGHrnywM+/p0Cl8WnzSAWnNjx8Ro8w0Dgeuc9ycEK4L1s
	+rWDN2lEPjYDHu3A/RMnaxdL1WJSrFus2IMYfzvtR+2hkPUTJMQVMRt9PsSL+Mk6
	UQwrW74f51DkJ63pJNS3mjn3lV4VGyXWPg/wXBTclZEyDP3f9Qjr+RtBFmhN+yax
	+ffWqh4gziMU5hXhjN7b6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764113441; x=
	1764199841; bh=nlyisD2DoWvfJ2JWOQuBBQto+OFD9xdhpzDO5Al9tlY=; b=x
	ZXwcRzGpZ/gdLXidpSsURnQx4tKMMxM4VyEWs8Y+qznXFFfhiaGtpDOoB/AS4oIV
	/T4Tcmyr2Pw8VJCU6wREGcnRYvEry20EWh9nma93ZeKL7TBaX/sP+ECpO+rdqTL9
	HJGNljvRZ+kHoU0qpJRZhBSyca4RdXPAmf9DsTnNVopjLlB3MtKZPpHfcVOaPHeD
	V8XvieFJFppkAFd2LM49k1JF5sAghhe6ouJe/WQ7oX3oSibrKIsQmN4Ve46r130q
	GDNgxgTSmkp+McdmoSA0qjIE/BgcRsk8NnGcyLS830yrmUhJYIaXkGkEKmP2OkSq
	neXpmp7NZEkNeJDqUxNwA==
X-ME-Sender: <xms:IDwmaTl5LqkCOryXMtRQfvN424G0b9UvxjMEL9ovrk7bafxmMjJ-9g>
    <xme:IDwmadu5axNaXDb0RQ8CXnnnEnhHMDh1zJE23reEqcSJXwxTF5smcsMCVDKObYsEm
    eQfpEMyQXrVS4YyrZK8DP8Kr_ZaxtE5MwO2_0ofSHcL5bVjqLgf1Q>
X-ME-Received: <xmr:IDwmaR93z_BYEt0nAjYzEVsF3XUSm6hNCm5HIGstQrYJSn4J11CUgJhdeN-tNTmJoY_I5ZQDnyLwgNEI5lSCIDImNim1o9adTocsoseAKz46zdHooU-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeigfigrnhhgseguughnrdgtohhmpdhrtghpthhtoh
    epmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvg
    hrthesuggunhdrtghomhdprhgtphhtthhopehgfihuseguughnrdgtohhm
X-ME-Proxy: <xmx:IDwmaXO8kCXmFHmUr-j2yqjlCDtEXa0a_xlVHQhX9PE48FgHyMEmYQ>
    <xmx:IDwmafFLCbGfcVDEiiFYWtoMh6gfZImpXKfm-puiJvOW3wvZ0vvFnA>
    <xmx:IDwmaVQ1WL8LVxelalUhbGkcduL8szdU9YcuqwUqhtQoxC1j3HDXvg>
    <xmx:IDwmact0IRBdPG-j6hTZdW4FOYGAT7WgWYob5qiV38O4FMN1R2wr-A>
    <xmx:ITwmaT5hgHemI1mLySRHHGpzNtM2zyj9p0_zcCH4E8Bemh8ZqAo5EUJ6>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 18:30:39 -0500 (EST)
Message-ID: <0a539736-3988-4e19-a027-873a7b219ca7@bsbernd.com>
Date: Wed, 26 Nov 2025 00:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Umask handling problem if FUSE_CAP_DONT_MASK is
 disabled
To: xwang@ddn.com, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com, gwu@ddn.com
References: <20251110-fuse_acl_umask-v1-1-cf1d431cae06@ddn.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251110-fuse_acl_umask-v1-1-cf1d431cae06@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/25 09:31, Xin Wang via B4 Relay wrote:
> From: Xin Wang <xwang@ddn.com>
> 
> According to umask manpage, it should be ignored if the parent has a
> default ACL.  But currently, if FUSE_CAP_DONT_MASK is disabled, fuse
> always applies umask no matter if the parent has a default ACL or not.
> This behaviior is not consistent with the behavior described in the
> manpage.
> 
> Fix the problem by checking if the parent has a default ACL before
> applying umask if FUSE_CAP_DONT_MASK is disabled.
> 
> ---
> We found that there may be a problem about umask handling in fuse code.
> According to umask manpage, it should be ignored if the parent has a
> default ACL. But currently, if FUSE_CAP_DONT_MASK is disabled, fuse always
> applies umask no matter if the parent has a default ACL or not. So, we
> think this may be a problem because it is not consistent with the behavior
> described in the manpage.
> 
> umask manpage:
>        Alternatively, if the parent directory has a default ACL
>        (see acl(5)), the umask is ignored, the default ACL is inherited,
>        the permission bits are set based on the inherited ACL, …

We had discussed this internally, it is better to just FUSE_DONT_MASK
and FUSE_POSIX_ACL from fuse server.

Confusing in current fuse_fill_super_common() is

/* Handle umasking inside the fuse code */
	if (sb->s_flags & SB_POSIXACL)  ===> Where is set from
		fc->dont_mask = 1;
	sb->s_flags |= SB_POSIXACL;

I.e. this assumes libfuse mount or fusermount would set MS_POSIXACL?
Libfuse isn't doing that - maybe we should we add an "acl" mount
option?


Thanks,
Bernd


