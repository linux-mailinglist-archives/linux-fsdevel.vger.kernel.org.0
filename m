Return-Path: <linux-fsdevel+bounces-47825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD9AA5EA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F494C35B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0FB5103F;
	Thu,  1 May 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/ailoTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7418E3F;
	Thu,  1 May 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746103617; cv=none; b=kvhMJJ59WqLVbH1kbdWbxW04LqOMOhyUjILvLed/3hc/h7ddYcxbbohVkv1+81B2C2bhIhPtr5jaDlF4O3OKMpV8pgllevkkFtk0sGToIzHqTnIrUlsATmPzQaYzOQWWr7SJqbMIlSho/G2NwAVzIgybZIB/306r5qGIEhYqtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746103617; c=relaxed/simple;
	bh=gh4K3sr8A85nGmp3/KYor1kooge4eZ3XoQIIXCsKJmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdA5vBmFUveT4nLoYXFN3IcZLnEN7dHhqoK6IvAMP91YbcU/YBAoPF/KnVX0TzFdTYgjj/wb5UlRkoiBhzfl8Dnd+YWZRw2f5B+E/BZhGLLcmShjVCiRuM4RWpN9vjbv+LHRWDKAUEAl9fZI5b7/lAJuLp8/RADwTTBnUoOau34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j/ailoTZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MT3KCqHjly6/WkVzRYtUyUQ6kHv1G8+d/uDnpb9+Wlg=; b=j/ailoTZKXoaOPmmlFPl9MsAHX
	5BfvpF7rqDdfdJugevO0RmalbtVN3LbzoZJDuMhHYIUL5GBPHa/45fnthYZ3G1iYo4Lp9g5Tll1QV
	IZWjYKVgb2nJy11r156J1w4KMzxpbxS6teghHN/7aWMVFUAvyRaMWkXdpYqr8b7ibLi0sFbImszXQ
	7npg6eL8VRnWIqGdqLPUz+o4vQ80fPV6Aw1DKk/gPW3VWB8g54fzKPrvft5cp+jO1I0o0Y4vPRUzY
	bimGToFXaLY3sInkkKgAYGCRZLun+XgZoZ1/V6IzM7YOqBQnuI+m/uCmpz98Cz8V/j0HYTRKtaQSp
	Hz22RDpA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uATJP-00000000Euy-2n9s;
	Thu, 01 May 2025 12:46:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBB8830035E; Thu,  1 May 2025 14:46:46 +0200 (CEST)
Date: Thu, 1 May 2025 14:46:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Shuah Khan <shuah@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
	seanjc@google.com
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <20250501124646.GC4356@noisy.programming.kicks-ass.net>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501114235.GP4198@noisy.programming.kicks-ass.net>

On Thu, May 01, 2025 at 01:42:35PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
> > On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
> > > On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> > > > On 10/16/24 04:20, Lorenzo Stoakes wrote:
> > ...
> > > > > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > > > > index 88d6830ee004..1640b711889b 100644
> > > > > --- a/tools/testing/selftests/pidfd/pidfd.h
> > > > > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > > > > @@ -50,6 +50,14 @@
> > > > >    #define PIDFD_NONBLOCK O_NONBLOCK
> > > > >    #endif
> > > > > +/* System header file may not have this available. */
> > > > > +#ifndef PIDFD_SELF_THREAD
> > > > > +#define PIDFD_SELF_THREAD -100
> > > > > +#endif
> > > > > +#ifndef PIDFD_SELF_THREAD_GROUP
> > > > > +#define PIDFD_SELF_THREAD_GROUP -200
> > > > > +#endif
> > > > > +
> > > > 
> > > > As mentioned in my response to v1 patch:
> > > > 
> > > > kselftest has dependency on "make headers" and tests include
> > > > headers from linux/ directory
> > > 
> > > Right but that assumes you install the kernel headers on the build system,
> > > which is quite a painful thing to have to do when you are quickly iterating
> > > on a qemu setup.
> > > 
> > > This is a use case I use all the time so not at all theoretical.
> > > 
> > 
> > This is turning out to be a fairly typical reaction from kernel
> > developers, when presented with the "you must first run make headers"
> > requirement for kselftests.
> > 
> > Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
> > colorful, so I'll helpfully cite it here. :)
> 
> Let me re-try this.
> 
> This is driving me insane. I've spend the past _TWO_ days trying to
> build KVM selftests and I'm still failing.
> 
> This is absolute atrocious crap and is costing me valuable time.
> 
> Please fix this fucking selftests shit to just build. This is unusable
> garbage.

So after spending more time trying to remember how to debug Makefiles (I
hate my life), I found that not only do I need this headers shit, the
kvm selftests Makefile is actively broken if you use: make O=foo

-INSTALL_HDR_PATH = $(top_srcdir)/usr
+INSTALL_HDR_PATH = $(top_srcdir)/$(O)/usr


And then finally, I can do:

make O=foo headers_install
make O=foo -C tools/testing/selftests/kvm/

So yeah, thank you very much for wasting my time *AGAIN*.


Seriously, I want to be able to do:

  cd tools/testing/selftests/foo; make

and have it just work. I would strongly suggest every subsystem to
reclaim their selftests and make it so again.

And on that, let me go merge the fixes I need to have x86 and futex
build without this headers shit.

