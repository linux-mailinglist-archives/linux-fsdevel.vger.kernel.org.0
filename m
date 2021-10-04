Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE88421352
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhJDQDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 12:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236300AbhJDQDP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D620613DB;
        Mon,  4 Oct 2021 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633363286;
        bh=KTbo+s/w7AyrU4AEVHl0HuO9gPINXVnH36Enx5dl+wU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fsf6d+gMrDJXgbpWiLSjXeXr8QV2HKSWSU/MM2+mAxboUM0vnQlfTJ9fnCsfBIObf
         U/uuuhpo05kDUk4rsU306BM7QUHmW9PdsoOgg/r7xXVzyoVc+BMtJZDzxYFaZqOP2V
         2LkakCryo2NclbAwSLoR3KYv4uG651VII5XVHMo+eda5PKWnf7yb6Kz6uWFMurnHU3
         mrkUIhkAFrRTxi5Ya2NuVcqQgDemIzUDtVRni+ZPmRwruScNw5TPSetjpMBCkc/EYW
         Y1Efcl1Y3ub96I5Pkug8i16NuDJ/r4W79oBJMmxIcy+vrs1ainfrbY1zF9HkWlGYNi
         kzq4bdbwSkwYg==
Message-ID: <7404892c92592507506038ef9bdcfc1780311000.camel@kernel.org>
Subject: Re: [PATCH] security: Return xattr name from
 security_dentry_init_security()
From:   Jeff Layton <jlayton@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bfields@fieldses.org, chuck.lever@oracle.com,
        stephen.smalley.work@gmail.com
Date:   Mon, 04 Oct 2021 12:01:24 -0400
In-Reply-To: <06a82de9-1c3e-1102-7738-f40905ea9ee4@schaufler-ca.com>
References: <YVYI/p1ipDFiQ5OR@redhat.com>
         <1583ffb057e8442fa7af40dabcb38960982211ba.camel@kernel.org>
         <06a82de9-1c3e-1102-7738-f40905ea9ee4@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-10-04 at 08:54 -0700, Casey Schaufler wrote:
> On 10/4/2021 8:20 AM, Jeff Layton wrote:
> > On Thu, 2021-09-30 at 14:59 -0400, Vivek Goyal wrote:
> > > Right now security_dentry_init_security() only supports single security
> > > label and is used by SELinux only. There are two users of of this hook,
> > > namely ceph and nfs.
> > > 
> > > NFS does not care about xattr name. Ceph hardcodes the xattr name to
> > > security.selinux (XATTR_NAME_SELINUX).
> > > 
> > > I am making changes to fuse/virtiofs to send security label to virtiofsd
> > > and I need to send xattr name as well. I also hardcoded the name of
> > > xattr to security.selinux.
> > > 
> > > Stephen Smalley suggested that it probably is a good idea to modify
> > > security_dentry_init_security() to also return name of xattr so that
> > > we can avoid this hardcoding in the callers.
> > > 
> > > This patch adds a new parameter "const char **xattr_name" to
> > > security_dentry_init_security() and LSM puts the name of xattr
> > > too if caller asked for it (xattr_name != NULL).
> > > 
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > > 
> > > I have compile tested this patch. Don't know how to setup ceph and
> > > test it. Its a very simple change. Hopefully ceph developers can
> > > have a quick look at it.
> > > 
> > > A similar attempt was made three years back.
> > > 
> > > https://lore.kernel.org/linux-security-module/20180626080429.27304-1-zyan@redhat.com/T/
> > > ---
> > >  fs/ceph/xattr.c               |    3 +--
> > >  fs/nfs/nfs4proc.c             |    3 ++-
> > >  include/linux/lsm_hook_defs.h |    3 ++-
> > >  include/linux/lsm_hooks.h     |    1 +
> > >  include/linux/security.h      |    6 ++++--
> > >  security/security.c           |    7 ++++---
> > >  security/selinux/hooks.c      |    6 +++++-
> > >  7 files changed, 19 insertions(+), 10 deletions(-)
> > > 
> > > Index: redhat-linux/security/selinux/hooks.c
> > > ===================================================================
> > > --- redhat-linux.orig/security/selinux/hooks.c	2021-09-28 11:36:03.559785943 -0400
> > > +++ redhat-linux/security/selinux/hooks.c	2021-09-30 14:01:05.869195347 -0400
> > > @@ -2948,7 +2948,8 @@ static void selinux_inode_free_security(
> > >  }
> > >  
> > I agree with Al that it would be cleaner to just return the string, but
> > the call_*_hook stuff makes that a bit more tricky. I suppose this is a
> > reasonable compromise.
> 
> call_int_hook() and call_void_hook() were introduced to reduce the monotonous
> repetition in the source. They are cosmetic and add no real value. They shouldn't
> be a consideration in the discussion.
> 
> There is a problem with Al's suggestion. The interface as used today has two real
> problems. It returns an attribute value without identifying the attribute. Al's
> interface would address this issue. The other problem is that the interface can't
> provide multiple attribute+value pairs. The interface is going to need changed to
> support that for full module stacking. I don't see a rational way to extend the
> interface if it returns a string when there are multiple attributes to choose from.
> 

Is that also a problem for the ctx parameter? In the case of full module
stacking do you get back multiple contexts as well?

> > >  static int selinux_dentry_init_security(struct dentry *dentry, int mode,
> > > -					const struct qstr *name, void **ctx,
> > > +					const struct qstr *name,
> > > +					const char **xattr_name, void **ctx,
> > >  					u32 *ctxlen)
> > >  {
> > >  	u32 newsid;
> > > @@ -2961,6 +2962,9 @@ static int selinux_dentry_init_security(
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	if (xattr_name)
> > > +		*xattr_name = XATTR_NAME_SELINUX;
> > > +
> > >  	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
> > >  				       ctxlen);
> > >  }
> > > Index: redhat-linux/security/security.c
> > > ===================================================================
> > > --- redhat-linux.orig/security/security.c	2021-08-16 10:39:28.518988836 -0400
> > > +++ redhat-linux/security/security.c	2021-09-30 13:54:36.367195347 -0400
> > > @@ -1052,11 +1052,12 @@ void security_inode_free(struct inode *i
> > >  }
> > >  
> > >  int security_dentry_init_security(struct dentry *dentry, int mode,
> > > -					const struct qstr *name, void **ctx,
> > > -					u32 *ctxlen)
> > > +				  const struct qstr *name,
> > > +				  const char **xattr_name, void **ctx,
> > > +				  u32 *ctxlen)
> > >  {
> > >  	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> > > -				name, ctx, ctxlen);
> > > +				name, xattr_name, ctx, ctxlen);
> > >  }
> > >  EXPORT_SYMBOL(security_dentry_init_security);
> > >  
> > > Index: redhat-linux/include/linux/lsm_hooks.h
> > > ===================================================================
> > > --- redhat-linux.orig/include/linux/lsm_hooks.h	2021-06-02 10:20:27.717485143 -0400
> > > +++ redhat-linux/include/linux/lsm_hooks.h	2021-09-30 13:56:48.440195347 -0400
> > > @@ -196,6 +196,7 @@
> > >   *	@dentry dentry to use in calculating the context.
> > >   *	@mode mode used to determine resource type.
> > >   *	@name name of the last path component used to create file
> > > + *	@xattr_name pointer to place the pointer to security xattr name
> > It might be a good idea to also document the lifetime for xattr_name
> > here. In particular you're returning a pointer to a static string, and
> > it would be good to note that the caller needn't free it or anything.
> > 
> > >   *	@ctx pointer to place the pointer to the resulting context in.
> > >   *	@ctxlen point to place the length of the resulting context.
> > >   * @dentry_create_files_as:
> > > Index: redhat-linux/include/linux/security.h
> > > ===================================================================
> > > --- redhat-linux.orig/include/linux/security.h	2021-08-16 10:39:28.484988836 -0400
> > > +++ redhat-linux/include/linux/security.h	2021-09-30 13:59:00.288195347 -0400
> > > @@ -317,8 +317,9 @@ int security_add_mnt_opt(const char *opt
> > >  				int len, void **mnt_opts);
> > >  int security_move_mount(const struct path *from_path, const struct path *to_path);
> > >  int security_dentry_init_security(struct dentry *dentry, int mode,
> > > -					const struct qstr *name, void **ctx,
> > > -					u32 *ctxlen);
> > > +				  const struct qstr *name,
> > > +				  const char **xattr_name, void **ctx,
> > > +				  u32 *ctxlen);
> > >  int security_dentry_create_files_as(struct dentry *dentry, int mode,
> > >  					struct qstr *name,
> > >  					const struct cred *old,
> > > @@ -739,6 +740,7 @@ static inline void security_inode_free(s
> > >  static inline int security_dentry_init_security(struct dentry *dentry,
> > >  						 int mode,
> > >  						 const struct qstr *name,
> > > +						 const char **xattr_name,
> > >  						 void **ctx,
> > >  						 u32 *ctxlen)
> > >  {
> > > Index: redhat-linux/include/linux/lsm_hook_defs.h
> > > ===================================================================
> > > --- redhat-linux.orig/include/linux/lsm_hook_defs.h	2021-07-07 11:54:59.673549151 -0400
> > > +++ redhat-linux/include/linux/lsm_hook_defs.h	2021-09-30 14:02:13.114195347 -0400
> > > @@ -83,7 +83,8 @@ LSM_HOOK(int, 0, sb_add_mnt_opt, const c
> > >  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
> > >  	 const struct path *to_path)
> > >  LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
> > > -	 int mode, const struct qstr *name, void **ctx, u32 *ctxlen)
> > > +	 int mode, const struct qstr *name, const char **xattr_name,
> > > +	 void **ctx, u32 *ctxlen)
> > >  LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
> > >  	 struct qstr *name, const struct cred *old, struct cred *new)
> > >  
> > > Index: redhat-linux/fs/nfs/nfs4proc.c
> > > ===================================================================
> > > --- redhat-linux.orig/fs/nfs/nfs4proc.c	2021-07-14 14:47:42.732842926 -0400
> > > +++ redhat-linux/fs/nfs/nfs4proc.c	2021-09-30 14:06:02.249195347 -0400
> > > @@ -127,7 +127,8 @@ nfs4_label_init_security(struct inode *d
> > >  		return NULL;
> > >  
> > >  	err = security_dentry_init_security(dentry, sattr->ia_mode,
> > > -				&dentry->d_name, (void **)&label->label, &label->len);
> > > +				&dentry->d_name, NULL,
> > > +				(void **)&label->label, &label->len);
> > >  	if (err == 0)
> > >  		return label;
> > >  
> > > Index: redhat-linux/fs/ceph/xattr.c
> > > ===================================================================
> > > --- redhat-linux.orig/fs/ceph/xattr.c	2021-09-09 13:05:21.800611264 -0400
> > > +++ redhat-linux/fs/ceph/xattr.c	2021-09-30 14:14:59.892195347 -0400
> > > @@ -1311,7 +1311,7 @@ int ceph_security_init_secctx(struct den
> > >  	int err;
> > >  
> > >  	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
> > > -					    &as_ctx->sec_ctx,
> > > +					    &name, &as_ctx->sec_ctx,
> > >  					    &as_ctx->sec_ctxlen);
> > >  	if (err < 0) {
> > >  		WARN_ON_ONCE(err != -EOPNOTSUPP);
> > > @@ -1335,7 +1335,6 @@ int ceph_security_init_secctx(struct den
> > >  	 * It only supports single security module and only selinux has
> > >  	 * dentry_init_security hook.
> > >  	 */
> > > -	name = XATTR_NAME_SELINUX;
> > >  	name_len = strlen(name);
> > >  	err = ceph_pagelist_reserve(pagelist,
> > >  				    4 * 2 + name_len + as_ctx->sec_ctxlen);
> > > 
> > Looks reasonable overall.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > 
> 

-- 
Jeff Layton <jlayton@kernel.org>

