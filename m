Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CF587BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiHBL6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBL6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:58:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D454AD7A;
        Tue,  2 Aug 2022 04:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06746B81EF5;
        Tue,  2 Aug 2022 11:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38397C433D6;
        Tue,  2 Aug 2022 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659441493;
        bh=aPuGftVIsDG7Y7CdPuQDLSg2l7bYocqX44l5KaPCV+o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nN7B7dn6pf45P3zOzbiq/D/QsHIPhcIQJxRRRdP80mViCmLjfmn1Fr733ERmKNFY/
         7EyBNhoEuUPE9zwfw+nAtWUzDeZrN19Hd9Y4tmTaqpPrmEIZabnHwqYDcHGKcQxl0j
         I/m+3+bHkgApXESFafCUKfUoRxhK4HPAqPfTzebOnRYqCzOStVuAJrjCYIs0g4KQwE
         cExhU9aovDx36rWpC/nlYkGxIgwcdRa0625TpIPcxqqHqvTf/qxWdup8ZYpvTxA8Zu
         jUZTdXhAXSo+q1G75f1C8zgL0shOCpNETKSji4liF2tUg41uYn26LsIyfvJfaQDI/j
         phixbeomx1jJg==
Message-ID: <ec2d4a30372548ad0e7fa2c72c10e527f95aa6f2.camel@kernel.org>
Subject: Re: [PATCH 1/2] ext4: don't increase iversion counter for ea_inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, linux-fsdevel@vger.kernel.org
Date:   Tue, 02 Aug 2022 07:58:11 -0400
In-Reply-To: <20220728133914.49890-1-lczerner@redhat.com>
References: <20220728133914.49890-1-lczerner@redhat.com>
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

On Thu, 2022-07-28 at 15:39 +0200, Lukas Czerner wrote:
> ea_inodes are using i_version for storing part of the reference count so
> we really need to leave it alone.
>=20
> The problem can be reproduced by xfstest ext4/026 when iversion is
> enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
> inodes in ext4_mark_iloc_dirty().
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  fs/ext4/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..b76554124224 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5717,7 +5717,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	}
>  	ext4_fc_track_inode(handle, inode);
> =20
> -	if (IS_I_VERSION(inode))
> +	/*
> +	 * ea_inodes are using i_version for storing reference count, don't
> +	 * mess with it
> +	 */
> +	if (IS_I_VERSION(inode) &&
> +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
>  		inode_inc_iversion(inode);
> =20
>  	/* the do_update_inode consumes one bh->b_count */

Reviewed-by: Jeff Layton <jlayton@kernel.org>
