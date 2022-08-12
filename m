Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131A2591594
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiHLSmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHLSmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1647AB274E;
        Fri, 12 Aug 2022 11:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FED61779;
        Fri, 12 Aug 2022 18:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD5C433D6;
        Fri, 12 Aug 2022 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660329759;
        bh=0SpTXliYw/kJ2X+cCNItoT93KPSfbEg24GS3DZyjttg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fi8kKktUFO2l8KCGVfOlkMPBRgND1x8TPBbdD2gSLaQrI1BOchBVkiYPeQf+dWM9A
         ry0PxY8DO7Cy9XAoEXlDZK9btgUZe23bWHE08AVQtiCSJZyUztVstCRHy3dx1Qdxi7
         3WIOVxokSzSu/U+aXbEs0jWW1zrSla1nWh/KIS0AyjDYU9h1pgY25BCPBf3m3/x14d
         xf2eKKBNAftmOxDq/M2SSl+Ny7A4hNp1dKGhTnNSOituf0KkVWllo7wTCVfE38wf4z
         0UB/WwGUTSBCXoHATo34uARCQzbWYHgEyOO2fHGV9Z/7VqtIrKBK6pU/lbS4HwUEkh
         QTEaMHRF1mSgg==
Message-ID: <b2e18765bc22ea851c2293c15a8aa4c3cec0fde5.camel@kernel.org>
Subject: Re: [PATCH v3 1/3] ext4: don't increase iversion counter for
 ea_inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        ebiggers@kernel.org, david@fromorbit.com
Date:   Fri, 12 Aug 2022 14:42:36 -0400
In-Reply-To: <20220812123727.46397-1-lczerner@redhat.com>
References: <20220812123727.46397-1-lczerner@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Fri, 2022-08-12 at 14:37 +0200, Lukas Czerner wrote:
> ea_inodes are using i_version for storing part of the reference count so
> we really need to leave it alone.
>=20
> The problem can be reproduced by xfstest ext4/026 when iversion is
> enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
> inodes in ext4_mark_iloc_dirty().
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
> v2, v3: no change
>=20
>  fs/ext4/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 601214453c3a..2a220be34caa 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5731,7 +5731,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
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


I've spent some time writing tests for the i_version counter (still
quite rough right now), and what I've found is that this particular
inode_inc_iversion results in the counter being bumped on _reads_ as
well as writes, due to the atime changing. This call to
inode_inc_iversion seems to make no sense, as we aren't bumping the
mtime here.

I'm still working on and testing this, but I think we'll probably just
want to remove this inode_inc_iversion entirely, and leave the i_version
bumping for normal files to happen when the timestamps are updated. So
far, my testing seems to indicate that that does the right thing.

Hopefully I'll have some testcases + patches for this next week
sometime.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
