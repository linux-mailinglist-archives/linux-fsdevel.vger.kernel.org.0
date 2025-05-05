Return-Path: <linux-fsdevel+bounces-48081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC53AA949E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53F2173D9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A08258CCB;
	Mon,  5 May 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkF1cTFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BED2040B6;
	Mon,  5 May 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452119; cv=none; b=GkdW+QDPMht/RcvlnQpjhltlURthfFCsiSbieehNI+4KIUJZEHAeu9hfG2N+fPUNw5SFWq+WTAQ6x7fn4YpqHDBvtKKhaNBqp6WoNnlAvrINlJqDSnoMguwLcE4ALWmHufUkFN2u2SDApSTq/G5SKUUWecHKz9a9GLKt5mF0n1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452119; c=relaxed/simple;
	bh=lZYJj5+RvlpcB3C/3nThNIVF+4ts/zwD2yTL3wPkp6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuaOK6RC86zHlAzerYOF/Royd3zJyVZI7hNQkbToyOu9662p7Z8k/qZW8q90uesOxoT/LyIFWhTJlqZjFjNKBFjwTN6G873sR7o424MKWNExTaUdcpKniWkJe5ntmbxnSx9gwhMrxMK8aN+4yg3kIHz5vClh2vDmrsBtroBrXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkF1cTFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4726BC4CEE4;
	Mon,  5 May 2025 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746452118;
	bh=lZYJj5+RvlpcB3C/3nThNIVF+4ts/zwD2yTL3wPkp6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkF1cTFvbhP4Ye7NeV9917c1PkBLXuYnLDbiOErKUKsUumdsSQbOSMNV+zqY18Rek
	 iMgcsmDQnKKTGn+zuxvwpTgU95tKAC7axgb/oimBwIeWBH4Qdl//jsdS4phegc4QB6
	 Od8s6UqytlBBSYBU6sYpgrW0+Xp5QP9sPiVwNULR2e9TANRtMUkmw+uXdjg01d79Ln
	 oApceD/DookzKf4fYwsDQNTRHGg1JtviuRWBg02Cwd5WEcQ0XvCA/LXEG/YJP63KIn
	 sUWf6i8bS2nrfk6KNE3ZE7xDcac83jrNRzGftJ/nnH7mqWNvilg2dKT7aNvbAlNFVZ
	 3fsRCjlhW9PCw==
Date: Mon, 5 May 2025 15:35:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, seanjc@google.com
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <20250505-postablage-drinnen-ddaa539abc18@brauner>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
 <20250501124646.GC4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501124646.GC4356@noisy.programming.kicks-ass.net>

On Thu, May 01, 2025 at 02:46:46PM +0200, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 01:42:35PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
> > > On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
> > > > On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> > > > > On 10/16/24 04:20, Lorenzo Stoakes wrote:
> > > ...
> > > > > > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > > > > > index 88d6830ee004..1640b711889b 100644
> > > > > > --- a/tools/testing/selftests/pidfd/pidfd.h
> > > > > > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > > > > > @@ -50,6 +50,14 @@
> > > > > >    #define PIDFD_NONBLOCK O_NONBLOCK
> > > > > >    #endif
> > > > > > +/* System header file may not have this available. */
> > > > > > +#ifndef PIDFD_SELF_THREAD
> > > > > > +#define PIDFD_SELF_THREAD -100
> > > > > > +#endif
> > > > > > +#ifndef PIDFD_SELF_THREAD_GROUP
> > > > > > +#define PIDFD_SELF_THREAD_GROUP -200
> > > > > > +#endif
> > > > > > +
> > > > > 
> > > > > As mentioned in my response to v1 patch:
> > > > > 
> > > > > kselftest has dependency on "make headers" and tests include
> > > > > headers from linux/ directory
> > > > 
> > > > Right but that assumes you install the kernel headers on the build system,
> > > > which is quite a painful thing to have to do when you are quickly iterating
> > > > on a qemu setup.
> > > > 
> > > > This is a use case I use all the time so not at all theoretical.
> > > > 
> > > 
> > > This is turning out to be a fairly typical reaction from kernel
> > > developers, when presented with the "you must first run make headers"
> > > requirement for kselftests.
> > > 
> > > Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
> > > colorful, so I'll helpfully cite it here. :)
> > 
> > Let me re-try this.
> > 
> > This is driving me insane. I've spend the past _TWO_ days trying to
> > build KVM selftests and I'm still failing.
> > 
> > This is absolute atrocious crap and is costing me valuable time.
> > 
> > Please fix this fucking selftests shit to just build. This is unusable
> > garbage.
> 
> So after spending more time trying to remember how to debug Makefiles (I
> hate my life), I found that not only do I need this headers shit, the
> kvm selftests Makefile is actively broken if you use: make O=foo
> 
> -INSTALL_HDR_PATH = $(top_srcdir)/usr
> +INSTALL_HDR_PATH = $(top_srcdir)/$(O)/usr
> 
> 
> And then finally, I can do:
> 
> make O=foo headers_install
> make O=foo -C tools/testing/selftests/kvm/
> 
> So yeah, thank you very much for wasting my time *AGAIN*.
> 
> 
> Seriously, I want to be able to do:
> 
>   cd tools/testing/selftests/foo; make
> 
> and have it just work. I would strongly suggest every subsystem to
> reclaim their selftests and make it so again.
> 
> And on that, let me go merge the fixes I need to have x86 and futex
> build without this headers shit.

I'm completely lost as to what's happening here or whether the test here
is somehow at fault for something.

The pidfd.h head explicitly has no dependency on the pidfd uapi header
itself and I will NAK anything that makes it so. It's just a giant pain.

