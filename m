Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5681FFD6D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 08:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfKOHUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 02:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfKOHUS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:20:18 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4825E2072D;
        Fri, 15 Nov 2019 07:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573802417;
        bh=iQd1pqyrReTRVECeogRn/0pT26bazl5tIx24X6aOZNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6JY7aPlxEKt5qe5AdRh2FPCIAFpALC2/VQZYcjtLtq8ZvVupQIpw2hg0GKpYyrEg
         fxYB4dyC3QuTRzubZTwJIZ+Ley/8OLhOP2UvMpS+BGAI50lUAmrxkKgP64EI09EQQH
         g0YRHDJDzeWDCW2ctxH3tXOV5bOPEoSpBFvNoLWg=
Date:   Fri, 15 Nov 2019 15:20:11 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     yu kuai <yukuai3@huawei.com>, rafael@kernel.org,
        rostedt@goodmis.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115072011.GA1203354@kroah.com>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
 <20191115041243.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115041243.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 04:12:43AM +0000, Al Viro wrote:
> On Fri, Nov 15, 2019 at 11:27:59AM +0800, Greg KH wrote:
> > On Fri, Nov 15, 2019 at 11:27:50AM +0800, yu kuai wrote:
> > > 'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
> > > confused about two different dentry take the 'd_lock'.
> > > 
> > > However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> > > two dentry are involed. So, and in 'DENTRY_D_LOCK_NESTED_2'
> > > 
> > > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > > ---
> > >  include/linux/dcache.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> > > index 10090f1..8eb84ef 100644
> > > --- a/include/linux/dcache.h
> > > +++ b/include/linux/dcache.h
> > > @@ -129,7 +129,8 @@ struct dentry {
> > >  enum dentry_d_lock_class
> > >  {
> > >  	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
> > > -	DENTRY_D_LOCK_NESTED
> > > +	DENTRY_D_LOCK_NESTED,
> > > +	DENTRY_D_LOCK_NESTED_2
> > 
> > You should document this, as "_2" does not make much sense to anyone
> > only looking at the code :(
> > 
> > Or rename it better.
> 
> FWIW, I'm not sure it's a good solution.  What are the rules for callers
> of that thing, anyway?  If it can be called when somebody is creating
> more files in that subtree, we almost certainly will have massive
> problems with the lifetimes of underlying objects...
> 
> Could somebody familiar with debugfs explain how is that thing actually
> used and what is required from/promised to its callers?  I can try and
> grep through the tree and guess what the rules are, but I've way too
> much on my platter right now and I don't want to get sidetracked into yet
> another tree-wide search and analysis session ;-/

Yu wants to use simple_empty() in debugfs_remove_recursive() instead of
manually checking:
	if (!list_empty(&child->d_subdirs)) {

See patch 3 of this series for that change and why they feel it is
needed:
	https://lore.kernel.org/lkml/1573788472-87426-4-git-send-email-yukuai3@huawei.com/

As to if patch 3 really is needed, I'll leave that up to Yu given that I
thought we had resolved these types of issues already a year or so ago.

thanks,

greg k-h
