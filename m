Return-Path: <linux-fsdevel+bounces-47822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9BAA5DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522F29A837D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52322488E;
	Thu,  1 May 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yk3be88r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EC19A;
	Thu,  1 May 2025 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746099770; cv=none; b=fChFnrwy28jLgTwkWg+UxsK3VzzDMeQTfL4u7sTYZmHZA4cOUX+i59UU4FIY4g7ko3qQY9iJcNXQv1sBtEL7bWI+eldJJR88gULd6T4bJeDeUqDp4o9xUdHw/aCgtF4WuHcHyMFuTiAhjMbBzavf0zu9y9TkR1ekfxWwIIHW2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746099770; c=relaxed/simple;
	bh=WqdSTn7f7FTDqhEoRMwbCqWlOk7H67e5aeVchffSyWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL5XCIx/xT4dRuQRo8K4GfQBirXixrZ2jj1fnJqiC5PdGsQApnfTr7ReQUiwwDuKmjPK64RgxASLYx2x1PchQrnuimDJHhKHfjQfL7bhStEhoQ3Vs0mqSK655N5kPSBjQqW6niwsFUwCpyNTNDlL75jV5R3MCn79OwttzHzgGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yk3be88r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iqBDQiUTHDotW7wVOgOpaA+Ei6LCT/MLR0aCdooTSVE=; b=Yk3be88rXMdkvtvYTEFgEsVg2U
	KX31JyfrrdYikKuRl0b+5OWvgTVHG+ONcKzs4Cu2aDHMRvNUG6GscQblkqt3JodaSIiqg3MF7nkFk
	TI0lQdOU1kLghLWMKMYIhBS9U8lkQMS4Vc7JNDw0DdyNoNJPcyOwXaXRuycOSL+0u/pmtnHJyK4V0
	6CjGpPmp8zdboJ0LsZK85RgAsKHKglwTe5kcV1FAWxhIODOZlbu8rlAiC2fd5QiJmlVs4lq9rOQW+
	B0SKLVu+W70dG8Sfj/8Dp69wXViD1RIz/4yHDFrMCERk2IpVmVfwbiR0F6ln0nG2Rv+P8IOZl0Dzi
	p3Nzjbjw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uASJH-000000003XF-3tOB;
	Thu, 01 May 2025 11:42:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3944D300230; Thu,  1 May 2025 13:42:35 +0200 (CEST)
Date: Thu, 1 May 2025 13:42:35 +0200
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
Message-ID: <20250501114235.GP4198@noisy.programming.kicks-ass.net>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>

On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
> On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
> > On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> > > On 10/16/24 04:20, Lorenzo Stoakes wrote:
> ...
> > > > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > > > index 88d6830ee004..1640b711889b 100644
> > > > --- a/tools/testing/selftests/pidfd/pidfd.h
> > > > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > > > @@ -50,6 +50,14 @@
> > > >    #define PIDFD_NONBLOCK O_NONBLOCK
> > > >    #endif
> > > > +/* System header file may not have this available. */
> > > > +#ifndef PIDFD_SELF_THREAD
> > > > +#define PIDFD_SELF_THREAD -100
> > > > +#endif
> > > > +#ifndef PIDFD_SELF_THREAD_GROUP
> > > > +#define PIDFD_SELF_THREAD_GROUP -200
> > > > +#endif
> > > > +
> > > 
> > > As mentioned in my response to v1 patch:
> > > 
> > > kselftest has dependency on "make headers" and tests include
> > > headers from linux/ directory
> > 
> > Right but that assumes you install the kernel headers on the build system,
> > which is quite a painful thing to have to do when you are quickly iterating
> > on a qemu setup.
> > 
> > This is a use case I use all the time so not at all theoretical.
> > 
> 
> This is turning out to be a fairly typical reaction from kernel
> developers, when presented with the "you must first run make headers"
> requirement for kselftests.
> 
> Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
> colorful, so I'll helpfully cite it here. :)

Let me re-try this.

This is driving me insane. I've spend the past _TWO_ days trying to
build KVM selftests and I'm still failing.

This is absolute atrocious crap and is costing me valuable time.

Please fix this fucking selftests shit to just build. This is unusable
garbage.

