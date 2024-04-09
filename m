Return-Path: <linux-fsdevel+bounces-16491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BDC89E3A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887691C22339
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2C157490;
	Tue,  9 Apr 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IFYpbA1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fs0f5ZAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362285652;
	Tue,  9 Apr 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691253; cv=none; b=q/P3rDAAddigbqrEF0T3lfyXFch9FDKNzCtAo2vywyHukYw9HDn4yKZvin9uVESUg2iuf66tx7n68DTSLqXy344aP6dI2IYX2diSD5cY2LhXxE22eWJtZJi0nXa729/i9QR+3WHFNCaNhIvE6fUTHzBIyEEWk2fUEibHTwiMmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691253; c=relaxed/simple;
	bh=3oRxUXJXiDa0l7YbL5IxLQptQY10QMjOhpHspaSiMs8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=C96HcazBYxSlqPYRJofd3+o9RnkKuFW4D5hjq1Oz5wcpEBEUvynFQ5h/moWBpKowmpzX6Iz/2MTK7uYUOhvpINm8NT6XWsTVTi22NEZmD22kiUZZ/qNO329HCWIUCBDg/ZlKswlbm6BnX0Lsp5gsHxx/5FmEuAnDrZVT75Lbuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IFYpbA1N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fs0f5ZAs; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id DDBA31C00127;
	Tue,  9 Apr 2024 15:34:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 15:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712691249; x=1712777649; bh=4SijHpqMyg
	Oli+EaGX6auphy+KWeiiFWTERVE+ugHLY=; b=IFYpbA1NZvsUdWYr59ckZYHAVv
	6jjPnfeNkSIuyQiDAN67LaNY6JWF+Kx0qJSRBVG3cuFGVzYrNa4frxtYwpOY8QrU
	xb46eMF3gebNmxeWEC7ht1HMJQObnu2WCOFFZCkIJaQGFKpbnsdfAVapCR5jYJMN
	Ce2P9mGqlx700IHMbM23PBLwspUInVPVCQnRdnn5gaTBiknXUmjJXyQtqbJYI4xP
	qAifcKjzE97IbctiBYLE2VD1f7CpJlPdeT3Kp2xBHlBeW7ymrjoiPI8ei4yB72Jz
	zmjK1bJEUUbqkUKz2a7FCsP/h80jXOvm9wJKq7Y8/5RCNnOuR0a6N5va+chQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712691249; x=1712777649; bh=4SijHpqMygOli+EaGX6auphy+KWe
	iiFWTERVE+ugHLY=; b=Fs0f5ZAsU9nFUP6ys86N1BujbxMA9pP9Eb2GEnjjBoVG
	thIEo+UQL+XGtePuBSEdWF6KwcIMgyyNuClkVYE58M0Z5XvzTafl+8o7jAs7nLWu
	0T3oVJwFUaR/YoCfx1wgLVswRieW+KyyR6nlLYyIPBrYhs1fsmb2MCj8xDrDfxWk
	qD/E+pfHeopVotqcbhoN7h5SM9ZW7HXnR38ExxbcGvJ0ytiqqdVCcpbIwxD7yJOw
	+0xCHJIXzUInh1W2B1+qWV3NVwyXPPe6zDfT9mVXKJscqQjo4Mkrc9yRDXDwDUnv
	lUw6W/ngUqUhQenCatlBRf3iLWLYuRxaJkl4EMmLCw==
X-ME-Sender: <xms:MJgVZrmb4KNXal1WEeEg-Xwb68DDmL575Mb92kEmOd1BIkVMHdGbYg>
    <xme:MJgVZu2fDNfrDqjSnOyzVC4C5Eyvzcz4ofpdZP7L4EFMVo74KbBdkWShxjqW2ub6w
    dgRgxJLuVAmPHskw_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MJgVZhpe69M7sWdb7TSi06y-JCcTcHicpnpv3XVb5mOurPCETghU7w>
    <xmx:MJgVZjnZnUIl8_w16phQGg_kSweJSP1bYiUlPWhWW7OvEMGL3lwHZA>
    <xmx:MJgVZp13LhlyKGveIgu7UEsFdrWA-EPw5y4mKNAB5ZTKnhmTFHtMLg>
    <xmx:MJgVZiuY4mNVlgwVKtZRv5w3TTrVGBbmteby0Yg8j3hEimD_ur-nTw>
    <xmx:MZgVZqsLy3MgltEHgQ1Ognr2D-3WUZMxdFjT7Mo7rdPYpPJIKjan2E3Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C59A3B6008F; Tue,  9 Apr 2024 15:34:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03b98c31-130d-4ec7-b162-621bd5b604cf@app.fastmail.com>
In-Reply-To: 
 <CAOg9mSSMAao4WpZWmVhsqLwsn=sfs05XPVuHMdjH0wUyWET_WQ@mail.gmail.com>
References: <20240408075052.3304511-1-arnd@kernel.org>
 <20240408143623.t4uj4dbewl4hyoar@quack3>
 <CAFhGd8ohK=tQ+_qBQF5iW10qoySWi6MsGNoL3diBGHsgsP+n_A@mail.gmail.com>
 <96b55a64-2bcf-44da-a728-ae54e2a73343@app.fastmail.com>
 <CAOg9mSSMAao4WpZWmVhsqLwsn=sfs05XPVuHMdjH0wUyWET_WQ@mail.gmail.com>
Date: Tue, 09 Apr 2024 21:33:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Marshall" <hubcap@omnibond.com>
Cc: "Justin Stitt" <justinstitt@google.com>, "Jan Kara" <jack@suse.cz>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Martin Brandenburg" <martin@omnibond.com>, devel@lists.orangefs.org,
 "Vlastimil Babka" <vbabka@suse.cz>, "Kees Cook" <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
Content-Type: text/plain

On Tue, Apr 9, 2024, at 18:26, Mike Marshall wrote:
> I applied Arnd's patch on top of Linux 6.9-rc3 and
> ran through xfstests with no issue.
>
> Also, instead of Arnd's patch, I used Jan's idea:
>
> +
> +       buf->f_fsid.val[0] = ORANGEFS_SB(sb)->fs_id;
> +       buf->f_fsid.val[1] = ORANGEFS_SB(sb)->id;
> +
>
> And ran that through as well, no issue.
>
> Sorry for missing the earlier patch.

Thanks!

I was about to send the updated patch and can skip that now.

   Arnd

