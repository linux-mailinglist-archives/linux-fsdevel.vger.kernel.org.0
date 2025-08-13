Return-Path: <linux-fsdevel+bounces-57626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36980B23F77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418963A67AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6E2BE04F;
	Wed, 13 Aug 2025 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E+YLf8qv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F32505A5;
	Wed, 13 Aug 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058933; cv=none; b=spwVn0VDtFg49Ekn1h3jGFzAqLuKw5XRa3B0jK+KvKNbrmzAP/UJs3vlVaQfxkiQK0HcZ5sA9xkC8mEufmleDOsWzE6Mn1PSe/ASHwh3+FYaE7Jhb3KF2f6lrZbMte1XeEM2p9nH4FTphiFK3+4ELn7sAYd/AnYIXYHn7d6ZFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058933; c=relaxed/simple;
	bh=VMh2BLGphXRvG/FFzhL1PFA92eHn/bxF7Kk0BRTOyHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXTKcPd8bN78a/buuIPfOHGXjPTe1NaE4ndRz8gwfIUXkSZz7d9SauHVJSZxwEKXTjBX8IBv0luzrqEYlQ7OBzCoxraE3mEjbf7SzAgvecgnAavdDKfKeXX+oHTwXz+O0NCzWJdw38KYzuK+T2nfTCYgqqw7wXobu5mmEOYtYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E+YLf8qv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdU/0zwSMH2y0O1TRA9YmJ5Fw0UxuvH5pkvmlwTE5W4=; b=E+YLf8qvXLfxYK0as6o9jTXHlV
	yV1NRjXLvW9S0R51j1f3lLc0CGwYDCeWM7y/ylMOtQm9Jx2ANDc9nb+S+roZZ7ANg1Myuq0go4ZR1
	Z+zJpGFlqLoT3GF0gU1JVh+h459QD9szlEO+8ULWb9wPt5XR9Go9ehuUZEike+kKFfYZxzwA2JovI
	OWx1fqHFlkh6c9KE8pGaNxB7aN0eqFbkARwEvK3rACEuaDUiKtCBGKXNWP90A8UpYtw1tAMjG1b/Y
	HsCWforfyvrltzOcXDT9AapZpUs3yCk6YpcxDcZIYg3osY9wQcz6z4BAkW9+MUEp7h3sUGYpc5Q0L
	Gl0P2Sbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2zy-00000005WTr-37Ng;
	Wed, 13 Aug 2025 04:22:02 +0000
Date: Wed, 13 Aug 2025 05:22:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
Message-ID: <20250813042202.GA222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-5-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-5-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:07PM +1000, NeilBrown wrote:
> A few callers operate on a dentry which they already have - unlike the
> normal case where a lookup proceeds an operation.
> 
> For these callers dentry_lookup_continue() is provided where other
> callers would use dentry_lookup().  The call will fail if, after the
> lock was gained, the child is no longer a child of the given parent.
> 
> There are a couple of callers that want to lock a dentry in whatever
> its current parent is.  For these a NULL parent can be passed, in which
> case ->d_parent is used.  In this case the call cannot fail.
> 
> The idea behind the name is that the actual lookup occurred some time
> ago, and now we are continuing with an operation on the dentry.
> 
> When the operation completes done_dentry_lookup() must be called.  An
> extra reference is taken when the dentry_lookup_continue() call succeeds
> and will be dropped by done_dentry_lookup().
> 
> This will be used in smb/server, ecryptfs, and overlayfs, each of which
> have their own lock_parent() or parent_lock() or similar; and a few
> other places which lock the parent but don't check if the parent is
> still correct (often because rename isn't supported so parent cannot be
> incorrect).

I would really like the see the conversion of these callers.  You are
asking for a buy-in for a primitive with specific semantics; that's
hard to review without seeing how it will be used.

