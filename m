Return-Path: <linux-fsdevel+bounces-25044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FB94838D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CAB1F2166A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2816CD11;
	Mon,  5 Aug 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc9BqLhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EC14A4E1;
	Mon,  5 Aug 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890087; cv=none; b=r0Myghn+7CdiTkMmnUvCe0YNqduUhP+1EvJpQYvNficZPd0dblvjE+ROFoPCzBeEBTeTE3X6Bm4IRJwVEnz147yhyA6UenjkGKrUxMWSEmI0tfYKFzernoscp5tK05Mbj7mL4sz2hGjYuwktG34ua6zpgd/oVliWBg6a9JVYxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890087; c=relaxed/simple;
	bh=WLTAncxHbb2bIwU5P7XV//UTrrUj8v2T3O3toZDJJr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW+lxsFQRboM8ULG7VxaLRPWbgMqo9nLzDoCPGhPFQonmb4duuz89xF3/byC48mgdsNH7RkKAqhn/CbbSaOXL+rKICD6xaugmYSAUG2JJjmczKoaXsU+cTfDqDW4qqJLtUovStzQII/leOtQeOfe4pMgqoAjoNCBG6cZErracCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc9BqLhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EEBC4AF11;
	Mon,  5 Aug 2024 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722890087;
	bh=WLTAncxHbb2bIwU5P7XV//UTrrUj8v2T3O3toZDJJr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sc9BqLhjeh2KS44wtEj+WsvujNNEvhStNwwxogs6REPzOwcyGI831+DgM0R9qw/bo
	 4C3FuTDNs5h84XYJnsNLNQJSALmtq+Xtlhz/x6/rbj/PCqjSX4oSHeHAUNQEMJGVsT
	 X0O6xcYsOSOwMNgV3+tuGwh6NomBRtwZneCWgLFRp9+EhOY7mR73S2+c4K1jSiEqbw
	 jCQssanAT7SBIzXCJfsVhbeXQE41Krw76s8trgLsWqNDE7/AabkWyek2QoNNYpmQO3
	 lTz64XYyYVkLA31qK0KKS1nr6DegMsX4qNIqg1U7i31VICG/ch9yzgFfel7XkSSpm9
	 RkdEhGio3z4ZQ==
Date: Mon, 5 Aug 2024 13:34:46 -0700
From: Kees Cook <kees@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202408051330.277A639@keescook>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
 <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
 <4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>
 <202408051018.F7BA4C0A6@keescook>
 <230E81B0-A0BD-44B5-B354-3902DB50D3D0@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230E81B0-A0BD-44B5-B354-3902DB50D3D0@juniper.net>

On Mon, Aug 05, 2024 at 06:44:44PM +0000, Brian Mak wrote:
> On Aug 5, 2024, at 10:25 AM, Kees Cook <kees@kernel.org> wrote:
> 
> > On Thu, Aug 01, 2024 at 05:58:06PM +0000, Brian Mak wrote:
> >> On Jul 31, 2024, at 7:52 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>> One practical concern with this approach is that I think the ELF
> >>> specification says that program headers should be written in memory
> >>> order.  So a comment on your testing to see if gdb or rr or any of
> >>> the other debuggers that read core dumps cares would be appreciated.
> >> 
> >> I've already tested readelf and gdb on core dumps (truncated and whole)
> >> with this patch and it is able to read/use these core dumps in these
> >> scenarios with a proper backtrace.
> > 
> > Can you compare the "rr" selftest before/after the patch? They have been
> > the most sensitive to changes to ELF, ptrace, seccomp, etc, so I've
> > tried to double-check "user visible" changes with their tree. :)
> 
> Hi Kees,
> 
> Thanks for your reply!
> 
> Can you please give me some more information on these self tests?
> What/where are they? I'm not too familiar with rr.

I start from where whenever I go through their tests:

https://github.com/rr-debugger/rr/wiki/Building-And-Installing#tests


> > And those VMAs weren't thread stacks?
> 
> Admittedly, I did do all of this exploration months ago, and only have
> my notes to go off of here, but no, they should not have been thread
> stacks since I had pulled all of them in during a "first pass".

Okay, cool. I suspect you'd already explored that, but I wanted to be
sure we didn't have an "easy to explain" solution. ;)

> > It does also feel like part of the overall problem is that systemd
> > doesn't have a way to know the process is crashing, and then creates the
> > truncation problem. (i.e. we're trying to use the kernel to work around
> > a visibility issue in userspace.)
> 
> Even if systemd had visibility into the fact that a crash is happening,
> there's not much systemd can do in some circumstances. In applications
> with strict time to recovery limits, the process needs to restart within
> a certain time limit. We run into a similar issue as the issue I raised
> in my last reply on this thread: to keep the core dump intact and
> recover, we either need to start up a new process while the old one is
> core dumping, or wait until core dumping is complete to restart.
> 
> If we start up a new process while the old one is core dumping, we risk
> system stability in applications with a large memory footprint since we
> could run out of memory from the duplication of memory consumption. If
> we wait until core dumping is complete to restart, we're in the same
> scenario as before with the core being truncated or we miss recovery
> time objectives by waiting too long.
> 
> For this reason, I wouldn't say we're using the kernel to work around a
> visibility issue or that systemd is creating the truncation problem, but
> rather that the issue exists due to limitations in how we're truncating
> cores. That being said, there might be some use in this type of
> visibility for others with less strict recovery time objectives or
> applications with a lower memory footprint.

Yeah, this is interesting. This effectively makes the coredumping
activity rather "critical path": the replacement process can't start
until the dump has finished... hmm. It feels like there should be a way
to move the dumping process aside, but with all the VMAs still live, I
can see how this might go weird. I'll think some more about this...

-- 
Kees Cook

