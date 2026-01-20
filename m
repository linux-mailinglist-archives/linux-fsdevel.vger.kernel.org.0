Return-Path: <linux-fsdevel+bounces-74693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHpZLl7Ib2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:24:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B649670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 676B47C8E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088653396F8;
	Tue, 20 Jan 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fhnYraYl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWIXbyzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970412FF16F;
	Tue, 20 Jan 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927507; cv=none; b=h6gmqj/G5Vm3fpVJEM/9g33/XHZxMciIu2yAhP+bcTHTnbQn5nfQfZ2izqC2y5+nzIPhK4JSXfo7atXaj53VCe5Qh+T4VtcmXm3AQV0jEKGZKBsnEGIe/9BnDnCbYglLNWNr9/6rwL2uNqQIWnrrV8o9bplPAFfwnldkREvHoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927507; c=relaxed/simple;
	bh=kZcp2PHuxyss+VI4RFZDelap38d4uiw9WboOiWNBp1g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oeg1Q0hMG+V5ki2Y6eB7XKGtNlp+Lng1GjjasG8ujNxeaPhn+RT4SRjFwrSGpUKDj5eo2NScoHK6ZQpAYmYVDUUJRTiivd897vVxTf1voxwaOaaPvzuHT9BA79ef4F3H/d2UBkbze5bOs/1jofX65xx3MPmzdxvHYDPakoY85Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fhnYraYl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWIXbyzO; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id BC47F130057C;
	Tue, 20 Jan 2026 11:45:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 11:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768927502;
	 x=1768934702; bh=nxbkJAISpw9hnpQ7/ITBBIUz+TKq+iocNACRaG8UpNs=; b=
	fhnYraYlrrq+RP9vqomjRQwsQ9mvhXiuGoV4zAKoX+FhTObAWpIa/drZeA1aUcS0
	bGSjbl2pphX0I3WOvR7J1T5RQu306RrAZx1yxTQAzDYh+wjMAb2zsJ/Ru211VkD0
	FFJ6j0oPV0gG3GS8DlU5g6mtmb2W4aXnwusi1bMFGWZzFtU2B+qpeOy/FH2ODMq0
	vzYckmbQQCcqlugFQrAP8w49E3LWH4xUcJI/9pt685VYzTEzbryK3io8dNxcRsRU
	EhDDmJvfexMY7ImJBBzrfKPqM5G7SS+YxvYcjwUWwySEYGHSbyvMjvAYz8htDnrB
	YqpzDhH0ItWDCgYrVxYVug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768927502; x=
	1768934702; bh=nxbkJAISpw9hnpQ7/ITBBIUz+TKq+iocNACRaG8UpNs=; b=q
	WIXbyzOT6bq7HDqgS8ADTf9ZTfFpXm4Lk/scmRmwwLIqRtX4iWxKYlSw5YxYH6Jp
	/dNbZVMVciC6c0ld15ThSY0vdpLcNdHNHO+A/EJnGIbQNONcPZhp0To5VUqLk0Z6
	ZUZvoiQlGdbj5hePd+k9+rmMo18oFTujr6iQ+uVJWIQjwvKq5z3VTMhRyFyHmMtl
	AsSyfsdcA8dTLYuwsyX/Nvn6HAZUNUI4puT89ClU7s0KSSEAUu2rbe6jtLpK1t0j
	9uaHOe0inhxcQXuaVqU+R6SwOxCUKcnjtqIoRiAzP6V+iuafRLGaofHkcXXhBmC8
	LHmEkyUOUc8uVEftPQ5LA==
X-ME-Sender: <xms:DbFvaXr4c-86Yk4cy1FDNkTs5jtIv5zDtK6qsn0iIPj0fevKJtnXWA>
    <xme:DbFvacc7pd2GFBJVN7Rx4wuUlNgidN6Lb0NpLsLVug_3gLwImcsW-JS6z0GmoznKw
    7sfuZPlsawKzl0PZGtgn2t3ir6P5j3MTUBpyBnCsP5sbt2ZtbYaN70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtoh
    hmpdhrtghpthhtohepjhhoohhnrghsrdhlrghhthhinhgvnheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfh
    hrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigsehlihhs
    thhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepnhhtfhhsfeeslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvhguihhmmheslhhishhtshdrlhhi
    nhhugidruggvvhdprhgtphhtthhopeguvghvvghlsehlihhsthhsrdhorhgrnhhgvghfsh
    drohhrgh
X-ME-Proxy: <xmx:DbFvaVjsaIBoCwQLmeUwd0lsKZv61M6naBb8iovN1Apy42D6gDYYoQ>
    <xmx:DbFvaWXro2koE-VHeVm4FWVeO1IgJQVmKvbTjG72moOpuTbwbax8ug>
    <xmx:DbFvaZw9P5oCYGc2UiGpsv86qoRgTlhwqCZGPNxFL95wr8ogXh9Wmg>
    <xmx:DbFvaexZdjp0Zge5ynjLEvqdDZN9C_7oGW6WcBL8XKs1rkv1cSPqlw>
    <xmx:DrFvadBndY7ACKn2QdkvHwHl4Yp28phKBg7OjiN7y5QfUc9wcmOqmx7_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 13CA1700069; Tue, 20 Jan 2026 11:45:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWSx1lsrOtaB
Date: Tue, 20 Jan 2026 17:44:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Huang Rui" <ray.huang@amd.com>, "Matthew Auld" <matthew.auld@intel.com>,
 "Matthew Brost" <matthew.brost@intel.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Benjamin LaHaise" <bcrl@kvack.org>, "Gao Xiang" <xiang@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Yue Hu" <zbestahu@gmail.com>,
 "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Reinette Chatre" <reinette.chatre@intel.com>,
 "Dave Martin" <Dave.Martin@arm.com>, "James Morse" <james.morse@arm.com>,
 "Babu Moger" <babu.moger@amd.com>, "Carlos Maiolino" <cem@kernel.org>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Naohiro Aota" <naohiro.aota@wdc.com>,
 "Johannes Thumshirn" <jth@kernel.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Zi Yan" <ziy@nvidia.com>,
 "Nico Pache" <npache@redhat.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>,
 "Lance Yang" <lance.yang@linux.dev>, "Jann Horn" <jannh@google.com>,
 "Pedro Falcato" <pfalcato@suse.de>,
 "David Howells" <dhowells@redhat.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Message-Id: <9ff58468-a72d-4984-95f4-d0a60554705d@app.fastmail.com>
In-Reply-To: <44461883-a75c-466b-a278-97c4ab46b461@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
 <1617ac60-6261-483d-aeb5-13aba5f477af@app.fastmail.com>
 <44461883-a75c-466b-a278-97c4ab46b461@lucifer.local>
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t only
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.45 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[arndb.de,none];
	TAGGED_FROM(0.00)[bounces-74693-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 618B649670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026, at 17:22, Lorenzo Stoakes wrote:
> On Tue, Jan 20, 2026 at 05:00:28PM +0100, Arnd Bergmann wrote:
>> On Tue, Jan 20, 2026, at 16:10, Lorenzo Stoakes wrote:
>> >
>> > It strikes me that the key optimisation here is the inlining, now if the issue
>> > is that ye olde compiler might choose not to inline very small functions (seems
>> > unlikely) we could always throw in an __always_inline?
>>
>> I can think of three specific things going wrong with structures passed
>> by value:
>
> I mean now you seem to be talking about it _in general_ which, _in theory_,
> kills the whole concept of bitmap VMA flags _altogether_ really, or at
> least any workable version of them.

No, what I'm saying is "understand what the pitfalls are", not
"don't do it". I think that is what Jason was also getting at.

     Arnd

