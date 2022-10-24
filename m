Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA5609F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJXKxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 06:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXKxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:53:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570525A17F;
        Mon, 24 Oct 2022 03:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 070E3B810E5;
        Mon, 24 Oct 2022 10:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12ADC433C1;
        Mon, 24 Oct 2022 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666608828;
        bh=v7rB+owjUI2XRngBv9CTZ1gWDKmDyAWdqguhZux8HmA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fiZnhN3PswtxXCKH8SLyd7AF3gQN9pVHS1SsekNPE4h/XZ5cF2dFl/wW/isGjG/3U
         4x4kb6pVFaIlOFXs61Lj7p/0PWlpWB0gLXWFPv2IL7Rrkz43Ibuy+lLSzQOx9Bhxsy
         2M+/bQRDbGtWFmkcKZTOSHFplPT7UTKcYrOHJFfKUiIOTfRbfOjZBzmUoiUac2ouC+
         VLg3bnSfzjqoGVse7EwZBda/kSZSailffdxtv3A+rFmmBruP+cB2a2BxwZsyk9fTMq
         cS2JcOVGxqPCk/g9crKzfxR0iQ2BsFZwwZQAN91ZmYq9f/JHyOsm0xsZ5+d8UyM/B2
         eZaeM9R4VJXDw==
Message-ID: <627dd3b048812fe8127058a66fd5a4aafca8242a.camel@kernel.org>
Subject: Re: [PATCH -next 2/5] nfs: fix possible null-ptr-deref when parsing
 param
From:   Jeff Layton <jlayton@kernel.org>
To:     Hawkins Jiawei <yin31149@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 24 Oct 2022 06:53:46 -0400
In-Reply-To: <20221023163945.39920-3-yin31149@gmail.com>
References: <20221023163945.39920-1-yin31149@gmail.com>
         <20221023163945.39920-3-yin31149@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-10-24 at 00:39 +0800, Hawkins Jiawei wrote:
> According to commit "vfs: parse: deal with zero length string value",
> kernel will set the param->string to null pointer in vfs_parse_fs_string(=
)
> if fs string has zero length.
>=20
> Yet the problem is that, nfs_fs_context_parse_param() will dereferences t=
he
> param->string, without checking whether it is a null pointer, which may
> trigger a null-ptr-deref bug.
>=20
> This patch solves it by adding sanity check on param->string
> in nfs_fs_context_parse_param().
>=20
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  fs/nfs/fs_context.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 4da701fd1424..0c330bc13ef2 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -684,6 +684,8 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  			return ret;
>  		break;
>  	case Opt_vers:
> +		if (!param->string)
> +			goto out_invalid_value;
>  		trace_nfs_mount_assign(param->key, param->string);
>  		ret =3D nfs_parse_version_string(fc, param->string);
>  		if (ret < 0)
> @@ -696,6 +698,8 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		break;
> =20
>  	case Opt_proto:
> +		if (!param->string)
> +			goto out_invalid_value;
>  		trace_nfs_mount_assign(param->key, param->string);
>  		protofamily =3D AF_INET;
>  		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) =
{
> @@ -732,6 +736,8 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
>  		break;
> =20
>  	case Opt_mountproto:
> +		if (!param->string)
> +			goto out_invalid_value;
>  		trace_nfs_mount_assign(param->key, param->string);
>  		mountfamily =3D AF_INET;
>  		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) =
{


Looks reasonable. I took a quick look for other fsparam_string values
that might not handle a NULL pointer correctly, but I didn't see any.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
