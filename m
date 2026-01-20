Return-Path: <linux-fsdevel+bounces-74689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA27BqK8b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:34:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF048A46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 919335AD845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138947A0DE;
	Tue, 20 Jan 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kR9gOAj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcwcLU9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391A311967;
	Tue, 20 Jan 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924863; cv=none; b=Q+RZoKlKpLAyLu1OCCPzY9wIebDUfBNoU2xBQkxunQjlJ5OlrgMPOP9bAzd5lfGbXvusOqfq9454kzeOcid+tAGC4KevDG+yuvz1ireb7Fw1Ht9/RmbEu1XEU8bSiK/iuDbsjGua4787xrpvnE3GjQ44IsQuVshFHDskFTCUeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924863; c=relaxed/simple;
	bh=XntaNhMOb3ljN0OUod4vqOUNi4wPltdCRFCEO3POz5k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hTrzCie9REUOI6UPUmBxZfotDQie3fsip/O4uWuch5OxX6GI+kx86BL2A21d3VSeYtrpApkEGKTSz4mQ2HMixFStK9mEu/hvCVJzqTEcGdnpNmHtUxnhAIQKIwYLv2h9cTaOehuht6pIH8dEqcPr/L9ShjPgGwaReaTMR+Pl6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kR9gOAj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcwcLU9t; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id A7CFA13012B5;
	Tue, 20 Jan 2026 11:00:57 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 11:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768924857;
	 x=1768932057; bh=KfkVnVcFie+8lJSMwr+BM1cQg1+WZ1F7itYYKxiYDxA=; b=
	kR9gOAj5pXn1HlvyIPf1Dn2UnaJAS+jRzIAsaR2XzWmwVU3duRgbE0mh5JHntjXj
	cuWYepTHKUWzhsOhC73++QR5yvZK4X1S2AwaIcjIrwElOhOnB7qBma9Rt3sk4wEp
	WApUxciyhayGX/RZcK8fKFz6xIdI+xP0DrR1lTAATkjc8XoS7YDkMHYuYZCNVtBX
	4oGFoRnhTrXR+Av/H+nXr31W99ztPY8wV3R2x29p9i/J68icSSg69RfuDb4y8YAC
	s4LhKb2VHYYXAgITpUrU4ktCyPGwkOI9lIgNBoXcky3A3mVVfmLH/JHxew6hI9Hi
	veL08yMhuZP0sXK/DL5Ezw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768924857; x=
	1768932057; bh=KfkVnVcFie+8lJSMwr+BM1cQg1+WZ1F7itYYKxiYDxA=; b=h
	cwcLU9t2Na5NvYNY+HqrNgOlIOAEx2zdTmluSgjajfn4eJ5F+JIB4BRW8ErmbMJb
	5ljggxqqdQPdg2SZtb56c1NTdnpBu5weRDSXaiQR+Mg0Ub9iThiAQ79EUDX9yysa
	If4/Knasx1iPLLZBRyvYpz8FhOYnlESn3fgeQPRrN8KMwKv6jSRpu0DLxO2sSNsb
	R4TQnDC+MhnR+ow7ZS/sYxRoTgI4V6asIPb1zuVNFs2Fc8BB9RtG2146jooAzX5l
	vcbjXpebeDkjFdxXkF3/V9TJ8Omw44E5cSge6Qts1idwHBYUlshPhSE1PbPF8M3M
	EM/yfREYAwG76Llyugm5Q==
X-ME-Sender: <xms:tqZvabeGsRgVUmYbJYubbEJsMblBOKkMPVUcZJSAcArtFN7R0_JmeQ>
    <xme:tqZvacCZ4cB2mdxuaWLwjQTUSZDxD3Bf1wqfkWuap9G_bNa-8cI9R9Kjk_UIAoevp
    8e2nWPX3vkW-eL_zNn3-aozty1UyyBCIwgt3SJui6DtRU08gGv2zDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtkeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tqZvaWR4-8YE2KZu1y5jvyNQljKoCBlYcV9QkUPtn5Ni7W-NSZMsUw>
    <xmx:tqZvaRktxaBWwwSZcFROAg2TG6_nap3Qro5Wk-tlRgwqau7F5lM2lA>
    <xmx:tqZvaZLjBCOSgCLQJimLJKR8KCf21qGLd9xPnpeFgrHRnOQFa7r4YA>
    <xmx:tqZvacVW_XYjP20S7nkpndFaafpNrDdhIyeeUuIH4hGwRfJO4DQR5A>
    <xmx:uaZvadqcdmsUnvEM9LNX4jzRraMdQCDjpzpx0jFAVDSf99K8t-JGJM_0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A67DD70006A; Tue, 20 Jan 2026 11:00:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWSx1lsrOtaB
Date: Tue, 20 Jan 2026 17:00:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
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
Message-Id: <1617ac60-6261-483d-aeb5-13aba5f477af@app.fastmail.com>
In-Reply-To: <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
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
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[arndb.de,none];
	TAGGED_FROM(0.00)[bounces-74689-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,arndb.de:dkim,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 72BF048A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026, at 16:10, Lorenzo Stoakes wrote:
> On Tue, Jan 20, 2026 at 09:36:19AM -0400, Jason Gunthorpe wrote:
>
> I am not sure about this 'idiomatic kernel style' thing either, it feels rather
> conjured. Yes you wouldn't ordinarily pass something larger than a register size
> by-value, but here the intent is for it to be inlined anyway right?
>
> It strikes me that the key optimisation here is the inlining, now if the issue
> is that ye olde compiler might choose not to inline very small functions (seems
> unlikely) we could always throw in an __always_inline?

I can think of three specific things going wrong with structures passed
by value:

- functions that cannot be inlined are bound by the ELF ABI, and
  several of them require structs to be passed on the stack regardless
  of the size. Most of the popular architectures seem fine here, but
  mips and powerpc look like they are affected.

- The larger the struct is, the more architectures are affected.
  Parts of the amdgpu driver and the bcachefs file system ran into this
  with 64-bit structures passed by value on 32-bit architectures
  causing horrible codegen even with inlining. I think it's
  usually fine up to a single register size.

- clang's inlining algorithm works the other way round from gcc's:
  inlining into the root caller first and sometimes leaving tiny
  leaf function out of line unless you add __always_inline.

      Arnd

