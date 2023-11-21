Return-Path: <linux-fsdevel+bounces-3276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A28E7F2348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5371C21835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A98CA76;
	Tue, 21 Nov 2023 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjLrK/0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBB79E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 01:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B27CC433C8;
	Tue, 21 Nov 2023 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700531074;
	bh=hoXS9yWhmKq0ZkdNZrcpTQ6xVdZnoBM6/od7q+Nk52s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjLrK/0XH3M8I+gl7DTkEWMwwZXzPA60hWvcAvjW4+67R5z0zISjxRl0T4z+/cveh
	 Sc+gMqyDkemUkm6gdVausJu9jV+QPeoG0EVqkv9cMcpgbHiVdYw4e5b4KGxRkSn+TT
	 9CMm6ZhhHGb9Fh/LdCGspiG3bGzmeszwYwFqnKSyjndWWwrXbNzqa9QErtI8gNxW2F
	 hRl97GgZCzgHc4N+8MgO5yqWQDYuhHoieDj557k8v8n5SLesa93sm60ehaOFGzaCV+
	 UmnITUJJmjFGI1D87IQ+sqkk9cXgTimpDhMfwge3QuJAqSvv10EFcqb7/sJtOuQ8/l
	 OLsZr2rQ17W5w==
Date: Mon, 20 Nov 2023 17:44:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <20231121014434.GA36168@frogsfrogsfrogs>
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

<shrug> address_space::i_private_{data,lock,list} is fine with me.

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

