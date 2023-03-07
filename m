Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1C6AE7CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCGRCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 12:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCGRCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:02:14 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F13196A6;
        Tue,  7 Mar 2023 08:58:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWLxT3867z9xFrH;
        Wed,  8 Mar 2023 00:48:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHlVz2bAdkgUR6AQ--.20502S2;
        Tue, 07 Mar 2023 17:57:39 +0100 (CET)
Message-ID: <f1ced48fad10e11e1623aeefbcd446d4af142010.camel@huaweicloud.com>
Subject: Re: [PATCH 26/28] evm: Move to LSM infrastructure
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, viro@zeniv.linux.org.uk,
        chuck.lever@oracle.com, jlayton@kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 07 Mar 2023 17:57:24 +0100
In-Reply-To: <cfbf35c1-deb8-08d0-ecf7-958a56d6c3b6@schaufler-ca.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303182602.1088032-4-roberto.sassu@huaweicloud.com>
         <688527a9-c164-581e-ae60-f82bd8ccccad@schaufler-ca.com>
         <dc3f43e0f445b0339aac510ecd4a74accc83dd6a.camel@huaweicloud.com>
         <cfbf35c1-deb8-08d0-ecf7-958a56d6c3b6@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHlVz2bAdkgUR6AQ--.20502S2
X-Coremail-Antispam: 1UD129KBjvAXoWfWFWrKF4kKw43urWDuw15urg_yoW8Kw17Go
        WxXws7JF4kXry5JrW5Ga42qF9F9ay5G3yUAryrJw4DC3W2y3Wjkw12kF13JFW5WF18Gr47
        K34Iqw109FW5Xrn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4ZObwAAsZ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-03-07 at 08:54 -0800, Casey Schaufler wrote:
> On 3/6/2023 1:21 AM, Roberto Sassu wrote:
> > On Sat, 2023-03-04 at 13:36 -0800, Casey Schaufler wrote:
> > > On 3/3/2023 10:26 AM, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > As for IMA, remove hardcoded EVM function calls from the LSM infrastructure
> > > > and the VFS. Make EVM functions as static (except for
> > > > evm_inode_init_security(), which is exported), and register them as hook
> > > > implementations in init_evm_lsm(), called from integrity_lsm_init().
> > > > 
> > > > Finally, switch to the LSM reservation mechanism for the EVM xattr, by
> > > > setting the lbs_xattr field of the lsm_blob_sizes structure, and
> > > > consequently decrement the number of xattrs to allocate in
> > > > security_inode_init_security().
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  fs/attr.c                         |   2 -
> > > >  fs/posix_acl.c                    |   3 -
> > > >  fs/xattr.c                        |   2 -
> > > >  include/linux/evm.h               | 116 ------------------------------
> > > >  security/integrity/evm/evm_main.c | 106 ++++++++++++++++++++++-----
> > > >  security/integrity/iint.c         |   7 ++
> > > >  security/integrity/integrity.h    |   9 +++
> > > >  security/security.c               |  41 +++--------
> > > >  8 files changed, 115 insertions(+), 171 deletions(-)
> > > > 
> > > > diff --git a/fs/attr.c b/fs/attr.c
> > > > index 406d782dfab..1b911a627fe 100644
> > > > --- a/fs/attr.c
> > > > +++ b/fs/attr.c
> > > > @@ -16,7 +16,6 @@
> > > >  #include <linux/fcntl.h>
> > > >  #include <linux/filelock.h>
> > > >  #include <linux/security.h>
> > > > -#include <linux/evm.h>
> > > >  
> > > >  #include "internal.h"
> > > >  
> > > > @@ -485,7 +484,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
> > > >  	if (!error) {
> > > >  		fsnotify_change(dentry, ia_valid);
> > > >  		security_inode_post_setattr(idmap, dentry, ia_valid);
> > > > -		evm_inode_post_setattr(idmap, dentry, ia_valid);
> > > >  	}
> > > >  
> > > >  	return error;
> > > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > > index 5b8c92fce0c..608cb0a9f84 100644
> > > > --- a/fs/posix_acl.c
> > > > +++ b/fs/posix_acl.c
> > > > @@ -26,7 +26,6 @@
> > > >  #include <linux/mnt_idmapping.h>
> > > >  #include <linux/iversion.h>
> > > >  #include <linux/security.h>
> > > > -#include <linux/evm.h>
> > > >  #include <linux/fsnotify.h>
> > > >  #include <linux/filelock.h>
> > > >  
> > > > @@ -1103,7 +1102,6 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> > > >  	if (!error) {
> > > >  		fsnotify_xattr(dentry);
> > > >  		security_inode_post_set_acl(dentry, acl_name, kacl);
> > > > -		evm_inode_post_set_acl(dentry, acl_name, kacl);
> > > >  	}
> > > >  
> > > >  out_inode_unlock:
> > > > @@ -1214,7 +1212,6 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> > > >  	if (!error) {
> > > >  		fsnotify_xattr(dentry);
> > > >  		security_inode_post_remove_acl(idmap, dentry, acl_name);
> > > > -		evm_inode_post_remove_acl(idmap, dentry, acl_name);
> > > >  	}
> > > >  
> > > >  out_inode_unlock:
> > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > index 10c959d9fc6..7708ffdacca 100644
> > > > --- a/fs/xattr.c
> > > > +++ b/fs/xattr.c
> > > > @@ -16,7 +16,6 @@
> > > >  #include <linux/mount.h>
> > > >  #include <linux/namei.h>
> > > >  #include <linux/security.h>
> > > > -#include <linux/evm.h>
> > > >  #include <linux/syscalls.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/fsnotify.h>
> > > > @@ -535,7 +534,6 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> > > >  	if (!error) {
> > > >  		fsnotify_xattr(dentry);
> > > >  		security_inode_post_removexattr(dentry, name);
> > > > -		evm_inode_post_removexattr(dentry, name);
> > > >  	}
> > > >  
> > > >  out:
> > > > diff --git a/include/linux/evm.h b/include/linux/evm.h
> > > > index 8c043273552..61794299f09 100644
> > > > --- a/include/linux/evm.h
> > > > +++ b/include/linux/evm.h
> > > > @@ -21,46 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
> > > >  					     void *xattr_value,
> > > >  					     size_t xattr_value_len,
> > > >  					     struct integrity_iint_cache *iint);
> > > > -extern int evm_inode_setattr(struct mnt_idmap *idmap,
> > > > -			     struct dentry *dentry, struct iattr *attr);
> > > > -extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
> > > > -				   struct dentry *dentry, int ia_valid);
> > > > -extern int evm_inode_setxattr(struct mnt_idmap *idmap,
> > > > -			      struct dentry *dentry, const char *name,
> > > > -			      const void *value, size_t size, int flags);
> > > > -extern void evm_inode_post_setxattr(struct dentry *dentry,
> > > > -				    const char *xattr_name,
> > > > -				    const void *xattr_value,
> > > > -				    size_t xattr_value_len,
> > > > -				    int flags);
> > > > -extern int evm_inode_removexattr(struct mnt_idmap *idmap,
> > > > -				 struct dentry *dentry, const char *xattr_name);
> > > > -extern void evm_inode_post_removexattr(struct dentry *dentry,
> > > > -				       const char *xattr_name);
> > > > -static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
> > > > -					     struct dentry *dentry,
> > > > -					     const char *acl_name)
> > > > -{
> > > > -	evm_inode_post_removexattr(dentry, acl_name);
> > > > -}
> > > > -extern int evm_inode_set_acl(struct mnt_idmap *idmap,
> > > > -			     struct dentry *dentry, const char *acl_name,
> > > > -			     struct posix_acl *kacl);
> > > > -static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
> > > > -				       struct dentry *dentry,
> > > > -				       const char *acl_name)
> > > > -{
> > > > -	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
> > > > -}
> > > > -static inline void evm_inode_post_set_acl(struct dentry *dentry,
> > > > -					  const char *acl_name,
> > > > -					  struct posix_acl *kacl)
> > > > -{
> > > > -	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
> > > > -}
> > > > -extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > > -				   const struct qstr *qstr,
> > > > -				   struct xattr *xattrs);
> > > >  extern bool evm_revalidate_status(const char *xattr_name);
> > > >  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
> > > >  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> > > > @@ -92,82 +52,6 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
> > > >  }
> > > >  #endif
> > > >  
> > > > -static inline int evm_inode_setattr(struct mnt_idmap *idmap,
> > > > -				    struct dentry *dentry, struct iattr *attr)
> > > > -{
> > > > -	return 0;
> > > > -}
> > > > -
> > > > -static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
> > > > -					  struct dentry *dentry, int ia_valid)
> > > > -{
> > > > -	return;
> > > > -}
> > > > -
> > > > -static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
> > > > -				     struct dentry *dentry, const char *name,
> > > > -				     const void *value, size_t size, int flags)
> > > > -{
> > > > -	return 0;
> > > > -}
> > > > -
> > > > -static inline void evm_inode_post_setxattr(struct dentry *dentry,
> > > > -					   const char *xattr_name,
> > > > -					   const void *xattr_value,
> > > > -					   size_t xattr_value_len,
> > > > -					   int flags)
> > > > -{
> > > > -	return;
> > > > -}
> > > > -
> > > > -static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
> > > > -					struct dentry *dentry,
> > > > -					const char *xattr_name)
> > > > -{
> > > > -	return 0;
> > > > -}
> > > > -
> > > > -static inline void evm_inode_post_removexattr(struct dentry *dentry,
> > > > -					      const char *xattr_name)
> > > > -{
> > > > -	return;
> > > > -}
> > > > -
> > > > -static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
> > > > -					     struct dentry *dentry,
> > > > -					     const char *acl_name)
> > > > -{
> > > > -	return;
> > > > -}
> > > > -
> > > > -static inline int evm_inode_set_acl(struct mnt_idmap *idmap,
> > > > -				    struct dentry *dentry, const char *acl_name,
> > > > -				    struct posix_acl *kacl)
> > > > -{
> > > > -	return 0;
> > > > -}
> > > > -
> > > > -static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
> > > > -				       struct dentry *dentry,
> > > > -				       const char *acl_name)
> > > > -{
> > > > -	return 0;
> > > > -}
> > > > -
> > > > -static inline void evm_inode_post_set_acl(struct dentry *dentry,
> > > > -					  const char *acl_name,
> > > > -					  struct posix_acl *kacl)
> > > > -{
> > > > -	return;
> > > > -}
> > > > -
> > > > -static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > > -					  const struct qstr *qstr,
> > > > -					  struct xattr *xattrs)
> > > > -{
> > > > -	return 0;
> > > > -}
> > > > -
> > > >  static inline bool evm_revalidate_status(const char *xattr_name)
> > > >  {
> > > >  	return false;
> > > > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > > > index 8b5c472f78b..c45bc97277c 100644
> > > > --- a/security/integrity/evm/evm_main.c
> > > > +++ b/security/integrity/evm/evm_main.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include <linux/xattr.h>
> > > >  #include <linux/integrity.h>
> > > >  #include <linux/evm.h>
> > > > +#include <linux/lsm_hooks.h>
> > > >  #include <linux/magic.h>
> > > >  #include <linux/posix_acl_xattr.h>
> > > >  
> > > > @@ -566,9 +567,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
> > > >   * userspace from writing HMAC value.  Writing 'security.evm' requires
> > > >   * requires CAP_SYS_ADMIN privileges.
> > > >   */
> > > > -int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > -		       const char *xattr_name, const void *xattr_value,
> > > > -		       size_t xattr_value_len, int flags)
> > > > +static int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +			      const char *xattr_name, const void *xattr_value,
> > > > +			      size_t xattr_value_len, int flags)
> > > >  {
> > > >  	const struct evm_ima_xattr_data *xattr_data = xattr_value;
> > > >  
> > > > @@ -598,8 +599,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > >   * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
> > > >   * the current value is valid.
> > > >   */
> > > > -int evm_inode_removexattr(struct mnt_idmap *idmap,
> > > > -			  struct dentry *dentry, const char *xattr_name)
> > > > +static int evm_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +				 const char *xattr_name)
> > > >  {
> > > >  	/* Policy permits modification of the protected xattrs even though
> > > >  	 * there's no HMAC key loaded
> > > > @@ -649,9 +650,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
> > > >   * Prevent modifying posix acls causing the EVM HMAC to be re-calculated
> > > >   * and 'security.evm' xattr updated, unless the existing 'security.evm' is
> > > >   * valid.
> > > > + *
> > > > + * Return: zero on success, -EPERM on failure.
> > > >   */
> > > > -int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > -		      const char *acl_name, struct posix_acl *kacl)
> > > > +static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +			     const char *acl_name, struct posix_acl *kacl)
> > > >  {
> > > >  	enum integrity_status evm_status;
> > > >  
> > > > @@ -690,6 +693,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> > > >  	return -EPERM;
> > > >  }
> > > >  
> > > > +/**
> > > > + * evm_inode_remove_acl - Protect the EVM extended attribute from posix acls
> > > > + * @idmap: idmap of the mount
> > > > + * @dentry: pointer to the affected dentry
> > > > + * @acl_name: name of the posix acl
> > > > + *
> > > > + * Prevent removing posix acls causing the EVM HMAC to be re-calculated
> > > > + * and 'security.evm' xattr updated, unless the existing 'security.evm' is
> > > > + * valid.
> > > > + *
> > > > + * Return: zero on success, -EPERM on failure.
> > > > + */
> > > > +static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +				const char *acl_name)
> > > > +{
> > > > +	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
> > > > +}
> > > > +
> > > >  static void evm_reset_status(struct inode *inode)
> > > >  {
> > > >  	struct integrity_iint_cache *iint;
> > > > @@ -738,9 +759,11 @@ bool evm_revalidate_status(const char *xattr_name)
> > > >   * __vfs_setxattr_noperm().  The caller of which has taken the inode's
> > > >   * i_mutex lock.
> > > >   */
> > > > -void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
> > > > -			     const void *xattr_value, size_t xattr_value_len,
> > > > -			     int flags)
> > > > +static void evm_inode_post_setxattr(struct dentry *dentry,
> > > > +				    const char *xattr_name,
> > > > +				    const void *xattr_value,
> > > > +				    size_t xattr_value_len,
> > > > +				    int flags)
> > > >  {
> > > >  	if (!evm_revalidate_status(xattr_name))
> > > >  		return;
> > > > @@ -756,6 +779,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
> > > >  	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
> > > >  }
> > > >  
> > > > +/**
> > > > + * evm_inode_post_set_acl - Update the EVM extended attribute from posix acls
> > > > + * @dentry: pointer to the affected dentry
> > > > + * @acl_name: name of the posix acl
> > > > + * @kacl: pointer to the posix acls
> > > > + *
> > > > + * Update the 'security.evm' xattr with the EVM HMAC re-calculated after setting
> > > > + * posix acls.
> > > > + */
> > > > +static void evm_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> > > > +				   struct posix_acl *kacl)
> > > > +{
> > > > +	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
> > > > +}
> > > > +
> > > >  /**
> > > >   * evm_inode_post_removexattr - update 'security.evm' after removing the xattr
> > > >   * @dentry: pointer to the affected dentry
> > > > @@ -766,7 +804,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
> > > >   * No need to take the i_mutex lock here, as this function is called from
> > > >   * vfs_removexattr() which takes the i_mutex.
> > > >   */
> > > > -void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
> > > > +static void evm_inode_post_removexattr(struct dentry *dentry,
> > > > +				       const char *xattr_name)
> > > >  {
> > > >  	if (!evm_revalidate_status(xattr_name))
> > > >  		return;
> > > > @@ -782,6 +821,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
> > > >  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
> > > >  }
> > > >  
> > > > +/**
> > > > + * evm_inode_post_remove_acl - Update the EVM extended attribute from posix acls
> > > > + * @idmap: idmap of the mount
> > > > + * @dentry: pointer to the affected dentry
> > > > + * @acl_name: name of the posix acl
> > > > + *
> > > > + * Update the 'security.evm' xattr with the EVM HMAC re-calculated after
> > > > + * removing posix acls.
> > > > + */
> > > > +static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
> > > > +					     struct dentry *dentry,
> > > > +					     const char *acl_name)
> > > > +{
> > > > +	evm_inode_post_removexattr(dentry, acl_name);
> > > > +}
> > > > +
> > > >  static int evm_attr_change(struct mnt_idmap *idmap,
> > > >  			   struct dentry *dentry, struct iattr *attr)
> > > >  {
> > > > @@ -805,8 +860,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
> > > >   * Permit update of file attributes when files have a valid EVM signature,
> > > >   * except in the case of them having an immutable portable signature.
> > > >   */
> > > > -int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > -		      struct iattr *attr)
> > > > +static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +			     struct iattr *attr)
> > > >  {
> > > >  	unsigned int ia_valid = attr->ia_valid;
> > > >  	enum integrity_status evm_status;
> > > > @@ -853,8 +908,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > >   * This function is called from notify_change(), which expects the caller
> > > >   * to lock the inode's i_mutex.
> > > >   */
> > > > -void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > -			    int ia_valid)
> > > > +static void evm_inode_post_setattr(struct mnt_idmap *idmap,
> > > > +				   struct dentry *dentry, int ia_valid)
> > > >  {
> > > >  	if (!evm_revalidate_status(NULL))
> > > >  		return;
> > > > @@ -892,7 +947,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > >  	if (!evm_protected_xattrs)
> > > >  		return -EOPNOTSUPP;
> > > >  
> > > > -	evm_xattr = xattr;
> > > > +	evm_xattr = xattrs + integrity_blob_sizes.lbs_xattr;
> > > Please don't do this inline. Convention is to use a function,
> > > intergrity_xattrs() for this.
> > Ok.
> > 
> > > >  
> > > >  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> > > >  	if (!xattr_data)
> > > > @@ -952,4 +1007,23 @@ static int __init init_evm(void)
> > > >  	return error;
> > > >  }
> > > >  
> > > > +static struct security_hook_list evm_hooks[] __lsm_ro_after_init = {
> > > > +	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
> > > > +	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
> > > > +	LSM_HOOK_INIT(inode_setxattr, evm_inode_setxattr),
> > > > +	LSM_HOOK_INIT(inode_set_acl, evm_inode_set_acl),
> > > > +	LSM_HOOK_INIT(inode_post_set_acl, evm_inode_post_set_acl),
> > > > +	LSM_HOOK_INIT(inode_remove_acl, evm_inode_remove_acl),
> > > > +	LSM_HOOK_INIT(inode_post_remove_acl, evm_inode_post_remove_acl),
> > > > +	LSM_HOOK_INIT(inode_post_setxattr, evm_inode_post_setxattr),
> > > > +	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
> > > > +	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
> > > > +	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
> > > > +};
> > > > +
> > > > +void __init init_evm_lsm(void)
> > > > +{
> > > > +	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), "integrity");
> > > > +}
> > > > +
> > > >  late_initcall(init_evm);
> > > > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > > > index bbadf974b31..952d5ea4e18 100644
> > > > --- a/security/integrity/iint.c
> > > > +++ b/security/integrity/iint.c
> > > > @@ -179,12 +179,19 @@ static int __init integrity_lsm_init(void)
> > > >  			      0, SLAB_PANIC, init_once);
> > > >  
> > > >  	init_ima_lsm();
> > > > +	init_evm_lsm();
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +struct lsm_blob_sizes integrity_blob_sizes __lsm_ro_after_init = {
> > > > +	.lbs_xattr = 1,
> > > Really? 1 byte? Don't even think of storing number of elements in lbs_xattr.
> > > The linux_blob_size structure contains sizes of blobs, not number of elements.
> > Oh, I see it can be confusing.
> > 
> > However, lbs_xattr does not help to position in the security blob but
> > in the new_xattrs array, allocated in security_inode_init_security()
> > (see below). Any suggestion on how to make this part better?
> 
> On further review, your current use is perfectly reasonable.
> The patch that introduces lbs_xattr (not in this set, I see)
> needs to document the use so other LSMs can use is correctly.

Ok, will add it.

So far, Paul's review should be the last.

Thanks

Roberto

> > Thanks
> > 
> > Roberto
> > 
> > > > +};
> > > > +
> > > >  DEFINE_LSM(integrity) = {
> > > >  	.name = "integrity",
> > > >  	.init = integrity_lsm_init,
> > > >  	.order = LSM_ORDER_LAST,
> > > > +	.blobs = &integrity_blob_sizes,
> > > >  };
> > > >  
> > > >  /*
> > > > diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> > > > index c72d375a356..76e7eda6651 100644
> > > > --- a/security/integrity/integrity.h
> > > > +++ b/security/integrity/integrity.h
> > > > @@ -188,6 +188,7 @@ int integrity_kernel_read(struct file *file, loff_t offset,
> > > >  #define INTEGRITY_KEYRING_MAX		4
> > > >  
> > > >  extern struct dentry *integrity_dir;
> > > > +extern struct lsm_blob_sizes integrity_blob_sizes;
> > > >  
> > > >  struct modsig;
> > > >  
> > > > @@ -199,6 +200,14 @@ static inline void __init init_ima_lsm(void)
> > > >  }
> > > >  #endif
> > > >  
> > > > +#ifdef CONFIG_EVM
> > > > +void __init init_evm_lsm(void);
> > > > +#else
> > > > +static inline void __init init_evm_lsm(void)
> > > > +{
> > > > +}
> > > > +#endif
> > > > +
> > > >  #ifdef CONFIG_INTEGRITY_SIGNATURE
> > > >  
> > > >  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> > > > diff --git a/security/security.c b/security/security.c
> > > > index 9bc6a4ef758..74abf04feef 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -20,13 +20,13 @@
> > > >  #include <linux/kernel_read_file.h>
> > > >  #include <linux/lsm_hooks.h>
> > > >  #include <linux/integrity.h>
> > > > -#include <linux/evm.h>
> > > >  #include <linux/fsnotify.h>
> > > >  #include <linux/mman.h>
> > > >  #include <linux/mount.h>
> > > >  #include <linux/personality.h>
> > > >  #include <linux/backing-dev.h>
> > > >  #include <linux/string.h>
> > > > +#include <linux/xattr.h>
> > > >  #include <linux/msg.h>
> > > >  #include <net/flow.h>
> > > >  
> > > > @@ -1662,8 +1662,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> > > >  	if (!initxattrs)
> > > >  		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > > >  				    dir, qstr, NULL);
> > > > -	/* Allocate +1 for EVM and +1 as terminator. */
> > > > -	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> > > > +	/* Allocate +1 for terminator. */
> > > > +	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 1, sizeof(*new_xattrs),
> > > >  			     GFP_NOFS);
> > > >  	if (!new_xattrs)
> > > >  		return -ENOMEM;
> > > > @@ -1699,9 +1699,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> > > >  	if (!num_filled_xattrs)
> > > >  		goto out;
> > > >  
> > > > -	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs);
> > > > -	if (ret && ret != -EOPNOTSUPP)
> > > > -		goto out;
> > > >  	ret = initxattrs(inode, new_xattrs, fs_data);
> > > >  out:
> > > >  	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
> > > > @@ -2201,14 +2198,9 @@ int security_inode_permission(struct inode *inode, int mask)
> > > >  int security_inode_setattr(struct mnt_idmap *idmap,
> > > >  			   struct dentry *dentry, struct iattr *attr)
> > > >  {
> > > > -	int ret;
> > > > -
> > > >  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > >  		return 0;
> > > > -	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -	return evm_inode_setattr(idmap, dentry, attr);
> > > > +	return call_int_hook(inode_setattr, 0, idmap, dentry, attr);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(security_inode_setattr);
> > > >  
> > > > @@ -2272,9 +2264,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
> > > >  
> > > >  	if (ret == 1)
> > > >  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -2293,15 +2283,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
> > > >  			   struct dentry *dentry, const char *acl_name,
> > > >  			   struct posix_acl *kacl)
> > > >  {
> > > > -	int ret;
> > > > -
> > > >  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > >  		return 0;
> > > > -	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
> > > > -			    kacl);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
> > > > +	return call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
> > > > +			     kacl);
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -2354,14 +2339,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
> > > >  int security_inode_remove_acl(struct mnt_idmap *idmap,
> > > >  			      struct dentry *dentry, const char *acl_name)
> > > >  {
> > > > -	int ret;
> > > > -
> > > >  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > >  		return 0;
> > > > -	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -	return evm_inode_remove_acl(idmap, dentry, acl_name);
> > > > +	return call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -2397,7 +2377,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
> > > >  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > >  		return;
> > > >  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> > > > -	evm_inode_post_setxattr(dentry, name, value, size, flags);
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -2458,9 +2437,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
> > > >  	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
> > > >  	if (ret == 1)
> > > >  		ret = cap_inode_removexattr(idmap, dentry, name);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -	return evm_inode_removexattr(idmap, dentry, name);
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  /**

