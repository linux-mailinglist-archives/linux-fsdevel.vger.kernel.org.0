Return-Path: <linux-fsdevel+bounces-59835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19333B3E498
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1F104E2B19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC6321F3F;
	Mon,  1 Sep 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CnAwI6SL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ck+bLnVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBF229B36;
	Mon,  1 Sep 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732802; cv=none; b=rVlXMVzDQ4wVafMyr3UOr0/eCqg3U+i5h8d2ja4tH5Yrb7UwKOYBpbCIvQ73SIl9Z/sGl3W5J7vqsKDbIVsOIwKTnTgqveXq6BM/b1ggZxEaZMvNwZ9mRegkEunZBwtYmXUvEbuvoefcP8dnhrbsh1bMUF+CSl+BH/Q7F6dkUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732802; c=relaxed/simple;
	bh=Mw8Cn4/OCWn4lPhhW5QgwqsK4SmxabwHi0TRYO6VF1s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cx5MQMuMRB/23Gd/1l5tLbAJ2oBpFSSscM3yiLrlt9jUj3C4zkEbLt4VlXbpfC+U8fH3X90tNLsBGV2+kwQw3z91ltgIayRosbKEsz4l68y3ML14LsWs4a+pLZsgPgpld1EmOIz0fNZvSkVNKRPmy9Mk35nt+cKRehJ3Zjpp+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CnAwI6SL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ck+bLnVy; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 0273F1300C7C;
	Mon,  1 Sep 2025 09:19:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 01 Sep 2025 09:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756732798;
	 x=1756739998; bh=Mw8Cn4/OCWn4lPhhW5QgwqsK4SmxabwHi0TRYO6VF1s=; b=
	CnAwI6SLiAzw0ll8Zcw4x5ea+0Wq8HSRDsTA+9idX6q1fQOlDdE3T68T/kysPsIG
	nKO9tHyF6Fkm5B/udz2FfkCejBvRRR69H9aA2BrCMMr0ANRdSOH6v/vmUfCY6aKN
	9al2A9m+/LbUpShQmy9n/+vOjS0OpgsEZXq0Hj3P0uQRDAZ6sDBza6GbHCFQZfCU
	bK3sxkJn4xh0u5pizVBli7lqdFPr0vIypTIrsNVvRo5/G3G98pikcIa/SMLnU+XR
	joMia7KY2YpR6qcrOYAY4upTkIkbmsxCcG7v0eDIzuymSe6UVhl0vDVJcf8/pwuU
	ub3tO2OuWEVDh/PNC1ns9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756732798; x=
	1756739998; bh=Mw8Cn4/OCWn4lPhhW5QgwqsK4SmxabwHi0TRYO6VF1s=; b=c
	k+bLnVyuYvhrOGGKenVyE6fBWoVEDNzhfGsMxUqDAGiBXMw3Y0aqSZrO99yruehh
	7SuaY3v8ffaiwA7q/f2441rlWzMGV2KhxDUvwd5dJkD0oNAnUbFI+noFJSDwLkKD
	jaa1OqQOv30Qbm6ICXD545lYhFrDJwWshMDunmIO1s2irCc75wtkhZpAT5hwAc4C
	n9m0gNYy7MoNjydJqkXVeuEM3iLHeA2rOUyPeXYXDswUfkuw0LeEthOs5ReQ8jiv
	c3Pd+c7YESEkFE+JbQiaKxUimpiO9cHD2qvSqsWz4lgmPWBj3I05MDeoALVGtNaJ
	UzJmRoeKiveqvY5CekgRA==
X-ME-Sender: <xms:d521aC0u7k4amQJoLyVrcBLNx0wUYznM_zSAvZLeU2-BlC0z8244DA>
    <xme:d521aFEzWHjBQoSajlcp_aq_RTDvOyBr8PFD3opgNZ-35p-O7Zx_pio9feaRUauPA
    -6F_cY6_RIsBvHmh9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehmghhorh
    hmrghnsehsuhhsvgdruggvpdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhr
    tggvfhhorhhgvgdrjhhppdhrtghpthhtoheptghgrhhouhhpshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrlhhphhgrsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtshhkhiesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d521aJbYCfJKFnzAy-OwM6PqVQ_fcrhaLANYO3c1UvIPGTz1tYdAUg>
    <xmx:d521aDlZ48FyGpG0KTdhHL5zxMK2x_1O5V_gv9k1zeUP7_YKQmjAHg>
    <xmx:d521aCxJr_e5WBMfalpY5TZjIvP2obRwdbIREpkCkdp_PdpJfjYe1w>
    <xmx:d521aMvMgCtTy5OqA64XDSsEufV7f6lUl9HluAjsXVu6CwKxpthR6A>
    <xmx:fp21aNvM5R6PYH-zyKAm8vBU6cruj05d3bRLorh9nyzV2V9Fz9q0KKLP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76793700065; Mon,  1 Sep 2025 09:19:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AngmsHLdt4H3
Date: Mon, 01 Sep 2025 15:19:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Hildenbrand" <david@redhat.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Kees Cook" <kees@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 guoren <guoren@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Tejun Heo" <tj@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Kentaro Takeda" <takedakn@nttdata.co.jp>,
 "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Brian Cain" <bcain@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Chris Zankel" <chris@zankel.net>,
 "Max Filippov" <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 stable@vger.kernel.org
Message-Id: <13f8ca46-92f0-47bb-a046-165402122a44@app.fastmail.com>
In-Reply-To: 
 <20250901-nios2-implement-clone3-v2-1-53fcf5577d57@siemens-energy.com>
References: 
 <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-1-53fcf5577d57@siemens-energy.com>
Subject: Re: [PATCH v2 1/4] copy_sighand: Handle architectures where sizeof(unsigned
 long) < sizeof(u64)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 1, 2025, at 15:09, Simon Schuster via B4 Relay wrote:

> This commit fixes the bug by always passing clone_flags to copy_sighand
> via their declared u64 type, invariant of architecture-dependent integer
> sizes.
>
> Fixes: b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")
> Cc: stable@vger.kernel.org # linux-5.5+
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

