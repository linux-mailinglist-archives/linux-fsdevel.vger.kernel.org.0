Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E795962E63C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiKQVBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 16:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiKQVBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382271004D;
        Thu, 17 Nov 2022 13:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C453E6223F;
        Thu, 17 Nov 2022 21:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B04C433C1;
        Thu, 17 Nov 2022 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668718903;
        bh=pK84Oh+46qGlbj35Fr/fiQAsI8PUo07QeOABAKvF8PQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZCMFoS4Q5IRm3PIqnwqena3O+EzT5bxvElqtPEk0o/uiFZG4rloq3U+xuL2cekRGB
         lbsbQxBrjNjWm4c/5iC8INH3e/4E1/xw2b1MnxkAhRwBSbIiTFVnG9KlrcH3ELnYuQ
         g4/4vdfdR+qQrxh1BQscyEmC7a+L+4OcWtqxYKKYXr4nGFfgMen/C/AsyBbcZ7cO2u
         FJ3V6g7VkAq9wWjpotrujtpzlbnBtOvXFbcze8b/BAHwfla6I8kSZv+2PWFlqGoiAf
         nbSTtd0461JVEIV+TGzzJ8imKrlz2Mr1Dd6Afqbinrk1O9oByPojdxdqcVA87JP7hB
         j4oD+UmKf/fWg==
Message-ID: <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
Subject: Re: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto
 mounts
From:   Jeff Layton <jlayton@kernel.org>
To:     Richard Weinberger <richard@nod.at>, linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at
Date:   Thu, 17 Nov 2022 16:01:40 -0500
In-Reply-To: <20221117191151.14262-3-richard@nod.at>
References: <20221117191151.14262-1-richard@nod.at>
         <20221117191151.14262-3-richard@nod.at>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-11-17 at 20:11 +0100, Richard Weinberger wrote:
> This function is only used by NFSD to cross mount points.
> If a mount point is of type auto mount, follow_down() will
> not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
> to have ->d_automount() called when NFSD walks down the
> mount tree.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 578c2110df02..000c4b84e6be 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1462,7 +1462,7 @@ int follow_down(struct path *path)
>  {
>  	struct vfsmount *mnt =3D path->mnt;
>  	bool jumped;
> -	int ret =3D traverse_mounts(path, &jumped, NULL, 0);
> +	int ret =3D traverse_mounts(path, &jumped, NULL, LOOKUP_AUTOMOUNT);
> =20
>  	if (path->mnt !=3D mnt)
>  		mntput(mnt);


What happens when CROSSMOUNT isn't enabled and someone tries to stroll
into an automount point? I'm guessing the automount happens but the
export is denied? It seems like LOOKUP_AUTOMOUNT ought to be conditional
on the parent export having CROSSMOUNT set.

There's also another caller of follow_down too, the UNIX98 pty code.
This may be harmless for it, but it'd be best not to perturb that if we
can help it.

Maybe follow_down can grow a lookupflags argument?
--=20
Jeff Layton <jlayton@kernel.org>
