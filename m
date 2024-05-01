Return-Path: <linux-fsdevel+bounces-18449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C428B91A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2821F22567
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C012D76F;
	Wed,  1 May 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jormAfGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BC1E481;
	Wed,  1 May 2024 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714602920; cv=none; b=ppv2huELm0B5ISVAPXhlWVpeotWry/x3d8tPReZtHsNpjXOtBDdM1iRUMDBw1M/TShZRcuB+WeJi75WJZfRoBFDaIkFwEqaZZdIHYc0sX2A+5QHUnctJ7XMNGkT8GXctXpngFfwXt16YejF0LK+gCkv+lKA0NFhXY/aNcmtGcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714602920; c=relaxed/simple;
	bh=IvBt0AnsQRK03r72S9Hzs8jvLYj9n9tVLdaSRgQErx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbeRwCESA2E4hl78lek6KGKHcWlKCRaRePvSMwYR2A7rhC5a+uXvudDu1bMMON92kH+2spRY0hjWmiyf3LNkPo9MV6izcgZL7dHjU9Zv06X/r1wMlk/fnKrYmjVtIb/dza30CijznjZj0dYjWbURZj9Glibj8dpYudF29oMF1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jormAfGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3453FC072AA;
	Wed,  1 May 2024 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714602920;
	bh=IvBt0AnsQRK03r72S9Hzs8jvLYj9n9tVLdaSRgQErx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jormAfGIONiIfCJxskjav5eEAg6QLdko/VnQ/DQkYE6ugfOpTMtautWR+RNrjiBfO
	 hl8Ap7Hq+ieaGmv2/zM7IRNkutkGI8mL2QGGERrCE1EXoa6gFAcOj2YBVaB6LYhxww
	 WR/DfeNCFvEKd8z6LqWjZfTtJg1ssSjG6UYxW7OXXAQiEnXy5BAdgfbYFw6biKGwX/
	 w1ipIOuZa0RsHtrGuOHwulDJHmY3MG+GBQv6dP9ReorSmrpqmPbdJS3NNK4MLd5TD9
	 513KYjcgbUhPLK9XdUKqKtUmwkWuiSQniQQ+wTYzTm2RHXzse4/wVFwk4/ffwfSUoH
	 5q7pC/cK3hFzQ==
Date: Wed, 1 May 2024 15:35:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fsverity: support block-based Merkle tree caching
Message-ID: <20240501223519.GG360919@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679658.955480.4637262867075831070.stgit@frogsfrogsfrogs>
 <ZjHw6wt3K164hOBr@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHw6wt3K164hOBr@infradead.org>

On Wed, May 01, 2024 at 12:36:11AM -0700, Christoph Hellwig wrote:
> > @@ -377,6 +391,19 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
> >  
> >  	block->pos = pos;
> >  	block->size = params->block_size;
> > +	block->verified = false;
> > +
> > +	if (vops->read_merkle_tree_block) {
> > +		struct fsverity_readmerkle req = {
> > +			.inode = inode,
> > +			.ra_bytes = ra_bytes,
> > +		};
> > +
> > +		err = vops->read_merkle_tree_block(&req, block);
> > +		if (err)
> > +			goto bad;
> > +		return 0;
> 
> I still don't understand why we're keeping two interfaces instead of
> providing a read through pagecache helper that implements the
> ->read_block interface.  That makes the interface really hard to follow
> and feel rather ad-hoc.  I also have vague memories of providing such a
> refactoring a long time ago.

Got a link?  This is the first I've heard of this, but TBH I've been
ignoring a /lot/ of things trying to get online repair merged (thank
you!) over the past months...

--D

