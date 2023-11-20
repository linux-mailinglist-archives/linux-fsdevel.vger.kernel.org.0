Return-Path: <linux-fsdevel+bounces-3212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3C7F16C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D960B1C2181F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B21CF83;
	Mon, 20 Nov 2023 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB2ElRxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D110A3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 15:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0309DC433C8;
	Mon, 20 Nov 2023 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700493033;
	bh=tnlpJi5EOgubc49X6sCICiog2NJixxqj5/P38DuYJLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZB2ElRxjerLjT947FUrPaIhJuRdWzK70nuj6e7t3XNF8bWwq9+DGsbSq981z7aGM6
	 ptdA1rSBAQlChsU5z7ZcfpRI1GnDz6xo0EMhzEVnLiSH0l3KTOgzj1ijKjk2TsyZ5W
	 AjcUmNRqIYcpIQR2PNb1zAqHwofGTYkKuE5T3QVrdFG5WjuS6J4+yuI/yY7ZynGE5u
	 0jNftmE5Kz4yvPRNBoMLI3JI3h9LTwHxQwzrAEmPsQcdFol6lLLreY7ECMaaFeWPO4
	 yz2NTy+gtofDikqM30Fzg7eQHRsVsFZI7tM/53VrlI/nHD2YegMI78UhHLJrkQ/smA
	 MXnj18/qWY7Rw==
Date: Mon, 20 Nov 2023 16:10:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <20231120-offerieren-raufen-9d920b224cb3@brauner>
References: <20231117215823.2821906-1-willy@infradead.org>
 <20231117220437.GF36211@frogsfrogsfrogs>
 <ZVfljIc64nEw0ewn@casper.infradead.org>
 <20231117232637.GD1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231117232637.GD1957730@ZenIV>

On Fri, Nov 17, 2023 at 11:26:37PM +0000, Al Viro wrote:
> On Fri, Nov 17, 2023 at 10:13:32PM +0000, Matthew Wilcox wrote:
> > On Fri, Nov 17, 2023 at 02:04:37PM -0800, Darrick J. Wong wrote:
> > > On Fri, Nov 17, 2023 at 09:58:23PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > It is hard to find where mapping->private_lock, mapping->private_list and
> > > > mapping->private_data are used, due to private_XXX being a relatively
> > > > common name for variables and structure members in the kernel.  To fit
> > > > with other members of struct address_space, rename them all to have an
> > > > i_ prefix.  Tested with an allmodconfig build.
> > > 
> > > /me wonders if the prefix ought to be "as_" for address space instead of
> > > inode.  Even though inode begat address_space, they're not the same
> > > anymore.
> > 
> > It'd be the first thing in fs.h to ase an as_ prefix.  Right now, we
> > have i_pages, i_mmap_writable, i_mmap, i_mmap_rwsem.  We have a_ops
> > (which differs from f_op, i_op, s_op, dq_op, s_qcop in being plural!).
> > Everything else doesn't have anything close to a meaningful prefix --
> > host, invalidate_lock, gfp_mask, nr_thps, nrpages, writeback_index,
> > flags, wb_err.
> > 
> > So i_ was the most common prefix, but if we wanted to go with a different
> > prefix, we could go with a_.  Maybe we'll rename a_ops to a_op at
> > some point.
> 
> Um...  One obvious note: there is only one point in the cycle where such
> renaming can be done - rc1.  And it has to be announced and agreed upon
> in the previous cycle.
> 
> IMO we need to figure out a policy for that kind of stuff; I _think_

I think that anything before -rc3 is fine. I'm not sure we should tie
our hands behind our back by agreeing on this so much in advance and
having some sort of policy. In the end if someone really cares they can
always speak up.

> that ->d_subdirs/->d_child conversion I have in my tree does not
> quite reach the threshold for that (relatively small footprint),
> but the thing you are suggesting is almost certainly crosses it.

