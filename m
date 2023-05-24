Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D753670F9CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjEXPI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjEXPI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65315E9;
        Wed, 24 May 2023 08:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02168617BC;
        Wed, 24 May 2023 15:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E26C4339B;
        Wed, 24 May 2023 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684940905;
        bh=GdLsUpZLBsirJz5igIaN9pF2KdmoAUOlg0CNCDZnHJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bx/B4HQwk71OSt26yCE1us7+xXVm5qEDVjMsElT1waCCyVqJwmHmTFMXGkBbJo4Yh
         gyrhHoxJVvdxQv2GbjKsUkRIPmrgSxiInD6cU7BQeBQBaEETcZVhfTlx+jln36fCNB
         qAxKzDN7WP0OlhVa3jt/5ocFdpn6S4cJ2L/maDpn0bVCq7l04xmYthSmygKjVBXv0O
         in2NOfGb/X7/C4ZVnuxt08a8uNMq1ar3zVZNHw11DMCBk91PbtUqMtkpeMXMJH007j
         gKwp3Oic2dxAckS/4cYKzd76xv1iMjRUvQQD56LJngAbXdL/D9JIkC5rAQ93XwTJ+w
         7/vrQJBLJ9Ykg==
Message-ID: <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 24 May 2023 11:08:23 -0400
In-Reply-To: <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
         <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
> Remove the check for F_WRLCK in generic_add_lease to allow file_lock
> to be used for write delegation.
>=20
> First consumer is NFSD.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/locks.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index df8b26a42524..08fb0b4fd4f8 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, str=
uct file_lock **flp, void **pr
>  	if (is_deleg && !inode_trylock(inode))
>  		return -EAGAIN;
> =20
> -	if (is_deleg && arg =3D=3D F_WRLCK) {
> -		/* Write delegations are not currently supported: */
> -		inode_unlock(inode);
> -		WARN_ON_ONCE(1);
> -		return -EINVAL;
> -	}
> -
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
>  	time_out_leases(inode, &dispose);

I'd probably move this back to the first patch in the series.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
