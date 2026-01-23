Return-Path: <linux-fsdevel+bounces-75326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE4bLGIDdGlA1QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:25:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A337B7AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9D4301AB84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3229A9E9;
	Fri, 23 Jan 2026 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TWGp4qqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qn9TNkA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015431CAA78;
	Fri, 23 Jan 2026 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769210708; cv=none; b=PsCAt0QFomn2G57+moPKEET+V8hkAh31s0Z1mfJE+vZYzJ9JTJJd6L/dVFmzTElup/Nt77vG57pRC0iRUh3bN41jTGjVyvQaJBIvX/j2TldX+3zdtL9pA82X9e7OQImR96gU3L6G8DffAgTgmmIaI7T7w8W7mrtDq+0uIWlVSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769210708; c=relaxed/simple;
	bh=YuSGDcXxft7vL09xreGoN9P9ZPU+zDZ89hq2A0DCBBQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SiW4nBq6IMCe67vNZ6TA9WfAV8GwIiZ53WijOm5ozW0P4J0BL8lkAurKzwFy93ZINBjlt0+IOgfWX+1MK22vkqOPI5hm6nlhGYw2Nvt1ul8wfb8iL34QP/TMCScXvCF31C8juYaE8ysdtqLON7+5PTGtPADuwwwUZsbSzCeTCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TWGp4qqd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qn9TNkA8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 097C61400058;
	Fri, 23 Jan 2026 18:25:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 23 Jan 2026 18:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769210705; x=1769297105; bh=2P1N8B/fi8BqjWA/ln4gJUSk+n4jq03dUUK
	IfSOlf8c=; b=TWGp4qqdEYk/TpEMmdQE1ToYnEHDfweKMMElTxGjz9DgXnBm6oV
	ZuYSeJLo5b/UJ1h3CWMjAHLN/eKZILhoBXMQ0I4KtwUfRHL/w5TIft5MzR2PWJsd
	Tcp7Csalce2xSpDMQj//cMWGoXjXjWpWVIZKPgY0qpgjjCogw5Jc5yNVEvl+rB3T
	oGemM9SIDmP9m5Tk3+paih4auvdY0UFcOCvljRlY2gXvIKml65uQ9+O5X01Ef2ZT
	eCMnACUCfNIIOvhYHIGudSUsAvCi7Fw93WkbzLcWYEmobSwIwzvLX8zHgvHOKV9y
	ZM6nKQareXQYbpSoNNVqxKnzAy5hd3kMt7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769210705; x=
	1769297105; bh=2P1N8B/fi8BqjWA/ln4gJUSk+n4jq03dUUKIfSOlf8c=; b=Q
	n9TNkA8ljLIsPs1fIom+A/8TtMjJvRd3pWY1t7W/qGEd6sKjPFCe0g5/ifkInEgD
	UH8QDg1q6LICiQJCDRJFg4378bRc3K5Q6UI04x5LhYdsZW3EvI78swJifD6ZCyPD
	LlY/tEllT6He4f9sGB33Zbf6Ol9gYIi5vgb0BIR0eQ+OX5AGJX+uRuANSese17S3
	x9xxB0/fNBSXfCbmKS5Z4SKAvpXTh2GxYyAIS1xcgnQijdzmEy4sOjFwktxwjaGT
	bIOHGZ13mC4EZBVnHiKmQzu9NlJhsFTlaSTVaBCKeGZLuQhddgwcdK53prO9mZOw
	vW6Xr5N6AQWn8EimJf5Pw==
X-ME-Sender: <xms:UAN0aeNzVkvYQgnJISbp5pFxrAH0SN-5IkheZXqxcTKceG2VZutDCw>
    <xme:UAN0aY0cFma-_NW6_foKeMiObt4U2irk5cDjz0whDdNiKJusrd0n8Phx9GdefyaVR
    iZV_df9xLCWXArWbeLJHJfbUJHdRpDLwB5fvg1JyC7PktzC6A>
X-ME-Received: <xmr:UAN0aSTx17z5QYpV4-cNGAVpPIZYUzPqL2w8HxPBBC3MXB_esNKpyi45CZAp_Q3dUfzsjw1b_siWJQNq7zyriS191_aQbiJ2ogrF7qypcBl->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghnnhgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UAN0aTlv-ayAJs6bY_A2MNFRb6h5qVut1wg5OimX_d9Foq4cNDjunQ>
    <xmx:UAN0abPK_n74DHtTnRK9WwPhFShRUhx2YJxgkMCQigQ-qDiXOcHh9g>
    <xmx:UAN0aXhdS0Yw37SdUmQqmjJj_alX-LsgwzGB8EdZaiUv25zFqaqVag>
    <xmx:UAN0aZgyOyXyO7zq5DnuIXxPoGY3rhc97Ith3RFhqs84-f0omy4laA>
    <xmx:UQN0aV3bAqeDvzJcePvQOYbvt87DJ4ENrd2gvIcoxrNqslJIPaWJggOP>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 18:25:01 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
In-reply-to: <C0C90433-6319-4CB5-9485-A9CA87E09AFC@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>, =?utf-8?q?=3C6d?=
 =?utf-8?q?7bfccbaf082194ea257749041c19c2c2385cce=2E1769026777=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>,
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>,
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>,
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>,
 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>,
 <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>,
 <3080c6d6-4734-41e9-81a6-8ad9fc8a1061@app.fastmail.com>,
 <C0C90433-6319-4CB5-9485-A9CA87E09AFC@hammerspace.com>
Date: Sat, 24 Jan 2026 10:24:58 +1100
Message-id: <176921069844.16766.11829850179498769003@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75326-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 22A337B7AC
X-Rspamd-Action: no action

On Fri, 23 Jan 2026, Benjamin Coddington wrote:
> On 22 Jan 2026, at 9:49, Chuck Lever wrote:
> 
> > On Wed, Jan 21, 2026, at 8:22 PM, Benjamin Coddington wrote:
> >> On 21 Jan 2026, at 18:55, Chuck Lever wrote:
> >>
> >>> On 1/21/26 5:56 PM, Benjamin Coddington wrote:
> >>>>
> >>>> Why only netlink for this one besides your preference?
> >>>
> >>> You might be channeling one of your kids there.
> >>
> >> That's unnecessary.
> >
> > Is it? There's no point in asking that question other than as the
> > kind of jab a kid makes when trying to catch a parent in a
> > contradiction (which is exactly what you continue with below).
> 
> Wow, yes.  It's personal, and unprofessional. It has nothing to do with the
> merits of the argument at hand.

For the record I agree with Ben.  It was reasonable question for Ben to
ask, and an unhelpful and unprofessional response from Chuck.

NeilBrown

