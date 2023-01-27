Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6C67E2E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjA0LOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 06:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjA0LO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F613519
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 03:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674818020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T3l0J0UinmjdVIL92SoZoP9qVR5G6gLjIHVlY/tDsY=;
        b=SqDgm3h97mAfaQPwG/Sw5IWh247Ma+cmabktZTJYhIeo4UzSHzNbiRSMZPxRzf0/n6aYW4
        ULLO5+FMspksOINzHj28lA8/j1pq6wNU549ge7fSL+jNaHVdgLbObbhcxGptiNpeXzemQc
        znpNV382xWnSYopcbfNUvsB4juZSwNs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-S3X6HEBRM8q9ej2FCCmt-A-1; Fri, 27 Jan 2023 06:13:37 -0500
X-MC-Unique: S3X6HEBRM8q9ej2FCCmt-A-1
Received: by mail-qk1-f199.google.com with SMTP id j10-20020a05620a288a00b0070630ecfd9bso2811901qkp.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 03:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1T3l0J0UinmjdVIL92SoZoP9qVR5G6gLjIHVlY/tDsY=;
        b=wb2THIzgdqpdbC0412ykyhTMYfa8i39UNg6D/bmLU15IXI56dSygnTT7YCdJx9HdVv
         aUEj+FZBXyCqRoen+FL+8+VGWxeUh3TXhuxXoPwXnFph1kI5+iaVFu0TTvB7WCyQqnsf
         E2qqs9LKal33AM4rl5ixQPFfeQ4/xr8ZFK3q0K4yQiHhcqHSR5GURVR6Er+DdJAmakAc
         xKQY9RbyTeidJ9tt7wELscqIp02bNro8R1KGXIWu9mR2IOc6nTuVVtf9PJcG4UnyTAC4
         f+mK+2QOsK4kKxHe+hQj9BCU008RS8yjtP26jCt4oAak1Su9pd92RnYCXueVCcWAPryN
         PJXA==
X-Gm-Message-State: AFqh2kppmpb8IGYuFdE3a6Hvc0WfA7HClScrZGdv+kQVvAs+tFpsttkP
        DD6+BvRn3jH/AsA5GtPLOMA7p0OEU/uwUnUp7UZ7But5xYUW/A069y9NlSvjsH8Ne70yYeSVrTk
        pVjNbjdEJKcjE1OisbjcnawdmPg==
X-Received: by 2002:a05:6214:3c88:b0:535:54ab:16a3 with SMTP id ok8-20020a0562143c8800b0053554ab16a3mr51822490qvb.45.1674818016538;
        Fri, 27 Jan 2023 03:13:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuXFIWEponDCw/N8IxhQ8sfn+0efm/HOuhAWzS7r2hIRFsXIlF4IzozvtJcCyEtL8KlXxK4Pw==
X-Received: by 2002:a05:6214:3c88:b0:535:54ab:16a3 with SMTP id ok8-20020a0562143c8800b0053554ab16a3mr51822457qvb.45.1674818016219;
        Fri, 27 Jan 2023 03:13:36 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id pj4-20020a05620a1d8400b0070648cf78bdsm2659198qkn.54.2023.01.27.03.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:13:35 -0800 (PST)
Message-ID: <148c5edccd0f26851d9fe7883e9025383f4399eb.camel@redhat.com>
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
From:   Jeff Layton <jlayton@redhat.com>
To:     Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs-list <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Fri, 27 Jan 2023 06:13:34 -0500
In-Reply-To: <166432738753.7008.13932358518650344215.stgit@donald.themaw.net>
References: <166432738753.7008.13932358518650344215.stgit@donald.themaw.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-09-28 at 09:09 +0800, Ian Kent wrote:
> From: Roberto Bergantinos Corpas <rbergant@redhat.com>
>=20
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
> changes since v1:
> - add a boolean to fs context and postpone error reporting until
>   parsing is done.
>=20
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  fs/cifs/fs_context.c       |    4 ++--
>  fs/cifs/fs_context.h       |    1 -
>  fs/fs_context.c            |   14 ++++++++++++--
>  fs/nfs/fs_context.c        |    5 +++--
>  fs/nfs/internal.h          |    1 -
>  include/linux/fs_context.h |    2 ++
>  6 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> index 0e13dec86b25..32c3fdd7d27a 100644
> --- a/fs/cifs/fs_context.c
> +++ b/fs/cifs/fs_context.c
> @@ -864,7 +864,7 @@ static int smb3_fs_context_parse_param(struct fs_cont=
ext *fc,
>  	if (!skip_parsing) {
>  		opt =3D fs_parse(fc, smb3_fs_parameters, param, &result);
>  		if (opt < 0)
> -			return ctx->sloppy ? 1 : opt;
> +			return fc->sloppy ? 1 : opt;
>  	}
> =20
>  	switch (opt) {
> @@ -1420,7 +1420,7 @@ static int smb3_fs_context_parse_param(struct fs_co=
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
> index bbaee4c2281f..75e4c41466fa 100644
> --- a/fs/cifs/fs_context.h
> +++ b/fs/cifs/fs_context.h
> @@ -157,7 +157,6 @@ struct smb3_fs_context {
>  	bool uid_specified;
>  	bool cruid_specified;
>  	bool gid_specified;
> -	bool sloppy;
>  	bool got_ip;
>  	bool got_version;
>  	bool got_rsize;
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index df04e5fc6d66..911a36bf2226 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -157,8 +157,15 @@ int vfs_parse_fs_param(struct fs_context *fc, struct=
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

Is it correct to store an error message when we don't know whether
"sloppy" has been specified yet?

> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(vfs_parse_fs_param);
> =20
> @@ -234,6 +241,9 @@ int generic_parse_monolithic(struct fs_context *fc, v=
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
> index 4da701fd1424..09da63cc84f7 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -485,7 +485,7 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
> =20
>  	opt =3D fs_parse(fc, nfs_fs_parameters, param, &result);
>  	if (opt < 0)
> -		return (opt =3D=3D -ENOPARAM && ctx->sloppy) ? 1 : opt;
> +		return (opt =3D=3D -ENOPARAM && fc->sloppy) ? 1 : opt;
> =20
>  	if (fc->security)
>  		ctx->has_sec_mnt_opts =3D 1;
> @@ -853,7 +853,8 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		 * Special options
>  		 */
>  	case Opt_sloppy:
> -		ctx->sloppy =3D true;
> +		fc->sloppy =3D true;
> +		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
>  		break;
>  	}
> =20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 898dd95bc7a7..83552def96f1 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -90,7 +90,6 @@ struct nfs_fs_context {
>  	bool			internal;
>  	bool			skip_reconfig_option_check;
>  	bool			need_mount;
> -	bool			sloppy;
>  	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
>  	unsigned int		rsize, wsize;
>  	unsigned int		timeo, retrans;
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index ff1375a16c8c..d91d42bc06ce 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -111,6 +111,8 @@ struct fs_context {
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
>=20
>=20

Overall, the patch looks reasonable though.
--=20
Jeff Layton <jlayton@redhat.com>

