Return-Path: <linux-fsdevel+bounces-57824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF1B25969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 04:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42553BF97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 02:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1623D7FD;
	Thu, 14 Aug 2025 02:07:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BC42AB0;
	Thu, 14 Aug 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755137277; cv=none; b=tjRZ5u3My9PX7mkJBwI/0hyoUwfUY/OYNsyP96O2V/q5Eu05jB+KdgvNeLf78VPESDY36l7UvBFrRFfoHAheHFFoqoVS7YFVXEuAEPC+uHA5Nbj/iiZ/lgQRhU4R5sI7kYiTPdqZhtB+0vYGC5jEz25WP7wNwD5Ol2Edmq28UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755137277; c=relaxed/simple;
	bh=yrd/h+u4Kfr/C4JJ0SqjKhKAruC7MI/kP+cjkOteg9o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QfQycAQWxKJm1FeyIbFImiaG3EPRwitcqzNfeP+BCCJcfQybPoXnft12OAW8JhaAQfUPJrv+5D8VWmdThC+bbfHeFtEEjCn/a8bxXHmsBCsZsG2hAKxJDLA0Xc14uKWkRbmXH/lHlzmUqji35kLxgUkjfSqs286TwafbJ4SYx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umNNV-005hKm-MP;
	Thu, 14 Aug 2025 02:07:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 11/11] VFS: introduce d_alloc_noblock() and d_alloc_locked()
In-reply-to: <20250813065333.GG222315@ZenIV>
References: <>, <20250813065333.GG222315@ZenIV>
Date: Thu, 14 Aug 2025 12:07:42 +1000
Message-id: <175513726277.2234665.5395852687971371437@noble.neil.brown.name>

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:14PM +1000, NeilBrown wrote:
> > Several filesystems use the results of readdir to prime the dcache.
> > These filesystems use d_alloc_parallel() which can block if there is a
> > concurrent lookup.  Blocking in that case is pointless as the lookup
> > will add info to the dcache and there is no value in the readdir waiting
> > to see if it should add the info too.
> > 
> > Also these calls to d_alloc_parallel() are made while the parent
> > directory is locked.  A proposed change to locking will lock the parent
> > later, after d_alloc_parallel().  This means it won't be safe to wait in
> > d_alloc_parallel() while holding the directory lock.
> > 
> > So this patch introduces d_alloc_noblock() which doesn't block
> > but instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
> > dcache now use that and ignore -EWOULDBLOCK errors as harmless.
> > 
> > A few filesystems need more than -EWOULDBLOCK - they need to be able to
> > create the missing dentry within the readdir.  procfs is a good example
> > as the inode number is not known until the lookup completes, so readdir
> > must perform a full lookup.
> > 
> > For these filesystems d_alloc_locked() is provided.  It will return a
> > dentry which is already d_in_lookup() but will also lock it against
> > concurrent lookup.  The filesystem's ->lookup function must co-operate
> > by calling lock_lookup() before proceeding with the lookup.  This way we
> > can ensure exclusion between a lookup performed in ->iterate_shared and
> > a lookup performed in ->lookup.  Currently this exclusion is provided by
> > waiting in d_wait_lookup().  The proposed changed to dir locking will
> > mean that calling d_wait_lookup() (in readdir) while already holding
> > i_rwsem could deadlock.
> 
> The last one is playing fast and loose with one assertion that is used
> in quite a few places in correctness proofs - that the only thing other
> threads do to in-lookup dentries is waiting on them (and that - only
> in d_wait_lookup()).  I can't tell whether it will be a problem without
> seeing what you do in the users of that thing, but that creates an
> unpleasant areas to watch out for in the future ;-/

Yeah, it's not my favourite part of the series.

> 
> Which filesystems are those, aside of procfs?
> 

afs in afs_lookup_atsys().  While looking up a name that ends "@sys" it
need to look up the prefix with various alternate suffixes appended.
So this isn't readdir related, but is a lookup-within-a-lookup.

The use of d_add_ci() in xfs is the same basic pattern.

overlayfs does something in ovl_lookup_real_one() that I don't
understand yet but it seems to need a lookup while the directory is
locked. 

ovl_cache_update is in the ovl iterate_shared code (which in fact holds
an exclusive lock).  I think this is the same pattern as procfs in that
an inode number needs to be allocated at lookup time, but there might be
more too it.

So it is:
  procfs and overlayfs for lookup in readdir
  xfs and afs for nested lookup.

The only other approach I could come up with was to arrange some sort of
proxy-execution. i.e. instead of d_alloc_locked() provide a
  d_alloc_proxy()
which, if it found a d_in_lookup() dentry, would perform the ->lookup
itself with some sort of interlock with lookup_slow etc.
That would prevent the DCACHE_PAR_LOOKUP dentry leaking out, but would
be more intrusive and would affect the lookup path for filesystems which
didn't need it.

NeilBrown

