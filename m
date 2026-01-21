Return-Path: <linux-fsdevel+bounces-74896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKKAG9orcWl1fAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:41:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAAF5C5FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DED1E865BA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6249E36D510;
	Wed, 21 Jan 2026 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="X99EHgEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LA52F2nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88B32E6BC;
	Wed, 21 Jan 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020132; cv=none; b=oY9vABIb6o6UNeedPu+PifSEr8TdpDb10gF79sllHJ2Mj+IG2MssJ4t/fXJUPREDa74/msN1xY34rK31hjvCpEbAx/Z6c+4afH8SaLoH+UktZ+xy/iHFWJFkj7nC/mqkJHoNZLt5SG0WzML6rhnMSywTNtpxIiCcDgg87CaFaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020132; c=relaxed/simple;
	bh=S2bB+NBKRhFPklPqfmGgZoUuT/+NbGuQAUXc4mvAbK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6jqSqf4Nq+1Lg50nulj8d6TbJ3BAA6I5L/DouNtR1rVoNg2a0ZwKk5idReMPK1vJpCECtXzcr9Zr0kefTa5/Bs8i2IHa22MRgjU38sW/gwjZYvIFMD3kdC6fbRD/UnXpsYmWhXR/zYNSIQy44v9r7kKnIzjdkkjJx9sasjORAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=X99EHgEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LA52F2nf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45D231400087;
	Wed, 21 Jan 2026 13:28:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 13:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769020129;
	 x=1769106529; bh=XGzuwVzCFc4taRa5N/+7r6QHqp+qHvicbry7wdzZIG4=; b=
	X99EHgEPh5VY9VVRSqZo5jkvINhry/+T9s+EduJG6PPzPy6gjxIbBpuJ1pJ7ggCo
	pETZQc8DYjsMO27CP5NMqCi4fCIglrQSLtIcKKzy2fONtaPDgCL/xnVg/WrEvYU/
	vQH/avzy0qTjS0TxoOU9bF+D1NyKNnOD/ef/X9Zkh01NCswCXe2mAMcrMsjwHPBD
	HbDgHrwitUfw0V4fhU4VJ+EJbe6wXbcD6XU/7qWf9qet9F3jkWuJDZVkRNCFOJWY
	kQrEdU+KK84AhWdzImNLqRDqEa+cOcC07m4v774aHjCODGMtLIqdZGFYf6LVY1oN
	i4jTpda4lAq6boxFy5B7TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769020129; x=
	1769106529; bh=XGzuwVzCFc4taRa5N/+7r6QHqp+qHvicbry7wdzZIG4=; b=L
	A52F2nfnXxnNCg4baKGdwa1cCVfABuuiZosDdIb+IfLqtdzmX/S2vcqukI03SvIN
	nGrOlrM83urNch6PgZ6wwNAp6PlK0+b1oh0OY6WtKxMWOQ4vkErldbNWrbjh50UW
	QwMI62GWHILwuutEKOuPNKwor8s2kPNsm5hJuqZr//IfYKrv/kiHJ0+I7sPmUK98
	JEgqnjsTYNrciQ419CsfC9oaQzyMbfGqNZwzD5KGkShqudzDX/+KgMYEwdD+WMq2
	CK8wh5jkUjuy7umXrVHgnpj20W6hfJOez/mbnG/a5GV0FnXrZF4DNvARPbqh8LgJ
	QoQK18fJ/GPq9lQ/FLLPQ==
X-ME-Sender: <xms:3xpxaZxXvn0HMv_4c1HsrF12tVCy1aWb3tKUMyznPK2JTDA3Aas1Yw>
    <xme:3xpxaewLHN_mRwy8opes_10zyJ0GJnbeuJyVR6ScbxkyLAF_JC09neksRdkaXW2sT
    4cJgMRJneXpXTfKWmOdGEyaDKF_TXFn3cIsdqiJ8kMp4JMceAE>
X-ME-Received: <xmr:3xpxaSbtNQJUfIJt_fzi4wu9C5o08fcW8Ss1hxow_eTQhF2eLL3GpoSggkOLh9AX9aolAh887dNUyLtoYUFh1A78t3zd-0QK-L0LMCgz3yH42mDvjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejffdutdeghfffgffgjeehteejueekieetieehveehteeuiefgieeuleek
    jeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hhohhrshhtsegsihhrthhhvghlmhgvrhdruggvpdhrtghpthhtoheplhhuihhssehighgr
    lhhirgdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtg
    hpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhl
    ohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgthhgvnhesuggunhdrtghomhdprhgtphhtthhopehhsghi
    rhhthhgvlhhmvghrseguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3xpxaf0qp8Ahnb7t0Sw9Hyfs4VgyDwDosdPd_3ss9avQT17BsdZLXA>
    <xmx:4BpxaUcac5FQfbXYu0Q10vJNvfHzDix_UnqS3ya7l4msOTwlhM_Wjg>
    <xmx:4BpxacIbAqAYkbLzQ8eZGZz1DEG9u24yXU6lyQ9qWVVQBV9u9ewUyw>
    <xmx:4BpxaSq9Gz45F_FzEs8waGToAkv43hAIHCPByx5UKn6IhjwriIa3bA>
    <xmx:4RpxaaP5mtChmG0TzybUuP8CGjTwZWreWEzK2nX0lfEZVpHCRsfa1HVD>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:28:45 -0500 (EST)
Message-ID: <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
Date: Wed, 21 Jan 2026 19:28:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
 Kevin Chen <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp>
 <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com> <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp> <aXEVjYKI6qDpf-VW@fedora>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <aXEVjYKI6qDpf-VW@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-74896-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ddn.com:email,messagingengine.com:dkim,bsbernd.com:mid,bsbernd.com:dkim]
X-Rspamd-Queue-Id: 6EAAF5C5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/26 19:16, Horst Birthelmer wrote:
> Hi Luis,
> 
> On Wed, Jan 21, 2026 at 05:56:12PM +0000, Luis Henriques wrote:
>> Hi Horst!
>>
>> On Fri, Jan 09 2026, Horst Birthelmer wrote:
>>
>>> On Fri, Jan 09, 2026 at 07:12:41PM +0000, Bernd Schubert wrote:
>>>> On 1/9/26 19:29, Amir Goldstein wrote:
>>>>> On Fri, Jan 9, 2026 at 4:56 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/9/26 16:37, Miklos Szeredi wrote:
>>>>>>> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>>>
>>>>>>>> What about FUSE_CREATE? FUSE_TMPFILE?
>>>>>>>
>>>>>>> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.
>>>>>>>
>>>>>>> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
>>>>>>> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
>>>>>>>
>>>>>
>>>>> I thought that the idea of FUSE_CREATE is that it is atomic_open()
>>>>> is it not?
>>>>> If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
>>>>> it won't be atomic on the server, would it?
>>>>
>>>> Horst just posted the libfuse PR for compounds
>>>> https://github.com/libfuse/libfuse/pull/1418
>>>>
>>>> You can make it atomic on the libfuse side with the compound
>>>> implementation. I.e. you have the option leave it to libfuse to handle
>>>> compound by compound as individual requests, or you handle the compound
>>>> yourself as one request.
>>>>
>>>> I think we need to create an example with self handling of the compound,
>>>> even if it is just to ensure that we didn't miss anything in design.
>>>
>>> I actually do have an example that would be suitable.
>>> I could implement the LOOKUP+CREATE as a pseudo atomic operation in passthrough_hp.
>>
>> So, I've been working on getting an implementation of LOOKUP_HANDLE+STATX.
>> And I would like to hear your opinion on a problem I found:
>>
>> If the kernel is doing a LOOKUP, you'll send the parent directory nodeid
>> in the request args.  On the other hand, the nodeid for a STATX will be
>> the nodeid will be for the actual inode being statx'ed.
>>
>> The problem is that when merging both requests into a compound request,
>> you don't have the nodeid for the STATX.  I've "fixed" this by passing in
>> FUSE_ROOT_ID and hacking user-space to work around it: if the lookup
>> succeeds, we have the correct nodeid for the STATX.  That seems to work
>> fine for my case, where the server handles the compound request itself.
>> But from what I understand libfuse can also handle it as individual
>> requests, and in this case the server wouldn't know the right nodeid for
>> the STATX.
>>
>> Obviously, the same problem will need to be solved for other operations
>> (for example for FUSE_CREATE where we'll need to do a FUSE_MKOBJ_H +
>> FUSE_STATX + FUSE_OPEN).
>>
>> I guess this can eventually be fixed in libfuse, by updating the nodeid in
>> this case.  Another solution is to not allow these sort of operations to
>> be handled individually.  But maybe I'm just being dense and there's a
>> better solution for this.
>>
> 
> You have come across a problem, that I have come across, too, during my experiments. 
> I think that makes it a rather common problem when creating compounds.
> 
> This can only be solved by convention and it is the reason why I have disabled the default
> handling of compounds in libfuse. Bernd actually wanted to do that automatically, but I think
> that is too risky for exactly the reason you have found.
> 
> The fuse server has to decide if it wants to handle the compound as such or as a
> bunch of single requests.

Idea was actually to pass compounds to the daemon if it has a compound
handler, if not to handle it automatically. Now for open+getattr
fuse-server actually not want the additional getattr - cannot be handle
automatically. But for lookup+stat and others like this, if fuse server
server does not know how to handle the entire compound, libfuse could
still do it correctly, i.e. have its own handler for known compounds?

> 
> At the moment I think it is best to just not use the libfuse single request handling 
> of the compound where it is not possible. 
> As my passthrough_hp shows, you can handle certain compounds as a compound where you know all the information
> (like some lookup, you just did in the fuse server) and leave the 'trivial' ones to the lib.
> 
> We could actually pass 'one' id in the 'in header' of the compound as some sort of global parent 
> but that would be another convention that the fuse server has to know and keep.
> 


Thanks,
Bernd

