Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A263A4C25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 03:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFLBsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 21:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhFLBsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:48:03 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFBAC061574;
        Fri, 11 Jun 2021 18:46:04 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrsic-007A4F-9m; Sat, 12 Jun 2021 01:45:50 +0000
Date:   Sat, 12 Jun 2021 01:45:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/7] kernfs: use i_lock to protect concurrent inode
 updates
Message-ID: <YMQRzl4guvQQJwG0@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 04:51:22PM +0800, Ian Kent wrote:
> The inode operations .permission() and .getattr() use the kernfs node
> write lock but all that's needed is to keep the rb tree stable while
> updating the inode attributes as well as protecting the update itself
> against concurrent changes.

Huh?  Where does it access the rbtree at all?  Confused...

> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 3b01e9e61f14e..6728ecd81eb37 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
>  {
>  	struct kernfs_iattrs *attrs = kn->iattr;
>  
> +	spin_lock(&inode->i_lock);
>  	inode->i_mode = kn->mode;
>  	if (attrs)
>  		/*
> @@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
>  
>  	if (kernfs_type(kn) == KERNFS_DIR)
>  		set_nlink(inode, kn->dir.subdirs + 2);
> +	spin_unlock(&inode->i_lock);
>  }

Even more so - just what are you serializing here?  That code synchronizes inode
metadata with those in kernfs_node.  Suppose you've got two threads doing
->permission(); the first one gets through kernfs_refresh_inode() and goes into
generic_permission().  No locks are held, so kernfs_refresh_inode() from another
thread can run in parallel with generic_permission().

If that's not a problem, why two kernfs_refresh_inode() done in parallel would
be a problem?

Thread 1:
	permission
		done refresh, all locks released now
Thread 2:
	change metadata in kernfs_node
Thread 2:
	permission
		goes into refresh, copying metadata into inode
Thread 1:
		generic_permission()
No locks in common between the last two operations, so
we generic_permission() might see partially updated metadata.
Either we don't give a fuck (in which case I don't understand
what purpose does that ->i_lock serve) *or* we need the exclusion
to cover a wider area.
