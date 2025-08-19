Return-Path: <linux-fsdevel+bounces-58347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94ABB2CF69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358207AC0A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9900D223DCE;
	Tue, 19 Aug 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8is8tYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BFD531;
	Tue, 19 Aug 2025 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642877; cv=none; b=Y3+8Z9BxxUYYBQ9L8wF1mymXi0kEcRbRrX9pOcds1dtyZcglNd0oHGdisj+w8K1yCwLYOYwqlYekx4O1cKu9jh6odPGxBHc511XtHVnhcmlo6afJiIIyLtHoAdo8Q19XQywQio8mQzVaW0YFRc5go2vgzfaVuej59H10tRbzo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642877; c=relaxed/simple;
	bh=6Sk/MNWBFDioqL39rNr4B4PX+fafxYE5hU6kqwLAC60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMeLj4JgA6/Y/5utEJUYvtQKEY7cYJ0QaoF8isMRTA1n2sKsYM3gPISAEq13l4DDF3b/Xtizr7N0F7YDg1ULlTUj9ezN6mgElE4956GbfYNxfADo4s8BxHpmGgRIE+g5tm3vASrC6gu41zsXEPEOSpI4Gax4poIGY9mArTIIuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8is8tYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEE3C4CEF1;
	Tue, 19 Aug 2025 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755642876;
	bh=6Sk/MNWBFDioqL39rNr4B4PX+fafxYE5hU6kqwLAC60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8is8tYVtpytE05vnC4AEAiO2Sgb7LQHcA84q4ih6q/pvpskZWaCzrkq70rRw5t37
	 jW2niufEFAxRDqrPWRCD0R/8ggeM8n9qBliJuziaUG++cgEhWhangonf92ydflG+mm
	 3DLxBojovVmZmKBTIw68Wc3luWbPWKJbwE+tbrn1RihdyBh1GzgimLUXFppQEnU5Jz
	 z9pLaxJHCy+hmzcXVv9k3smq+JfcDv9Z78Jp11BGue9+KhjXHJcIxLfkV52Fjoh6Dc
	 t/qzkwcJ20hJFn0UL+ndD71H2VAdrXTXq2pUxkvYaGdALMFnKKzmQBHeRynzFkWnlM
	 FXTZ+rPBQni3A==
Date: Tue, 19 Aug 2025 15:34:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <20250819223435.GH7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
 <oolcpxrjdzrkqnmj4xvcymnyb6ovdt7np7trxlgndniqe35l3s@ru5adqnjxexh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oolcpxrjdzrkqnmj4xvcymnyb6ovdt7np7trxlgndniqe35l3s@ru5adqnjxexh>

On Fri, Aug 15, 2025 at 11:38:02AM -0500, John Groves wrote:
> On 25/08/14 03:58PM, Miklos Szeredi wrote:
> > On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
> > >
> > > * The new GET_DAXDEV message/response is enabled
> > > * The command it triggered by the update_daxdev_table() call, if there
> > >   are any daxdevs in the subject fmap that are not represented in the
> > >   daxdev_dable yet.
> > 
> > This is rather convoluted, the server *should know* which dax devices
> > it has registered, hence it shouldn't need to be explicitly asked.
> 
> That's not impossible, but it's also a bit harder than the current
> approach for the famfs user space - which I think would need to become
> stateful as to which daxdevs had been pushed into the kernel. The
> famfs user space is as unstateful as possible ;)
> 
> > 
> > And there's already an API for registering file descriptors:
> > FUSE_DEV_IOC_BACKING_OPEN.  Is there a reason that interface couldn't
> > be used by famfs?
> 
> FUSE_DEV_IOC_BACKING_OPEN looks pretty specific to passthrough. The
> procedure for opening a daxdev is stolen from the way xfs does it in 
> fs-dax mode. It calls fs_dax_get() rather then open(), and passes in 
> 'famfs_fuse_dax_holder_ops' to 1) effect exclusivity, and 2) receive
> callbacks in the event of memory errors. See famfs_fuse_get_daxdev()...

Yeah, that's about what I would do to wire up fsdax in fuse-iomap.

> A *similar* ioctl could be added to push in a daxdev, but that would
> still add statefulness that isn't required in the current implementation.
> I didn't go there because there are so few IOCTLs currently (the overall 
> model is more 'pull' than 'push').
> 
> Keep in mind that the baseline case with famfs will be files that are 
> interleaved across strips from many daxdevs. We commonly create files 
> that are striped across 16 daxdevs, selected at random from a
> significantly larger pool. Because interleaving is essential to memory 
> performance...
> 
> There is no "device mapper" analog for memory, so famfs really does 
> have to span daxdevs. As Darrick commented somewhere, famfs fmaps do 
> repeating patterns well (i.e. striping)...
> 
> I think there is a certain elegance to the current approach, but
> if you feel strongly I will change it.

I still kinda wonder if you actually want BPF for this sort of thing
(programmatically computed file IO mappings) since they'd give you more
flexibility than hardcoded C in the kernel.

--D

> Thanks!
> John
> 
> 

