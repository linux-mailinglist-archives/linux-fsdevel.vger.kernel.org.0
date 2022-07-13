Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BD573468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiGMKgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiGMKgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:36:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89217FD51D
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 03:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2298A614F0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A876C34114;
        Wed, 13 Jul 2022 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657708595;
        bh=G/h1QDFrPgsQQ61LF/5axZK/7oOIWsRyGyJwEKDaZ5k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cldi/EA2Y7zRA4UEJ0m7WKwSGBteNeyhUnHa2WZWjT5SpQbUhVv6nA3nhvuK2nJxS
         EcHXQdV9ucHt1PNxkdeaPCFZzeBLPBG6lUXh+MXJyDyZL93hDGQ5orVztRAeowzKWu
         0SyXYVElMeKCx/N/N5OcW3HQCG38gxAbR2dt2jtPaNhIDZO5sBEiqxMUjnEqfjn6th
         gcMDyn/JrEXjEtM6v8MHmHv+keIKRZttPk7cE36UFVKhMBeEs0Ln54CMgilFUmvq2d
         9DG8eBHz8foT24pFW2pN4dYEJYrJUSLB6kik8Pp0U4x96UFRWg3tWfdSJuAgcigO27
         NFLUPi989UyIw==
Message-ID: <4eb320f0fee86b259fd499cd2d97127922a57e66.camel@kernel.org>
Subject: Re: [PATCH v2] vfs: parse sloppy mount option in correct order
From:   Jeff Layton <jlayton@kernel.org>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Date:   Wed, 13 Jul 2022 06:36:33 -0400
In-Reply-To: <20220210094454.826716-1-rbergant@redhat.com>
References: <20220210094454.826716-1-rbergant@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-02-10 at 10:44 +0100, Roberto Bergantinos Corpas wrote:
> With addition of fs_context support, options string is parsed
> sequentially, if 'sloppy' option is not leftmost one, we may
> return ENOPARAM to userland if a non-valid option preceeds sloopy
> and mount will fail :
>=20
> host# mount -o quota,sloppy 172.23.1.225:/share /mnt
> mount.nfs: an incorrect mount option was specified
> host# mount -o sloppy,quota 172.23.1.225:/share /mnt
> host#
>=20
> This patch correct that behaviour so that sloppy takes precedence
> if specified anywhere on the string
>=20
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  fs/cifs/fs_context.c       |  4 ++--
>  fs/cifs/fs_context.h       |  1 -
>  fs/fs_context.c            | 14 ++++++++++++--
>  fs/nfs/fs_context.c        |  4 ++--
>  fs/nfs/internal.h          |  1 -
>  include/linux/fs_context.h |  2 ++
>  6 files changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> index 7ec35f3f0a5f..5a8c074df74a 100644
> --- a/fs/cifs/fs_context.c
> +++ b/fs/cifs/fs_context.c
> @@ -866,7 +866,7 @@ static int smb3_fs_context_parse_param(struct fs_cont=
ext *fc,
>  	if (!skip_parsing) {
>  		opt =3D fs_parse(fc, smb3_fs_parameters, param, &result);
>  		if (opt < 0)
> -			return ctx->sloppy ? 1 : opt;
> +			return fc->sloppy ? 1 : opt;
>  	}
> =20
>  	switch (opt) {
> @@ -1412,7 +1412,7 @@ static int smb3_fs_context_parse_param(struct fs_co=
ntext *fc,
>  		ctx->multiuser =3D true;
>  		break;
>  	case Opt_sloppy:
> -		ctx->sloppy =3D true;
> +		fc->sloppy =3D true;
>  		break;
>  	case Opt_nosharesock:
>  		ctx->nosharesock =3D true;
> diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
> index e54090d9ef36..52a67a96fb67 100644
> --- a/fs/cifs/fs_context.h
> +++ b/fs/cifs/fs_context.h
> @@ -155,7 +155,6 @@ struct smb3_fs_context {
>  	bool uid_specified;
>  	bool cruid_specified;
>  	bool gid_specified;
> -	bool sloppy;
>  	bool got_ip;
>  	bool got_version;
>  	bool got_rsize;
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 24ce12f0db32..2f9284e53589 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -155,8 +155,15 @@ int vfs_parse_fs_param(struct fs_context *fc, struct=
 fs_parameter *param)
>  	if (ret !=3D -ENOPARAM)
>  		return ret;
> =20
> -	return invalf(fc, "%s: Unknown parameter '%s'",
> -		      fc->fs_type->name, param->key);
> +	/* We got an invalid parameter, but sloppy may have been specified
> +	 * later on param string.
> +	 * Let's wait to process whole params to return EINVAL.
> +	 */
> +
> +	fc->param_inval =3D true;
> +	errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key)=
;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(vfs_parse_fs_param);
> =20
> @@ -227,6 +234,9 @@ int generic_parse_monolithic(struct fs_context *fc, v=
oid *data)
>  		}
>  	}
> =20
> +	if (!fc->sloppy && fc->param_inval)
> +		ret =3D -EINVAL;
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(generic_parse_monolithic);
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index ea17fa1f31ec..c9ff68e17b68 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -482,7 +482,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
> =20
>  	opt =3D fs_parse(fc, nfs_fs_parameters, param, &result);
>  	if (opt < 0)
> -		return ctx->sloppy ? 1 : opt;
> +		return fc->sloppy ? 1 : opt;
> =20
>  	if (fc->security)
>  		ctx->has_sec_mnt_opts =3D 1;
> @@ -837,7 +837,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		 * Special options
>  		 */
>  	case Opt_sloppy:
> -		ctx->sloppy =3D true;
> +		fc->sloppy =3D true;
>  		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
>  		break;
>  	}
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 12f6acb483bb..9febdc95b4d0 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -80,7 +80,6 @@ struct nfs_fs_context {
>  	bool			internal;
>  	bool			skip_reconfig_option_check;
>  	bool			need_mount;
> -	bool			sloppy;
>  	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
>  	unsigned int		rsize, wsize;
>  	unsigned int		timeo, retrans;
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 13fa6f3df8e4..06a4b72a0f98 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -110,6 +110,8 @@ struct fs_context {
>  	bool			need_free:1;	/* Need to call ops->free() */
>  	bool			global:1;	/* Goes into &init_user_ns */
>  	bool			oldapi:1;	/* Coming from mount(2) */
> +	bool                    sloppy:1;       /* If fs support it and was spe=
cified */
> +	bool                    param_inval:1;  /* If set, check sloppy value *=
/
>  };
> =20
>  struct fs_context_operations {

This looks like it will do the right thing. We definitely _don't_ want
order-dependent option parsing.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
