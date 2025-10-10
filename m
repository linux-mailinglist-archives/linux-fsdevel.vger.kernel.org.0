Return-Path: <linux-fsdevel+bounces-63787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC1BCDBCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B994FF807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD622F8BC3;
	Fri, 10 Oct 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoI9yJ5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EA2F7ADB;
	Fri, 10 Oct 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109057; cv=none; b=uZVzZRNQwHtkDIcjiLoXUHlb4IKOXLXUbGAM9tiXl+r9vW1p5Xk8NyofsudsB2yZ7JOVefODNa4Mo8uxoeS5boEAzeGESPaE+izKmwkKt7IB4JyntYpGFcC5nB1BI1IFgvydm+QVWufIejYrLecqq6qBidf11QefCiEOXyUATVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109057; c=relaxed/simple;
	bh=KEDbK+SNjMKMUuKWgcl44zDXGeQjspgRWfumF0EZ0sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyPzdBENy8/0ucRrFGDmi+3bUfvMnhSkGDP9YiP/AAFD/t0oiuLghf9C0ac+P33NhLNdeW7aQrdHLl39o/dDLyvK/a06rLFvjyGf/dafVB7iO7iZ8uljwQz8YS+0QigHXC42zHNaQIH95PoOlQ6vUYKYGi/vXtIOfXO2ampV/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoI9yJ5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFDFC4AF09;
	Fri, 10 Oct 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760109057;
	bh=KEDbK+SNjMKMUuKWgcl44zDXGeQjspgRWfumF0EZ0sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoI9yJ5zMg+a2aiaAbFYUF0F4MKNSOR71aG2VTrbq/uTs252lAWstPRldgFYBotjZ
	 12mYLJLgRrVdvGHjaIHfgf/M63PVurTeeoxFLjZ03WDuH/cgjM+6pVXaj/IZ05HvSi
	 x8NocK9GBMlVXgZQIyMBQsnL0BTQIe4tAtzndRrb4XvBPXmCT/otdNRNTFvp1GtmaH
	 fzAoIRAj+aDkVGB1d2NhcVLJGCA03PbOi9IN6wrsTdpcYlaHL+Ml44bb8XHG3z/wtp
	 94J9aju6FhBWvySltROLZG87ge+9PGeWQQg7KMYvTOhIT3vdZig00EuPOdAYRywgMv
	 Rq/OjvBhwO5qQ==
Date: Fri, 10 Oct 2025 08:10:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jakub Acs <acsjakub@amazon.de>, jhubbard@nvidia.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	chengming.zhou@linux.dev, david@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, peterx@redhat.com,
	rust-for-linux@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <20251010151056.GD6174@frogsfrogsfrogs>
References: <20251007162136.1885546-1-aliceryhl@google.com>
 <20251008125427.68735-1-acsjakub@amazon.de>
 <aOZj4Jeif1uYXAxZ@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOZj4Jeif1uYXAxZ@google.com>

On Wed, Oct 08, 2025 at 01:15:12PM +0000, Alice Ryhl wrote:
> On Wed, Oct 08, 2025 at 12:54:27PM +0000, Jakub Acs wrote:
> > redefine VM_* flag constants with BIT()
> > 
> > Make VM_* flag constant definitions consistent - unify all to use BIT()
> > macro and define them within an enum.
> > 
> > The bindgen tool is better able to handle BIT(_) declarations when used
> > in an enum.
> > 
> > Also add enum definitions for tracepoints.
> > 
> > We have previously changed VM_MERGEABLE in a separate bugfix. This is a
> > follow-up to make all the VM_* flag constant definitions consistent, as
> > suggested by David in [1].
> > 
> > [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> > 
> > Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Xu Xin <xu.xin16@zte.com.cn>
> > Cc: Chengming Zhou <chengming.zhou@linux.dev>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > 
> > Hi Alice,
> > 
> > thanks for the patch, I squashed it in (should I add your signed-off-by
> > too?) and added the TRACE_DEFINE_ENUM calls pointed out by Derrick.
> 
> You could add this if you go with the enum approach:
> 
> Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> > I have the following points to still address, though: 
> > 
> > - can the fact that we're not controlling the type of the values if
> >   using enum be a problem? (likely the indirect control we have through
> >   the highest value is good enough, but I'm not sure)
> 
> The compiler should pick the right integer type in this case.
> 
> > - where do TRACE_DEFINE_ENUM calls belong?
> >   I see them placed e.g. in include/trace/misc/nfs.h for nfs or
> >   arch/x86/kvm/mmu/mmutrace.h, but I don't see a corresponding file for
> >   mm.h - does this warrant creating a separate file for these
> >   definitions?
> > 
> > - with the need for TRACE_DEFINE_ENUM calls, do we still deem this
> >   to be a good trade-off? - isn't fixing all of these in
> >   rust/bindings/bindings_helper.h better?
> > 
> > @Derrick, can you point me to how to test for the issue you pointed out?
> 
> I'm not familiar with the TRACE_DEFINE_ENUM unfortunately.

rostedt already filled in the technical details, so I can supply an
example from code in XFS:

$ git grep -E '(XFS_REFC_DOMAIN_COW|XFS_REFC_DOMAIN_STRINGS)' fs/xfs/
fs/xfs/libxfs/xfs_refcount.c:118:               irec->rc_domain = XFS_REFC_DOMAIN_COW;
<snip>
fs/xfs/libxfs/xfs_types.h:164:  XFS_REFC_DOMAIN_COW,
fs/xfs/libxfs/xfs_types.h:167:#define XFS_REFC_DOMAIN_STRINGS \
fs/xfs/libxfs/xfs_types.h:169:  { XFS_REFC_DOMAIN_COW,          "cow" }
<snip>
fs/xfs/xfs_trace.h:1117:TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_COW);
fs/xfs/xfs_trace.h:3635:                  __print_symbolic(__entry->domain, XFS_REFC_DOMAIN_STRINGS),

XFS_REFC_DOMAIN_COW is part of an enumeration:

enum xfs_refc_domain {
	XFS_REFC_DOMAIN_SHARED = 0,
	XFS_REFC_DOMAIN_COW,
};

Which then has a string decoder macro defined for use in
__print_symbolic:

#define XFS_REFC_DOMAIN_STRINGS \
	{ XFS_REFC_DOMAIN_SHARED,	"shared" }, \
	{ XFS_REFC_DOMAIN_COW,		"cow" }

Note the TRACE_DEFINE_ENUM usage in the grep output.

Let's look at one of the tracepoints that uses XFS_REFC_DOMAIN_STRINGS.
The class is xfs_refcount_extent_class, so a relevant tracepoint is
xfs_refcount_get:

# cat /sys/kernel/tracing/events/xfs/xfs_refcount_get/format
name: xfs_refcount_get
ID: 1839
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:dev_t dev;        offset:8;       size:4; signed:0;
        field:enum xfs_group_type type; offset:12;      size:1; signed:0;
        field:xfs_agnumber_t agno;      offset:16;      size:4; signed:0;
        field:enum xfs_refc_domain domain;      offset:20;      size:4; signed:0;
        field:xfs_agblock_t startblock; offset:24;      size:4; signed:0;
        field:xfs_extlen_t blockcount;  offset:28;      size:4; signed:0;
        field:xfs_nlink_t refcount;     offset:32;      size:4; signed:0;

print fmt: "dev %d:%d %sno 0x%x dom %s gbno 0x%x fsbcount 0x%x refcount %u", ((unsigned int) ((REC->dev) >> 20)), ((unsigned int) ((REC->dev) & ((1U << 20) - 1))), __print_symbolic(REC->type, { 0, "ag" }, { 1, "rtg" }), REC->agno, __print_symbolic(REC->domain, { 0, "shared" }, { 1, "cow" }), REC->startblock, REC->blockcount, REC->refcount

Notice that the XFS_REFC_DOMAIN_* enumeration values have been
converted into their raw numeric form inside the __print_symbolic
construction so that they're ready for trace-cmd-report.

It's really helpful to have ftrace render bitfield and enumeration
"integers" into something human-readable, especially in filesystems
where there are a lot of those.

--D

> > +#ifndef CONFIG_MMU
> > +TRACE_DEFINE_ENUM(VM_MAYOVERLAY);
> > +#endif /* CONFIG_MMU */
> 
> Here I think you want:
> 
> #ifdef CONFIG_MMU
> TRACE_DEFINE_ENUM(VM_UFFD_MISSING);
> #else
> TRACE_DEFINE_ENUM(VM_MAYOVERLAY);
> #endif /* CONFIG_MMU */
> 
> > +TRACE_DEFINE_ENUM(VM_SOFTDIRTY);
> 
> Here I think you want:
> 
> #ifdef CONFIG_MEM_SOFT_DIRTY
> TRACE_DEFINE_ENUM(VM_SOFTDIRTY);
> #endif
> 
> Alice
> 

