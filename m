Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAB307BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 18:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhA1RJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 12:09:38 -0500
Received: from mail.hallyn.com ([178.63.66.53]:39878 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232738AbhA1Q7t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:59:49 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 5334E11D4; Thu, 28 Jan 2021 10:58:52 -0600 (CST)
Date:   Thu, 28 Jan 2021 10:58:52 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
Message-ID: <20210128165852.GA20974@mail.hallyn.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
 <20210119162204.2081137-3-mszeredi@redhat.com>
 <8735yw8k7a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735yw8k7a.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 07:34:49PM -0600, Eric W. Biederman wrote:
> Miklos Szeredi <mszeredi@redhat.com> writes:
> 
> > If a capability is stored on disk in v2 format cap_inode_getsecurity() will
> > currently return in v2 format unconditionally.
> >
> > This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
> > and so the same conversions performed on it.
> >
> > If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
> > that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
> > user namespace in case of v2) cannot be mapped in the current user
> > namespace.
> 
> This looks like a good cleanup.

Sorry, I'm not following.  Why is this a good cleanup?  Why should
the xattr be shown as faked v3 in this case?

A separate question below.

> I do wonder how well this works with stacking.  In particular
> ovl_xattr_set appears to call vfs_getxattr without overriding the creds.
> What the purpose of that is I haven't quite figured out.  It looks like
> it is just a probe to see if an xattr is present so maybe it is ok.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 43 insertions(+), 24 deletions(-)
> >
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index bacc1111d871..c9d99f8f4c82 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -371,10 +371,11 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
> >  {
> >  	int size, ret;
> >  	kuid_t kroot;
> > +	__le32 nsmagic, magic;
> >  	uid_t root, mappedroot;
> >  	char *tmpbuf = NULL;
> >  	struct vfs_cap_data *cap;
> > -	struct vfs_ns_cap_data *nscap;
> > +	struct vfs_ns_cap_data *nscap = NULL;
> >  	struct dentry *dentry;
> >  	struct user_namespace *fs_ns;
> >  
> > @@ -396,46 +397,61 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
> >  	fs_ns = inode->i_sb->s_user_ns;
> >  	cap = (struct vfs_cap_data *) tmpbuf;
> >  	if (is_v2header((size_t) ret, cap)) {
> > -		/* If this is sizeof(vfs_cap_data) then we're ok with the
> > -		 * on-disk value, so return that.  */
> > -		if (alloc)
> > -			*buffer = tmpbuf;
> > -		else
> > -			kfree(tmpbuf);
> > -		return ret;
> > -	} else if (!is_v3header((size_t) ret, cap)) {
> > -		kfree(tmpbuf);
> > -		return -EINVAL;
> > +		root = 0;
> > +	} else if (is_v3header((size_t) ret, cap)) {
> > +		nscap = (struct vfs_ns_cap_data *) tmpbuf;
> > +		root = le32_to_cpu(nscap->rootid);
> > +	} else {
> > +		size = -EINVAL;
> > +		goto out_free;
> >  	}
> >  
> > -	nscap = (struct vfs_ns_cap_data *) tmpbuf;
> > -	root = le32_to_cpu(nscap->rootid);
> >  	kroot = make_kuid(fs_ns, root);
> >  
> >  	/* If the root kuid maps to a valid uid in current ns, then return
> >  	 * this as a nscap. */
> >  	mappedroot = from_kuid(current_user_ns(), kroot);
> >  	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
> > +		size = sizeof(struct vfs_ns_cap_data);
> >  		if (alloc) {
> > -			*buffer = tmpbuf;
> > +			if (!nscap) {
> > +				/* v2 -> v3 conversion */
> > +				nscap = kzalloc(size, GFP_ATOMIC);
> > +				if (!nscap) {
> > +					size = -ENOMEM;
> > +					goto out_free;
> > +				}
> > +				nsmagic = VFS_CAP_REVISION_3;
> > +				magic = le32_to_cpu(cap->magic_etc);
> > +				if (magic & VFS_CAP_FLAGS_EFFECTIVE)
> > +					nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
> > +				memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
> > +				nscap->magic_etc = cpu_to_le32(nsmagic);
> > +			} else {
> > +				/* use allocated v3 buffer */
> > +				tmpbuf = NULL;
> > +			}
> >  			nscap->rootid = cpu_to_le32(mappedroot);
> > -		} else
> > -			kfree(tmpbuf);
> > -		return size;
> > +			*buffer = nscap;
> > +		}
> > +		goto out_free;
> >  	}
> >  
> >  	if (!rootid_owns_currentns(kroot)) {
> > -		kfree(tmpbuf);
> > -		return -EOPNOTSUPP;
> > +		size = -EOVERFLOW;

Why this change?  Christian (cc:d) noticed that this is a user visible change.
Without this change, if you are in a userns which has different rootid, the
EOVERFLOW tells vfs_getxattr to vall back to __vfs_getxattr() and so you can
see the v3 capability with its rootid.

With this change, you instead just get EOVERFLOW.

> > +		goto out_free;
> >  	}
> >  
> >  	/* This comes from a parent namespace.  Return as a v2 capability */
> >  	size = sizeof(struct vfs_cap_data);
> >  	if (alloc) {
> > -		*buffer = kmalloc(size, GFP_ATOMIC);
> > -		if (*buffer) {
> > -			struct vfs_cap_data *cap = *buffer;
> > -			__le32 nsmagic, magic;
> > +		if (nscap) {
> > +			/* v3 -> v2 conversion */
> > +			cap = kzalloc(size, GFP_ATOMIC);
> > +			if (!cap) {
> > +				size = -ENOMEM;
> > +				goto out_free;
> > +			}
> >  			magic = VFS_CAP_REVISION_2;
> >  			nsmagic = le32_to_cpu(nscap->magic_etc);
> >  			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
> > @@ -443,9 +459,12 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
> >  			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
> >  			cap->magic_etc = cpu_to_le32(magic);
> >  		} else {
> > -			size = -ENOMEM;
> > +			/* use unconverted v2 */
> > +			tmpbuf = NULL;
> >  		}
> > +		*buffer = cap;
> >  	}
> > +out_free:
> >  	kfree(tmpbuf);
> >  	return size;
> >  }
