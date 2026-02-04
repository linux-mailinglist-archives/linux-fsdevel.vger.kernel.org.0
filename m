Return-Path: <linux-fsdevel+bounces-76351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA6JKRSzg2k0tAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 21:59:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B2EC9DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 21:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90ADD3004C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD4443C072;
	Wed,  4 Feb 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="E9chXpur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mI4Xx9F7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D966427A16
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238734; cv=none; b=OosC4oZ9pWTOxQN+G2pwOJ7p7V/6j9ERYjhaLx0oONcKhinJfpf8RCuSM2Vg5T0NASh42HXpWMWSldzsrL/YS+cucJtci7uTNR/KN96QTJk9y/YxR04xCCJ3r6oQgbqVQSvBXa0WOAUcSiET7Mu1nPreSojWcf2uYLv0tjo5qN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238734; c=relaxed/simple;
	bh=gS+nXSHSl3yLTbrM6HETi75DdB43Auzaya8OwuiAoMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDjmvta5ZmcmRrg6oyXwz0anRqG5jC0v6m5i3l837wFRLE0Y2raw1JndJkDL63Aiw/65aOO3N/eXElTL89me74332PVSpyxPrjZDXk+aZlqlycyetkOTNM0asaAcv7uyc+UukksmSGwn2rcYJWGGzla0usolpS65Fz5c84F+NUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=E9chXpur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mI4Xx9F7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF4D81400094;
	Wed,  4 Feb 2026 15:58:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 15:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1770238733;
	 x=1770325133; bh=euciqyBfay3pbborA7Zj/CYln3JbSJQBpLLp03ntCOo=; b=
	E9chXpurBMCN3AtNM5WAqSN7Oc7mkpvkLByxTBKwkfueN8Aa1Cl2kFIAxjb8wM4Y
	GyI0xNkUaerYJAPA3SMXqYTcp28j84R+qdWNOAc4SqoqiQfVfRItbhcnWwogQjEI
	VmcTUjqs2i/EoPHdMMNmdLoGj8fdGz91Ed/eqXd5oYghzLNIlzg64DBEONFuf3mG
	2wqAQQGJxH32LB3vl1WYeTF6Op4BYoBX1byKKqKkHllckfjfRvgjG9CcKrusdf0+
	8OBVZ3CCvh0TOTyxu1obMNBBIVsQo8bn7qoNP2jScQTIbm8+Km6YjOzQ4lQqvUa+
	fu2tcHEdh0DBfgmVrv7iXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770238733; x=
	1770325133; bh=euciqyBfay3pbborA7Zj/CYln3JbSJQBpLLp03ntCOo=; b=m
	I4Xx9F765gxDSEs+ClDMd/1/Fm4SUAuDZvRk23YtwGlksjMeNJmepUc86q4p3NP0
	xvma05rYdmYaNcAzC8312Jp+rDfWRKW7JkSiVUlpI4lX2MTagUJ8b+/sYqVLSBrA
	CV5VoAu1mw70m2jSzCxI8QDTfl/bzycD4o7nqPCLRAA3uPyT15aX8vKQ5wLflB1A
	Con48EJuBj7QiL2bCS6UAd1yuVEZoYburqjuPbp9pW5dXt2OR3TwrwGhaMc6M8p7
	AHzL/PfT5FaL2xMcCOEhvSDLOgeU874P8lrLb/17Z3bOrjsyhGEuZaaHba0DrlHC
	xQKPdWKkaCKRgfsvsjJLA==
X-ME-Sender: <xms:DbODadPGJcFV0bUQ1FM5x3WgqzFn0pQI0l6KvTpEO82YXj0qgesGkw>
    <xme:DbODaU7vx3-mRE8oNh7MyUEiMcaUb-w-3PeKirpVd3jebp8xWGbszrg4UDIvnLOnh
    WHOVol1_Sz4rVnmkp5HBzwSlZ1fjtmeQbaB4WQlLrMNiL-Dcyw>
X-ME-Received: <xmr:DbODaQgoicpH8q9mkujhMMXmXToQGl_WLoY4Vv0_ZiaTgE9dOwiaeqd4dn7SWnkMKUhAUKCUVByGEKP5kQHItS-a1FKEwmj8ss_SPbWibQHc-05HtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghr
    vgguihdrhhhupdhrtghpthhtohepfhdqphgtsehlihhsthhsrdhlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdrnhgvthdprhgtphht
    thhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehluhhishesih
    hgrghlihgrrdgtohhmpdhrtghpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdgu
    vg
X-ME-Proxy: <xmx:DbODaZfxXl-4KlwcdDPLOgityTqIdi4yHvYTMPCnFdyF1XTv25Dlyw>
    <xmx:DbODaYyDtVqHrLareOER09zlo44sHYcI_U_RHForXPMKDL3Iqj3iUA>
    <xmx:DbODaY2xVNjFBDRPaLjUA9hL7XudPUxZxNHZAXzwjpYbK8rcJUkLag>
    <xmx:DbODaex_NpsIPYMYGsy2E1Q-pGZ6oIYhfCHBj5aQ-FnMe7oSaU4_hA>
    <xmx:DbODabMEEBen24GzOjLspgc6tqriDI5hlgDofSkt86Epe7JqXBnTdJ44>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 15:58:51 -0500 (EST)
Message-ID: <61a68025-f8c9-451a-9df7-a6a70764bf36@bsbernd.com>
Date: Wed, 4 Feb 2026 21:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: f-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260204190649.GB7693@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,igalia.com,birthelmer.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bsbernd.com:mid,bsbernd.com:dkim,messagingengine.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76351-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B10B2EC9DB
X-Rspamd-Action: no action



On 2/4/26 20:06, Darrick J. Wong wrote:
> On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
>> I propose a session where various topics of interest could be
>> discussed including but not limited to the below list
>>
>> New features being proposed at various stages of readiness:
>>
>>  - fuse4fs: exporting the iomap interface to userspace
> 
> FYI, I took a semi-break from fuse-iomap for 7.0 because I was too busy
> working on xfs_healer, but I was planning to repost the patchbomb with
> many many cleanups and reorganizations (thanks Joanne!) as soon as
> possible after Linus tags 7.0-rc1.
> 
> I don't think LSFMM is a good venue for discussing a gigantic pile of
> code, because (IMO) LSF is better spent either (a) retrying in person to
> reach consensus on things that we couldn't do online; or (b) discussing
> roadmaps and/or people problems.  In other words, I'd rather use
> in-person time to go through broader topics that affect multiple people,
> and the mailing lists for detailed examination of a large body of text.
> 
> However -- do you have questions about the design?  That could be a good
> topic for email /and/ for a face to face meeting.  Though I strongly
> suspect that there are so many other sub-topics that fuse-iomap could
> eat up an entire afternoon at LSFMM:
> 
>  0 How do we convince $managers to spend money on porting filesystems
>    to fuse?  Even if they use the regular slow mode?
> 
>  1 What's the process for merging all the code changes into libfuse?
>    The iomap parts are pretty straightforward because libfuse passes
>    the request/reply straight through to fuse server, but...

To be honest, I'm rather lost with your patch bomb - in which order do I
need to review what? And what can be merged without?
Regarding libfuse patches - certainly helpful if you also post them
here, but I don't want to create PRs out of your series, which then
might fail the PR tests and I would have to fix it on my own ;)
So the right order is to create libfuse PRs, let the test run, let
everyone review here or via PR and then it gets merged.

> 
>  2 ...the fuse service container part involves a bunch of architecture
>    shifts to libfuse.  First you need a new mount helper to connect to
>    a unix socket to start the service, pass some resources (fds and
>    mount options) through the unix socket to the service.  Obviously
>    that requires new library code for a fuse server to see the unix
>    socket and request those resources.  After that you also need to
>    define a systemd service file that stands up the appropriate
>    sandboxing.  I've not written examples, but that needs to be in the
>    final product.
> 
>  3 What tooling changes to we need to make to /sbin/mount so that it
>    can discover fuse-service-container support and the caller's
>    preferences in using the f-s-c vs. the kernel and whatnot?  Do we
>    add another weird x-foo-bar "mount option" so that preferences may
>    be specified explicitly?
> 
>  4 For defaults situations, where do we make policy about when to use
>    f-s-c and when do we allow use of the kernel driver?  I would guess
>    that anything in /etc/fstab could use the kernel driver, and
>    everything else should use a fuse container if possible.  For
>    unprivileged non-root-ns mounts I think we'd only allow the
>    container?
> 
> <shrug> If we made progress on merging the kernel code in the next three
> months, does that clear the way for discussions of 2-4 at LSF?
> 
> Also, I hear that FOSSY 2026 will have kernel and KDE tracks, and it's
> in Vancouver BC, which could be a good venu to talk to the DE people.
> 
>>  - famfs: export distributed memory
> 
> This has been, uh, hanging out for an extraordinarily long time.
> 
>>  - zero copy for fuse-io-uring
>>
>>  - large folios
>>
>>  - file handles on the userspace API
> 
> (also all that restart stuff, but I think that was already proposed)
> 
>>  - compound requests
>>
>>  - BPF scripts
> 
> Is this an extension of the fuse-bpf filtering discussion that happened
> in 2023?  (I wondered why you wouldn't just do bpf hooks in the vfs
> itself, but maybe hch already NAKed that?)
> 
> As for fuse-iomap -- this week Joanne and I have been working on making
> it so that fuse servers can upload ->iomap_{begin,end,ioend} functions
> into the kernel as BPF programs to avoid server upcalls.  This might be
> a better way to handle the repeating-pattern-iomapping pattern that
> seems to exist in famfs than hardcoding things in yet another "upload
> iomap mappings" fuse request.
> 
> (Yes I see you FUSE_SETUPMAPPING...)
> 
>> How do these fit into the existing codebase?
>>
>> Cleaner separation of layers:
>>
>>  - transport layer: /dev/fuse, io-uring, viriofs
> 
> I've noticed that each thread in the libfuse uring backend collects a
> pile of CQEs and processes them linearly.  So if it receives 5 CQEs and
> the first request takes 30 seconds, the other four just get stuck in
> line...?

I'm certainly open for suggestions and patches :)
At DDN the queues are polled from reactors (co-routine line), that
additional libfuse API will never go public, but I definitely want to
finish and if possible implement a new API before I leave (less than 2
months left). We had a bit of discussion with Stefan Hajnoczi about that
around last March, but I never came even close that task the whole year.

> 
>>  - filesystem layer: local fs, distributed fs
> 
> <nod>
> 
>> Introduce new version of cleaned up API?
>>
>>  - remove async INIT
>>
>>  - no fixed ROOT_ID
> 
> Can we just merge this?
> https://lore.kernel.org/linux-fsdevel/176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs/

Could you create a libfuse PR please?


Thanks,
Bernd

