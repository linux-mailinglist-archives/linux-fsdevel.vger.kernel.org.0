Return-Path: <linux-fsdevel+bounces-62870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31490BA3665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C11C7AB3FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349B2F49F2;
	Fri, 26 Sep 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD1JE0tX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40324374C4;
	Fri, 26 Sep 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884006; cv=none; b=S2AR9BlTavjGPILdjCnsn5zcQgsT79FWVsUxDcMev2O/8NCuOBnCiE0YJ7yFlbuP/Tzrk3am13HOzLFd2r2WDFr2oXiS1i5z9AHDs9s3SjKix+nHyaQkz0gsV5Z+kXt5s03qTCCZ30QpSd0cJmYyp5gvmNnVbRk/cIhE2DlDxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884006; c=relaxed/simple;
	bh=7hmmYSJPRgv/HC65SCjVCWih93S3343uLCIvyfBCuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv5ZpxRLEmuLamgxBVYX/dtNj6nfGWPzBPldSzmpQkzlUIy3+ynOceroNyVjen2sUfBXO+7kYOrMVgrt3ffohpJcx2mywkDiZQsaxdHKO2krHk8MC3+G/L6S361qCWnXnbHZsPTktnmA3ow+mleYGawFZBUwq8fiLvSqApCgnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD1JE0tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D44C4CEF4;
	Fri, 26 Sep 2025 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758884005;
	bh=7hmmYSJPRgv/HC65SCjVCWih93S3343uLCIvyfBCuoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD1JE0tXSNlpM8sPhyTXW479bU0LI8INqzK4TERYGl4X7uWhmA9lmVftkg1kWXZ5R
	 77GIltP55fsK1VaNF04SNJorVj4he00rts0ps3WabgzU+pkpIwJ4s8I+R0hmUJnUtU
	 RiaA5H5VESS2asBJWt7pSZgGaIv0Nm+KYRCGG+rPlSqbN+Dbh5Z/Txoz0wlINXpYEV
	 XpuzK1hMtXmi8NPXs68yGAwo2DcoOz/MQPBrQn8al4WKuMkf07ZITw6sd0eQuO6+Q/
	 NxEbMuIeeoejXQN3nR+oF+rAs5zBbLTi3No4iK9EUmEyBi7Uiryz2YSyhJ74rbGMLA
	 g299/90nvCdmA==
Date: Fri, 26 Sep 2025 11:53:12 +0100
From: Will Deacon <will@kernel.org>
To: Patrick Roy <patrick.roy@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Roy, Patrick" <roypat@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"song@kernel.org" <song@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>,
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
	"tabba@google.com" <tabba@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for
 disabling TLB flushing
Message-ID: <aNZwmPFAxm_HRYpC@willie-the-truck>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-3-roypat@amazon.co.uk>
 <e25867b6-ffc0-4c7c-9635-9b3f47b186ca@intel.com>
 <c1875a54-0c87-450f-9370-29e7ec4fea3d@redhat.com>
 <82bff1c4-987f-46cb-833c-bd99eaa46e7a@intel.com>
 <c79173d8-6f18-40fa-9621-e691990501e4@redhat.com>
 <c88514c3-e15f-4853-8acf-15e7b4b979f4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88514c3-e15f-4853-8acf-15e7b4b979f4@linux.dev>

On Fri, Sep 26, 2025 at 10:46:15AM +0100, Patrick Roy wrote:
> 
> 
> On Thu, 2025-09-25 at 21:13 +0100, David Hildenbrand wrote:
> > On 25.09.25 21:59, Dave Hansen wrote:
> >> On 9/25/25 12:20, David Hildenbrand wrote:
> >>> On 25.09.25 20:27, Dave Hansen wrote:
> >>>> On 9/24/25 08:22, Roy, Patrick wrote:
> >>>>> Add an option to not perform TLB flushes after direct map manipulations.
> >>>>
> >>>> I'd really prefer this be left out for now. It's a massive can of worms.
> >>>> Let's agree on something that works and has well-defined behavior before
> >>>> we go breaking it on purpose.
> >>>
> >>> May I ask what the big concern here is?
> >>
> >> It's not a _big_ concern. 
> > 
> > Oh, I read "can of worms" and thought there is something seriously problematic :)
> > 
> >> I just think we want to start on something
> >> like this as simple, secure, and deterministic as possible.
> > 
> > Yes, I agree. And it should be the default. Less secure would have to be opt-in and documented thoroughly.
> 
> Yes, I am definitely happy to have the 100% secure behavior be the
> default, and the skipping of TLB flushes be an opt-in, with thorough
> documentation!
> 
> But I would like to include the "skip tlb flushes" option as part of
> this patch series straight away, because as I was alluding to in the
> commit message, with TLB flushes this is not usable for Firecracker for
> performance reasons :(

I really don't want that option for arm64. If we're going to bother
unmapping from the linear map, we should invalidate the TLB.

Will

