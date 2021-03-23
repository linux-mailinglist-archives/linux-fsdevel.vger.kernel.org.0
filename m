Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1D345CBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCWLZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 07:25:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhCWLYu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:24:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B42A4AD6D;
        Tue, 23 Mar 2021 11:24:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C42A4DA7AE; Tue, 23 Mar 2021 12:22:44 +0100 (CET)
Date:   Tue, 23 Mar 2021 12:22:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
Message-ID: <20210323112244.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-2-mszeredi@redhat.com>
 <20210322223338.GD22094@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322223338.GD22094@magnolia>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:33:38PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 22, 2021 at 03:48:59PM +0100, Miklos Szeredi wrote:
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -441,6 +441,9 @@ As of kernel 2.6.22, the following members are defined:
> >  				   unsigned open_flag, umode_t create_mode);
> >  		int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
> >  	        int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
> > +		int (*miscattr_set)(struct user_namespace *mnt_userns,
> > +				    struct dentry *dentry, struct miscattr *ma);
> > +		int (*miscattr_get)(struct dentry *dentry, struct miscattr *ma);
> >  	};
> >  
> >  Again, all methods are called without any locks being held, unless
> > @@ -588,6 +591,18 @@ otherwise noted.
> >  	atomically creating, opening and unlinking a file in given
> >  	directory.
> >  
> > +``miscattr_get``
> 
> I wish this wasn't named "misc" because miscellaneous is vague.

It also adds yet another way to name all the attributes (the "N + 1st
standard" problem). So I'd rather reuse a term that's already known and
understood by users. And this is 'file attributes', eg. as noted in
chattr manual page "change file attributes on a Linux file system".
For clarity avoid any 'x' in the name so we easily distinguish that from
the extended attributes aka xattrs.

We can perhaps live with miscattrs in code as anybody who has ever
touched the flags/attrs interfaces knows what it is referring to.

> fileattr_get, perhaps?

That sounds about right to me.
