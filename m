Return-Path: <linux-fsdevel+bounces-61873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB1B7CCC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE03C3A1E67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 04:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63A21D3C0;
	Wed, 17 Sep 2025 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ff8TPjj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7933469D;
	Wed, 17 Sep 2025 04:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083702; cv=none; b=Grmus1fA3OMvQr3kvatjn9aLexkLqON1w0Qntp7MYkY0m2qsjfuXDcPWDH6zfuXswGy20D4khZuQrPRW7CfyqMnHZZ9ywMMpm0DA/nHiAifhna/JU8sLfC7h3fq51i13Xndt0UVBgzlTjbgRtZKnAGDBAN2Bayf2f21/QMvWGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083702; c=relaxed/simple;
	bh=AvHU4bUxw4BjJAe+gEMi0eufiih5AXOkuIyv1Fx0hXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqYcfOyJBO9FJ1injR50H5ESOjgJFczuRF4OdP6Z+7rxY4aTxAf+pejdCLOGOL3bN1I0No2CP7RgXKQz3HJTNuy6E96gAMGJD1E8A4Z0MKv57C3rQpNwJlBrwX+FdBP9q0XzvbFGHAKqj6F7weVjoQy5MbBf/ir7TefjYr7OYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ff8TPjj8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f7QG6sZWaUOx85uTqGPin9zOoX1QBOBLhnbtZesbzXU=; b=ff8TPjj8EnAiQ7OJsJI9GncISw
	Lqdn+9zncRQpm+7GuITmQdwKExMwk10gIqoJdVXxwMbPjavBoPTVXpxDEeR5DOkRZsZiNpDjrS5P8
	NzS+jn7ZZZYoHet/ML+p+m7/jlv6w0bJ2qr+dKccPDLULgieFJv/BHlApysggpDr2102lRSWJczJC
	YAhF9LWs2P80auaSspMZEEk/6psLFsvOR8SJkH4SNlWDtGnGUDHRq3rfKGlQjK17n6OcPqmDE76GN
	3wXozbKD5CZRs7X0fOi8/ve07ak4U3xBUbgVTi6uo7BpJFooIAj+RlyRW7XzWniGPqeTOqTMoU+zC
	pJLQWPCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyjsg-00000008lJe-3AAZ;
	Wed, 17 Sep 2025 04:34:58 +0000
Date: Wed, 17 Sep 2025 05:34:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS: change ->atomic_open() calling to always have exclusive
 access
Message-ID: <20250917043458.GT39973@ZenIV>
References: <20250915031134.2671907-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915031134.2671907-1-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 15, 2025 at 01:01:06PM +1000, NeilBrown wrote:
> ->atomic_open() is called with only a shared lock on the directory when
> O_CREAT wasn't requested.  If the dentry is negative it is still called
> because the filesystem might want to revalidate-and-open in an atomic
> operations.  NFS does this to fullfil close-to-open consistency
> requirements.
> 
> NFS has complex code to drop the dentry and reallocate with
> d_alloc_parallel() in this case to ensure that only one lookup/open
> happens at a time.  It would be simpler to have NFS return zero from
> ->d_revalidate in this case so that d_alloc_parallel() will be calling
> in lookup_open() and NFS wan't need to worry about concurrency.
> 
> So this series makes that change to NFS to simplify atomic_open and remove
> the d_drop() and d_alloc_parallel(), and then changes lookup_open() so that
> atomic_open() can never be called without exclusive access to the dentry.

What will happen if you have a stale negative dentry of /mnt/foo/bar, with
/mnt/foo not writable to you (e.g. because /mnt is read-only mount) and
foo/bar having actually been created by another client since your old lookup
had happened?  What's more, assume that this file is owned by you and has 0660
for mode.

Calling open("/mnt/foo/bar", O_CREAT|O_RDWR, 0666) should succeed - the file
in question exists, so O_CREAT and the third argument of open(2) should be
ignored.

What happens is that we get ->d_revalidate() still with effects of O_CREAT
(i.e. LOOKUP_CREATE|LOOKUP_OPEN), but ->atomic_open() does *not* get O_CREAT.

Your series is broken in that case, AFAICS.

