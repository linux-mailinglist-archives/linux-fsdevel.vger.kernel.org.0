Return-Path: <linux-fsdevel+bounces-41279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F57A2D2B2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 02:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D838F188F08C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941F13D89D;
	Sat,  8 Feb 2025 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sMitv0UP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5F125D6;
	Sat,  8 Feb 2025 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978700; cv=none; b=TSL4wTISMJe6bTX+S9foUNZXXVOmvmkQTxvn9QSPODenJUGTMIehHHa9CqEDjjUDtqSVaLv8GXzecwtr1ELDD2zmrQ5nCXP/MpWWxFPPZ9Dbaw/1QfPy4ss/X5akOU4YHUPr8u1qUCXAt6YWC0aPobpQjmPiOWWG5luHFudnfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978700; c=relaxed/simple;
	bh=5RdPuIupXM0o99MlL5MemrPk1dR1f+W6n8xnXlZhTuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8yUI5QanCQRezGSpyphGcyIimzG1w8ZHnUH4PYe4Sdh8WWzYgL0BuZ8it9rIrNNxE+xpKsAoXBi9PCH1DcTYjCjcO5nA5c+nAdd9OBq/BdDcx4xi2Sim48adk45VSrSRprZUEi0chBAPdrMTRw6sU4Vjd7CPWSO9kCc8ghNhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sMitv0UP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yIWDLrMWFND4xkWqnB/7SgqeV6TLYGm3mK/UWXDyZfA=; b=sMitv0UPhRbyo/k1qcD4GbdKyX
	VRKfRLNLDtLIzBSp/sINeG+TIeBfBkwJ21YfGTqfXQALYW4+XY/daMvlP5O7YG/jOR1CQcDLZAnQe
	qS+irID8irgxT4pqIFpfJhP4scBNDZBYIYnUKCKc+ezoyBPZZPMHB554ZoD/IGAYUedXFFbk0Jn4f
	LwKjfpFYNPt0+Q6gPs1w9RyY4jzn4cpDaNoTTkdX7P29A6k2LBBKho/Z0M+Hg6kN/Ve5lPNcC0yV1
	Oo7dhrrHmHli06PKjTrJFc/bVoZ5uXdiATWQ9d3WFAkX5Havyzf+Abp4pOMHMuI32P3rcRNlMBhtk
	XOeGuACA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgZnS-00000006rjQ-37Vd;
	Sat, 08 Feb 2025 01:38:14 +0000
Date: Sat, 8 Feb 2025 01:38:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] VFS: Add ability to exclusively lock a dentry and
 use for create/remove  operations.
Message-ID: <20250208013814.GP1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-12-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-12-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:48PM +1100, NeilBrown wrote:
> d_update_lock(), d_update_trylock(), d_update_unlock() are added which
> can be used to get an exclusive lock on a dentry in preparation for
> updating it.
> 
> As contention on a name is rare this is optimised for the uncontended
> case.  A bit is set under the d_lock spinlock to claim as lock, and
> wait_var_event_spinlock() is used when waiting is needed.  To avoid
> sending a wakeup when not needed we have a second bit flag to indicate
> if there are any waiters.
> 
> This locking is used in lookup_and_lock().
> 
> Once the exclusive "update" lock is obtained on the dentry we must make
> sure it wasn't unlinked or renamed while we slept.  If it was we repeat
> the lookup.
> 
> We also ensure that the parent isn't similarly locked.  This is will be
> used to protect a directory during rmdir.

What's the point re rmdir()?  Just have the victim _always_ locked exclusive,
same as e.g. for ->unlink() or overwriting ->rename().

