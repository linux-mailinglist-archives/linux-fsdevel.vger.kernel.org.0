Return-Path: <linux-fsdevel+bounces-3108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463317EFB34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 23:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A2BB20BD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572F4503B;
	Fri, 17 Nov 2023 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KsVcxW1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C08D4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 14:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MFUtEs3y616hfbBRvmns6H6P0KpWMdLP/1PcgbIXsyE=; b=KsVcxW1kIZh/8ZC7W1s9I+sSCi
	KDZQWW4kzUEmJp+7v3ZMyK2hqIbEz83kHfvoamNqw4TedRB9YrXvTVturP1q1WpngbgikQ0c+aSh4
	b7s15mz+ZITKVVNUPRMnGunt9p0LxcSyJDdIVnEo8Wd64Sky23RZoJam3a4B6HRqqY8IbeJkbmHHB
	yc5bd+Q8Ipkm7euGl1SUbSdUG9AZL7WWVNLOAtFbmnANov3CyygZpnHsc9Oa0tAt9Kb1qD+1bJxLV
	9z8NVS+ZxciKHrsxBFqFCxej0P0IWVkXNacjd5q7CYg63Y5PheFVCOHVDFCocMBPm/Kh99+almDSj
	4R6X9yzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r475g-00BszZ-Iy; Fri, 17 Nov 2023 22:13:32 +0000
Date: Fri, 17 Nov 2023 22:13:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <ZVfljIc64nEw0ewn@casper.infradead.org>
References: <20231117215823.2821906-1-willy@infradead.org>
 <20231117220437.GF36211@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117220437.GF36211@frogsfrogsfrogs>

On Fri, Nov 17, 2023 at 02:04:37PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 17, 2023 at 09:58:23PM +0000, Matthew Wilcox (Oracle) wrote:
> > It is hard to find where mapping->private_lock, mapping->private_list and
> > mapping->private_data are used, due to private_XXX being a relatively
> > common name for variables and structure members in the kernel.  To fit
> > with other members of struct address_space, rename them all to have an
> > i_ prefix.  Tested with an allmodconfig build.
> 
> /me wonders if the prefix ought to be "as_" for address space instead of
> inode.  Even though inode begat address_space, they're not the same
> anymore.

It'd be the first thing in fs.h to ase an as_ prefix.  Right now, we
have i_pages, i_mmap_writable, i_mmap, i_mmap_rwsem.  We have a_ops
(which differs from f_op, i_op, s_op, dq_op, s_qcop in being plural!).
Everything else doesn't have anything close to a meaningful prefix --
host, invalidate_lock, gfp_mask, nr_thps, nrpages, writeback_index,
flags, wb_err.

So i_ was the most common prefix, but if we wanted to go with a different
prefix, we could go with a_.  Maybe we'll rename a_ops to a_op at
some point.

