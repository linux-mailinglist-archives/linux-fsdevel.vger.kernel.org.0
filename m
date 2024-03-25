Return-Path: <linux-fsdevel+bounces-15252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2EC88B092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AE2E1B94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BD4501F;
	Mon, 25 Mar 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jGiLYVk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226C224DB;
	Mon, 25 Mar 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396466; cv=none; b=IGk6lOxxqdOEmQ2770ShU/Ncbd4Msd8VrLXoztLNswHlw8G8O/1GZ8itGsVhy3RZLZ9MuIqVbFnxXXVDJvKyFZIHVEhMZv2INJc3Z5vyYvZ471zmtdQFIGQgDrCoZoQoHDQ8wsGw5Yo9w//5fRjHFjtdJNNdBpjGM+HUpIRtb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396466; c=relaxed/simple;
	bh=Hy2D4JJqgBzY08cEDq6AeRjSKFZX+A9Y1A28xMMdobI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0KMKLpyYA9iN6zduEoj9+eSx1QCfjbm1uVPSaAvO8MnwdBvLyZ7CQ+dhzzQNi3cOT6nRXeC7n/1gqOHX/1kPDRMtN590PoahF7/eo4hd1KOH7JRGA+oZtjuPbFCvBr6v7DMexvK7gCWbileVobyVKaP8L/LHP0nFGwLoXpSzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jGiLYVk0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=btW7kQnjDmUmvNE23NH4vh6GdFNyilpMQ7GM8BLzUxo=; b=jGiLYVk075whzTFEz9PjZ7Cig8
	Dvb2S2yw90zt5tTY3q69uUjfk13fVEeAeZy1pXgZMT6w+Q5JMTI1zPmBfjTg/XaofApLcyBbQWSA8
	BVET1D7c4X+8z5pg3MGJFvycQpgEsTHkjWmAxVURxIEiLuE61OO/mGHw5mB83tIXQq6zVNLxQzY6O
	108aP6tkrjQnM3o9HBiEWi/+76kphM7w1dxx2b2m/lyNq2iOY5/+tcIoZ4A7OORJ4iNEQVsGWuQgh
	XmlRUNi1ntn7Rp02pLQ7n1w0SR257tR1VSpJeo9oZQwwutFSlXs7ZEetTdicVH7o0BYiSTmq15WmM
	fdUEKH7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1roqOb-00GXMi-0K;
	Mon, 25 Mar 2024 19:54:13 +0000
Date: Mon, 25 Mar 2024 19:54:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Christian Brauner <christian@brauner.io>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240325195413.GW538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <CAH2r5muL4NEwLxq_qnPOCTHunLB_vmDA-1jJ152POwBv+aTcXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muL4NEwLxq_qnPOCTHunLB_vmDA-1jJ152POwBv+aTcXg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 25, 2024 at 11:26:59AM -0500, Steve French wrote:

> A loosely related question.  Do I need to change cifs.ko to return the
> pointer to inode on mknod now?  dentry->inode is NULL in the case of mknod
> from cifs.ko (and presumably some other fs as Al noted), unlike mkdir and
> create where it is filled in.   Is there a perf advantage in filling in the
> dentry->inode in the mknod path in the fs or better to leave it as is?  Is
> there a good example to borrow from on this?

AFAICS, that case in in CIFS is the only instance of ->mknod() that does this
"skip lookups, just unhash and return 0" at the moment.

What's more, it really had been broken all along for one important case -
AF_UNIX bind(2) with address (== socket pathname) being on the filesystem
in question.

Options:
	1) make vfs_mknod() callers aware of the possibility, have the ones
that care do lookup in case when return value is 0 and dentry is unhashed.
That's similar to what we do for vfs_mkdir().  No changes needed for CIFS
or fs/namei.c (i.e. do_mknodat()), unix_bind() definitely needs a change,
ecryptfs can stay as-is, overlayfs just needs to stop complaining when it sees
that situation, nfsd might or might not need a change - hadn't checked yet.
In that case we document ->mknod() as "may unhash and return 0 if it wants
to save a lookup".
	2) make vfs_mknod() check for that case and have it call ->lookup()
if it sees that.  I don't see any benefits to that, TBH - no performance
benefits anywhere and no real simplification for ->mknod() instances.  It
does avoid the need to change anything in CIFS, though.
	3) require ->mknod() instances to make dentry positive on success.
CIFS needs a fix, documentation gets updated to explicitly require that.
AFAICS, nothing else would need to be touched, except possibly adding
a warning in vfs_mknod() to catch violation of that rule.

Note that cifs_sfu_make_node() is the only case in CIFS where that happens -
other codepaths (both in cifs_make_node() and in smb2_make_node()) will
instantiate.  How painful would it be for cifs_sfu_make_node()?
AFAICS, you do open/sync_write/close there; would it be hard to do
an eqiuvalent of fstat and set the inode up?  No need to reread the
file contents (as cifs_sfu_type() does), and you do have full path
anyway, so it's less work than for full ->lookup() even if you need
a path-based protocol operations...

Does that thing have an equivalent of fstat() that would return the
metadata of opened file?

