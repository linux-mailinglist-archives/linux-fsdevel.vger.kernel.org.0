Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C46FD395
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 05:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKOENK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 23:13:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52560 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKOENJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:13:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVSyR-0003gD-Cf; Fri, 15 Nov 2019 04:12:43 +0000
Date:   Fri, 15 Nov 2019 04:12:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     yu kuai <yukuai3@huawei.com>, rafael@kernel.org,
        rostedt@goodmis.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115041243.GN26530@ZenIV.linux.org.uk>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115032759.GA795729@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:27:59AM +0800, Greg KH wrote:
> On Fri, Nov 15, 2019 at 11:27:50AM +0800, yu kuai wrote:
> > 'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
> > confused about two different dentry take the 'd_lock'.
> > 
> > However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> > two dentry are involed. So, and in 'DENTRY_D_LOCK_NESTED_2'
> > 
> > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > ---
> >  include/linux/dcache.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> > index 10090f1..8eb84ef 100644
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -129,7 +129,8 @@ struct dentry {
> >  enum dentry_d_lock_class
> >  {
> >  	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
> > -	DENTRY_D_LOCK_NESTED
> > +	DENTRY_D_LOCK_NESTED,
> > +	DENTRY_D_LOCK_NESTED_2
> 
> You should document this, as "_2" does not make much sense to anyone
> only looking at the code :(
> 
> Or rename it better.

FWIW, I'm not sure it's a good solution.  What are the rules for callers
of that thing, anyway?  If it can be called when somebody is creating
more files in that subtree, we almost certainly will have massive
problems with the lifetimes of underlying objects...

Could somebody familiar with debugfs explain how is that thing actually
used and what is required from/promised to its callers?  I can try and
grep through the tree and guess what the rules are, but I've way too
much on my platter right now and I don't want to get sidetracked into yet
another tree-wide search and analysis session ;-/
