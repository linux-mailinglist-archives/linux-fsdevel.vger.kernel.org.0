Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801777924D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjIEP7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354341AbjIEKvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:51:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B717199;
        Tue,  5 Sep 2023 03:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9300DCE0EF6;
        Tue,  5 Sep 2023 10:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A9BC433C8;
        Tue,  5 Sep 2023 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693911051;
        bh=yD0nOFI3AHIspQ0BVMts4LTJ14tPisnv0XLYMGOPUFs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lOOniKToqYwPSVDqLEKMkYNzh/3SDLO9EpAcKcmy2kbFNzLMRlyzn1s3cxVeKco4s
         gFJqN65OhRkQzPYf+K/DlxNjCBKjd9byFG+4E3uFKnl6MemPsXG3qNbPKWE+C8u9CJ
         I64DroXrUXiWBWxsOW2zJH4pd98hVeS0verJlcFRjFznkUhtV3tstPY0nwOSFSMo66
         VluVaV0f0ai1grF40pLEP97SD2HZ+g68hYZyuxq7O1fplc1e8O0RkkQjrxEPw6xqTw
         M1EVQJvbMKCERsp8NI3XUUhm4nlkcaD5SIsVT4Klnr8zq34BBkZ38QP8zh2dGYMD7t
         cuiU7aNe+381Q==
Message-ID: <72b43294c85fb7dee01d976da606c5b792c5b430.camel@kernel.org>
Subject: Re: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Sep 2023 06:50:49 -0400
In-Reply-To: <TYCPR01MB11847DEDE49FD02AD9F771971D9E9A@TYCPR01MB11847.jpnprd01.prod.outlook.com>
References: <20230516124655.82283-1-jlayton@kernel.org>
         <TYCPR01MB11847DEDE49FD02AD9F771971D9E9A@TYCPR01MB11847.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-09-04 at 20:36 +0000, Ondrej Valousek wrote:
> Hi Jeff,
>=20
> I can confirm that with rawhide kernel 6.5 the error is gone, i.e.
>=20
> Listxattr() shows only "system.nfs4_acl" attribute on NFSv4 filesystem,
>=20
> Problem is, that (on the same kernel) getxattr(name,XATTR_NAME_POSIX_ACL_=
ACCESS, 0,0)
> Sets errno to ENODATA where "name" is file on NFSv4.
>=20
> This is different behavior to the previous versions, i.e. on RHEL8 getxat=
tr() sets errno to ENOTSUP in the same scenario - which is what I'd expect =
more.
>=20
> Is the change of the getxattr() behavior expected or not?
>=20
> Thanks,
> Ondrej
>=20

I'd say not. I've been working through xfstests failures on NFS and
didn't realize that this was a regression, and posted this fstests patch
recently:

    https://lore.kernel.org/fstests/20230830-fixes-v4-1-88d7b8572aa3@kernel=
.org/

It would be nice if getxattr were also fixed here.

Cheers,
Jeff

> -----Original Message-----
> From: Jeff Layton <jlayton@kernel.org>=20
> Sent: Dienstag, 16. Mai 2023 14:47
> To: Alexander Viro <viro@zeniv.linux.org.uk>; Christian Brauner <brauner@=
kernel.org>
> Cc: trondmy@hammerspace.com; eggert@cs.ucla.edu; bruno@clisp.org; Ondrej =
Valousek <ondrej.valousek.xm@renesas.com>; linux-fsdevel@vger.kernel.org; l=
inux-kernel@vger.kernel.org
> Subject: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr
>=20
> Commit f2620f166e2a caused the kernel to start emitting POSIX ACL xattrs =
for NFSv4 inodes, which it doesn't support. The only other user of generic_=
listxattr is HFS (classic) and it doesn't support POSIX ACLs either.
>=20
> Fixes: f2620f166e2a xattr: simplify listxattr helpers
> Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xattr.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index fcf67d80d7f9..e7bbb7f57557 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -985,9 +985,16 @@ int xattr_list_one(char **buffer, ssize_t *remaining=
_size, const char *name)
>  	return 0;
>  }
> =20
> -/*
> +/**
> + * generic_listxattr - run through a dentry's xattr list() operations
> + * @dentry: dentry to list the xattrs
> + * @buffer: result buffer
> + * @buffer_size: size of @buffer
> + *
>   * Combine the results of the list() operation from every xattr_handler =
in the
> - * list.
> + * xattr_handler stack.
> + *
> + * Note that this will not include the entries for POSIX ACLs.
>   */
>  ssize_t
>  generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_siz=
e) @@ -996,10 +1003,6 @@ generic_listxattr(struct dentry *dentry, char *buf=
fer, size_t buffer_size)
>  	ssize_t remaining_size =3D buffer_size;
>  	int err =3D 0;
> =20
> -	err =3D posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_size);
> -	if (err)
> -		return err;
> -
>  	for_each_xattr_handler(handlers, handler) {
>  		if (!handler->name || (handler->list && !handler->list(dentry)))
>  			continue;
> --
> 2.40.1
>=20

--=20
Jeff Layton <jlayton@kernel.org>
