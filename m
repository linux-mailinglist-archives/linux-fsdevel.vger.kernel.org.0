Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2BFDEB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKONQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:16:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60406 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:16:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVbSb-0000Kr-Ni; Fri, 15 Nov 2019 13:16:25 +0000
Date:   Fri, 15 Nov 2019 13:16:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     yu kuai <yukuai3@huawei.com>, rafael@kernel.org,
        rostedt@goodmis.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115131625.GO26530@ZenIV.linux.org.uk>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
 <20191115041243.GN26530@ZenIV.linux.org.uk>
 <20191115072011.GA1203354@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115072011.GA1203354@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 03:20:11PM +0800, Greg KH wrote:

> > FWIW, I'm not sure it's a good solution.  What are the rules for callers
> > of that thing, anyway?  If it can be called when somebody is creating
> > more files in that subtree, we almost certainly will have massive
> > problems with the lifetimes of underlying objects...
> > 
> > Could somebody familiar with debugfs explain how is that thing actually
> > used and what is required from/promised to its callers?  I can try and
> > grep through the tree and guess what the rules are, but I've way too
> > much on my platter right now and I don't want to get sidetracked into yet
> > another tree-wide search and analysis session ;-/
> 
> Yu wants to use simple_empty() in debugfs_remove_recursive() instead of
> manually checking:
> 	if (!list_empty(&child->d_subdirs)) {
> 
> See patch 3 of this series for that change and why they feel it is
> needed:
> 	https://lore.kernel.org/lkml/1573788472-87426-4-git-send-email-yukuai3@huawei.com/
> 
> As to if patch 3 really is needed, I'll leave that up to Yu given that I
> thought we had resolved these types of issues already a year or so ago.

What I'm asking is what concurrency warranties does the whole thing
(debugfs_remove_recursive()) have to deal with.  IMO the overall
structure of the walk-and-remove the tree algorithm in there
is Not Nice(tm) and I'd like to understand if it needs to be kept
that way.  And the locking is confused in there - it either locks
too much, or not enough.

So... can debugfs_remove_recursive() rely upon the lack of attempts to create
new entries inside the subtree it's trying to kill?  If it can, the things
can be made simpler; if it can't, it's not locking enough; e.g. results of
simple_empty() on child won't be guaranteed to remain unchanged just as it
returns to caller.

What's more, the uses of simple_unlink()/simple_rmdir() there are not
imitiating the normal locking environment for ->unlink() and ->rmdir() resp. -
the victim's inode is not locked, so just for starters the call of simple_empty()
from simple_rmdir() itself is not guaranteed to give valid result.

I want to understand the overall situation.  No argument, list_empty()
in there is BS, for many reasons.  But I wonder if trying to keep the
current structure of the iterator _and_ the use of simple_rmdir()/simple_unlink()
is the right approach.
