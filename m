Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49533A869
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCNWCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 18:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhCNWCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615759354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4EK6hhWIbRoLqeWgTcfFUUNPNT97ooEQxQWo15yTnLQ=;
        b=fik1dv4vIyiC049l5k2rfw12aXrLNjfsyvATvuQGTGTS2MLPiMUFiXOihVrjLw2kq7yAc4
        vDmJgA29wxlrdbInw7e078DBPXY4jqQovZOsejNyvigopwtDmU7Aby7lbsKb9EsugI8EAH
        FxGyUsqwMXvmAlg/xxilT6E7LdeKNKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-NhuuvZxiPqO0az23AWwriA-1; Sun, 14 Mar 2021 18:02:30 -0400
X-MC-Unique: NhuuvZxiPqO0az23AWwriA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F3183E741;
        Sun, 14 Mar 2021 22:02:27 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-132.rdu2.redhat.com [10.10.112.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0466E519;
        Sun, 14 Mar 2021 22:02:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 91DB922054F; Sun, 14 Mar 2021 18:02:25 -0400 (EDT)
Date:   Sun, 14 Mar 2021 18:02:25 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 02/40] fs: add id translation helpers
Message-ID: <20210314220225.GA223210@redhat.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-3-christian.brauner@ubuntu.com>
 <20210313000529.GA181317@redhat.com>
 <20210313143148.d6rhgmhxwq6abb6y@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313143148.d6rhgmhxwq6abb6y@wittgenstein>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 03:31:48PM +0100, Christian Brauner wrote:
> On Fri, Mar 12, 2021 at 07:05:29PM -0500, Vivek Goyal wrote:
> > On Thu, Jan 21, 2021 at 02:19:21PM +0100, Christian Brauner wrote:
> > > Add simple helpers to make it easy to map kuids into and from idmapped
> > > mounts. We provide simple wrappers that filesystems can use to e.g.
> > > initialize inodes similar to i_{uid,gid}_read() and i_{uid,gid}_write().
> > > Accessing an inode through an idmapped mount maps the i_uid and i_gid of
> > > the inode to the mount's user namespace. If the fsids are used to
> > > initialize inodes they are unmapped according to the mount's user
> > > namespace. Passing the initial user namespace to these helpers makes
> > > them a nop and so any non-idmapped paths will not be impacted.
> > > 
> > > Link: https://lore.kernel.org/r/20210112220124.837960-9-christian.brauner@ubuntu.com
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > > /* v2 */
> > > - Christoph Hellwig <hch@lst.de>:
> > >   - Get rid of the ifdefs and the config option that hid idmapped mounts.
> > > 
> > > /* v3 */
> > > unchanged
> > > 
> > > /* v4 */
> > > - Serge Hallyn <serge@hallyn.com>:
> > >   - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
> > >     terminology consistent.
> > > 
> > > /* v5 */
> > > unchanged
> > > base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> > > 
> > > /* v6 */
> > > unchanged
> > > base-commit: 19c329f6808995b142b3966301f217c831e7cf31
> > > ---
> > >  include/linux/fs.h | 47 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index fd0b80e6361d..3165998e2294 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -40,6 +40,7 @@
> > >  #include <linux/build_bug.h>
> > >  #include <linux/stddef.h>
> > >  #include <linux/mount.h>
> > > +#include <linux/cred.h>
> > >  
> > >  #include <asm/byteorder.h>
> > >  #include <uapi/linux/fs.h>
> > > @@ -1573,6 +1574,52 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
> > >  	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
> > >  }
> > >  
> > > +static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
> > > +				   kuid_t kuid)
> > > +{
> > > +	return make_kuid(mnt_userns, __kuid_val(kuid));
> > > +}
> > > +
> > 
> > Hi Christian,
> > 
> > I am having little trouble w.r.t function names and trying to figure
> > out whether they are mapping id down or up.
> > 
> > For example, kuid_into_mnt() ultimately calls map_id_down(). That is,
> > id visible inside user namespace is mapped to host
> > (if observer is in init_user_ns, IIUC).
> > 
> > But fsuid_into_mnt() ultimately calls map_id_up(). That's take a kuid
> > and map it into the user_namespace.
> > 
> > So both the helpers end with into_mnt() but one maps id down and
> > other maps id up. I found this confusing and was wondering how
> > should I visualize it. So thought of asking you.
> > 
> > Is this intentional or can naming be improved so that *_into_mnt()
> > means one thing (Either map_id_up() or map_id_down()). And vice-a-versa
> > for *_from_mnt().
> 
> [Trimming my crazy Cc list to not spam everyone.].
> 
> Hey Vivek,
> 
> Thank you for your feedback, really appreciated!
> 
> The naming was intended to always signify that the helpers always return
> a k{u,g}id but I can certainly see how the naming isn't as clear as it
> should be for those helpers in other ways. I would suggest we remove
> such direct exposures of these helpers completely and make it simpler
> for callers by introducing very straightforward helpers. See the tiny
> patches below (only compile tested for now):

Hi Chirstian,

Thanks for the following patches. Now we are only left with
kuid_from_mnt() and kuid_into_mnt() and I can wrap my head around
it.

Thanks
Vivek

> 
> From 1bab0249295d0cad359f39a38e6171bcd2d68a60 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Sat, 13 Mar 2021 15:08:04 +0100
> Subject: [PATCH 1/2] fs: introduce fsuidgid_has_mapping() helper
> 
> Don't open-code the checks and instead move them into a clean little
> helper we can call. This also reduces the risk that if we ever changing
> something here we forget to change all locations.
> 
> Inspired-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  fs/namei.c         | 11 +++--------
>  include/linux/fs.h | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 216f16e74351..bc03cbc37ba7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2823,16 +2823,14 @@ static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
>  static inline int may_create(struct user_namespace *mnt_userns,
>  			     struct inode *dir, struct dentry *child)
>  {
> -	struct user_namespace *s_user_ns;
>  	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE);
>  	if (child->d_inode)
>  		return -EEXIST;
>  	if (IS_DEADDIR(dir))
>  		return -ENOENT;
> -	s_user_ns = dir->i_sb->s_user_ns;
> -	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
> -	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
> +	if (!fsuidgid_has_mapping(dir->i_sb, mnt_userns))
>  		return -EOVERFLOW;
> +
>  	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>  }
>  
> @@ -3034,14 +3032,11 @@ static int may_o_create(struct user_namespace *mnt_userns,
>  			const struct path *dir, struct dentry *dentry,
>  			umode_t mode)
>  {
> -	struct user_namespace *s_user_ns;
>  	int error = security_path_mknod(dir, dentry, mode, 0);
>  	if (error)
>  		return error;
>  
> -	s_user_ns = dir->dentry->d_sb->s_user_ns;
> -	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
> -	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
> +	if (!fsuidgid_has_mapping(dir->dentry->d_sb, mnt_userns))
>  		return -EOVERFLOW;
>  
>  	error = inode_permission(mnt_userns, dir->dentry->d_inode,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec8f3ddf4a6a..a970a43afb0a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1620,6 +1620,19 @@ static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
>  	return kgid_from_mnt(mnt_userns, current_fsgid());
>  }
>  
> +static inline bool fsuidgid_has_mapping(struct super_block *sb,
> +					struct user_namespace *mnt_userns)
> +{
> +	struct user_namespace *s_user_ns = sb->s_user_ns;
> +	if (!kuid_has_mapping(s_user_ns,
> +		kuid_from_mnt(mnt_userns, current_fsuid())))
> +		return false;
> +	if (!kgid_has_mapping(s_user_ns,
> +		kgid_from_mnt(mnt_userns, current_fsgid())))
> +		return false;
> +	return true;
> +}
> +
>  extern struct timespec64 current_time(struct inode *inode);
>  
>  /*
> -- 
> 2.27.0
> 
> 
> From 2f316f7de3ac96ecc8cc889724c0132e96b47b51 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Sat, 13 Mar 2021 15:11:55 +0100
> Subject: [PATCH 2/2] fs: introduce two little fs{u,g}id inode initialization
>  helpers
> 
> As Vivek pointed out we could tweak the names of the fs{u,g}id helpers.
> That's already good but the better approach is to not expose them in
> this way to filesystems at all and simply give the filesystems two
> helpers inode_fsuid_set() and inode_fsgid_set() that will do the right
> thing.
> 
> Inspired-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  fs/ext4/ialloc.c   |  2 +-
>  fs/inode.c         |  4 ++--
>  fs/xfs/xfs_inode.c |  2 +-
>  include/linux/fs.h | 10 ++++++----
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 633ae7becd61..755a68bb7e22 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -970,7 +970,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  		i_gid_write(inode, owner[1]);
>  	} else if (test_opt(sb, GRPID)) {
>  		inode->i_mode = mode;
> -		inode->i_uid = fsuid_into_mnt(mnt_userns);
> +		inode_fsuid_set(inode, mnt_userns);
>  		inode->i_gid = dir->i_gid;
>  	} else
>  		inode_init_owner(mnt_userns, inode, dir, mode);
> diff --git a/fs/inode.c b/fs/inode.c
> index a047ab306f9a..21c5a620ca89 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2148,7 +2148,7 @@ EXPORT_SYMBOL(init_special_inode);
>  void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		      const struct inode *dir, umode_t mode)
>  {
> -	inode->i_uid = fsuid_into_mnt(mnt_userns);
> +	inode_fsuid_set(inode, mnt_userns);
>  	if (dir && dir->i_mode & S_ISGID) {
>  		inode->i_gid = dir->i_gid;
>  
> @@ -2160,7 +2160,7 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
>  			mode &= ~S_ISGID;
>  	} else
> -		inode->i_gid = fsgid_into_mnt(mnt_userns);
> +		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
>  }
>  EXPORT_SYMBOL(inode_init_owner);
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 46a861d55e48..aa924db90cd9 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -812,7 +812,7 @@ xfs_init_new_inode(
>  
>  	if (dir && !(dir->i_mode & S_ISGID) &&
>  	    (mp->m_flags & XFS_MOUNT_GRPID)) {
> -		inode->i_uid = fsuid_into_mnt(mnt_userns);
> +		inode_fsuid_set(inode, mnt_userns);
>  		inode->i_gid = dir->i_gid;
>  		inode->i_mode = mode;
>  	} else {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a970a43afb0a..b337daa6b191 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1610,14 +1610,16 @@ static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
>  	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
>  }
>  
> -static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
> +static inline void inode_fsuid_set(struct inode *inode,
> +				   struct user_namespace *mnt_userns)
>  {
> -	return kuid_from_mnt(mnt_userns, current_fsuid());
> +	inode->i_uid = kuid_from_mnt(mnt_userns, current_fsuid());
>  }
>  
> -static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
> +static inline void inode_fsgid_set(struct inode *inode,
> +				   struct user_namespace *mnt_userns)
>  {
> -	return kgid_from_mnt(mnt_userns, current_fsgid());
> +	inode->i_gid = kgid_from_mnt(mnt_userns, current_fsgid());
>  }
>  
>  static inline bool fsuidgid_has_mapping(struct super_block *sb,
> -- 
> 2.27.0
> 

