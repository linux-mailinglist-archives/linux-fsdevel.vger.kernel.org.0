Return-Path: <linux-fsdevel+bounces-33438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC49B8BB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE891F2235B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01161531EF;
	Fri,  1 Nov 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBVjOAXc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98E1494A7;
	Fri,  1 Nov 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444724; cv=none; b=jmqfCTieC+aHOOKkb4r+BgxQmJsJc3qL7Fatz6EgjQlmzFOagAF48CTgGhXtrrGFeDURM6yOivYyXuNd682Nz0lyHHjzEGvR5h1BkP76NJSgGoscVIPdVyv5sXMj07Kjz9VY8PxKdh4QT7z1r6c2KNuLCUmvDYsDECMr7sMbOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444724; c=relaxed/simple;
	bh=ThxAaKztzBi0/cRlZPNliYJwvg/hi15Q8xMYGl3W3fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj070xdla1VMfY2rT6xVD72pPZG+n/9u1cLVoRMiDWfWZSNF5vBi96+bluGDWfSwe9MDyLidf8rWuR7ZwdiFMAwITqFi0KawwSb5ES/4KoxdJfA5L9SqRk8LqA0J1LnVCzI+H92ak+3vZnk0Nvoc1tCAiQTi3BSofv7w8IqbN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBVjOAXc; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so24210786d6.0;
        Fri, 01 Nov 2024 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730444721; x=1731049521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeRtSAMS9mSdK5Z3YnzN1Gk/iNcxNQ7vtANptzs5s5s=;
        b=KBVjOAXcWCexCu+G2KqhxQzfb2JOdXzNpnggaysw6apOFIGb7wvGFcRYUI7e71Go7y
         REDznD85wYKUxpZDtinEVHMjjLDoPheLi+dV71tNGf5hyDCjNcbfjH91/2YM1NevGwpX
         Bz/nX88xoDAYYRN/u0LLq8EvWMG1ScHtkLqeXMNWIpb3FlR9th4OVnNK8/f9C1D1w06x
         86SsSucgDi3BjzHCRV63+7zBZz8LU/kOzjYhviMkRfTLp6X1Ud+F1swHhQFluekAftre
         v9m+qwrlFK+BI/xB3NbZvCPNTrGU+nXy6sJBnjpTUmD9kfms5ofV5GINl3PBxOB7/aPc
         CWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730444721; x=1731049521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeRtSAMS9mSdK5Z3YnzN1Gk/iNcxNQ7vtANptzs5s5s=;
        b=AjuERcGMAme3mlskIXqHsn2rBEAo/7QiONToEHupAEUG/nAsdzO0c5KjPpNFNK2jEm
         Fg8T2Pw13FW4fuW9q4qSgSArA8DgeeIzYrA9bn0tldROoVDZnyfu2TIZSfS8+o1Favd6
         OD72/oW00tu7fwxKgO+w5XQcQt88w+wjk/JFyV68yiihmnwq7tC6t+y0liBGSvK5hcVZ
         UC4LPukjCeLOybAmhzkAGNlKGpkyu4ypL8cxWhVpna0jxq4bJdpE0BaltQ0onmVpWp45
         gbFyDoVzLOLKsyOSsSJD5n9GacLHHlW6qRicw//+YB524WQ0kE0K9b8fGGP+EX18CXQ0
         nCyw==
X-Forwarded-Encrypted: i=1; AJvYcCVaAOC21FyDtN3YIOWYh/ByLFOPYGowcQ4UKs5Mqv78he1ke4Wm1YrdZifbudJpoE2Z73AL7vF/aaVM7V03ZQ==@vger.kernel.org, AJvYcCViM6D1W8GJzBJm2GHaDzk7c8dFDYaiv9E46N7j2KSdl5chWsvGat6ekFUiVfQPsd9DLT3E@vger.kernel.org, AJvYcCWPrPQDfQPUl63g8YGmsZmiuGPcNPYxvhTh/xraf8Sh3X8+zRnjNRaoRWIadUyVJxgBh0OJgjviHH8AIHzK@vger.kernel.org, AJvYcCXcrs70+fXUU0EubW3zmBKBZYSkoAdRmStISrHg318O8HuqhrZsUET88GmCQf5HHYjcNJeqAZpMvvKi@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhEQX0En9zMT8UnvmSte8c0Vd0ZXrpQxoH0aEUyHO+qDpg+6w
	6SRoOZGuboNT8x64U2dNWQprH7/QLk0gxqLBDO2cHM3sB+Uv8BoGlBeiVoFI
X-Google-Smtp-Source: AGHT+IFrsBo99R77+QegcYKVQJQa7o75kxQSDycQVpMwSj1BelPv4m5AvmbCAqFWjQIDvFEi2jWTGQ==
X-Received: by 2002:a0c:c682:0:b0:6d1:6fae:6451 with SMTP id 6a1803df08f44-6d3542aa362mr74394476d6.10.1730444721125;
        Fri, 01 Nov 2024 00:05:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9f4e4sm16288896d6.10.2024.11.01.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:05:20 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4AB8A1200043;
	Fri,  1 Nov 2024 03:05:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 01 Nov 2024 03:05:20 -0400
X-ME-Sender: <xms:sH0kZ08A3ouC4fowzy8CSGkVPjbjWmcH-KuAODKOAsrCLPXJl3Z70A>
    <xme:sH0kZ8s3lxTPyi2hDzujZuvrhYp-WVf8-Sf965vl8Mk3R2lql72y6v2VufyoFEwaz
    oOXSs2tRAG9rZPtcw>
X-ME-Received: <xmr:sH0kZ6B7BxHG5qIwZWa1yZDfbd6nweSSBw-d-22bBr5sYk5gUgAUybdtWTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeehkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhk
    mhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:sH0kZ0fPpPWT-ZMfAxLmoGiEJHvS0eh430pWhKA5tKb98M7sCRzotQ>
    <xmx:sH0kZ5PPHY1qYd6c1_1iUjnQTJ0cl6EE16KaUf7P8wfTPdmLjVqmlg>
    <xmx:sH0kZ-kPmjSKwJbiG5nyq4rQA1UfTXHPU9ulFdJ5SBKWQExnooNYpg>
    <xmx:sH0kZ7utTfsVwCtwWjp_A8pra2-EkoBQjbUGOpgE0RhPKsLrU44XVQ>
    <xmx:sH0kZ3vHPSUXZMOXlCAjhtq15r6J38ifscptCou0h_BaMU1BRYJYHLol>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 03:05:19 -0400 (EDT)
Date: Fri, 1 Nov 2024 00:04:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, lkmm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com,
 Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Subject: Re: [RFC v2 11/13] rust: sync: Add memory barriers
Message-ID: <ZyR9aTAhtCdpdC-h@boqun-archlinux>
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <20241101060237.1185533-12-boqun.feng@gmail.com>
 <CABVgOSn1eeZo7HggJYNEzzuGGpKABF=NbyMZLQbNjRwCAKXY-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn1eeZo7HggJYNEzzuGGpKABF=NbyMZLQbNjRwCAKXY-w@mail.gmail.com>

On Fri, Nov 01, 2024 at 02:55:23PM +0800, David Gow wrote:
> On Fri, 1 Nov 2024 at 14:07, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Memory barriers are building blocks for concurrent code, hence provide
> > a minimal set of them.
> >
> > The compiler barrier, barrier(), is implemented in inline asm instead of
> > using core::sync::atomic::compiler_fence() because memory models are
> > different: kernel's atomics are implemented in inline asm therefore the
> > compiler barrier should be implemented in inline asm as well.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/helpers/helpers.c      |  1 +
> >  rust/kernel/sync.rs         |  1 +
> >  rust/kernel/sync/barrier.rs | 67 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 69 insertions(+)
> >  create mode 100644 rust/kernel/sync/barrier.rs
> >
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index ab5a3f1be241..f4a94833b29d 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include "atomic.c"
> > +#include "barrier.c"
> 
> It looks like "barrier.c" is missing, so this isn't compiling for me.
> I assume it was meant to be added in this patch...?
> 

Yes, I just send an updated one.

Glad being "checking missing files" buddies with you ;-) Thanks!

Regards,
Boqun

> Thanks,
> -- David



