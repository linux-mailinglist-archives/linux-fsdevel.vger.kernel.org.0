Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54470AF0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEUQ17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUQ16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 12:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9DB4;
        Sun, 21 May 2023 09:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B70E60E15;
        Sun, 21 May 2023 16:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFFDC433EF;
        Sun, 21 May 2023 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684686476;
        bh=ezcC03D6qNensIl7RDYImsdZMumFQsWIa23jQZlcEcM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MjQ7ncxQMFO199nKOeIpMmODoEEzPBrOf67/URtfhYld8GM7Kfm8pynZyAgiWXlrL
         rnwE6Jx8rLr505iCakxhFcZnw9dZpmImxwIu0OQm4ZCOFEYvaaLp6ntOJhRb6VGQmi
         sFXi3SIh2nJnBbLed3yHFSn79V/qz/1+surY8F1gJywQebVGi/IJSj8dhC+gvFONlR
         aiR0P+gWqlLuidpoIVyiN3pTPtDhBNa5rz3bsx/9as+Jcg4Hf0c1ne7Vstlfkz01QD
         8WobaG04g2bJYeFSCoyZh4OFs+Qa8vPDdI12E1GvoQ19gOEbdz8tLR0ej/LqVV1bRo
         TATHpnBB52Zog==
Message-ID: <b22be4600aec37a3926b814343f331d2783984d7.camel@kernel.org>
Subject: Re: [PATCH v4 1/4] locks: allow support for write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Sun, 21 May 2023 12:27:54 -0400
In-Reply-To: <1684618595-4178-2-git-send-email-dai.ngo@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
         <1684618595-4178-2-git-send-email-dai.ngo@oracle.com>
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

On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
