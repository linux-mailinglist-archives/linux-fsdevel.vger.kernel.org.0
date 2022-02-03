Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61704A7FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 08:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiBCHKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 02:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbiBCHKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:10:41 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB3C061714;
        Wed,  2 Feb 2022 23:10:40 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFWGK-006jyM-Rx; Thu, 03 Feb 2022 07:10:36 +0000
Date:   Thu, 3 Feb 2022 07:10:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeremy Allison <jra@samba.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [ksmbd] racy uses of ->d_parent and ->d_name
Message-ID: <Yft/7MsrovAOaApi@zeniv-ca.linux.org.uk>
References: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk>
 <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
 <YftT5X0s6s5b8DiL@zeniv-ca.linux.org.uk>
 <YftaNrtziHd88b1j@jeremy-acer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YftaNrtziHd88b1j@jeremy-acer>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:29:42PM -0800, Jeremy Allison wrote:
> On Thu, Feb 03, 2022 at 04:02:45AM +0000, Al Viro wrote:
> > On Thu, Feb 03, 2022 at 08:16:21AM +0900, Namjae Jeon wrote:
> > 
> > > > 	Why is so much tied to "open, then figure out where it is" model?
> > > > Is it a legacy of userland implementation, or a network fs protocol that
> > > > manages to outsuck NFS, or...?
> > > It need to use absolute based path given from request.
> > 
> > Er... yes?  Normal syscalls also have to be able to deal with pathnames;
> > the sane way for e.g. unlink() is to traverse everything except the last
> > component, then do inode_lock() on the directory you've arrived at, do
> > lookup for the final component and do the operation.
> > 
> > What we do not attempt is "walk the entire path, then try to lock the
> > parent of whatever we'd arrived at, then do operation".  Otherwise
> > we'd have the same kind of headache in all directory-manipulating
> > syscalls...
> > 
> > What's the problem with doing the same thing here?  Lack of convenient
> > exported helpers for some of those?  Then let's sort _that_ out...
> > If there's something else, I'd like to know what exactly it is.
> 
> Samba recently did a complete VFS rewrite to remove almost
> *all* pathname-based calls for exactly this reason (remove
> all possibility of symlink races).
> 
> https://www.samba.org/samba/security/CVE-2021-20316.html
> 
> Is this essentially the same bug affecting ksmbd here ?

It's not about symlinks; it's about rename racing with pathname
resolution and tearing the object you've looked up away from the
directory you are preparing to modify.

ksmbd does pathwalk + attempt to lock the parent + check if we
had been moved away while we'd been grabbing the lock.  It *can*
be made to work, but it's bloody painful - you need to grab
a reference to parent (take a look at the games dget_parent()
has to do, and that one has a luxury of not needing to grab a blocking
lock), *then* you need to lock it, check that our object is still
its child (child->d_parent might change, but its comparison with
dentry of locked directory is stable), then check that child is
still hashed and either proceed with the operation, or unlock
the directory you'd locked, drop the reference to it and repeat
the entire dance starting at dget_parent().

It's doable, but really unpleasant.  A much simpler approach is
to find the parent as we are looking for child, lock it and
then look for child in an already locked directory.  Which
guarantees the stability of name and parent of whatever you
find there, for as long as directory remains locked.  None of
such retry loops are needed (and dget_parent() *is* that
internally), no need to bother about unexpected errors, etc.
