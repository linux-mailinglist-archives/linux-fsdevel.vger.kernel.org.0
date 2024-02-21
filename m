Return-Path: <linux-fsdevel+bounces-12216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DD85D1DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD4E1C241AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FCE3B795;
	Wed, 21 Feb 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPPQIkvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952543B781;
	Wed, 21 Feb 2024 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502131; cv=none; b=oy6ngC95y41xS2D0R+Uqn937wyOaSHuUT+g8KXD/xdUgX0/moKOkE1921dO/HHOAbn31i2yAs5LJPU4Z4IUnh5H782rQ6x6fOQeVCAlahmDXu2C+Uz181XhU/Gw3UWJqSUh0hgBR5jD/rp6GcxuInD90Ms05rDRoTdu3v0PG/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502131; c=relaxed/simple;
	bh=8Gjs3UyGstIz+V//qXmGOQrur0RJZg8xu/QusoSW3Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBAbe9b4hnWutqhWSS1GCsHmJCQ9zdfoaPFEDJrTXdLrUCFZSZgluUJGlUmHaru/0mcKkivKGWm3e6pa3F+nqnKj+9HCpPBSHpoO41kIFWInrZSDHjG+s3mf0sNzt9wP75FrBvDWAb1QmM609q1xDNo2hWTfu0d9Vcx75+yAIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPPQIkvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F58C43399;
	Wed, 21 Feb 2024 07:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708502130;
	bh=8Gjs3UyGstIz+V//qXmGOQrur0RJZg8xu/QusoSW3Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPPQIkvSE9Ft9sp9lxixoHAzNGl/Q9i4t8QZNSt9SU/kUAEspPDDVyAX9V/q9Z0x/
	 BmFYubP2pHFDG/S/sz5mwOGiyaYp0aliL7931BapY1CRdaWCKavxem/83NQVsVfyBq
	 z/cyh62szYytjtNkuOpg2VuD0JGsVODJtG4cGiIXLxf0ZlLcx/7kcrpNF7KF9dRErN
	 f4ukMQAjK4wKsPqjtxHAqkyQ6i4FQB4FpteczRMkqriHWSt/+HncB6M/KfTrmVPmoG
	 l6m6t+KoUeidixjk502g4yQSZ8t93VXJJw6clYacn3matBVgdrCrekEzeE+jDE8clz
	 6lhkH8fUIVeJg==
Date: Wed, 21 Feb 2024 08:55:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf-next 01/11] bpf: make bpf_d_path() helper use
 probe-read semantics
Message-ID: <20240221-fugen-turmbau-07ec7df36609@brauner>
References: <cover.1708377880.git.mattbobrowski@google.com>
 <5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com>
 <20240220-erstochen-notwehr-755dbd0a02b3@brauner>
 <ZdSnhqkO_JbRP5lO@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdSnhqkO_JbRP5lO@google.com>

On Tue, Feb 20, 2024 at 01:22:14PM +0000, Matt Bobrowski wrote:
> On Tue, Feb 20, 2024 at 10:48:10AM +0100, Christian Brauner wrote:
> > On Tue, Feb 20, 2024 at 09:27:23AM +0000, Matt Bobrowski wrote:
> > > There has now been several reported instances [0, 1, 2] where the
> > > usage of the BPF helper bpf_d_path() has led to some form of memory
> > > corruption issue.
> > > 
> > > The fundamental reason behind why we repeatedly see bpf_d_path() being
> > > susceptible to such memory corruption issues is because it only
> > > enforces ARG_PTR_TO_BTF_ID constraints onto it's struct path
> > > argument. This essentially means that it only requires an in-kernel
> > > pointer of type struct path to be provided to it. Depending on the
> > > underlying context and where the supplied struct path was obtained
> > > from and when, depends on whether the struct path is fully intact or
> > > not when calling bpf_d_path(). It's certainly possible to call
> > > bpf_d_path() and subsequently d_path() from contexts where the
> > > supplied struct path to bpf_d_path() has already started being torn
> > > down by __fput() and such. An example of this is perfectly illustrated
> > > in [0].
> > > 
> > > Moving forward, we simply cannot enforce KF_TRUSTED_ARGS semantics
> > > onto struct path of bpf_d_path(), as this approach would presumably
> > > lead to some pretty wide scale and highly undesirable BPF program
> > > breakage. To avoid breaking any pre-existing BPF program that is
> > > dependent on bpf_d_path(), I propose that we take a different path and
> > > re-implement an incredibly minimalistic and bare bone version of
> > > d_path() which is entirely backed by kernel probe-read semantics. IOW,
> > > a version of d_path() that is backed by
> > > copy_from_kernel_nofault(). This ensures that any reads performed
> > > against the supplied struct path to bpf_d_path() which may end up
> > > faulting for whatever reason end up being gracefully handled and fixed
> > > up.
> > > 
> > > The caveats with such an approach is that we can't fully uphold all of
> > > d_path()'s path resolution capabilities. Resolving a path which is
> > > comprised of a dentry that make use of dynamic names via isn't
> > > possible as we can't enforce probe-read semantics onto indirect
> > > function calls performed via d_op as they're implementation
> > > dependent. For such cases, we just return -EOPNOTSUPP. This might be a
> > > little surprising to some users, especially those that are interested
> > > in resolving paths that involve a dentry that resides on some
> > > non-mountable pseudo-filesystem, being pipefs/sockfs/nsfs, but it's
> > > arguably better than enforcing KF_TRUSTED_ARGS onto bpf_d_path() and
> > > causing an unnecessary shemozzle for users. Additionally, we don't
> > 
> > NAK. We're not going to add a semi-functional reimplementation of
> > d_path() for bpf. This relied on VFS internals and guarantees that were
> > never given. Restrict it to KF_TRUSTED_ARGS as it was suggested when
> > this originally came up or fix it another way. But we're not adding a
> > bunch of kfuncs to even more sensitive VFS machinery and then build a
> > d_path() clone just so we can retroactively justify broken behavior.
> 
> OK, I agree, having a semi-functional re-implementation of d_path() is
> indeed suboptimal. However, also understand that slapping the

The ugliness of the duplicated code made me start my mail with NAK. It
would've been enough to just say no.

> KF_TRUSTED_ARGS constraint onto the pre-existing BPF helper
> bpf_d_path() would outright break a lot of BPF programs out there, so
> I can't see how taht would be an acceptable approach moving forward
> here either.
> 
> Let's say that we decided to leave the pre-existing bpf_d_path()
> implementation as is, accepting that it is fundamentally succeptible
> to memory corruption issues, are you saying that you're also not for
> adding the KF_TRUSTED_ARGS d_path() variant as I've done so here

No, that's fine and was the initial proposal anyway. You're already
using the existing d_path() anway in that bpf_d_path() thing. So
exposing another variant with KF_TRUSTED_ARGS restriction is fine. But
not hacking up a custom d_path() variant.

> [0]. Or, is it the other supporting reference counting based BPF
> kfuncs [1, 2] that have irked you and aren't supportive of either?

Yes, because you're exposing fs_root, fs_pwd, path_put() and fdput(),
get_task_exe_file(), get_mm_exe_file(). None of that I see being turned
into kfuncs.

