Return-Path: <linux-fsdevel+bounces-33811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05929BF4BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4F1C23351
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB511207A0D;
	Wed,  6 Nov 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cl2L75m9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFB2076CE;
	Wed,  6 Nov 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915964; cv=none; b=XrKO0NU+tIc7wn7UE8KHOFXoxVNMl+oMchk45gg3wXWDhaRGYVAggZqtN4//V4Q24bA8EFQyTkry6tkRcbgRHSGazCUiJT50xn9zE1BNYR7/ieQFo8n0PLq2kGiWGgVmHL0/l4twqPNnISlnnm8tHCIU7aj6Yw9JfGxdU9stF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915964; c=relaxed/simple;
	bh=dcUwVXHDJvoq4ELZ+Jm0L84FW/3wK3XAHmM1DOyy8tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub7VcX/lIKmbx3VrfOWjEXZfyZ2Y6/yEQ5DlOBIT384csH8sbHaV9topnqbmd8BTpPb9AuY4ej+d3VGCTX/9xlhgDNbUMTZ8B3IBWm8D/37kLiGFXi50P4dWeQVqgIm3h3cXhWgWzRdcASf8aAy7iY/ANntGCNEBwDUJzWtLHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cl2L75m9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8XbbN/vPoIJejDqiSIIveN8cogeYAqqr1cnFYFwXZig=; b=cl2L75m9Bxuf2hXw63OPeGjgmf
	T3YE1lu5dgBfgNQko9QrlyUSx3jdxSIwkT8P16eXJV8NfmxnTiIBXZa/H7e3NDsPOQe0gPe7gE22K
	cL0n33IjTivggzsXAahK0dyLNoO9003qoMcF6E+Jn4968FiCUwfxOkfF5eEKXsondpa3ca9XEfZ3J
	cG0VETkZHzVmfidPkK/j6Tfbhu7U+Za7S4IxBUivODn1BMabpuaKqwTJCtqonyN+9+yqKQTVTj5X9
	Si/1AXr44Cct9L6CpKERVV9AOwvgFVHtOsyOqCq9zZGeGlb4PtXf7rSJbN1rVhtm5E9QLWdxUcOF0
	v/sOMnRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8kJI-0000000BjqL-2a3p;
	Wed, 06 Nov 2024 17:59:16 +0000
Date: Wed, 6 Nov 2024 17:59:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: "Ma, Yu" <yu.ma@intel.com>, Christian Brauner <brauner@kernel.org>,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20241106175916.GX1350452@ZenIV>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
 <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
 <20240802142248.GV5334@ZenIV>
 <20240805-gesaugt-crashtest-705884058a28@brauner>
 <5210f83c-d2d9-4df6-b3eb-3311da128dae@intel.com>
 <20240812024044.GF13701@ZenIV>
 <20241106174423.kdgv6eonsmwci5oj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106174423.kdgv6eonsmwci5oj@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 06, 2024 at 06:44:23PM +0100, Jan Kara wrote:
> On Mon 12-08-24 03:40:44, Al Viro wrote:
> > On Mon, Aug 12, 2024 at 09:31:17AM +0800, Ma, Yu wrote:
> > > 
> > > On 8/5/2024 2:56 PM, Christian Brauner wrote:
> > > > On Fri, Aug 02, 2024 at 03:22:48PM GMT, Al Viro wrote:
> > > > > On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
> > > > > > > Hmm...   Something fishy's going on - those are not reachable by any branches.
> > > > > > Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
> > > > > > to play around with --onto.
> > > > > > 
> > > > > > > I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
> > > > > > > and I'm going to apply those 3 unless anyone objects.
> > > > > > Fine since they aren't in that branch. Otherwise I generally prefer to
> > > > > > just merge a common branch.
> > > > > If it's going to be rebased anyway, I don't see much difference from cherry-pick,
> > > > > TBH...
> > > > Yeah, but I generally don't rebase after -rc1 anymore unles there's
> > > > really annoying conflicts.
> > > 
> > > Thanks Christian and Al for your time and efforts. I'm not familiar with the
> > > merging process, may i know about when these patches could be seen in master
> > 
> > It's in work.fdtable in my tree, will post that series tonight and add to #for-next
> 
> Al, it seems you didn't push the patches to Linus during the last merge
> window. Do you plan to push them during the coming one?

Yes, I do.  I can merge that branch into viro/vfs.git#for-next, but that would be
redundant - note that vfs/vfs.git#workd.fdtable is identical to it (same sha1 of
head) and vfs/vfs.git#vfs.file contains a merge from it and vfs/vfs.git#vfs.all
merges #vfs.file.  So it's already in linux-next in the current form and until
something else gets added to the branch I see no point.

