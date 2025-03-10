Return-Path: <linux-fsdevel+bounces-43559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA84BA589B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 01:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BCC16A277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55435288A5;
	Mon, 10 Mar 2025 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Iy2kGHDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O13pG5ib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420FEC5;
	Mon, 10 Mar 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567144; cv=none; b=t5aPtE9goiRBAHy/FGQEA+cxkhaJohPKoEy1PFvjVkzjPAHDpI+6VL8abSpWab0mytsh+k6o/n/KExsB5kfgzEL0ZzHsy0HXKJ5V4JIvNWf1VIipMDNEdw9xMjoQMdIcXOELOoPKKbUhGGNBvsrx2I86PsH+K2M3r1w17PPiJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567144; c=relaxed/simple;
	bh=Zk4IqK1YHB9anjvH68tavax4aim4PEEvHsx5aPzZjIA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+eUh2wLnRXApfPckCnB6RzCOJN5KPD5lAtcl6+NPpfMO0vzEU107GlQDI4JFmXTtfkZXQouQBpigiYBfFFmQal+HR9t+zMGeXcMVsyXlHNbmtFhKMqcIJUjZur/OC2lW8cXOl64kbF60fiIVP2VrmxNLEcoU9thRfLKZEQUnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Iy2kGHDo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O13pG5ib; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id CE0582014BD;
	Sun,  9 Mar 2025 20:39:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 09 Mar 2025 20:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741567140;
	 x=1741570740; bh=16H3GijOciCT5RbTq7UWlPSfyCJ0ENdD3BiXCL8prKo=; b=
	Iy2kGHDo5auF/qCUKt+wGKPv4ePSIevjkOQy/yKF2wyPgXdJ8SIbcdW2ixUt0CuC
	sew1Tqe8J7KIupUMTOk0Ok+OD4+4aFc/Sq+o5Fh04AQVgB6Z8PycJszhHan1XBqK
	7ARVXQEdCSRPDv8hW0WpiJt5LccQA1PUZVZ+EOjVHAVFGh3UFTGAq8y8wgCI3c6R
	CYXWZLMzHZOVhbYLjZk2qoS1muqRmryZHztVKBABzOQziWlOZ9Fa31v+8u9ETTRA
	8i+R5HWHaLyRO5uMWZ1r2/UKW5ABdh5S5ccCoXKt7C8T5lSjcRB7h3yQP1VuMB1x
	pzSqxFb/f1x30ExD5hTbUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741567140; x=
	1741570740; bh=16H3GijOciCT5RbTq7UWlPSfyCJ0ENdD3BiXCL8prKo=; b=O
	13pG5ibMu3lyoh4+lBu2lCsHHpyIyA0sKvXjGXpxqk8NSAFbbth1qxMqes+GNMzY
	OfQZN1lhPQJ2jKlwfqpgONc/nUp0Gn3kUrbUeQTm1ZGLAALl3/GgY5/Vu51J/T2Y
	hN9apSRhGGd8zQt6kLhg8DYtYlw4VpFxsmPrWyxxoHaY0i7ET6/06h+XEUWsoxVZ
	ZxxOx0i6nYHS8bTqtYsVhBCmHaiz3n2tHEhzurj6/nyD4h2GPrXpNNtPoHv3P8wz
	bUljydPYo+xKoV8bvO5POTPr1S7+hTZ5MhS2fSWyJpLKlVXCJ7hu+nzv+UmG6dsp
	CwTdvdTxANvWwa5zL+seA==
X-ME-Sender: <xms:pDTOZ7bnTeA0P548iQWBMsfAG-if2Ej5USRZ3p5djf8a5ZhlAwd7Uw>
    <xme:pDTOZ6ZIFzcp6wkrNLUXT1iaKUYRR6ZQlBpcvG_ONi5BfGmWTWB8RjaTEkE3Nt_FX
    styVVdwg-KaPzETvIY>
X-ME-Received: <xmr:pDTOZ99ql0Rgg3LXBzj7f25RT52mGNx9ElAVgYrj3RZISvrqht5_C_gmoslO0i3_3ieOQW9Y3g20zl9sG8Vpl1zOAIjAyPZwEjixZu7Pd_rOPv_s0x79kVBO6sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepvdegudeugfdujefgtdetffdujeejleeliedukeeujedu
    heetgffhgedvteevffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprh
    gtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghk
    sehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuh
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehrvghpnhhophesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehthigthhhosehthigthhhordhpihiiiigrpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pDTOZxpH9GoIb4Y2o0BSfLBvi6xt4WX6xP1Dai78k8L_OHrbXsQ8wg>
    <xmx:pDTOZ2pmH1YCk2iJAjIsNhSGNxtt5ZJYjDh4QhSW74ydD1AS2ZTSaA>
    <xmx:pDTOZ3RzALj1yLLhf5QCEZzssk2Eo8HU7q8aKXedysog1JUfW2snWA>
    <xmx:pDTOZ-rxeDmdfJxk56Oo7ZxRZ5GdFXjsRNLWG3tPJfVY-LMPT1GU5A>
    <xmx:pDTOZ11icSVYnhj4TvuXOGS6n93YQ7i6zlSxF7ATOv0FyHMJD7_S6viV>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 20:38:58 -0400 (EDT)
Message-ID: <17fc58b6-18cf-4c5c-9060-3198ac65bf8c@maowtm.org>
Date: Mon, 10 Mar 2025 00:38:57 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 2/9] Refactor per-layer information in rulesets and
 rules
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Andy Lutomirski <luto@amacapital.net>
References: <cover.1741047969.git.m@maowtm.org>
 <6e8887f204c9fbe7470e61876bc597932a8f74d9.1741047969.git.m@maowtm.org>
 <20250304.aiGhah9lohh5@digikod.net>
 <4e0ed692-50e7-4665-962b-3cc1694e441a@maowtm.org>
 <20250306.aeth4Thaepae@digikod.net>
Content-Language: en-US
In-Reply-To: <20250306.aeth4Thaepae@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/8/25 18:57, Mickaël Salaün wrote:
[...]
> Yes, we could put the access rights in the hierarchy, but that would
> involve walking through the hierarchy to know if Landlock should
> actually handle (i.e. allow or potentially deny) an access request.
> Landlock is designed in a way that makes legitimate/allowed access as
> fast as possible (there is still room for improvement though).  In the
> case of the supervisor feature, it should mainly be used to dynamically
> allow access which are statically denied for one layer.  And because it
> will require a round trip to user space anyway, the performance impact
> of putting the supervisor pointer in landlock_hierarchy is negligible.
> 
> Initially the purpose of landlock_hierarchy was to be able to compare
> domains (for ptrace and later scope restrictions), whereas the
> landlock_ruleset is to store immutable data (without references) when
> used as a domain.  With the audit feature, the landlock_hierarchy will
> also contain domain's shared/mutable states and pointers that should
> only be rarely accessed (i.e. only for denials).  So, in a nutshell
> landlock_ruleset as a domain should stay minimal and improve data
> locality to speed up allowed access requests.

That makes total sense - I will move the supervisor pointer to 
landlock_hierarchy and drop this change in the next version.

