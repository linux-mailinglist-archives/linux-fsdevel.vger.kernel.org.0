Return-Path: <linux-fsdevel+bounces-3111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161347EFC1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 00:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB821281411
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E21E46535;
	Fri, 17 Nov 2023 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D+twJGJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4951D6D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JUKUmM7k/h7OyHVBEeI82gqmMArbRNnc8n1KPhqoFcM=; b=D+twJGJouDVUWuf6PZlsWXgJGE
	vYUUkj5c8irEXhHL27y9Ic3vBiqlK09eVoAOtD5vUKQXyJUAuzTo7BGiZutudKwc6/Ipweqek1JLb
	ou7oJNxHrXfxH9mKHL5Hs8nlVcfhbMaRYeA/1xmML0Dfrv0EqMJntL7+FLtMUHPdXZBqIbfD03bka
	mdFummMqf85Hnd9CFhJvUY+POBs6vk9Qg/NQTVHCG39A/0gJ9xCaVU9MbTbNpn1nVINcM3RFgQYsA
	2lqUi4kS7Ne2A2GSITNFPC4Xkq94mezJqBwcjRfhL71n2lYCgXnJnzVQuk78/QMhwkI3ELh+HYxBp
	W7YAcCcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r48EP-00HD7U-10;
	Fri, 17 Nov 2023 23:26:37 +0000
Date: Fri, 17 Nov 2023 23:26:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <20231117232637.GD1957730@ZenIV>
References: <20231117215823.2821906-1-willy@infradead.org>
 <20231117220437.GF36211@frogsfrogsfrogs>
 <ZVfljIc64nEw0ewn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVfljIc64nEw0ewn@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 17, 2023 at 10:13:32PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 17, 2023 at 02:04:37PM -0800, Darrick J. Wong wrote:
> > On Fri, Nov 17, 2023 at 09:58:23PM +0000, Matthew Wilcox (Oracle) wrote:
> > > It is hard to find where mapping->private_lock, mapping->private_list and
> > > mapping->private_data are used, due to private_XXX being a relatively
> > > common name for variables and structure members in the kernel.  To fit
> > > with other members of struct address_space, rename them all to have an
> > > i_ prefix.  Tested with an allmodconfig build.
> > 
> > /me wonders if the prefix ought to be "as_" for address space instead of
> > inode.  Even though inode begat address_space, they're not the same
> > anymore.
> 
> It'd be the first thing in fs.h to ase an as_ prefix.  Right now, we
> have i_pages, i_mmap_writable, i_mmap, i_mmap_rwsem.  We have a_ops
> (which differs from f_op, i_op, s_op, dq_op, s_qcop in being plural!).
> Everything else doesn't have anything close to a meaningful prefix --
> host, invalidate_lock, gfp_mask, nr_thps, nrpages, writeback_index,
> flags, wb_err.
> 
> So i_ was the most common prefix, but if we wanted to go with a different
> prefix, we could go with a_.  Maybe we'll rename a_ops to a_op at
> some point.

Um...  One obvious note: there is only one point in the cycle where such
renaming can be done - rc1.  And it has to be announced and agreed upon
in the previous cycle.

IMO we need to figure out a policy for that kind of stuff; I _think_
that ->d_subdirs/->d_child conversion I have in my tree does not
quite reach the threshold for that (relatively small footprint),
but the thing you are suggesting is almost certainly crosses it.

