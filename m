Return-Path: <linux-fsdevel+bounces-65931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CEEC158CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FF92542835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B5345722;
	Tue, 28 Oct 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDwv4WN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1E3446BF;
	Tue, 28 Oct 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665634; cv=none; b=q//SR7HWjw0T9hA5RcC/o1a44UK/wHvudT1JUIhr3Uijvi3TDgs75AmavEKKxzIL6ThGIN/lY0eoyn6kwnVDeR4sad3ULjRJUUzLHJ9cakfAfpdp5EwHUOc/scX8WpVGMeTPBr4/I5UWZqDzLVnB4tjifXR8B0Q9YIZZgnGLvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665634; c=relaxed/simple;
	bh=cX+C81nVx0Z3LScNIsS6bnmKVkssc/fKJSZrOOzm2EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+D/0uj/OX/323RyMfpsuoq7e5c7PwEbDs+nOl3EgDQ0V7U8ExiD8BfN1hltgO1cAFbWwbiOCEciJ2FvGXiuwOku0I5x44yGDxN4m28X4hEbpFuj7NivVoZc+xm2bpYuflxxLRwPFW+KWWHNKKqpYjz5yAzutmemJRP+LRkMwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDwv4WN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B635BC4CEE7;
	Tue, 28 Oct 2025 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665633;
	bh=cX+C81nVx0Z3LScNIsS6bnmKVkssc/fKJSZrOOzm2EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDwv4WN+E/9jIS+YaRJNG7MSRe0rZK9JAVuKEi6DUk9I+yRfBiVXJb60EVy1JXq1b
	 m+t0FnCOA9f9mWDDMLDExxqDecIdODKecq/8ma7/RRkplrRuPvdh1SAQEvmTlrIdQ+
	 xS3kd9yPCP7BkDuxC5O8A1a2hFYKdmfM7hUYJj9V4ogUNZ5pt4NTy6nLIjZiSQZKqH
	 bUUQHYvsCm+7qyfZPKZPDLtigwoBTP6+E+vT00ZAatYPsEqNvTX+SYi42L87zuDoO3
	 g5uzpBvX0JK7w91ZoBEmkiRj9jY02yPDk2y8QOA0VguFrgHfkX1oRGCrGGTIritTJl
	 AARFHGwCvrmxA==
Date: Tue, 28 Oct 2025 16:33:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/70] ns: add active reference count
Message-ID: <20251028-unvollendet-erzogen-a3ec83ca68bf@brauner>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
 <87a51cwbck.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a51cwbck.ffs@tglx>

On Mon, Oct 27, 2025 at 05:36:27PM +0100, Thomas Gleixner wrote:
> On Fri, Oct 24 2025 at 12:52, Christian Brauner wrote:
> > diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> > index ee05cad288da..2e7c110bd13f 100644
> > --- a/kernel/time/namespace.c
> > +++ b/kernel/time/namespace.c
> > @@ -106,6 +106,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
> >  	ns->offsets = old_ns->offsets;
> >  	ns->frozen_offsets = false;
> >  	ns_tree_add(ns);
> > +	ns_ref_active_get_owner(ns);
> 
> It seems all places where ns_ref_active_get_owner() is added it is
> preceeded by a variant of ns_tree_add(). So why don't you stilck that
> refcount thing into ns_tree_add()? I'm probably missing something here.

Yes, as usual a very astute observation. I've taken your advice and
folded the parent count into __ns_tree_add_raw(). Thanks!

