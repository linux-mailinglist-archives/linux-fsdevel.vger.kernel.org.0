Return-Path: <linux-fsdevel+bounces-75056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI6SKyBAcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:20:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82868983
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1A9A5177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8835028E;
	Thu, 22 Jan 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3LV/Gt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2352C0F6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093614; cv=none; b=fysbUvKaUdww5aHLdGTbC6mIpIutY00sNOIdrPMVYaKqDpiwtxeGmq6BxmOa1bh7QnxQyeX49U3XSIgo0VchzO5qDjuIsNxJ7ey2S8wVtMkb/ET1h5WCM47CXNrsY7LZFBJTgk0RH4rEro5eryk34xGtEv4IOE9tUPPdfx3jTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093614; c=relaxed/simple;
	bh=S+QSxQ67PvDHyCRTj4w5E4e6GueKYKIQQbvQSlrjg8w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aZOUa45waRZ/2Qt5ulIObvotJrrsAjEMMd2ZQEynOnkNBeZr2DahJGxU7QOyqihC+Lqbq07bF/wF1dEgpSPdGZMp3KRnpQtViUEBVSwJRIb40U3tf0UTQk8XGbYq/XWF9OaAhr97/jNtL8FBjv6VV+KW8uqroqDAdmSxTKQtBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3LV/Gt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0340BC19423;
	Thu, 22 Jan 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769093614;
	bh=S+QSxQ67PvDHyCRTj4w5E4e6GueKYKIQQbvQSlrjg8w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N3LV/Gt5jGamGhqMXRLzARhslPykUQdWoP3DOBqiakdQCDuL0E4xIIOfgq06O4bVO
	 s1DspKAoy7SUrQcSkdy5KfrNRYiiJKDMZ6xj4KrHlsOp7NpkJknAsvlCpj8YE7Eina
	 35PGThOKCG0EHWBta0g5Gk/Y7BFB5YJbd+5zxKA8CYA+vHspSTFKszz4cmhh80gms1
	 ZiOZiznMHY/1jlBuG/jGYIvMxIncSEKDQW/vBP9tt8qI7qHgoZwTSey0f2h8YnC+tm
	 SEswPKJ75ljw6v8sygjyOHmEmQ7cdEryBOq6PDPKFE5IQ75R1qnCNbtxKYpWIK6Ebf
	 PEVW4CHqztkBQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0AD2AF4006A;
	Thu, 22 Jan 2026 09:53:33 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 09:53:33 -0500
X-ME-Sender: <xms:7DlyacYeHI8sSnnwkZyvIsEt919ZGlb0EaX2on9rpzGt1VPRXlBeZg>
    <xme:7DlyaSPStSCdDuDNXWxyM2cXjvhR2HCLVewFKPB5H3xBOvepz0kl633SWhe2phvMU
    zsImQSWubulJKOifxKeYy-8PBubSQf2k1llNMfPR63Ba6WKPRVZ1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:7DlyaQCsntrEmalBB-dzXdQxAuGpWhGBPfwVtP7l2OSG7xKx1T-wfg>
    <xmx:7TlyaeWmSPGYgez8egFo7aF9ZuV9uR0e1GCxe_ne_wJ-BesPtmazdA>
    <xmx:7Tlyae8GTjtphqKBSem1CFAjyNJoFYS-jAFfUNYi6s5PH7TwiJ0LTQ>
    <xmx:7TlyaQTrdTNvsu7O7Y1lArO0wCnP11eN0IrnFL8CVX6l1Yxzonhsiw>
    <xmx:7TlyaTQ_lUCgbK4l8gxMMMZeitmXQc4Q0O0ZXCxfqji6MsR72RukZZGh>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E004D780070; Thu, 22 Jan 2026 09:53:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1vGOqVGteog
Date: Thu, 22 Jan 2026 09:53:09 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <e91bdc9e-16b0-4e9c-a1a0-aedd30e1c135@app.fastmail.com>
In-Reply-To: <d43cd682b0c51b187ba124f0c3c11ccc9d8698c8.camel@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
 <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
 <d43cd682b0c51b187ba124f0c3c11ccc9d8698c8.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.45 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75056-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2F82868983
X-Rspamd-Action: no action



On Thu, Jan 22, 2026, at 7:30 AM, Jeff Layton wrote:
> On Wed, 2026-01-21 at 20:22 -0500, Benjamin Coddington wrote:
>> On 21 Jan 2026, at 18:55, Chuck Lever wrote:
>> 
>> > As I stated before: we have said we don't want to continue adding
>> > new APIs to procfs. It's not just NFSD that prefers this, it's a long
>> > term project across the kernel. If you have a clear technical reason
>> > that a new procfs API is needed, let's hear it.
>> 
>> You've just added one to your nfsd-testing branch two weeks ago that you
>> asked me to rebase onto.
>> 
>
> Mea culpa. I probably should have dropped the min-threads procfile from
> those patches, but it was convenient when I was doing the development
> work. Chuck, if you like I can send a patch to remove it before the
> merge window.

Send a patch. I can still squash such a change into the queued patch
set.


> I can't see why we need both interfaces. The old /proc interface is
> really for the case where you have old nfs-utils and/or an old kernel.
> In order to use this, you need both new nfs-utils and new kernel. If
> you have those, then both should support the netlink interface.

This is exactly my assessment so far. But I'm open to hearing a
rationale for adding a procfs API


-- 
Chuck Lever

