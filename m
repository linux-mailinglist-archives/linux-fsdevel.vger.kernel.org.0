Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E03A4C1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 03:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFLB0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 21:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhFLB0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:26:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05548C061574;
        Fri, 11 Jun 2021 18:24:22 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrsNb-0079kf-2D; Sat, 12 Jun 2021 01:24:07 +0000
Date:   Sat, 12 Jun 2021 01:24:07 +0000
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
Subject: Re: [PATCH v6 4/7] kernfs: switch kernfs to use an rwsem
Message-ID: <YMQMtwa/hv4Rmwba@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322865230.361452.5882168567975703664.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162322865230.361452.5882168567975703664.stgit@web.messagingengine.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 04:50:52PM +0800, Ian Kent wrote:
> The kernfs global lock restricts the ability to perform kernfs node
> lookup operations in parallel during path walks.
> 
> Change the kernfs mutex to an rwsem so that, when opportunity arises,
> node searches can be done in parallel with path walk lookups.

> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
> index 5432883d819f2..c8f8e41b84110 100644
> --- a/fs/kernfs/symlink.c
> +++ b/fs/kernfs/symlink.c
> @@ -116,9 +116,9 @@ static int kernfs_getlink(struct inode *inode, char *path)
>  	struct kernfs_node *target = kn->symlink.target_kn;
>  	int error;
>  
> -	mutex_lock(&kernfs_mutex);
> +	down_read(&kernfs_rwsem);
>  	error = kernfs_get_target_path(parent, target, path);
> -	mutex_unlock(&kernfs_mutex);
> +	up_read(&kernfs_rwsem);

Unrelated to this patchset, two notes from reading through that area:
	1) parent is fetched outside of rwsem.  Unstable, IOW.
	2) kernfs_get_target_path() is an atrocity.  On *any* symlink you
get an arseload of ../ (up to kernfs root), followed by into whatever
directory we want.  Even if the target is in the same directory.
Think what happens if you mount --bind a subtree that contains both the
symlink and its destination.  And try to follow that symlink.
	It really ought to generate the minimal relative pathname.
And it's not hard to do:
	calculate the depth of source
	calculate the depth of destination
	walk up from the deeper one until we get to the depth of the
shallower one.
	walk up from both in tandem until two paths converge.
Now we have the LCA of those nodes and can use the to generate the relative
pathname.

