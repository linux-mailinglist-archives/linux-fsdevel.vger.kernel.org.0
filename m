Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A086581B0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbiGZU2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 16:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiGZU2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:28:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248832EEA;
        Tue, 26 Jul 2022 13:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEB94B8191D;
        Tue, 26 Jul 2022 20:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC58FC433D6;
        Tue, 26 Jul 2022 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658867278;
        bh=KnueVrE+igYsfkQX3nJiPPysZTJsSWq9qcOK5teA/7Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fe3cv0Jycq1X0+CLJN0jTG7V1cgt+LjIpWDcXg/WEqiUqyB9sV0afXJn9fdRtrKSG
         NBC78v4LWv1JwcVTMdZC7a8pz9B0GKlLjDqp4gfmK+26fMj2IExPaHNc185sCOz73p
         4VIDNUUk/Q1j8CATvScAj3CIwH7Xvtt+gCyh88iB3EiRQZbMAYW2srcR6osj2ocjGQ
         P0UZDg53WvOMpphMTCwv261XceNWZulBdWj0yUYRsWe1aQNZXYRWkIegJk5Tt4iEXE
         4GwLOG4zm0BEzdlc/65YevxuTmXQCW5zbSa9cpVluqd31jpgivzqVmnoiBqTxI6vod
         e849adF8NZDZQ==
Message-ID: <8e4d498a3e8ed80ada2d3da01e7503e082be31a3.camel@kernel.org>
Subject: Re: [RFC PATCH] vfs: don't check may_create_in_sticky if the file
 is already open/created
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Yongchen Yang <yoyang@redhat.com>
Date:   Tue, 26 Jul 2022 16:27:56 -0400
In-Reply-To: <20220726202333.165490-1-jlayton@kernel.org>
References: <20220726202333.165490-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-07-26 at 16:23 -0400, Jeff Layton wrote:
> NFS server is exporting a sticky directory (mode 01777) with root
> squashing enabled. Client has protect_regular enabled and then tries to
> open a file as root in that directory. File is created (with ownership
> set to nobody:nobody) but the open syscall returns an error.
>=20
> The problem is may_create_in_sticky, which rejects the open even though
> the file has already been created/opened. Only call may_create_in_sticky
> if the file hasn't already been opened or created.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1976829
> Reported-by: Yongchen Yang <yoyang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f28d3f463c3..7480b6dc8d27 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3495,10 +3495,15 @@ static int do_open(struct nameidata *nd,
>  			return -EEXIST;
>  		if (d_is_dir(nd->path.dentry))
>  			return -EISDIR;
> -		error =3D may_create_in_sticky(mnt_userns, nd,
> -					     d_backing_inode(nd->path.dentry));
> -		if (unlikely(error))
> -			return error;
> +		if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> +			error =3D may_create_in_sticky(mnt_userns, nd,
> +						d_backing_inode(nd->path.dentry));
> +			if (unlikely(error)) {
> +				printk("%s: f_mode=3D0x%x oflag=3D0x%x\n",
> +					__func__, file->f_mode, open_flag);
> +				return error;
> +			}
> +		}
>  	}
>  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
>  		return -ENOTDIR;

I'm pretty sure this patch is the wrong approach, actually, since it
doesn't fix the regular (non-atomic) open codepath. Any thoughts on what
the right fix might be?
--=20
Jeff Layton <jlayton@kernel.org>
