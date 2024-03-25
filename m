Return-Path: <linux-fsdevel+bounces-15255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CA88B5D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9104C6188F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309326F08A;
	Mon, 25 Mar 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lSEECYU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EA6EB67;
	Mon, 25 Mar 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399579; cv=none; b=LydA+DRq5WlgtiARx1KixhFL4/T8JqvveQsoRTQ0tTC+uVRfRkmL0H01A6IcyNXsiexuGwImKCPOCI4gNcmguXdj+ItZsl2339QsJYZt8C+ngXr5qS749BwH1d5mfLziiErf9rM7dy7NaESMm0iPu5uXQ7LVHGBn3OD8j97iIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399579; c=relaxed/simple;
	bh=Wv7VhIdeUJHPXBsBYbD7ljp3ZdS46aqAD9sFXeifFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/ouA6HwpM8qbHxxzIaPzNosoUWJd6V+TjmRtCfZQhwhcLFBWkNsdXsJ4i5GhlS8YwSmsxDZKlSQrUMJjHHERjHFS0Vh+Lm96Yqb2BNKFB2uGz73jv+FhTMP2+zVb5C8noTX28FPccjhJgMcN/QJaTP+Rai5cl2Dv+UmFmPRG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lSEECYU3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JnI6XuHiHhiKwlcQJZJOfCWTvngxEvdDS+1Es7Phmhw=; b=lSEECYU3VyvlwAFJYt0OtziTzj
	dCNMTREbLqOswCvNJADcu0ds0hYDV6QHjRqkt8DCRPFUyAeCoBWXxhnq0pXYUmI7ibDbWBVr2Sybk
	zSdzUNF+cWsAVljrHPQ8VzGEV6acRRROh4/RdXJoPPB+77whcUms8cnXV5FwrnVErhq7lcZnilYGH
	yKswlE+2KoEc78bE8/s0DPOcbm2memmkMQhi2pfQE9PHV7UZP2SlJ5Uvmbu74Si/BCT+FZEMjbMCW
	hAVqEdev4sCNuEl7Rqd5Cu7sWNQ4/MWYE5CTGUSK466bVih5DzgCbZgYTgisC//9dcVCSAowLzZTP
	xvDN6PjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rorCp-00GZcD-2W;
	Mon, 25 Mar 2024 20:46:08 +0000
Date: Mon, 25 Mar 2024 20:46:07 +0000
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
Message-ID: <20240325204607.GX538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <CAH2r5muL4NEwLxq_qnPOCTHunLB_vmDA-1jJ152POwBv+aTcXg@mail.gmail.com>
 <20240325195413.GW538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325195413.GW538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 25, 2024 at 07:54:13PM +0000, Al Viro wrote:

> Note that cifs_sfu_make_node() is the only case in CIFS where that happens -
> other codepaths (both in cifs_make_node() and in smb2_make_node()) will
> instantiate.  How painful would it be for cifs_sfu_make_node()?
> AFAICS, you do open/sync_write/close there; would it be hard to do
> an eqiuvalent of fstat and set the inode up?  No need to reread the
> file contents (as cifs_sfu_type() does), and you do have full path
> anyway, so it's less work than for full ->lookup() even if you need
> a path-based protocol operations...
> 
> Does that thing have an equivalent of fstat() that would return the
> metadata of opened file?

You do have a FID there, so doing ->query_file_info() just before close,
using the result to build inode (with type and ->i_rdev taken from what
you've been given by the caller) and passing it to d_instantiate() looks
not entirely implausible, but I'm really not familiar with the codebase,
so take that with a cartload of salt.

mknod() usually is followed by lookup of some sort pretty soon, and your
lookup would have to do at least open/sync_read/close just to decode the
device number.  So if anything, *not* setting an inode up during mknod()
is likely to be a pessimization...

If we did it in vfs_mknod() callers, that would be something along the
lines of
	err = vfs_mknod(..., dir, dentry, ...)
	if (err)
		fuck off
	if (unlikely(!dentry->d_inode)) {
		if (d_unhashed(dentry)) {
			struct dentry *d = dir->i_op->lookup(dir, dentry, 0);
			if (unlikely(d)) {
				if (IS_ERR(d)) {
					fuck off, lookup failed
				} else {
					// ->lookup returns a pointer to existing
					// alias *ONLY* for directories; WTF is
					// going on?
					dput(d);
					fuck off, wrong thing created there
				}
			}
			if (!dentry->d_inode)
				fuck off, it hasn't been created
			if (wrong type of dentry->d_inode))
				fuck off, wrong thing created there
			OK, there we go
		} else {
			complain about bogus ->mknod() behavior
			fuck off - it hasn't been created, apparently
		}
	}
at least in net/unix/af_unix.c:unix_bind().  So the minimal change
would be to have your d_drop(dentry) in that codepath followed by
cifs_lookup(<parent inode>, dentry, 0) and checking the result.

But I would very much suspect that fetching metadata by fid before
you close the file would be cheaper than full-blown cifs_lookup()
there.

