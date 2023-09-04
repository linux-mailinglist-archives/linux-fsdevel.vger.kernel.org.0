Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87B791EE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 23:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbjIDVKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIDVKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:10:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D3AB;
        Mon,  4 Sep 2023 14:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D98A8CE0F9B;
        Mon,  4 Sep 2023 21:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB6C433C7;
        Mon,  4 Sep 2023 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693861804;
        bh=7Y9LseJ8Ifb4Qe/c73MwbTJetx8TAAeqrdV7KuJsZM4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=fbR6MDUzYjIgnblyfLIyfVORPBbGiZo+VhH1UdDXOtbiR3BokmzPxgsnrriPbkCxA
         zMzYqAtccjAc0z+Zti90QUvuXBf+smw+q5591IPRmwvFDmdZGX6Uh7c2yqoGj+5VVd
         DgEnBCrediXuMNj6U0hTL9m4+0IdFJGdNqDlJwefZaap2dh270SD4YX5ljrKurds7Z
         y969BDgc1mc2CozKiIz1gX24hq/IZ04KKO2kC8QV8bQr8cRdcGUX/bXOE+lwHFUeAc
         ZHRuBaFRPw4qrLMB11LfWC2VCiiiTzLvDfztQEtePED2O434/kTlKsR+vSHHEm4QzL
         /7ZdGNIXy61wQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 00:09:56 +0300
Message-Id: <CVAFW71NZJ2X.EVVE8XAX3NS@suppilovahvero>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <selinux@vger.kernel.org>,
        "Roberto Sassu" <roberto.sassu@huawei.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 12/25] security: Introduce inode_post_setattr hook
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
 <20230831104136.903180-13-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230831104136.903180-13-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> the inode_post_setattr hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/attr.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 26 insertions(+)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 431f667726c7..3c309eb456c6 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -486,6 +486,7 @@ int notify_change(struct mnt_idmap *idmap, struct den=
try *dentry,
> =20
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> +		security_inode_post_setattr(idmap, dentry, ia_valid);
>  		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index fdf075a6b1bb..995d30336cfa 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -136,6 +136,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *de=
ntry, struct inode *inode,
>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
>  LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *=
dentry,
>  	 struct iattr *attr)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap=
,
> +	 struct dentry *dentry, int ia_valid)

LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap, s=
truct dentry *dentry,
	 int ia_valid)

>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dcb3604ffab8..820899db5276 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -355,6 +355,8 @@ int security_inode_follow_link(struct dentry *dentry,=
 struct inode *inode,
>  int security_inode_permission(struct inode *inode, int mask);
>  int security_inode_setattr(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr);
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry =
*dentry,
> +				 int ia_valid);

void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *de=
ntry, int ia_valid);

>  int security_inode_getattr(const struct path *path);
>  int security_inode_setxattr(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, const char *name,
> @@ -856,6 +858,11 @@ static inline int security_inode_setattr(struct mnt_=
idmap *idmap,
>  	return 0;
>  }
> =20
> +static inline void
> +security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dent=
ry,
> +			    int ia_valid)
> +{ }
> +
>  static inline int security_inode_getattr(const struct path *path)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 2b24d01cf181..764a6f28b3b9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2124,6 +2124,22 @@ int security_inode_setattr(struct mnt_idmap *idmap=
,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
> =20
> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr oper=
ation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry =
*dentry,
> +				 int ia_valid)

Ditto.

> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>  /**
>   * security_inode_getattr() - Check if getting file attributes is allowe=
d
>   * @path: file
> --=20
> 2.34.1


BR, Jarkko
