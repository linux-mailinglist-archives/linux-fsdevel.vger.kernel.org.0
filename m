Return-Path: <linux-fsdevel+bounces-21388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C17903542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF7A1F21F4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5117334E;
	Tue, 11 Jun 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="J/rYoVfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knDhbLDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow1-smtp.messagingengine.com (wflow1-smtp.messagingengine.com [64.147.123.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F03F8C7;
	Tue, 11 Jun 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093739; cv=none; b=rYX/8Juy/KVXENGvSFn6eBQPvXAdYF0Hi82IqBImV2PeWGfR9AY8hXRMVRt5y7Ymc+m7i/0Ot8mK7BmiGVwRDp3WhF7SrQ6ofEpLU9Kkrm1uv8oOInxQLh7wX+Obrwtx+m58NkEudTN6+DE8UAxw39WjUg/1UcOWchvjgdiV3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093739; c=relaxed/simple;
	bh=z43s94CnLrweY/tQQTWD/T164eJu5lCBbRFTHO2hCys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGyJ1FIh+Ev3pFy8c1ZGH+Lr4ssu33UkggZZtY4z/iAjfKKo9PwKzge4os0RdFhQwCzRkP+zXzw/nMHu3Rqe7VVsLpzGJPqfubgDM3A3ddkVCQYGyG4CBjLqWSjH5v+LKd6JP6Regs6G2LUPm6JQcZx4b2r9I36oYilGp8YAhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=J/rYoVfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knDhbLDt; arc=none smtp.client-ip=64.147.123.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 57A532CC01C9;
	Tue, 11 Jun 2024 04:15:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 Jun 2024 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718093733; x=1718097333; bh=FHmyaqd99K
	ibuNFcHRNSHKPpvreyC45H6/JsNKHxzgM=; b=J/rYoVfIrIPfb3R2Z5VsoocWAy
	9b2ZNUviqa5JVMGRCXBoiGRPeEeflfhkWFoS4xp0wjGjjSoSzjr9/Ry2HM1NQBN3
	rGqBL30RWZBG73M3IR0nPjnmrU3Sz21PdFoKWDbMJzhPW3O6iAMidFE01i0ne35m
	ZCifgOEBmaiySDmPBUt0jV5RVgES7tcTELewog99jLkcFGyJRB8tLQTfAuJ5fzWU
	NvC+jd9iAPGpwbp55drVsng9u6fA/WRQbuNVFLgVl4Q6G7g9XnWXU3XoTYp415xB
	qCvlyQPcfOV73rrJSbvTeUD+H6r87uB59hI4zB3Q1HHFT3ENM1XmjkFWtMsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718093733; x=1718097333; bh=FHmyaqd99KibuNFcHRNSHKPpvrey
	C45H6/JsNKHxzgM=; b=knDhbLDtDZHXqot+UutYHGqxS+ybOwLtEfM2l9Qv3Bwk
	xRNVii1WuqbblONh3bapyi6jj+y6ihyLWa0qNKKjHiIl7XFMm7fgR+5L+xCTF92K
	GWHUzRyxh9lghsjWzQ9gBVJ9hjKTS/HWxw2ShAhRKgm7Vm8yRx40W3qpoNsSCaGu
	aqquX1GrReuK45wM0FrT8SBTo3nZHK/2eH89ywUAXSuW5VUSDZmD4xm60JzA6TSe
	giAHdHgi2K8JXuiZ7rHtmgxSaDO6GemHKVygtxIh52B0oRqDmtyKfd4UH0PMBIWP
	mYiMgkVPIG2EZJBxX48gzPmFFkCXkWkL2HNPICsi/Q==
X-ME-Sender: <xms:pQdoZnJwpUwMJ5aSh754SMicBUig2Yo7cuxFIWBG488MykM7DOVeAg>
    <xme:pQdoZrJohRL0fRPyBWFyomxQw_Wntfm3Hi8KpMnHjHHAFSi3UgnvVIf_nrppUfvqp
    nbk4c5IYdmGH_HX-Us>
X-ME-Received: <xmr:pQdoZvvXVZYadnWUMnwqdouS2UsXYPZmppj5ffgA80HwlxeFKqUKT3Tckwlj9nuA14nh00vFXkes2Lh_2rgy-v4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttdejnecuhfhrohhmpeflohhnrghthhgr
    nhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenucggtffrrg
    htthgvrhhnpeekkeetgeefgfdvfefgfeffueefffejvdduieejheejheffkeejkeelffeu
    lefggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:pQdoZgbk3yz2iWEH2OCd2tzORrTqUi8Xy8tlfWlgEJ7aFszfgufoNA>
    <xmx:pQdoZuY-_ecrn57VvpsDzZQxq0DRPaeHlkGlaWPxohtt9RKsQqVRjw>
    <xmx:pQdoZkAIRT6rZ72ReWB9WCp__6QSGkYRSShFTuVyOTissCzd__D53w>
    <xmx:pQdoZsaUaxZf6hlV2VqKqE-kV3pGikI5Wpp7thyLHw9MpGq7NOr0AQ>
    <xmx:pQdoZioJsRbSnszbs1P2taAhZGEiLrtjH4FHUkxUUaOwAvhnVOVqp5RG>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 04:15:29 -0400 (EDT)
Date: Tue, 11 Jun 2024 01:20:40 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andrew Morgan <morgan@kernel.org>, brauner@kernel.org,
 	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
 	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 KP Singh <kpsingh@kernel.org>,
 	Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>,
 	Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 	Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 	Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, 	Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, 	Joel Granados <j.granados@samsung.com>,
 John Johansen <john.johansen@canonical.com>,
 	David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 	Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 	Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev,
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, apparmor@lists.ubuntu.com,
 	keyrings@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] capabilities: Add user namespace capabilities
Message-ID: <o5llgu7tzei7g2alssdqvy4g2gn66b73tcsir3xqktfqs765ke@wyofd2abvdbj>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-2-jcalmels@3xx0.net>
 <20240610130057.GB2193924@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610130057.GB2193924@mail.hallyn.com>

On Mon, Jun 10, 2024 at 08:00:57AM GMT, Serge E. Hallyn wrote:
> 
> Now, one thing that does occur to me here is that there is a
> very mild form of sendmail-capabilities vulnerability that
> could happen here.  Unpriv user joe can drop CAP_SYS_ADMIN
> from cap_userns, then run a setuid-root program which starts
> a container which expects CAP_SYS_ADMIN.  This could be a
> shared container, and so joe could be breaking expected
> behavior there.
> 
> I *think* we want to say we don't care about this case, but
> if we did, I suppose we could say that the normal cap raise
> rules on setuid should apply to cap_userns?
> 

Right, good catch. If we do want to fix it, we could just check for
setuid no? Or do we want to follow the normal root inheritance rules
too? Essentially something like this:

pU' = is_suid(root) ? X : pU

