Return-Path: <linux-fsdevel+bounces-11777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A05857174
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5602F1C22909
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1CE146009;
	Thu, 15 Feb 2024 23:15:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F824145B3E;
	Thu, 15 Feb 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038922; cv=none; b=M1szX93WIN9XSIq+cT9TF6Tu4IBW4n2DQcHQUCToeYYXGBUIYWl9kl6qR7Koc42uc7UZlkgvSYNvCqY4nXjGq6nO8K1l9aWOWVa9gK+nKsen/L3xAvC0h9x3XFARRLUSVt75u2zmog+y5hsNaO+5vJOhAtGNB3JRCv3NWkV+nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038922; c=relaxed/simple;
	bh=ip/9Kg1Z3F2WBU1bYH9SJsjerMjosMs2osrTFKWhflQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hk/HhlKtnj3ZuGyDMIV704/+p2OzUEXh5Q/+hFEyfqbKjZ96RfJsJcWJBgOrEyHBrtjUi1g3O8JoNp1FJLaEl5aKfn7v8evN/tl72CIRBcczA83PUiz+rCekZWtLRIN+OYlVUQcCJeBPxHgRjDoCOzVfYwkngHyT/DLMWhfYvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C9DC433C7;
	Thu, 15 Feb 2024 23:15:14 +0000 (UTC)
Date: Thu, 15 Feb 2024 18:16:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in
 show_mem()
Message-ID: <20240215181648.67170ed5@gandalf.local.home>
In-Reply-To: <20240215180742.34470209@gandalf.local.home>
References: <20240212213922.783301-1-surenb@google.com>
	<20240212213922.783301-32-surenb@google.com>
	<Zc3X8XlnrZmh2mgN@tiehlicka>
	<CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
	<Zc4_i_ED6qjGDmhR@tiehlicka>
	<CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
	<ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
	<320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
	<efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
	<20240215180742.34470209@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 18:07:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>    text         data            bss     dec             hex filename
> 29161847        18352730        5619716 53134293        32ac3d5 vmlinux.orig
> 29162286        18382638        5595140 53140064        32ada60 vmlinux.memtag-off		(+5771)
> 29230868        18887662        5275652 53394182        32ebb06 vmlinux.memtag			(+259889)
> 29230746        18887662        5275652 53394060        32eba8c vmlinux.memtag-default-on	(+259767) dropped?
> 29276214        18946374        5177348 53399936        32ed180 vmlinux.memtag-debug		(+265643)

If you plan on running this in production, and this increases the size of
the text by 68k, have you measured the I$ pressure that this may induce?
That is, what is the full overhead of having this enabled, as it could
cause more instruction cache misses?

I wonder if there has been measurements of it off. That is, having this
configured in but default off still increases the text size by 68k. That
can't be good on the instruction cache.

-- Steve

