Return-Path: <linux-fsdevel+bounces-61678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817AB58CF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D10522284
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61B23C4ED;
	Tue, 16 Sep 2025 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ox9L+D4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D322615;
	Tue, 16 Sep 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998017; cv=none; b=S/vs6ZCPFwQ5W6dgFqa14Z7r27+i56ASBXyrxVk7C2+HAy0NhKvBOzVHbGFTtw2XBOfoNWGU8L5kxT/re7lY2H8fwuBvBCUx0twRgfIwsxnDfOza0m1f6+1cEl+aTfegGQdvTOlxwF0UonZEeKdVm8egI8/0yL9/quQxsXPorXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998017; c=relaxed/simple;
	bh=T74ZzuPspDPqp5WudzeQCOjSlkg1JjJh0e7aM3Wogno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXaHBUyPO6MOvO7M+z+bo4SVO0HuoSRxkzXszbxxpyBeQFampwpJRWN7mPkgI8IH4Cxpg8RBbrkE/t2kN5mSWtTz862/pMWIta5XhNe4MfNAlmwgKSYY6OEfxyydck92wAXHQ0xU1IOp0BhwBuPlXbj0oRzgTd2Liiu7FeEKRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ox9L+D4w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zJKM8U9wCy2x6jEU9/NwYukpZ0MPjWkRmBpCq2d6jwc=; b=ox9L+D4w9ZzxQiIuAXM1mi0jo+
	cpo4X3XUrxcCVbbybOIMHXV++lLyHSkYuzY6zrldFhpIHKroHTcHqn+4uvsO06MzSd09Wstynu3QI
	ZLQTHvrztPXmZFd83ZDOOF+LklOXW4vKqmznuGXnDbkulwFPDcv2Q/ZK8BWICbufTK+Mg757vA379
	/Kmkpw8+xQpAdRQDBQFf/jJEFIYBax9bhbP0ap9qjvNqCkvepSipkM7ff8o4c1AtcWvSgL4gP4V2y
	M67uWR7GeK/WKuFr080DEOMuzrLCr5jStN+1NJ+K8kwcB1rIV7Vh2TA1rAq6J1GmZeBmzOjBYVyOw
	G24wV40Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyNaa-00000006Sju-3JxF;
	Tue, 16 Sep 2025 04:46:48 +0000
Date: Tue, 16 Sep 2025 05:46:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250916044648.GP39973@ZenIV>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
 <20250916035633.GM39973@ZenIV>
 <20250916035949.GO39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916035949.GO39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 16, 2025 at 04:59:49AM +0100, Al Viro wrote:
> On Tue, Sep 16, 2025 at 04:56:33AM +0100, Al Viro wrote:
> > 	if (!RB_EMPTY_NODE(to_ns_common(ns)->ns_tree_node))
> 
>  	if (!RB_EMPTY_NODE(&to_ns_common(ns)->ns_tree_node))
> 
> obviously...

FWIW, how about the following - I put the commit below into never-rebased
branch, pull it into #work.mount and you do the same to your branch
just prior to 18/33?  The difference from one in #work.mount is that
this variant checks RB_EMPTY_NODE(&ns->mnt_ns_tree_node) instead of
list_empty(&ns->mnt_ns_list).  The reasons why it's safe lockless are
pretty much the same...

Objections?  Does vfs/vfs.git #no-rebases-mnt_ns_tree_remove look sane
for you?

mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list
    
Actual removal is done under the lock, but for checking if need to bother
the lockless RB_EMPTY_NODE() is safe - either that namespace had never
been added to mnt_ns_tree, in which case the the node will stay empty, or
whoever had allocated it has called mnt_ns_tree_add() and it has already
run to completion.  After that point RB_EMPTY_NODE() will become false and
will remain false, no matter what we do with other nodes in the tree.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index ae6d1312b184..39afeb521a80 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -187,7 +187,7 @@ static void mnt_ns_release_rcu(struct rcu_head *rcu)
 static void mnt_ns_tree_remove(struct mnt_namespace *ns)
 {
 	/* remove from global mount namespace list */
-	if (!is_anon_ns(ns)) {
+	if (!RB_EMPTY_NODE(&ns->mnt_ns_tree_node)) {
 		mnt_ns_tree_write_lock();
 		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
 		list_bidir_del_rcu(&ns->mnt_ns_list);

