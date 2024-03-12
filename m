Return-Path: <linux-fsdevel+bounces-14180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA8878DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 05:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DFB1C214E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 04:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B7BA46;
	Tue, 12 Mar 2024 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhsBpi8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D2B66F;
	Tue, 12 Mar 2024 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710216957; cv=none; b=LmU0yXk88jrGakjLtllOK8T9datfmGfbRH3IsXmgfOMQn7ChqxBpa0N9yNnRtJJRqd/DxvtLDjnCxaEA0vZiR38oCSgPijL+zTZxCJamHqHDQCyWl2tl0PJjUgYccOyJpMBRkbeQEXFdSBdK2o4CqPBUnTdAaeoLI5pofA7dRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710216957; c=relaxed/simple;
	bh=iNaBzaLVKd3PkwA0GihEpEd2QdBPqa1tnFNQEOd6zYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbESj/c9LOXeTHgsgcOkvTx8GTLzGw7WtZA75eORnZPVceBghxboubPXHsNWWV9UXipsM6Tbdzwu9j2oIM6J7jHPTovXo1na5YBbivuc5VHpTXRpGYWVDMuqevuR4KCJOuiU6/zratuBCasM0ZN8VmciJrH84vtoSr0dKMMvUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhsBpi8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD67C433F1;
	Tue, 12 Mar 2024 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710216957;
	bh=iNaBzaLVKd3PkwA0GihEpEd2QdBPqa1tnFNQEOd6zYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhsBpi8zLqVXFByby2/rBeogS/r7p5l9WZBLZGqgQkM3onbiNdeWG6gk8NsocyQt1
	 lR6j+NqdAyf+Onql0PNTcxgCTUX1WUwRrzCWunuF/RD1JJFbOcNoCaxBJdnPxrH+SF
	 ePSYHnhvu3gn6s/EaUxikWf/IzTMTE9kOQ6eeiAIjsSlFS3XPelzPkJ5OqM4LcjHmz
	 XWbYDo7qkkqIrs45bRr00jvYX59WsX2LOZ1R4kl11lATC8Jt8lN98UUngEcm0HzvKN
	 UcqwplmNGFtIjcreW8WRnut9K8Yg+uQWRv+TwrPOc2l0o0cJPLO6+n6/8aOS7etRz2
	 tMkY2Ts/KEX6w==
Date: Mon, 11 Mar 2024 21:15:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240312041556.GZ1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
 <20240311152505.GR1927156@frogsfrogsfrogs>
 <20240312024320.GD1182@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312024320.GD1182@sol.localdomain>

On Mon, Mar 11, 2024 at 07:43:20PM -0700, Eric Biggers wrote:
> On Mon, Mar 11, 2024 at 08:25:05AM -0700, Darrick J. Wong wrote:
> > > > > I wonder, what are the access patterns for merkle blobs?  Is it actually
> > > > > sequential, or is more like 0 -> N -> N*N as we walk towards leaves?
> > > 
> > > I think the leaf level (i.e. individual record) access patterns
> > > largely match data access patterns, so I'd just treat it like as if
> > > it's a normal file being accessed....
> > 
> > <nod> The latest version of this tries to avoid letting reclaim take the
> > top of the tree.  Logically this makes sense to me to reduce read verify
> > latency, but I was hoping Eric or Andrey or someone with more
> > familiarity with fsverity would chime in on whether or not that made
> > sense.
> 
> The levels are stored ordered from root to leaf; they aren't interleaved.  So
> technically the overall access pattern isn't sequential, but it is sequential
> within each level, and the leaf level is over 99% of the accesses anyway
> (assuming the default parameters where each block has 128 children).

<nod>

> It makes sense to try to keep the top levels, i.e. the blocks with the lowest
> indices, cached.  (The other filesystems that support fsverity currently aren't
> doing anything special to treat them differently from other pagecache pages.)

<nod>

--D

> - Eric
> 

