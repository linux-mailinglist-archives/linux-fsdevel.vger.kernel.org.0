Return-Path: <linux-fsdevel+bounces-57647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B20B241F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A484A4E1896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA42D6418;
	Wed, 13 Aug 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wiz2DxV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E21FDE39;
	Wed, 13 Aug 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068026; cv=none; b=SzYWYpUOfcDt8FrOOUo1O8pbXkIqqvcSIOCs4wT28uE86gYttXDuH1rV5BHOUjJqx8ZOBfRabUZNlxyf2O20196zg4X6KsjPXJNz8Loe0drGxELdXx7KgvhzUdcO6atGlKRPyYeIBCC8WiCBUeyrdJjsfxSnHeAdPFBnkpro3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068026; c=relaxed/simple;
	bh=rDW+t1UVopUdYO3K7v4ygjbrDYxS9M/67RhudSEQ5QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjpBhfs2Db8EOYAMIUkEiqJO4Sh7MMtqaGXEDbcils0eTIQBc0d4A+UPnXIswJNYeZpA6GuRcGaVuv9yaApZNlrKb3OmlCkhkoRw8v3gyZly+WkcEY0ZJQ6GvkwGZh40cK4ngSw98AJ+7G21duxcJrnu8V0Trfq6q3PFcF6y7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wiz2DxV1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hm2PPtsNJuhxIDGNuJHriEQn1/qO4cQcfmhS7NNUXJg=; b=Wiz2DxV1z9TM0lkmOxo+TJ4Vyd
	qaiPgAgUlzH3xCeLVoqdhjk7kJp8cMmXYoXTwPYofwtXHrSvl9ppyTshskwHpMRPhlYCPhUJMpTsW
	+vVSXhupFsOFNuR4VbYt3owuewFlVzfQcb1JsbZ7Jiusct2xvleX1CdDxxTvJ8BJ1TnX+j6e+Ku7s
	y56pYVKPdxxRHSymM6lmpFG4sirXoAdBByGwJP5wHvqMg3ug2hH7dgBGlDuYBWTuO7R6N29I3aSAW
	+sDrkOErZO7FCVjKQYxCFBUQuHjT2Z9MS7ggd9RMaGQLx4GQeZLgzzsSedW2k5IyAZs9+AnXrvVq1
	8O4crq/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5Mb-00000006n9D-1KiH;
	Wed, 13 Aug 2025 06:53:33 +0000
Date: Wed, 13 Aug 2025 07:53:33 +0100
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
Subject: Re: [PATCH 11/11] VFS: introduce d_alloc_noblock() and
 d_alloc_locked()
Message-ID: <20250813065333.GG222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-12-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-12-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:14PM +1000, NeilBrown wrote:
> Several filesystems use the results of readdir to prime the dcache.
> These filesystems use d_alloc_parallel() which can block if there is a
> concurrent lookup.  Blocking in that case is pointless as the lookup
> will add info to the dcache and there is no value in the readdir waiting
> to see if it should add the info too.
> 
> Also these calls to d_alloc_parallel() are made while the parent
> directory is locked.  A proposed change to locking will lock the parent
> later, after d_alloc_parallel().  This means it won't be safe to wait in
> d_alloc_parallel() while holding the directory lock.
> 
> So this patch introduces d_alloc_noblock() which doesn't block
> but instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
> dcache now use that and ignore -EWOULDBLOCK errors as harmless.
> 
> A few filesystems need more than -EWOULDBLOCK - they need to be able to
> create the missing dentry within the readdir.  procfs is a good example
> as the inode number is not known until the lookup completes, so readdir
> must perform a full lookup.
> 
> For these filesystems d_alloc_locked() is provided.  It will return a
> dentry which is already d_in_lookup() but will also lock it against
> concurrent lookup.  The filesystem's ->lookup function must co-operate
> by calling lock_lookup() before proceeding with the lookup.  This way we
> can ensure exclusion between a lookup performed in ->iterate_shared and
> a lookup performed in ->lookup.  Currently this exclusion is provided by
> waiting in d_wait_lookup().  The proposed changed to dir locking will
> mean that calling d_wait_lookup() (in readdir) while already holding
> i_rwsem could deadlock.

The last one is playing fast and loose with one assertion that is used
in quite a few places in correctness proofs - that the only thing other
threads do to in-lookup dentries is waiting on them (and that - only
in d_wait_lookup()).  I can't tell whether it will be a problem without
seeing what you do in the users of that thing, but that creates an
unpleasant areas to watch out for in the future ;-/

Which filesystems are those, aside of procfs?

