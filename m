Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C3791EED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbjIDVLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjIDVLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B4AB;
        Mon,  4 Sep 2023 14:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C8E4616B9;
        Mon,  4 Sep 2023 21:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AA8C433C8;
        Mon,  4 Sep 2023 21:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693861899;
        bh=VzvHqwUb07vEXlaVops1vdy2zPHGYNdkCkt5uHSloaA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ddz547fbWNEZYh4XmkCjutITZI2zx5CPl24OevlCHTj4CuIMwtObSYLKM6j8qxyA1
         jEjlOJlUX5qAWm4zkJMYLWAV1yxnuDX500KQCuXmKctIm1ZLfs60tyTAKdIJwcWv44
         ZPyViGDT/eyWRGhW2H8V6eprLryI67b1bC+1mNJxeA22qt2Z3zTMEOizqysx/W0xg7
         KtwYBpNGTYD8ISv5tT03A1n6NMoJ4qSxkTM6MN+XfNbJkKJqc3+0VfyKgfCHDlfD3J
         1xAXa4qV9OIHk6PdWe2fQCRylnvUZoVTCH8Uym3KGfOiu0IR/cIITMOU8WzrYtA4O8
         li6a38VP1qeRw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 00:11:32 +0300
Message-Id: <CVAFXF2BQ14B.19BO7F9P62WGT@suppilovahvero>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <selinux@vger.kernel.org>,
        "Roberto Sassu" <roberto.sassu@huawei.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 13/25] security: Introduce inode_post_removexattr
 hook
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
        <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <dhowells@redhat.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <casey@schaufler-ca.com>
X-Mailer: aerc 0.14.0
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu Aug 31, 2023 at 1:41 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduc=
e
> the inode_post_removexattr hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e7bbb7f57557..4a0280295686 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  		goto out;
> =20
>  	error =3D __vfs_removexattr(idmap, dentry, name);
> +	if (error)
> +		goto out;
> =20
> -	if (!error) {
> -		fsnotify_xattr(dentry);
> -		evm_inode_post_removexattr(dentry, name);
> -	}
> +	fsnotify_xattr(dentry);
> +	security_inode_post_removexattr(dentry, name);
> +	evm_inode_post_removexattr(dentry, name);
> =20
>  out:
>  	return error;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 995d30336cfa..1153e7163b8b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -148,6 +148,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentr=
y, const char *name)
>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dent=
ry,
> +	 const char *name)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 820899db5276..665bba3e0081 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -374,6 +374,7 @@ int security_inode_getxattr(struct dentry *dentry, co=
nst char *name);
>  int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
> +void security_inode_post_removexattr(struct dentry *dentry, const char *=
name);
>  int security_inode_need_killpriv(struct dentry *dentry);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dent=
ry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -919,6 +920,10 @@ static inline int security_inode_removexattr(struct =
mnt_idmap *idmap,
>  	return cap_inode_removexattr(idmap, dentry, name);
>  }
> =20
> +static inline void security_inode_post_removexattr(struct dentry *dentry=
,
> +						   const char *name)
> +{ }

static inline void security_inode_post_removexattr(struct dentry *dentry, c=
onst char *name)
{
}

> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 764a6f28b3b9..3947159ba5e9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2354,6 +2354,20 @@ int security_inode_removexattr(struct mnt_idmap *i=
dmap,
>  	return evm_inode_removexattr(idmap, dentry, name);
>  }
> =20
> +/**
> + * security_inode_post_removexattr() - Update the inode after a removexa=
ttr op
> + * @dentry: file
> + * @name: xattr name
> + *
> + * Update the inode after a successful removexattr operation.
> + */
> +void security_inode_post_removexattr(struct dentry *dentry, const char *=
name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_removexattr, dentry, name);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() r=
equired
>   * @dentry: associated dentry
> --=20
> 2.34.1


These odd splits are everywhere in the patch set. Just (nit)picking some.

It is huge patch set so I don't really get for addign extra lines for no
good reason.

BR, Jarkko
