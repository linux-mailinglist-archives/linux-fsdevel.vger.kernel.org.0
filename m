Return-Path: <linux-fsdevel+bounces-11853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C6858068
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93E91C21AAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293D12F5A0;
	Fri, 16 Feb 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5z6tNXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9412F39D;
	Fri, 16 Feb 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096514; cv=none; b=R3U99GGPckF9Tw/5QNWWjP+bPVdEinHKwPHDseP+dRCxJzjOSOPuvVnIYm5Nr1d2vJn92lxiOmKj0MUrjlVlQ3RUUIDpQvlfsPLdX72+cUaR04JSqML0ndS7NCSd9XlCmPGGquLFQlnu8UNVAb6gmECzJMhExej69BUCSMjZ1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096514; c=relaxed/simple;
	bh=UZxvgj12gXJunVqb524yDyYbBRZhAtSxo48h5jfO3pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYGvicT+xZ7uOvrtlNwNHP+WXnNL9brpM0wrv0xdaiKr0jCqAvB865vpe/VG4m0Kfv6nKIS+fMiSyyRko9UBnx02V86Hs9U+g56XxBaHoXrSQFHH3V+eM3SHCt+tIip98TbcCyPwv6IzyS/fnMKVOF4I+WXH8eRaN8ZSU8Coa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5z6tNXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F5CC433C7;
	Fri, 16 Feb 2024 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708096514;
	bh=UZxvgj12gXJunVqb524yDyYbBRZhAtSxo48h5jfO3pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5z6tNXroCwwc52/0MaC4bKySERpEHLqZ/DkxJWNcdRQcoU/xMf6fkfO7Hz5EFYH6
	 GwEvpQRJ8IqLoZZ1XZN6VRyYY7JzIUKsBMiZ909lfo30EQUXUYAem2e6VRPHCfBp5I
	 q7gYukmOH2Ku23oNrTM2qd438FNl1Dp0hQ1X1mrYErONLw/swgc8kZkJ7ul91kWva5
	 6qO8N/oy0gcNbkinJ1x/iiYVol0fLJEvVH+GIFIgsPxDBydpbaoKqf6RhIc7aq7iML
	 LE/dUU7kcvQxvfJPSBgrXK5UaxDjgFKgfBhv9TA4PYZSsIRQu5dVq4QvgIhi/UA1Hi
	 zt+aAoSzCgsVw==
Date: Fri, 16 Feb 2024 16:15:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>, 
	viro@zeniv.linux.org.uk, hughd@google.com, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <20240216-prasseln-lachs-3fe73663d559@brauner>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
 <20240215130601.vmafdab57mqbaxrf@quack3>
 <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>

On Thu, Feb 15, 2024 at 08:45:33AM -0500, Chuck Lever wrote:
> On Thu, Feb 15, 2024 at 02:06:01PM +0100, Jan Kara wrote:
> > On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Test robot reports:
> > > > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > > >
> > > > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Feng Tang further clarifies that:
> > > > ... the new simple_offset_add()
> > > > called by shmem_mknod() brings extra cost related with slab,
> > > > specifically the 'radix_tree_node', which cause the regression.
> > > 
> > > Willy's analysis is that, over time, the test workload causes
> > > xa_alloc_cyclic() to fragment the underlying SLAB cache.
> > > 
> > > This patch replaces the offset_ctx's xarray with a Maple Tree in the
> > > hope that Maple Tree's dense node mode will handle this scenario
> > > more scalably.
> > > 
> > > In addition, we can widen the directory offset to an unsigned long
> > > everywhere.
> > > 
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > OK, but this will need the performance numbers.
> 
> Yes, I totally concur. The point of this posting was to get some
> early review and start the ball rolling.
> 
> Actually we expect roughly the same performance numbers now. "Dense
> node" support in Maple Tree is supposed to be the real win, but
> I'm not sure it's ready yet.

I keep repeating this but we need a better way to request performance
tests for specific series/branches. Maybe I can add a vfs.perf branch
where we can put patches that we suspect have positive/negative perf
impact and that perf bot can pull that in. I know, that's a fuzzy
boundary but for stuff like this where we already know that there's a
perf impact that's important for us it would really help.

Because it is royally annoying to get a perf regression report after a
patch has been in -next for a long time already and the merge window is
coming up or we already merged that stuff.

