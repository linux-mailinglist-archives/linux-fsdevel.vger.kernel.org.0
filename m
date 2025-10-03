Return-Path: <linux-fsdevel+bounces-63342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67371BB601C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AB13C8749
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551C1223DF1;
	Fri,  3 Oct 2025 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aMjNO8Aj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNYMaREd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AB6FBF;
	Fri,  3 Oct 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474575; cv=none; b=MB7jrvbCUOe5nbIEukNBcocHsRAtoCMAMvtVuNyrrKF6GsRBbI2Hzi9s8oZgt1L41zVsuaf4GRyYvo+D5YFX2JhLQTd7KNk30qPstOpE3ZaHvWOmztYWXe+F3cCAPWv6LGdZFH5bGQPD0oifQ3AE/1Rts2BTtCtmdX4IKKEgHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474575; c=relaxed/simple;
	bh=VsY56m5kSuveBNBUNSkmOpL9Gd42blVivMz56qhfGfQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=a6io9gre06xe/zyNQk1QLhmROFn3dMe6gExIFxhEbCnphs63D5lkpDX6yRGldZFEV/bhZrU2m15gq0su1+xJMM24wHiVEO63zXTe5HNwG3TwhVK9FsAmLhlLPr8QLG3vmA+j5QpKpfT6gMUS8hRJS52CcfnGS6cwQEga06hdS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aMjNO8Aj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNYMaREd; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id C4B9A130000D;
	Fri,  3 Oct 2025 02:56:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 03 Oct 2025 02:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759474567; x=1759481767; bh=j+Jw5iNM6nGAnWO3sjaDIDEUdkjo7ZX+LLz
	qd/P1hYw=; b=aMjNO8AjVn+sj0yKUl+VzgbYszqPNGJNtAPbUQGn88a5UP2eiqs
	R5yiWdKir92SSE469eXj/b+AHudi0OVXOIY6cS5YPi4E1B06RLjJ+yZPq4inyozE
	Q+B2H/gKkTXrrQ2uYPkaRXH7k9U3Y58+RCC7RD56mFR5x5KoRAcvgQv9tL7Zpc+/
	9N6venAGi7v2ylACMFGp9jJlqUne0QvLZGDqcm3MhRqSBzJwu12eGO57hRoA4sro
	NgXvxEQkBwxT5LSMI5KUZlWIDFBwzR+gvhw0a1r/a6Ty5zl4GCufIIlts3fIye4p
	JrHYaG8ko/FiP2kNmiy/58lOphRDKpSPmnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759474567; x=
	1759481767; bh=j+Jw5iNM6nGAnWO3sjaDIDEUdkjo7ZX+LLzqd/P1hYw=; b=P
	NYMaREdofJEjMxoqFbSBZZKryi4ZwnfANONgeT2a1dj37Y+FNVWf603dzC5NuApe
	8PxvyO6Q6DBCiVJrM8k6zEMwDy/cTTk1TtsSqwegcfRU11nONgZXR4em3KQPmyim
	OI2gDy6Ogzt7ifj6Ked0HHw1xR170gEX2viFcftT+WOsW+lFe503bLpkWDvr4Z7s
	cukyNO+ucMr7L3wCcGGdohDGSTdNWryH23xV6KBGaW3B+CI6PeIG9IouSZuBOKBC
	dKquqjsLUyCcaEnlM82UDPgSN/S1V02Qz83CuSnTbFMrLbBbQ9AXPWab7L0GXpjN
	gaLZmR2+e/ZuDrFlmXzew==
X-ME-Sender: <xms:gnPfaMkIJPG7oVHmiGGRa0CpjJx7RohXVYjkJGIiEh2iOGlLIXvz7Q>
    <xme:gnPfaL7yl9NUDnF6WrW14T4q-2gvfr53xNr0E_QiaHexrYaF0oruSqWMxAHBv_X-7
    he83VGHvZW4PzWgKOTeAohnaiAhTYeXu9Rhj5h50nInJJpCUvI>
X-ME-Received: <xmr:gnPfaKZHZu3YD6tKEjPzMoNoGzkIMDN3Z50sJg_3-6-KPUiHJtc04hN2x1QY170mpQr7__pL7KtyMY1QmrIBnneKxaREGagaO6Gn7NBgViHv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtghpthhtoheplhhinh
    hksehvihhvohdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmohguuhhlvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqmhgvughirgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhiuggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gnPfaG0eLIXy_hVmmU0ah6RiWYe432JzyxABI3_ZePEgQyvaESbQMg>
    <xmx:gnPfaFi8VKDei6hK_Kzm4HvejB1DcIxxW5AGQspQu-BZ0cfQX60vkQ>
    <xmx:gnPfaNiFoyBB5wKfL7gCcU3cs9PS5_p6fTSHi4mNminIEilZsHOtZA>
    <xmx:gnPfaDgIFdYh7LlGgsMY4-Bc3EDv7jElWaw_NOfwLw-Yk1w7kum8UQ>
    <xmx:h3PfaFqY121yl6e12RmJDdKdPbf2ATm6GquMeKQ2MvsNf-5FbRc2NBdT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 02:55:17 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
 tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
 ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
 yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com,
 netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com,
 corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org,
 christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, mark.rutland@arm.com,
 ada.coupriediaz@arm.com, kristina.martsenko@arm.com,
 wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com,
 dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org,
 ziy@nvidia.com, yuzhao@google.com, baolin.wang@linux.alibaba.com,
 usamaarif642@gmail.com, joel.granados@kernel.org,
 richard.weiyang@gmail.com, geert+renesas@glider.be,
 tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 28/47] dept: add documentation for dept
In-reply-to: <20251002081247.51255-29-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>,
 <20251002081247.51255-29-byungchul@sk.com>
Date: Fri, 03 Oct 2025 16:55:14 +1000
Message-id: <175947451487.247319.6809470356431942803@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 02 Oct 2025, Byungchul Park wrote:
> This document describes the concept and APIs of dept.
> 

Thanks for the documentation.  I've been trying to understand it.


> +How DEPT works
> +--------------
> +
> +Let's take a look how DEPT works with the 1st example in the section
> +'Limitation of lockdep'.
> +
> +   context X	   context Y	   context Z
> +
> +		   mutex_lock A
> +   folio_lock B
> +		   folio_lock B <- DEADLOCK
> +				   mutex_lock A <- DEADLOCK
> +				   folio_unlock B
> +		   folio_unlock B
> +		   mutex_unlock A
> +				   mutex_unlock A
> +
> +Adding comments to describe DEPT's view in terms of wait and event:
> +
> +   context X	   context Y	   context Z
> +
> +		   mutex_lock A
> +		   /* wait for A */
> +   folio_lock B
> +   /* wait for A */
> +   /* start event A context */
> +
> +		   folio_lock B
> +		   /* wait for B */ <- DEADLOCK
> +		   /* start event B context */
> +
> +				   mutex_lock A
> +				   /* wait for A */ <- DEADLOCK
> +				   /* start event A context */
> +
> +				   folio_unlock B
> +				   /* event B */
> +		   folio_unlock B
> +		   /* event B */
> +
> +		   mutex_unlock A
> +		   /* event A */
> +				   mutex_unlock A
> +				   /* event A */
> +

I can't see the value of the above section.
The first section with no comments is useful as it is easy to see the
deadlock being investigate.  The section below is useful as it add
comments to explain how DEPT sees the situation.  But the above section,
with some but not all of the comments, does seem (to me) to add anything
useful.

> +Adding more supplementary comments to describe DEPT's view in detail:
> +
> +   context X	   context Y	   context Z
> +
> +		   mutex_lock A
> +		   /* might wait for A */
> +		   /* start to take into account event A's context */

What do you mean precisely by "context".
You use the word in the heading "context X  context Y  context Z"
so it seems like "context" means "task" or "process".  But then as I
read on, I think - maybe it means something else.  If it does, then you
should use different words.  Maybe "task X ..." in the heading.

If the examples that follow It seems that the "context" for event A
starts at "mutex lock A" when it (possibly) waits for a mutex and ends
at "mutex unlock A" - which are both in the same process.  Clearly
various other events that happen between these two points in the same
process could be seen as the "context" for event A.

However event B starts in "context X" with "folio_lock B" and ends in
"context Z" or "context Y" with "folio_unlock B".  Is that right?

My question then is: how do you decide which, of all the event in all
the processes in all the system, between the start[S] and the end[E] are
considered to be part of the "context" of event A.

I think it would help me if you defined what a "context" is earlier.
What sorts of things appear in a context?

Thanks,
NeilBrown


> +		   /* 1 */
> +   folio_lock B
> +   /* might wait for B */
> +   /* start to take into account event B's context */
> +   /* 2 */
> +
> +		   folio_lock B
> +		   /* might wait for B */ <- DEADLOCK
> +		   /* start to take into account event B's context */
> +		   /* 3 */
> +
> +				   mutex_lock A
> +				   /* might wait for A */ <- DEADLOCK
> +				   /* start to take into account
> +				      event A's context */
> +				   /* 4 */
> +
> +				   folio_unlock B
> +				   /* event B that's been valid since 2 */
> +		   folio_unlock B
> +		   /* event B that's been valid since 3 */
> +
> +		   mutex_unlock A
> +		   /* event A that's been valid since 1 */
> +
> +				   mutex_unlock A
> +				   /* event A that's been valid since 4 */
> +
> +Let's build up dependency graph with this example. Firstly, context X:
> +
> +   context X
> +
> +   folio_lock B
> +   /* might wait for B */
> +   /* start to take into account event B's context */
> +   /* 2 */
> +
> +There are no events to create dependency. Next, context Y:
> +
> +   context Y
> +
> +   mutex_lock A
> +   /* might wait for A */
> +   /* start to take into account event A's context */
> +   /* 1 */
> +
> +   folio_lock B
> +   /* might wait for B */
> +   /* start to take into account event B's context */
> +   /* 3 */
> +
> +   folio_unlock B
> +   /* event B that's been valid since 3 */
> +
> +   mutex_unlock A
> +   /* event A that's been valid since 1 */
> +
> +There are two events. For event B, folio_unlock B, since there are no
> +waits between 3 and the event, event B does not create dependency. For
> +event A, there is a wait, folio_lock B, between 1 and the event. Which
> +means event A cannot be triggered if event B does not wake up the wait.
> +Therefore, we can say event A depends on event B, say, 'A -> B'. The
> +graph will look like after adding the dependency:
> +
> +   A -> B
> +
> +   where 'A -> B' means that event A depends on event B.
> +
> +Lastly, context Z:
> +
> +   context Z
> +
> +   mutex_lock A
> +   /* might wait for A */
> +   /* start to take into account event A's context */
> +   /* 4 */
> +
> +   folio_unlock B
> +   /* event B that's been valid since 2 */
> +
> +   mutex_unlock A
> +   /* event A that's been valid since 4 */
> +
> +There are also two events. For event B, folio_unlock B, there is a
> +wait, mutex_lock A, between 2 and the event - remind 2 is at a very
> +start and before the wait in timeline. Which means event B cannot be
> +triggered if event A does not wake up the wait. Therefore, we can say
> +event B depends on event A, say, 'B -> A'. The graph will look like
> +after adding the dependency:
> +
> +    -> A -> B -
> +   /           \
> +   \           /
> +    -----------
> +
> +   where 'A -> B' means that event A depends on event B.
> +
> +A new loop has been created. So DEPT can report it as a deadlock. For
> +event A, mutex_unlock A, since there are no waits between 4 and the
> +event, event A does not create dependency. That's it.
> +
> +CONCLUSION
> +
> +DEPT works well with any general synchronization mechanisms by focusing
> +on wait, event and its context.
> +

