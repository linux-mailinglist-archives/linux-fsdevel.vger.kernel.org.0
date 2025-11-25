Return-Path: <linux-fsdevel+bounces-69796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCCC8554B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 15:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB8EE35121A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4F324B1E;
	Tue, 25 Nov 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="OMPvzKlF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLka3iJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BF32255C;
	Tue, 25 Nov 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079788; cv=none; b=IGZqti2cFhyUDEXVIJEVh6vI/TX9IYN9o4OaBtyardgA9NRrpALQWWinPIZq4jKTgu0scH3IrtxFoFTcMuftw8q0Q82ej9tA9bygPG3Quu90XbQXHgCIAqhJ3ooVEqPlMSmqGsel5RLHiyv5G7wfonkhYK5zPJ2qG4lF9xXfPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079788; c=relaxed/simple;
	bh=41wuBfK6KmZfFSph9AoLMj/4UnC1VKX3ed8Fm4gY7Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rls3yt4yCFbF/9hoYA8mXJ+oOeKK5Ca6wbD5+gZzK4Q9nKoFdqgdm5uHyzbx8WOOM9rz0HeITfzXKPmNwhczxXyt4IX6PlVWIYnphmOgGOZDSLwRmFEG+bwyfTQG84qg3mDLIgyxLMiWGGaAZ12pNcwnT/rqfBkGn+95bQnRS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=OMPvzKlF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLka3iJJ; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 809B21380546;
	Tue, 25 Nov 2025 09:09:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 09:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764079785; x=
	1764086985; bh=3bMvsZSIiVU3pUA1Q96vlRsnQkJ+zVUPQsOHI7GHg2U=; b=O
	MPvzKlFHkHMEkgAvO1Uyss+96M/hGKj5YsQfHejRjOSc4qcoxmXMj4hhXg44W1Ef
	f+2FZmek/Vp7VMAcKSWKu5vw2ELUh/4TKqh05W+XH3fqT/kg0gRDs1cSTZFEzwsY
	lfUK/XstLQ/GgwvHNBGpiPsihS3C907bycj46mTcTPjPWBcIFuNO2mkJK87dq41v
	nEaYF+SW/r9n3rXEn7zZvJvhaqJKngqjJVqgYKouNkyWaY7csAolp+xbmx+7XCc6
	NTnu6vEK2LnrusXBylHkCIdYJU8Qwx8yLU37YVnlHB1bRfm2yV73RrmEmaeu/OnY
	zVRksTDa34siBV1sEgVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764079785; x=1764086985; bh=3bMvsZSIiVU3pUA1Q96vlRsnQkJ+zVUPQsO
	HI7GHg2U=; b=YLka3iJJS4uHYf+RVmsIhTYDXpAvrL5WrL9BPBFcYF8nsukYggb
	QHO6tT2dwT3h9TcJys0ZthsLNKdLgkuGaDv5MkN8DaRBDYOvSDFB76gBeKNn5W0/
	CVCemM3ZxiBVvJLvrV/KsXaaVnrH/XSHm5BR36zUS10Fj/JaEk3C0JUVf4tBZhI1
	rwv6nH1MsGZq8Rx4O9829S+HBuzkXZM4K4wcZY5iTTS7mIR4Fo1mVU9WkuJ1CMd2
	uD6szhHUcKTSLnb6TESaW5TxAiS8SqYaev0d0D3FkzA2naE3DgHaXS1hUhvkgcn9
	odS/eCQqz0+KbMLRtjqc8IUq4qTlSRV2bug==
X-ME-Sender: <xms:pbglaWvKN1DJZAzYSwKMRx9-OgT3rdfcTgkjojWPEw8KNW7Cx0AEAw>
    <xme:pbglaTXf9w3AHkCR2Fi9l8wIxJHg69s8vY_NmbLplbMAS7ZPJhAxU4ZyvP7W59tRY
    6tYZ94S8k6_dYSWuO2CmKlawxLgNFJRUNzUYh5ghix47LoIvHqcJ3E>
X-ME-Received: <xmr:pbglaTVq6gxwgmVLYbKwhZEo3Ue8V3Yipkq04ow2rgFUWOH-1wlLy2M77sQWTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstd
    dttddvnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeejheeufeduvdfgjeekie
    dvjedvgeejgfefieetveffhfdtvddtleduhfeffeffudenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepudefiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhouhhrrhihsehgohhurhhrhidrnhgvthdprhgtphhtthhopehlihhnuhigqd
    hmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvght
    rgdrtghomhdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhhvughimhhmsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtghhrohhuphhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:pbglaW_0cXMtMthUHN5H-fE7CGn6DIwBKbPochRZeWCN8gj92pgAfQ>
    <xmx:pbglab-e-8tK-jGoWZSTzd4htoSykssNFuRJIH-N3luEajg_qhcROg>
    <xmx:pbglaS8xVJOZqKo-Vsq3I59doGzt7pGvGwt-1UuY4j1VdvVF-sGV3A>
    <xmx:pbglabLAvm1PrWnHzKLnOzKQUK7tS39E5pLPz3qn6MaXu68uj2z1VA>
    <xmx:qbglaXODIQJ_Tp6UtA9zcmakBUdCO8tVHH50Z00bPS2jBHC-6eFUxFQ4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 09:09:40 -0500 (EST)
Date: Tue, 25 Nov 2025 14:09:39 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org,
 	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, 	cgroups@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, 	dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com,
 	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, 	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com,
 matthew.brost@intel.com, 	joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, 	apopple@nvidia.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, 	bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, tj@kernel.org, 	hannes@cmpxchg.org,
 mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
 	roman.gushchin@linux.dev, shakeel.butt@linux.dev, rientjes@google.com,
 jackmanb@google.com, 	cl@gentwo.org, harry.yoo@oracle.com,
 axelrasmussen@google.com, 	yuanchu@google.com, weixugc@google.com,
 zhengqi.arch@bytedance.com, 	yosry.ahmed@linux.dev, nphamcs@gmail.com,
 chengming.zhou@linux.dev, 	fabio.m.de.francesco@linux.intel.com,
 rrichter@amd.com, ming.li@zohomail.com, usamaarif642@gmail.com,
 	brauner@kernel.org, oleg@redhat.com, namcao@linutronix.de,
 escape@linux.alibaba.com, 	dongjoo.seo1@samsung.com
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
Message-ID: <h7vt26ek4wzrls6twsveinxz7aarwqtkhydbgvihsm7xzsjiuz@yk2dltuf2eoh>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>

On Wed, Nov 12, 2025 at 02:29:16PM -0500, Gregory Price wrote:
> With this set, we aim to enable allocation of "special purpose memory"
> with the page allocator (mm/page_alloc.c) without exposing the same
> memory as "System RAM".  Unless a non-userland component, and does so
> with the GFP_SPM_NODE flag, memory on these nodes cannot be allocated.

How special is "special purpose memory"? If the only difference is a
latency/bandwidth discrepancy compared to "System RAM", I don't believe
it deserves this designation.

I am not in favor of the new GFP flag approach. To me, this indicates
that our infrastructure surrounding nodemasks is lacking. I believe we
would benefit more by improving it rather than simply adding a GFP flag
on top.

While I am not an expert in NUMA, it appears that the approach with
default and opt-in NUMA nodes could be generally useful. Like,
introduce a system-wide default NUMA nodemask that is a subset of all
possible nodes. This way, users can request the "special" nodes by using
a wider mask than the default.

cpusets should allow to set both default and possible masks in a
hierarchical manner where a child's default/possible mask cannot be
wider than the parent's possible mask and default is not wider that
own possible.

> Userspace-driven allocations are restricted by the sysram_nodes mask,
> nothing in userspace can explicitly request memory from SPM nodes.
> 
> Instead, the intent is to create new components which understand memory
> features and register those nodes with those components. This abstracts
> the hardware complexity away from userland while also not requiring new
> memory innovations to carry entirely new allocators.

I don't see how it is a positive. It seems to be negative side-effect of
GFP being a leaky abstraction.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

