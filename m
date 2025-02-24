Return-Path: <linux-fsdevel+bounces-42377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7745A4132E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE9B1892C91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100919DF4B;
	Mon, 24 Feb 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KmAN0t4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA700EED6;
	Mon, 24 Feb 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362989; cv=none; b=uw+E0NWa2ZezYCG2gZs916E0obtAgSaPTEgpkzbHx7b1Ai09HvhAcZQB/rloL7g9JVdxWx9nj8US6gq+xbc1DY5zQM+vpdsv7DWZIKXu3mwBXkauTQwk2sSPTDvo34hy3Yl0PvCYw3nWZNl4rvb0VHsOBaT3b0cRGI6zpjDphow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362989; c=relaxed/simple;
	bh=FF6Wei/l8K8RDtEnTdw3476hC+kiKAOirTyFs73Q0t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbL1L0zlJZ70Zsj3jwDEsfP9wGOzi/jJ+rvgc9mtA1Tw/nyml1MOP8+fEJfK+Hq/zvOz4o65Cxq2y5NOQZMGGI0X2I48no9PO5kjGqhh74UGNFv1gl3+uqy2ELs68aP++bvxiTP2xdNiHc6mYvGXLt970Nn4e/+Xnhk8CKLHvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KmAN0t4A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k0z3ryzhlvwNnSY3M6NnkZyLrFw5ndXGZMxfWSNU7WE=; b=KmAN0t4ASfNyIO+14Tkdl6eWeS
	3h5f4U0OMObgauHsGHOggSvN3IH3kD9JEbHZkJw8V7XjINOSuY8bQ0KCoigDzT86A7uoqZ8sniL8p
	GcMQqi6DKiE0f287Qex4A3N4QmCmQiSYYLGz5ify3Xc26tT4EoicFpfO1qAhQP8TCUmj+lTLm91ic
	p1+A7yprmhsdpoGC58opaV8NVRBjyRTc7YzzcwHbbSaTkaZZ44ZfWX0NRBdhOCU2Fy+oer18kF+Wi
	oPMB34w48UifiegznLm57ZSPgJCDuN5xgqsbQ+u/CKZtTWDFRL0Q6LujN5ezl+BCpZiZrLvR0P0TD
	TAL7/hQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNuX-00000006aXB-3Rl4;
	Mon, 24 Feb 2025 02:09:33 +0000
Date: Mon, 24 Feb 2025 02:09:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250224020933.GV1977892@ZenIV>
References: <>
 <20250222041937.GM1977892@ZenIV>
 <174036084630.74271.16513912864596248299@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174036084630.74271.16513912864596248299@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 12:34:06PM +1100, NeilBrown wrote:
> On Sat, 22 Feb 2025, Al Viro wrote:
> > On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
> > 
> > > +In general, filesystems which use d_instantiate_new() to install the new
> > > +inode can safely return NULL.  Filesystems which may not have an I_NEW inode
> > > +should use d_drop();d_splice_alias() and return the result of the latter.
> > 
> > IMO that's a bad pattern, _especially_ if you want to go for "in-update"
> > kind of stuff later.
> 
> Agreed.  I have a draft patch to change d_splice_alias() and
> d_exact_alias() to work on hashed dentrys.  I thought it should go after
> these mkdir patches rather than before.

Could you give a braindump on the things d_exact_alias() is needed for?
It's a recurring headache when doing ->d_name/->d_parent audits; see e.g.
https://lore.kernel.org/all/20241213080023.GI3387508@ZenIV/ for related
mini-rant from the latest iteration.

Proof of correctness is bloody awful; it feels like the primitive itself
is wrong, but I'd never been able to write anything concise regarding
the things we really want there ;-/

