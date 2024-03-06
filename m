Return-Path: <linux-fsdevel+bounces-13750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E92873620
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276701F25052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172948003A;
	Wed,  6 Mar 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfcAte4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D21426B;
	Wed,  6 Mar 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727232; cv=none; b=lKYu6fFhS1DftmmGN8PXlPG0xPQHNv8bUsShwN208ubnYJFnHx+HBkpewWCBooHxY0WGv8qgBzZHbXHhpDnsMXMWlKZxcC8eoKXeGKY81kw82DVB02EaGonQxtcrFcRZH/ZpPh8Lg8ybkOWM5Cz4LotSt1ECSkklE0BjukrBfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727232; c=relaxed/simple;
	bh=ojEffb4COaOPiBzIgQj1CiYFBW+nj8u1CS/gHL+DJT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9evhu8JuOoq+hhZSBB6a0+ID4b5UTO0FvYCbvGRFkvGl8HOGf25jKNroQBvWLJlisJKd0415ruCC1UaXj8XsLxTn/EyJTthl2dVnvyUI0YSjJAcJR9g6+P/VSZECvNOCtwQAYzz33d3Hd8WVbbu6H5+NrgajNTrroECsnpD+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfcAte4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3666C433C7;
	Wed,  6 Mar 2024 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709727232;
	bh=ojEffb4COaOPiBzIgQj1CiYFBW+nj8u1CS/gHL+DJT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfcAte4dn72KWdp2vtAuJ+7w8w1YEfRjbOHEnfv78OShc8jeqYfZBlPbSJ+c0CDRW
	 nuVPUbyq7ooGFt14B//PqZjTSwXo8GBNOfojetZF8/i9S3g2l1/tqeXGItK0VTd/1o
	 yONoPED4zz9FlbSCedDhk1bF/j7MMDalGXJeP/9GlioZYaI0lXy+1h3129EIL/cVMY
	 rEbrOqf38PC2hLV6GAaDZs0p1/PE7RhwJ+N5/9g16TIqRrvX7LyRZTZI/E0z6i2NDR
	 vuv4nP7FC2/Fi6ErWLp8lTbPhmfcoUqyP+Jx/9KjQutV0fk0JkR971KoL1Is8UkmTj
	 rB3otNY+DhqYw==
Date: Wed, 6 Mar 2024 13:13:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240306-sandgrube-flora-a61409c2f10c@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306-flach-tragbar-b2b3c531bf0d@brauner>

On Wed, Mar 06, 2024 at 12:21:28PM +0100, Christian Brauner wrote:
> On Wed, Mar 06, 2024 at 07:39:14AM +0000, Matt Bobrowski wrote:
> > G'day All,
> > 
> > The original cover letter providing background context and motivating
> > factors around the needs for the BPF kfuncs introduced within this
> > patch series can be found here [0], so please do reference that if
> > need be.
> > 
> > Notably, one of the main contention points within v1 of this patch
> > series was that we were effectively leaning on some preexisting
> > in-kernel APIs such as get_task_exe_file() and get_mm_exe_file()
> > within some of the newly introduced BPF kfuncs. As noted in my
> > response here [1] though, I struggle to understand the technical
> > reasoning behind why exposing such in-kernel helpers, specifically
> > only to BPF LSM program types in the form of BPF kfuncs, is inherently
> > a terrible idea. So, until someone provides me with a sound technical
> > explanation as to why this cannot or should not be done, I'll continue
> > to lean on them. The alternative is to reimplement the necessary
> > in-kernel APIs within the BPF kfuncs, but that's just nonsensical IMO.
> 
> You may lean as much as you like. What I've reacted to is that you've
> (not you specifically, I'm sure) messed up. You've exposed d_path() to
> users  without understanding that it wasn't safe apparently.
> 
> And now we get patches that use the self-inflicted brokeness as an
> argument to expose a bunch of other low-level helpers to fix that.
> 
> The fact that it's "just bpf LSM" programs doesn't alleviate any
> concerns whatsoever. Not just because that is just an entry vector but
> also because we have LSMs induced API abuse that we only ever get to see
> the fallout from when we refactor apis and then it causes pain for the vfs.
> 
> I'll take another look at the proposed helpers you need as bpf kfuncs
> and I'll give my best not to be overly annoyed by all of this. I have no
> intention of not helping you quite the opposite but I'm annoyed that
> we're here in the first place.
> 
> What I want is to stop this madness of exposing stuff to users without
> fully understanding it's semantics and required guarantees.

So, looking at this series you're now asking us to expose:

(1) mmgrab()
(2) mmput()
(3) fput()
(5) get_mm_exe_file()
(4) get_task_exe_file()
(7) get_task_fs_pwd()
(6) get_task_fs_root()
(8) path_get()
(9) path_put()

in one go and the justification in all patches amounts to "This is
common in some BPF LSM programs".

So, broken stuff got exposed to users or at least a broken BPF LSM
program was written somewhere out there that is susceptible to UAFs
becauase you didn't restrict bpf_d_path() to trusted pointer arguments.
So you're now scrambling to fix this by asking for a bunch of low-level
exports.

What is the guarantee that you don't end up writing another BPF LSM that
abuses these exports in a way that causes even more issues and then
someone else comes back asking for the next round of bpf funcs to be
exposed to fix it.

The difference between a regular LSM asking about this and a BPF LSM
program is that we can see in the hook implementation what the LSM
intends to do with this and we can judge whether that's safe or not.

Here you're asking us to do this blindfolded. So I feel we can't really
ACK a series such as this without actually seeing what is intended to be
done with all these helpers that you want as kfuncs. Not after the
previous brokenness.

In any case, you need separate ACKs from mm for the mmgrab()/mmput()
kfuncs as well.

Because really, all I see immediately supportable is the addition of a
safe variant of bpf making use of the trusted pointer argument
constraint:

[PATCH v2 bpf-next 8/9] bpf: add trusted d_path() based BPF kfunc bpf_path_d_path()

