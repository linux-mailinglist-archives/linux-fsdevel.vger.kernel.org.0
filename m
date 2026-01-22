Return-Path: <linux-fsdevel+bounces-75025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BJiGjgYcmksawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:29:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B696266A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7C47727273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627436BCD6;
	Thu, 22 Jan 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bapPuMwV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfqGhGml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2FDDAB;
	Thu, 22 Jan 2026 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081529; cv=none; b=F/UZQtn+vVRfSKrKPlgossgRPnbgfSDcY9dB1sQjBH1mqNL47sL+kZfKbdFyp76THM+mweMuVWGE8zFemsU+gVWr1uK6nGTDQ+8j3PIxd++JBOdqdZVqU46Q7VdytAm3HIqZ1pKlVftRQOWEMtq+Xj694jlotWlE+gYtXEdmJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081529; c=relaxed/simple;
	bh=CXjq3wyQsuf0qKEHmGlNxyWRW8GC3zPk3bcbpB/jBrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQCScpr0RnRkJaYTlcP21OFnsc441g226W6btozpxdjKsKtXQbAaqykw+ufmIwgs9gG0474gAIJBH/ZUuTr09uI79H1qAf5Xxq+IyKufCtuhF5I1HN6j9tL892nKAbBMSDU+6VqqjqfXdkC/+yfOhJ0w3c9bOdYGZJHs9U9hA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bapPuMwV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfqGhGml; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D20E0140014F;
	Thu, 22 Jan 2026 06:32:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 22 Jan 2026 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769081525;
	 x=1769167925; bh=ubb7SX3ZCnFUyaHfqgbVjvcennbM4Ol785JrjoTlb8c=; b=
	bapPuMwV3nQVbsCQjKxFwplWTkY8H7Fknla2dx6HsiTOFFDLHCxbHHz7+g9G3pph
	GR/xrUGK7lGYzTVkn9vtBRHd1OnA4Tr8FG9TfZcCqc9RbK2Rey7iqN1OjSsTNUcM
	kDj991jaaYT8LGgbJ+OEG4RM0niE8QduCsBCjFSNs8cBaMATu78XjsdM3dBJA8q9
	03D5j7sGwuNwscziolg0bO2nXcdLSbILQoOqctfH7g9J+HDiuUVwwuW3o2A3Psuo
	WQ6NYA9gHW6I20JlzAD6ZDzGGMFqXD6kxd9ga5JpRq8viwbBE/nCOmD2BdA/Ki8m
	gbBSP4ZrK+XB/HelWZxvHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769081525; x=
	1769167925; bh=ubb7SX3ZCnFUyaHfqgbVjvcennbM4Ol785JrjoTlb8c=; b=I
	fqGhGmlASfjSrYdvzZAVbWw9HtNxkdHC1PGgzvh8jOxma/P7am4tDudGnU+xCHs0
	kM3+HLoqLJqOIzNgZSnLzVxMXe9lOAspxPBUh67Wa2VEUNVsvQnhOR4t7oSXrU7C
	xPGbsrW5pswGMzz3GS17vJzKN2MOLjB9Pzv33aGyg5nUyhI5smP0AXtlNyuJL6bX
	lQ2xUGuLVV2BBt7q3gA364c8uIZM6lRx9IPmLISJbibYuDJLMd7c09iMygzJoqrt
	oiZbHUw5TH14R4C0ub6mM60gCnBaxPLPSr3iAfMRpNCxvr/sjyGGGEvHo7I9RZWm
	TfqJITopAXsPSSKTqHHyg==
X-ME-Sender: <xms:tQpyaVacF7QSdSaLs7hO_Iri6W5W5fp48_yWRZF-8BZF8wX7QK5HTw>
    <xme:tQpyad8RecrjiWSVL5wOa9UKbQ0r60hqWQAftqE9XNCOlFuiq8uWMGWFekfkQ-6nu
    fDMxSjpmkmxACN4gA6yj3jJnGLHM9uDkLmdSNmP7njDT4Yr7hBS>
X-ME-Received: <xmr:tQpyaXOMuR1DtSnwLENL3QWnL7lawENO2o_IRFft-Qg2bpT6TQFbjecAqXIgE0NDfZ7pFpOE2JPts_bhFeb7fGDS76qbTGz4nWryXR6w1YKd9gMRWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeitdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtph
    htthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdruggvpdhrtghpthhtohepsghstghh
    uhgsvghrthesuggunhdrtghomhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilh
    drtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthht
    ohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehktghhvghnseguug
    hnrdgtohhmpdhrtghpthhtohephhgsihhrthhhvghlmhgvrhesuggunhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tQpyaaHwMrsGEflv_dYxx5IrEUYuRo6hDar5lbLu7QMirYJ7wdFeOg>
    <xmx:tQpyaVwo5rRSBnRYAreq8Q0fPiE_9uc3nCk3vavcQfALfERBPQ7Ayw>
    <xmx:tQpyabpVfB1arJ1kt8KGENCLS77yAGKrsEdcgFDotrrz2AAEwpH2Yg>
    <xmx:tQpyabm9XRN0oPhPvaWHNJ7TCEF-ugcvrB5oiM1scTi0Yl7uz4kO0Q>
    <xmx:tQpyaXQkZJE1o3WCcPOg-mdmDC5Ew-MaJbSGmoDQIUujZkZtOmMmAebA>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 06:32:03 -0500 (EST)
Message-ID: <ce468d08-4bdf-487e-9dc3-8b71236a74cc@bsbernd.com>
Date: Thu, 22 Jan 2026 12:32:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
 Kevin Chen <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com> <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com> <aXEhTi2-8DRZKb_I@fedora>
 <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com> <aXEjX7MD4GzGRvdE@fedora>
 <87pl726kko.fsf@wotan.olymp> <aXH48-QCxUU4TlNk@fedora.fritz.box>
 <87ldhp7wbf.fsf@wotan.olymp> <aXICIREIL46NcaK8@fedora.fritz.box>
 <87h5sd7uu5.fsf@wotan.olymp>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <87h5sd7uu5.fsf@wotan.olymp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	DMARC_POLICY_ALLOW(0.00)[bsbernd.com,none];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-75025-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,bsbernd.com:mid,bsbernd.com:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B696266A31
X-Rspamd-Action: no action



On 1/22/26 12:25, Luis Henriques wrote:
> On Thu, Jan 22 2026, Horst Birthelmer wrote:
> 
>> On Thu, Jan 22, 2026 at 10:53:24AM +0000, Luis Henriques wrote:
>>> On Thu, Jan 22 2026, Horst Birthelmer wrote:
>> ...
>>>>>
>>>>> So, to summarise:
>>>>>
>>>>> In the end, even FUSE servers that do support compound operations will
>>>>> need to check the operations within a request, and act accordingly.  There
>>>>> will be new combinations that will not be possible to be handle by servers
>>>>> in a generic way: they'll need to return -EOPNOTSUPP if the combination of
>>>>> operations is unknown.  libfuse may then be able to support the
>>>>> serialisation of that specific operation compound.  But that'll require
>>>>> flagging the request as "serialisable".
>>>>
>>>> OK, so this boils down to libfuse trying a bit harder than it does at the moment.
>>>> After it calls the compound handler it should check for EOPNOTSUP and the flag
>>>> and then execute the single requests itself.
>>>>
>>>> At the moment the fuse server implementation itself has to do this.
>>>> Actually the patched passthrough_hp does exactly that.
>>>>
>>>> I think I can live with that.
>>>
>>> Well, I was trying to suggest to have, at least for now, as little changes
>>> to libfuse as possible.  Something like this:
>>>
>>> 	if (req->se->op.compound)
>>> 		req->se->op.compound(req, arg->count, arg->flags, in_payload);
>>> 	else if (arg->flags & FUSE_COMPOUND_SERIALISABLE)
>>> 		fuse_execute_compound_sequential(req);
>>> 	else
>>> 		fuse_reply_err(req, ENOSYS);
>>>
>>> Eventually, support for specific non-serialisable operations could be
>>> added, but that would have to be done for each individual compound.
>>> Obviously, the server itself could also try to serialise the individual
>>> operations in the compound handle, and use the same helper.
>>>
>>
>> Is there a specific reason why you want that change in lowlevel.c?
>> The patched passthrouhg_hp does this implicitly, actually without the flag.
>> It handles what it knows as 'atomic' compound and uses the helper for the rest.
>> If you don't want to handle specific combinations, just check for them 
>> and return an error.
> 
> Sorry, I have the feeling that I'm starting to bikeshed a bit...
> 
> Anyway, I saw the passthrough_hp code, and that's why I thought it would
> be easy to just move that into the lowlevel API.  I assumed this would be
> a very small change to your current code that would also allow to safely
> handle "serialisable" requests in servers that do not have the
> ->compound() handler.  Obviously, the *big* difference from your code
> would be that the kernel would need to flag the non-serialisable requests,
> so that user-space would know whether they could handle requests
> individually or not.
> 
> And another thought I just had (more bikeshedding!) is that if the server
> will be allowed to call fuse_execute_compound_sequential(), then this
> function would also need to check that flag and return an error if the
> request can't be serialisable.
> 
> Anyway, I'll stop bothering you now :-)  These comments should probably
> have been done in the libfuse PR anyway.

Kind of, we have an organization github account as well - the PRs went
through that first. We need to add more documentation why it cannot
be done from fuse directly in all cases. Well, the kernel could indeed
add the flags when it is safe. Though the first user of compounds is
open+getattr and there it should not be handled automatically, at
least not without introducing change behavior.


Thanks,
Bernd

