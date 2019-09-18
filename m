Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E820B6CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfIRTtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 15:49:52 -0400
Received: from fieldses.org ([173.255.197.46]:50470 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731779AbfIRTtv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:49:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C6CE11504; Wed, 18 Sep 2019 15:49:50 -0400 (EDT)
Date:   Wed, 18 Sep 2019 15:49:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     NeilBrown <neilb@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lange <lange@informatik.uni-koeln.de>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190918194950.GD4652@fieldses.org>
References: <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
 <87woj3157p.fsf@notabene.neil.brown.name>
 <20190510200941.GB5349@fieldses.org>
 <20190918090731.GB19549@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918090731.GB19549@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:07:31AM +0200, Miklos Szeredi wrote:
> On Fri, May 10, 2019 at 04:09:41PM -0400, J. Bruce Fields wrote:
> > On Tue, May 07, 2019 at 10:24:58AM +1000, NeilBrown wrote:
> > > Interesting perspective .... though doesn't NFSv4 explicitly allow
> > > client-side ACL enforcement in the case of delegations?
> > 
> > Not really.  What you're probably thinking of is the single ACE that the
> > server can return on granting a delegation, that tells the client it can
> > skip the ACCESS check for users matching that ACE.  It's unclear how
> > useful that is.  It's currently unused by the Linux client and server.
> > 
> > > Not sure how relevant that is....
> > > 
> > > It seems to me we have two options:
> > >  1/ declare the NFSv4 doesn't work as a lower layer for overlayfs and
> > >     recommend people use NFSv3, or
> > >  2/ Modify overlayfs to work with NFSv4 by ignoring nfsv4 ACLs either
> > >  2a/ always - and ignore all other acls and probably all system. xattrs,
> > >  or
> > >  2b/ based on a mount option that might be
> > >       2bi/ general "noacl" or might be
> > >       2bii/ explicit "noxattr=system.nfs4acl"
> > >  
> > > I think that continuing to discuss the miniature of the options isn't
> > > going to help.  No solution is perfect - we just need to clearly
> > > document the implications of whatever we come up with.
> > > 
> > > I lean towards 2a, but I be happy with with any '2' and '1' won't kill
> > > me.
> > 
> > I guess I'd also lean towards 2a.
> > 
> > I don't think it applies to posix acls, as overlayfs is capable of
> > copying those up and evaluating them on its own.
> 
> POSIX acls are evaluated and copied up.
> 
> I guess same goes for "security.*" attributes, that are evaluated on MAC checks.
> 
> I think it would be safe to ignore failure to copy up anything else.  That seems
> a bit saner than just blacklisting nfs4_acl...
> 
> Something like the following untested patch.

It seems at least simple to implement and explain.

>  fs/overlayfs/copy_up.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -36,6 +36,13 @@ static int ovl_ccup_get(char *buf, const
>  module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
>  MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
>  
> +static bool ovl_must_copy_xattr(const char *name)
> +{
> +	return !strcmp(name, XATTR_POSIX_ACL_ACCESS) ||
> +	       !strcmp(name, XATTR_POSIX_ACL_DEFAULT) ||
> +	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
> +}
> +
>  int ovl_copy_xattr(struct dentry *old, struct dentry *new)
>  {
>  	ssize_t list_size, size, value_size = 0;
> @@ -107,8 +114,13 @@ int ovl_copy_xattr(struct dentry *old, s
>  			continue; /* Discard */
>  		}
>  		error = vfs_setxattr(new, name, value, size, 0);
> -		if (error)
> -			break;
> +		if (error) {

Can we check for EOPNOTSUPP instead of any error?

Maybe we're copying up a user xattr to a filesystem that's perfectly
capable of supporting those.  And maybe there's a disk error or we run
out of disk space or something.  Then I'd rather get EIO or ENOSPC than
silently fail to copy some xattrs.

--b.

> +			if (ovl_must_copy_xattr(name))
> +				break;
> +
> +			/* Ignore failure to copy unknown xattrs */
> +			error = 0;
> +		}
>  	}
>  	kfree(value);
>  out:
