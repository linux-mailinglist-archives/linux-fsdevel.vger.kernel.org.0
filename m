Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD37F78EEA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbjHaN3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHaN3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DD1A2;
        Thu, 31 Aug 2023 06:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5ACC63C15;
        Thu, 31 Aug 2023 13:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92078C433C8;
        Thu, 31 Aug 2023 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693488556;
        bh=ProAnCVAsEOJqJLqWLI6Z5HJrWmgKlE/OQzrZS9TQWA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=irWlMBJ57cwMl1YC8KwGDqWh0I0TbRdXux9cd0LLxZapqBCgrkWkBpjwM1F1Js9M+
         LgqsRrWmO4i1r/kdxNWaSeNxnrNh/+m2xTZWbWEkVvozLZR0ioYpjp/MrIqZM+wlt7
         c7Z5sw0NFb7n7Jw0Cv+F97PVfb/NMKeJv/SsdrCkuouiCcBSN+ZS5L10jS0/RkmlfZ
         3/xsomghmJygOD/+hVKOsbcB0Qg3fGzyeEQBAUOTPkvghE2WG+b1zIfxCsmi2yLWAx
         foII5Wi2HuYwL3zJpRasim9xiWxuXlsMTmEYpDC0a0E0Ui6DtxFkdTYlS5lYkEosAH
         ib5H95ZgrENUw==
Message-ID: <2f121ee5b7fad547ac833a5e0e986866d1177e21.camel@kernel.org>
Subject: Re: [PATCH] NFS: switch back to using kill_anon_super
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, brauner@kernel.org
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org, jack@suse.cz,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 31 Aug 2023 09:29:14 -0400
In-Reply-To: <20230831052940.256193-1-hch@lst.de>
References: <20230831052940.256193-1-hch@lst.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-08-31 at 07:29 +0200, Christoph Hellwig wrote:
> NFS switch to open coding kill_anon_super in 7b14a213890a
> ("nfs: don't call bdi_unregister") to avoid the extra bdi_unregister
> call.  At that point bdi_destroy was called in nfs_free_server and
> thus it required a later freeing of the anon dev_t.  But since
> 0db10944a76b ("nfs: Convert to separately allocated bdi") the bdi has
> been free implicitly by the sb destruction, so this isn't needed
> anymore.
>=20
> By not open coding kill_anon_super, nfs now inherits the fix in
> dc3216b14160 ("super: ensure valid info"), and we remove the only
> open coded version of kill_anon_super.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/super.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 2284f749d89246..0d6473cb00cb3e 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1339,15 +1339,13 @@ int nfs_get_tree_common(struct fs_context *fc)
>  void nfs_kill_super(struct super_block *s)
>  {
>  	struct nfs_server *server =3D NFS_SB(s);
> -	dev_t dev =3D s->s_dev;
> =20
>  	nfs_sysfs_move_sb_to_server(server);
> -	generic_shutdown_super(s);
> +	kill_anon_super(s);
> =20
>  	nfs_fscache_release_super_cookie(s);
> =20
>  	nfs_free_server(server);
> -	free_anon_bdev(dev);
>  }
>  EXPORT_SYMBOL_GPL(nfs_kill_super);
> =20

Nice. Long overdue. This also might explain why ceph was once this way
before we changed it here:

    470a5c77eac0 ceph: use kill_anon_super helper

In any case:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
