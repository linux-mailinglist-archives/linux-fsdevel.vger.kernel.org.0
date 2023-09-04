Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF69791ED6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjIDVIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIDVIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421A1B6;
        Mon,  4 Sep 2023 14:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 704D261708;
        Mon,  4 Sep 2023 21:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CF9C433C8;
        Mon,  4 Sep 2023 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693861729;
        bh=c/K0v1f1fOXVzFbawIYNQ7qFhq1at121qQ4pgUfYVaU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=q0BatMXZee/hoOID0g6Y+zDdWfb54DoZlDDmyQKupB+mJxT5Q26glReDoLfGI3AU8
         GG2PAkZBxyEVSgIGMEq7rrKvLqG38c6FNhfSgtCtKY1AcS9V0Mgqya7KVg4d6p1Cbh
         YipxbCju6etroCrF/7BDJWy+xm65bqKyMlm4wmiExXeV8bOEcJRgpwquvrxRZL/LaY
         pZ1IKjRk0l9BW30p4tIKLP7IML1F3jzlMkW3gBd4aonK5oZJVDF/PEiV5Hb6bZpDsZ
         lM6p+nPfSqbOHBvTU41hKVXSj2+fZIcdcxcvDaTw0Ib7VjIKiInwRu2eHAfd7E2mge
         Mk/WF2xYAlJqg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 00:08:43 +0300
Message-Id: <CVAFV92MONCH.257Y9YQ3OEU4B@suppilovahvero>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <selinux@vger.kernel.org>,
        "Roberto Sassu" <roberto.sassu@huawei.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 11/25] security: Align inode_setattr hook definition
 with EVM
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
 <20230831104136.903180-12-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230831104136.903180-12-roberto.sassu@huaweicloud.com>
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
> Add the idmap parameter to the definition, so that evm_inode_setattr() ca=
n
> be registered as this hook implementation.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hook_defs.h | 3 ++-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 3 ++-
>  security/smack/smack_lsm.c    | 4 +++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 4bdddb52a8fe..fdf075a6b1bb 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -134,7 +134,8 @@ LSM_HOOK(int, 0, inode_readlink, struct dentry *dentr=
y)
>  LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode =
*inode,
>  	 bool rcu)
>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
> -LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *att=
r)
> +LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *=
dentry,
> +	 struct iattr *attr)

LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *den=
try, struct iattr *attr)

Only 99 characters, i.e. breaking into two lines is not necessary.

>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/security/security.c b/security/security.c
> index cb6242feb968..2b24d01cf181 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2117,7 +2117,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
> =20
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	ret =3D call_int_hook(inode_setattr, 0, dentry, attr);
> +	ret =3D call_int_hook(inode_setattr, 0, idmap, dentry, attr);
>  	if (ret)
>  		return ret;
>  	return evm_inode_setattr(idmap, dentry, attr);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ee7c49c2cfd3..bfcc4d9aa5ab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3075,7 +3075,8 @@ static int selinux_inode_permission(struct inode *i=
node, int mask)
>  	return rc;
>  }
> =20
> -static int selinux_inode_setattr(struct dentry *dentry, struct iattr *ia=
ttr)
> +static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry =
*dentry,
> +				 struct iattr *iattr)
>  {
>  	const struct cred *cred =3D current_cred();
>  	struct inode *inode =3D d_backing_inode(dentry);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 679156601a10..89f2669d50a9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1181,12 +1181,14 @@ static int smack_inode_permission(struct inode *i=
node, int mask)
> =20
>  /**
>   * smack_inode_setattr - Smack check for setting attributes
> + * @idmap: idmap of the mount
>   * @dentry: the object
>   * @iattr: for the force flag
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_setattr(struct dentry *dentry, struct iattr *iatt=
r)
> +static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *d=
entry,
> +			       struct iattr *iattr)

static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *dent=
ry, struct iattr *iattr)

Can be still in a single line (100 characters exactly).


>  {
>  	struct smk_audit_info ad;
>  	int rc;
> --=20
> 2.34.1


BR, Jarkko
