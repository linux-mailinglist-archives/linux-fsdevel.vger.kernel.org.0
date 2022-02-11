Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34454B2769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 14:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350663AbiBKNuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 08:50:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiBKNuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:50:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1417EB;
        Fri, 11 Feb 2022 05:50:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61BCD2113B;
        Fri, 11 Feb 2022 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644587407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGuJNXJGZSyflnvLXHKxKMtbUIf4xzev9d9R2yVwbxU=;
        b=iK48v1pYsZw9RRFz0s5BKk949I0j3cE3AxcVkmqspHcdA/u+uNXOHAxRsrjGrqxZA9fG7o
        /45H/ul2GRhrl4e8waGl7B+WH4abtLbp/d0yGeSwTdh7mNy6C2xwLilWTXImUKlpjIXdl3
        4SGRUyuVYezJV9+KDs2kLF6Uinvordk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644587407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGuJNXJGZSyflnvLXHKxKMtbUIf4xzev9d9R2yVwbxU=;
        b=hSpfhfjuReNJGJS1QohGSocP4SZM1sRoDA4SDtx+uEQx0O0gfpOEeI9YNxlFB+CKHnphY/
        YY6EJd1RxFJX16Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03D8213C8B;
        Fri, 11 Feb 2022 13:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3OnBOY5pBmIvGwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 11 Feb 2022 13:50:06 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 4bf56692;
        Fri, 11 Feb 2022 13:50:20 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 10/48] ceph: implement -o test_dummy_encryption
 mount option
References: <20220111191608.88762-1-jlayton@kernel.org>
        <20220111191608.88762-11-jlayton@kernel.org>
Date:   Fri, 11 Feb 2022 13:50:20 +0000
In-Reply-To: <20220111191608.88762-11-jlayton@kernel.org> (Jeff Layton's
        message of "Tue, 11 Jan 2022 14:15:30 -0500")
Message-ID: <87h795v7fn.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/crypto.c | 53 ++++++++++++++++++++++++++++++++
>  fs/ceph/crypto.h | 26 ++++++++++++++++
>  fs/ceph/inode.c  | 10 ++++--
>  fs/ceph/super.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/ceph/super.h  | 12 +++++++-
>  fs/ceph/xattr.c  |  3 ++
>  6 files changed, 177 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index a513ff373b13..017f31eacb74 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -4,6 +4,7 @@
>  #include <linux/fscrypt.h>
>=20=20
>  #include "super.h"
> +#include "mds_client.h"
>  #include "crypto.h"
>=20=20
>  static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t=
 len)
> @@ -64,9 +65,20 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
>  	return ci->i_rsubdirs + ci->i_rfiles =3D=3D 1;
>  }
>=20=20
> +void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
> +{
> +	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
> +}
> +
> +static const union fscrypt_policy *ceph_get_dummy_policy(struct super_bl=
ock *sb)
> +{
> +	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
> +}
> +
>  static struct fscrypt_operations ceph_fscrypt_ops =3D {
>  	.get_context		=3D ceph_crypt_get_context,
>  	.set_context		=3D ceph_crypt_set_context,
> +	.get_dummy_policy	=3D ceph_get_dummy_policy,
>  	.empty_dir		=3D ceph_crypt_empty_dir,
>  };
>=20=20
> @@ -74,3 +86,44 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
>  {
>  	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
>  }
> +
> +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> +				 struct ceph_acl_sec_ctx *as)
> +{
> +	int ret, ctxsize;
> +	bool encrypted =3D false;
> +	struct ceph_inode_info *ci =3D ceph_inode(inode);
> +
> +	ret =3D fscrypt_prepare_new_inode(dir, inode, &encrypted);
> +	if (ret)
> +		return ret;
> +	if (!encrypted)
> +		return 0;
> +
> +	as->fscrypt_auth =3D kzalloc(sizeof(*as->fscrypt_auth), GFP_KERNEL);
> +	if (!as->fscrypt_auth)
> +		return -ENOMEM;
> +

Isn't this memory allocation leaking bellow in the error paths?

(Yeah, I'm finally (but slowly) catching up with this series... my memory
is blurry and there are a lot of things I forgot...)

Cheers,
--=20
Lu=C3=ADs

> +	ctxsize =3D fscrypt_context_for_new_inode(as->fscrypt_auth->cfa_blob, i=
node);
> +	if (ctxsize < 0)
> +		return ctxsize;
> +
> +	as->fscrypt_auth->cfa_version =3D cpu_to_le32(CEPH_FSCRYPT_AUTH_VERSION=
);
> +	as->fscrypt_auth->cfa_blob_len =3D cpu_to_le32(ctxsize);
> +
> +	WARN_ON_ONCE(ci->fscrypt_auth);
> +	kfree(ci->fscrypt_auth);
> +	ci->fscrypt_auth_len =3D ceph_fscrypt_auth_len(as->fscrypt_auth);
> +	ci->fscrypt_auth =3D kmemdup(as->fscrypt_auth, ci->fscrypt_auth_len, GF=
P_KERNEL);
> +	if (!ci->fscrypt_auth)
> +		return -ENOMEM;
> +
> +	inode->i_flags |=3D S_ENCRYPTED;
> +
> +	return 0;
> +}
> +
> +void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct cep=
h_acl_sec_ctx *as)
> +{
> +	swap(req->r_fscrypt_auth, as->fscrypt_auth);
> +}
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 6dca674f79b8..cb00fe42d5b7 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -8,6 +8,10 @@
>=20=20
>  #include <linux/fscrypt.h>
>=20=20
> +struct ceph_fs_client;
> +struct ceph_acl_sec_ctx;
> +struct ceph_mds_request;
> +
>  struct ceph_fscrypt_auth {
>  	__le32	cfa_version;
>  	__le32	cfa_blob_len;
> @@ -25,12 +29,34 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_f=
scrypt_auth *fa)
>  #ifdef CONFIG_FS_ENCRYPTION
>  void ceph_fscrypt_set_ops(struct super_block *sb);
>=20=20
> +void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
> +
> +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> +				 struct ceph_acl_sec_ctx *as);
> +void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct cep=
h_acl_sec_ctx *as);
> +
>  #else /* CONFIG_FS_ENCRYPTION */
>=20=20
>  static inline void ceph_fscrypt_set_ops(struct super_block *sb)
>  {
>  }
>=20=20
> +static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client =
*fsc)
> +{
> +}
> +
> +static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct=
 inode *inode,
> +						struct ceph_acl_sec_ctx *as)
> +{
> +	if (IS_ENCRYPTED(dir))
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *r=
eq,
> +						struct ceph_acl_sec_ctx *as_ctx)
> +{
> +}
>  #endif /* CONFIG_FS_ENCRYPTION */
>=20=20
>  #endif
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index c6653f83b6f0..55e23e2601df 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -83,12 +83,17 @@ struct inode *ceph_new_inode(struct inode *dir, struc=
t dentry *dentry,
>  			goto out_err;
>  	}
>=20=20
> +	inode->i_state =3D 0;
> +	inode->i_mode =3D *mode;
> +
>  	err =3D ceph_security_init_secctx(dentry, *mode, as_ctx);
>  	if (err < 0)
>  		goto out_err;
>=20=20
> -	inode->i_state =3D 0;
> -	inode->i_mode =3D *mode;
> +	err =3D ceph_fscrypt_prepare_context(dir, inode, as_ctx);
> +	if (err)
> +		goto out_err;
> +
>  	return inode;
>  out_err:
>  	iput(inode);
> @@ -101,6 +106,7 @@ void ceph_as_ctx_to_req(struct ceph_mds_request *req,=
 struct ceph_acl_sec_ctx *a
>  		req->r_pagelist =3D as_ctx->pagelist;
>  		as_ctx->pagelist =3D NULL;
>  	}
> +	ceph_fscrypt_as_ctx_to_req(req, as_ctx);
>  }
>=20=20
>  /**
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index fbdf434b4618..0b32d31c6fe0 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -45,6 +45,7 @@ static void ceph_put_super(struct super_block *s)
>  	struct ceph_fs_client *fsc =3D ceph_sb_to_client(s);
>=20=20
>  	dout("put_super\n");
> +	ceph_fscrypt_free_dummy_policy(fsc);
>  	ceph_mdsc_close_sessions(fsc->mdsc);
>  }
>=20=20
> @@ -162,6 +163,7 @@ enum {
>  	Opt_copyfrom,
>  	Opt_wsync,
>  	Opt_pagecache,
> +	Opt_test_dummy_encryption,
>  };
>=20=20
>  enum ceph_recover_session_mode {
> @@ -189,6 +191,7 @@ static const struct fs_parameter_spec ceph_mount_para=
meters[] =3D {
>  	fsparam_string	("fsc",				Opt_fscache), // fsc=3D...
>  	fsparam_flag_no ("ino32",			Opt_ino32),
>  	fsparam_string	("mds_namespace",		Opt_mds_namespace),
> +	fsparam_string	("mon_addr",			Opt_mon_addr),
>  	fsparam_flag_no ("poolperm",			Opt_poolperm),
>  	fsparam_flag_no ("quotadf",			Opt_quotadf),
>  	fsparam_u32	("rasize",			Opt_rasize),
> @@ -200,7 +203,8 @@ static const struct fs_parameter_spec ceph_mount_para=
meters[] =3D {
>  	fsparam_u32	("rsize",			Opt_rsize),
>  	fsparam_string	("snapdirname",			Opt_snapdirname),
>  	fsparam_string	("source",			Opt_source),
> -	fsparam_string	("mon_addr",			Opt_mon_addr),
> +	fsparam_flag	("test_dummy_encryption",	Opt_test_dummy_encryption),
> +	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),
>  	fsparam_u32	("wsize",			Opt_wsize),
>  	fsparam_flag_no	("wsync",			Opt_wsync),
>  	fsparam_flag_no	("pagecache",			Opt_pagecache),
> @@ -576,6 +580,16 @@ static int ceph_parse_mount_param(struct fs_context =
*fc,
>  		else
>  			fsopt->flags &=3D ~CEPH_MOUNT_OPT_NOPAGECACHE;
>  		break;
> +	case Opt_test_dummy_encryption:
> +#ifdef CONFIG_FS_ENCRYPTION
> +		kfree(fsopt->test_dummy_encryption);
> +		fsopt->test_dummy_encryption =3D param->string;
> +		param->string =3D NULL;
> +		fsopt->flags |=3D CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
> +#else
> +		warnfc(fc, "FS encryption not supported: test_dummy_encryption mount o=
ption ignored");
> +#endif
> +		break;
>  	default:
>  		BUG();
>  	}
> @@ -596,6 +610,7 @@ static void destroy_mount_options(struct ceph_mount_o=
ptions *args)
>  	kfree(args->server_path);
>  	kfree(args->fscache_uniq);
>  	kfree(args->mon_addr);
> +	kfree(args->test_dummy_encryption);
>  	kfree(args);
>  }
>=20=20
> @@ -714,6 +729,8 @@ static int ceph_show_options(struct seq_file *m, stru=
ct dentry *root)
>  	if (fsopt->flags & CEPH_MOUNT_OPT_NOPAGECACHE)
>  		seq_puts(m, ",nopagecache");
>=20=20
> +	fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
> +
>  	if (fsopt->wsize !=3D CEPH_MAX_WRITE_SIZE)
>  		seq_printf(m, ",wsize=3D%u", fsopt->wsize);
>  	if (fsopt->rsize !=3D CEPH_MAX_READ_SIZE)
> @@ -1041,6 +1058,52 @@ static struct dentry *open_root_dentry(struct ceph=
_fs_client *fsc,
>  	return root;
>  }
>=20=20
> +#ifdef CONFIG_FS_ENCRYPTION
> +static int ceph_set_test_dummy_encryption(struct super_block *sb, struct=
 fs_context *fc,
> +						struct ceph_mount_options *fsopt)
> +{
> +	/*
> +	 * No changing encryption context on remount. Note that
> +	 * fscrypt_set_test_dummy_encryption will validate the version
> +	 * string passed in (if any).
> +	 */
> +	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
> +		struct ceph_fs_client *fsc =3D sb->s_fs_info;
> +		int err =3D 0;
> +
> +		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_p=
olicy.policy) {
> +			errorfc(fc, "Can't set test_dummy_encryption on remount");
> +			return -EEXIST;
> +		}
> +
> +		err =3D fscrypt_set_test_dummy_encryption(sb,
> +							fsc->mount_options->test_dummy_encryption,
> +							&fsc->dummy_enc_policy);
> +		if (err) {
> +			if (err =3D=3D -EEXIST)
> +				errorfc(fc, "Can't change test_dummy_encryption on remount");
> +			else if (err =3D=3D -EINVAL)
> +				errorfc(fc, "Value of option \"%s\" is unrecognized",
> +					fsc->mount_options->test_dummy_encryption);
> +			else
> +				errorfc(fc, "Error processing option \"%s\" [%d]",
> +					fsc->mount_options->test_dummy_encryption, err);
> +			return err;
> +		}
> +		warnfc(fc, "test_dummy_encryption mode enabled");
> +	}
> +	return 0;
> +}
> +#else
> +static inline int ceph_set_test_dummy_encryption(struct super_block *sb,=
 struct fs_context *fc,
> +						struct ceph_mount_options *fsopt)
> +{
> +	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC)
> +		warnfc(fc, "test_dummy_encryption mode ignored");
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * mount: join the ceph cluster, and open root directory.
>   */
> @@ -1069,6 +1132,10 @@ static struct dentry *ceph_real_mount(struct ceph_=
fs_client *fsc,
>  				goto out;
>  		}
>=20=20
> +		err =3D ceph_set_test_dummy_encryption(fsc->sb, fc, fsc->mount_options=
);
> +		if (err)
> +			goto out;
> +
>  		dout("mount opening path '%s'\n", path);
>=20=20
>  		ceph_fs_debugfs_init(fsc);
> @@ -1277,9 +1344,15 @@ static void ceph_free_fc(struct fs_context *fc)
>=20=20
>  static int ceph_reconfigure_fc(struct fs_context *fc)
>  {
> +	int err;
>  	struct ceph_parse_opts_ctx *pctx =3D fc->fs_private;
>  	struct ceph_mount_options *fsopt =3D pctx->opts;
> -	struct ceph_fs_client *fsc =3D ceph_sb_to_client(fc->root->d_sb);
> +	struct super_block *sb =3D fc->root->d_sb;
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(sb);
> +
> +	err =3D ceph_set_test_dummy_encryption(sb, fc, fsopt);
> +	if (err)
> +		return err;
>=20=20
>  	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
>  		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
> @@ -1293,7 +1366,7 @@ static int ceph_reconfigure_fc(struct fs_context *f=
c)
>  		pr_notice("ceph: monitor addresses recorded, but not used for reconnec=
tion");
>  	}
>=20=20
> -	sync_filesystem(fc->root->d_sb);
> +	sync_filesystem(sb);
>  	return 0;
>  }
>=20=20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 853577f8d772..042ea1f8e5c2 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -17,6 +17,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/refcount.h>
>  #include <linux/security.h>
> +#include <linux/fscrypt.h>
>=20=20
>  #include <linux/ceph/libceph.h>
>=20=20
> @@ -24,6 +25,8 @@
>  #include <linux/fscache.h>
>  #endif
>=20=20
> +#include "crypto.h"
> +
>  /* f_type in struct statfs */
>  #define CEPH_SUPER_MAGIC 0x00c36400
>=20=20
> @@ -46,6 +49,7 @@
>  #define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-=
from' op */
>  #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory =
ops */
>  #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altog=
ether */
> +#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<17) /* enable dummy encryptio=
n (for testing) */
>=20=20
>  #define CEPH_MOUNT_OPT_DEFAULT			\
>  	(CEPH_MOUNT_OPT_DCACHE |		\
> @@ -102,6 +106,7 @@ struct ceph_mount_options {
>  	char *server_path;    /* default NULL (means "/") */
>  	char *fscache_uniq;   /* default NULL */
>  	char *mon_addr;
> +	char *test_dummy_encryption;	/* default NULL */
>  };
>=20=20
>  struct ceph_fs_client {
> @@ -141,9 +146,11 @@ struct ceph_fs_client {
>  #ifdef CONFIG_CEPH_FSCACHE
>  	struct fscache_volume *fscache;
>  #endif
> +#ifdef CONFIG_FS_ENCRYPTION
> +	struct fscrypt_dummy_policy dummy_enc_policy;
> +#endif
>  };
>=20=20
> -
>  /*
>   * File i/o capability.  This tracks shared state with the metadata
>   * server that allows us to cache or writeback attributes or to read
> @@ -1083,6 +1090,9 @@ struct ceph_acl_sec_ctx {
>  #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
>  	void *sec_ctx;
>  	u32 sec_ctxlen;
> +#endif
> +#ifdef CONFIG_FS_ENCRYPTION
> +	struct ceph_fscrypt_auth *fscrypt_auth;
>  #endif
>  	struct ceph_pagelist *pagelist;
>  };
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index fcf7dfdecf96..5e3522457deb 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1380,6 +1380,9 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_c=
tx *as_ctx)
>  #endif
>  #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
>  	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> +#endif
> +#ifdef CONFIG_FS_ENCRYPTION
> +	kfree(as_ctx->fscrypt_auth);
>  #endif
>  	if (as_ctx->pagelist)
>  		ceph_pagelist_release(as_ctx->pagelist);
> --=20
>
> 2.34.1
>
