Return-Path: <linux-fsdevel+bounces-52717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A1AE6022
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE00619238B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71FE27A931;
	Tue, 24 Jun 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH4HuEM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106342056;
	Tue, 24 Jun 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755736; cv=none; b=LUKQriVDUnfau7Fhn2agfTe6eHP3wwij8xb3RMTUKXrxB3+ySZ40Z/OW7JL6/Wjjc08qj6SLs4C5peTgI8/AHs5v5L7ZXqImbNE4E3oJ4wWia7xOyjNeKiulrOB/U+fqAWyOVoEX5Mp5P9DCzu3g14AzGgyJeKTuLpB4d2jwyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755736; c=relaxed/simple;
	bh=RYBkNNitf5svZH4js90PzpOw2USAgvJPhk2Xr/4Wr4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upAZ90k5IbmCFpjg32yoBzUjrmSw04SoIM1vlpJL+obX8K0ZK9mRcjnCKIFvOAxSgn3ZM9eoNl/IddHOVThoaC6t5qx1hXW7JEndRAAqkfBoBGuhIeI16cPlXKIC49JKFHCH0YRBWJihIFNPV5VTuX5BLkaMmDdPHQADZbt/MZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH4HuEM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAF4C4CEE3;
	Tue, 24 Jun 2025 09:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750755735;
	bh=RYBkNNitf5svZH4js90PzpOw2USAgvJPhk2Xr/4Wr4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EH4HuEM6RvBdtrTQe68Z/JuJzhwhGI1DoOHoxlOg/zPA2Ltx43kiWw4v731PF2qQr
	 xzAZnDdge6rY6/DdEPt4NZxhWroDrBdx4J8oAGvxwpzfa4Dr+VzBiaYrhZuZj10zJj
	 YgreLuEQjpwZ1uLX1rc/kY3wK+sxBk2o9p/41yNuZ+9SWvAtZTa4W9QZ5CUl+WIInP
	 pwLA5j7MVOsupjh1qcebSJWI5sYWpLZzTb4dZ2W2cnrxwROZTyEW6jfCqQd4LAZv8x
	 iLKupLi0L7DeOnU/BFkzw68A9qL8+ttJmmiog9lbjh8W9CYo8DczBpIU3UOoGYOkXN
	 rJmaGVdEvMpUA==
Date: Tue, 24 Jun 2025 11:02:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Shivank Garg <shivankg@amd.com>, david@redhat.com, 
	akpm@linux-foundation.org, paul@paul-moore.com, viro@zeniv.linux.org.uk, 
	willy@infradead.org, pbonzini@redhat.com, tabba@google.com, afranji@google.com, 
	ackerleytng@google.com, jack@suse.cz, cgzones@googlemail.com, ira.weiny@intel.com, 
	roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <20250624-einwickeln-geflecht-f9cc9cc67d3c@brauner>
References: <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org>
 <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org>
 <aFleJN_fE-RbSoFD@infradead.org>
 <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
 <20250623142836.GT1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623142836.GT1613200@noisy.programming.kicks-ass.net>

On Mon, Jun 23, 2025 at 04:28:36PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 23, 2025 at 04:21:15PM +0200, Vlastimil Babka wrote:
> > On 6/23/25 16:01, Christoph Hellwig wrote:
> > > On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
> > >> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
> > >> > I'm more than happy to switch a bunch of our exports so that we only
> > >> > allow them for specific modules. But for that we also need
> > >> > EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
> > >> 
> > >> Huh?  Any export for a specific in-tree module (or set thereof) is
> > >> by definition internals and an _GPL export if perfectly fine and
> > >> expected.
> > 
> > Peterz tells me EXPORT_SYMBOL_GPL_FOR_MODULES() is not limited to in-tree
> > modules, so external module with GPL and matching name can import.
> > 
> > But if we're targetting in-tree stuff like kvm, we don't need to provide a
> > non-GPL variant I think?
> 
> So the purpose was to limit specific symbols to known in-tree module
> users (hence GPL only).
> 
> Eg. KVM; x86 exports a fair amount of low level stuff just because KVM.
> Nobody else should be touching those symbols.
> 
> If you have a pile of symbols for !GPL / out-of-tree consumers, it
> doesn't really make sense to limit the export to a named set of modules,
> does it?
> 
> So yes, nothing limits things to in-tree modules per-se. The
> infrastructure only really cares about module names (and implicitly
> trusts the OS to not overwrite existing kernel modules etc.). So you
> could add an out-of-tree module name to the list (or have an out-of-free
> module have a name that matches a glob; "kvm-vmware" would match "kvm-*"
> for example).
> 
> But that is very much beyond the intention of things.

So I'm not well-versed in all the GPL vs non-GPL exports. I'm thinking
of cases like EXPORT_SYMBOL(fget_task_next); That's exposed to gfs2 (and
bpf but that's built-in). I see no reason to risk spreading the usage of
that special-thing to anywhere else. So I would use
EXPORT_*_FOR_MODULES(gfs2) for this and we'd notice if anything else is
trying to use that thing.

Another excellent candidate is:

  /*
   * synchronous analog of fput(); for kernel threads that might be needed
   * in some umount() (and thus can't use flush_delayed_fput() without
   * risking deadlocks), need to wait for completion of __fput() and know
   * for this specific struct file it won't involve anything that would
   * need them.  Use only if you really need it - at the very least,
   * don't blindly convert fput() by kernel thread to that.
   */
  void __fput_sync(struct file *file)
  {
          if (file_ref_put(&file->f_ref))
                  __fput(file);
  }
  EXPORT_SYMBOL(__fput_sync);

That thing worries me to no end because that can be used to wreak all
kinds of havoc and I want that thing tied down so no one can even look
at it without getting a compile time or runtime error that we can
immediately notice. So for that as well I want to allow-list modules
that we have explictly acknowledged to use it.

But iiuc I can't just switch that non-GPL exported symbol to a GPL
exported symbol. And I don't want to be involved in some kind of
ideological warfare around that stuff.

I care about not growing more users of __fput_sync(). So any advice is
appreciated.

