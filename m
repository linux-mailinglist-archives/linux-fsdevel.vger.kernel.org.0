Return-Path: <linux-fsdevel+bounces-24638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60294220B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906C51C22D8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867D18E02E;
	Tue, 30 Jul 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AfLb+6tR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33138B;
	Tue, 30 Jul 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373949; cv=none; b=uShFL92EgWbcegcriStpk1ONhaJglcqXLT67JBjnIGdAvexbThlbyTnOJGlO5Ms8JbLRhVNHqVshlgh9x441xGHOuq6njhUGpGGKB6x9vy8ZFgYHeVUiRhzrv+rZS4H9tJYpQ8bSx0MCGDPz8sf8NA7fZcBlpWpwL/Bigr2KESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373949; c=relaxed/simple;
	bh=cEk83l4mWONqpD4v1BQ3vkO7xHMQ560brpMG+0bHCOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPFVsu2wVAQVkfdZJ2uI1amAOeN8dnQuwDZPBfEEU5YJ44kOPJkGnYWvmPgoPWT/W9R8dDOC0AJoiC3oev+RiFg4zfmLnJgME54uv2ab7hSfXzsCJnHshSMBu2wwkTR5oN+daM5c4rJ7+IC8f2BDRQq1akVIuTBn+M/dVBLTKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AfLb+6tR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=juLNTGfDHj50atuMhk7dbWzwjGHWgRDm70U6RaLXPeI=; b=AfLb+6tRV/VaQlwK13wMXFAbnO
	vU63GJMLfBvuV5wJiW28+O+73IOccKalEjRgaSVawG/Z1x5KYwtMw9cis8PulfGTR5zJTk4+dwweP
	82HSUu5kEr3nipS5EwFKI3MjT7E6np3n0g4MXRjQw4iD6Z2XXPXtJLKcae/NR9QXRN+kc4sWcQWA0
	MIowMYuz1WqKP3J640l9+NLShXeP2fNoioj6rs1pow6c8sd7BR+oBCQaQmeYwIbcl8CWDeykeSC0h
	wtO4zqR7tY46hCgdf2bom5NnVZAPfBcjnuOUgCLe4m4lx4cN3eNRirNgjYbX+wU9ydJEGss3NETCV
	cbcOMWMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYu8v-00000000KBN-2OVT;
	Tue, 30 Jul 2024 21:12:25 +0000
Date: Tue, 30 Jul 2024 22:12:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Josef Bacik <josef@toxicpanda.com>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 08/39] experimental: convert fs/overlayfs/file.c to
 CLASS(...)
Message-ID: <20240730211225.GH5334@ZenIV>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-8-viro@kernel.org>
 <20240730191025.GB3830393@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730191025.GB3830393@perftesting>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 30, 2024 at 03:10:25PM -0400, Josef Bacik wrote:
> On Tue, Jul 30, 2024 at 01:15:54AM -0400, viro@kernel.org wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > There are four places where we end up adding an extra scope
> > covering just the range from constructor to destructor;
> > not sure if that's the best way to handle that.
> > 
> > The functions in question are ovl_write_iter(), ovl_splice_write(),
> > ovl_fadvise() and ovl_copyfile().
> > 
> > This is very likely *NOT* the final form of that thing - it
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > needs to be discussed.

> Is this what we want to do from a code cleanliness standpoint?  This feels
> pretty ugly to me, I feal like it would be better to have something like
> 
> scoped_class(fd_real, real) {
> 	// code
> }
> 
> rather than the {} at the same indent level as the underlying block.
> 
> I don't feel super strongly about this, but I do feel like we need to either
> explicitly say "this is the way/an acceptable way to do this" from a code
> formatting standpoint, or we need to come up with a cleaner way of representing
> the scoped area.

That's a bit painful in these cases - sure, we can do something like
	scoped_class(fd_real, real)(file) {
		if (fd_empty(fd_real)) {
			ret = fd_error(real);
			break;
		}
		old_cred = ovl_override_creds(file_inode(file)->i_sb);
		ret = vfs_fallocate(fd_file(real), mode, offset, len);
		revert_creds(old_cred);

		/* Update size */
		ovl_file_modified(file);  
	}
but that use of break would need to be documented.  And IMO anything like
        scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
			   &task->signal->cred_guard_mutex) {
is just distasteful ;-/  Control flow should _not_ be hidden that way;
it's hard on casual reader.

The variant I'd put in there is obviously not suitable for merge - we need
something else, the question is what that something should be...

