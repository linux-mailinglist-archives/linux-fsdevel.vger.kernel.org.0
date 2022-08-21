Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DF59B6E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 01:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiHUX57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 19:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiHUX55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:57:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D451AF11;
        Sun, 21 Aug 2022 16:57:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C51655C251;
        Sun, 21 Aug 2022 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661126274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBDPrppUbUN1rd6LE5UVlJ4gujBjDQfoU3i4Be+8PBs=;
        b=MHjvWOV/20tT8jStaPfFs0IXQqIeiARnzJb/JuYPexBS1pOL/u5sr7LToc2PokiSuw4+cT
        5dSJwOUHLooIU99FmxiNN97tpw5fUd5L7ccVzJEw3wnGgRNcVcqiZ2TwN8+AU544ZjyEjz
        QsRqJ+W8JaYFyHIPAV5uFZm0KovCJSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661126274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBDPrppUbUN1rd6LE5UVlJ4gujBjDQfoU3i4Be+8PBs=;
        b=oPfuwuIlTTj/l/sF2LNlQfVflk95/esv2KLtqvNltm680oMstDVpMXuVUB9tHBdOBJmaOP
        qPU4sZvAgqDzyEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B31E8139C7;
        Sun, 21 Aug 2022 23:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yfxUGn/GAmMnKwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 21 Aug 2022 23:57:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "Dave Chinner" <david@fromorbit.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "David Wysochanski" <dwysocha@redhat.com>
Subject: Re: [PATCH] xfs: don't bump the i_version on an atime update in
 xfs_vn_update_time
In-reply-to: <20220819113450.11885-1-jlayton@kernel.org>
References: <20220819113450.11885-1-jlayton@kernel.org>
Date:   Mon, 22 Aug 2022 09:57:48 +1000
Message-id: <166112626820.23264.11718948914253988812@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 Aug 2022, Jeff Layton wrote:
> xfs will update the i_version when updating only the atime value, which
> is not desirable for any of the current consumers of i_version. Doing so
> leads to unnecessary cache invalidations on NFS and extra measurement
> activity in IMA.
>=20
> Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> transaction should not update the i_version. Set that value in
> xfs_vn_update_time if we're only updating the atime.
>=20
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: David Wysochanski <dwysocha@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
>  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
>  fs/xfs/xfs_iops.c               | 10 +++++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
> index b351b9dc6561..866a4c5cf70c 100644
> --- a/fs/xfs/libxfs/xfs_log_format.h
> +++ b/fs/xfs/libxfs/xfs_log_format.h
> @@ -323,7 +323,7 @@ struct xfs_inode_log_format_32 {
>  #define	XFS_ILOG_ABROOT	0x100	/* log i_af.i_broot */
>  #define XFS_ILOG_DOWNER	0x200	/* change the data fork owner on replay */
>  #define XFS_ILOG_AOWNER	0x400	/* change the attr fork owner on replay */
> -
> +#define XFS_ILOG_NOIVER	0x800	/* don't bump i_version */
> =20
>  /*
>   * The timestamps are dirty, but not necessarily anything else in the inode
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inod=
e.c
> index 8b5547073379..ffe6d296e7f9 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -126,7 +126,7 @@ xfs_trans_log_inode(
>  	 * unconditionally.
>  	 */
>  	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> -		if (IS_I_VERSION(inode) &&
> +		if (!(flags & XFS_ILOG_NOIVER) && IS_I_VERSION(inode) &&
>  		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
>  			iversion_flags =3D XFS_ILOG_CORE;
>  	}
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 45518b8c613c..54db85a43dfb 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1021,7 +1021,7 @@ xfs_vn_update_time(
>  {
>  	struct xfs_inode	*ip =3D XFS_I(inode);
>  	struct xfs_mount	*mp =3D ip->i_mount;
> -	int			log_flags =3D XFS_ILOG_TIMESTAMP;
> +	int			log_flags =3D XFS_ILOG_TIMESTAMP|XFS_ILOG_NOIVER;
>  	struct xfs_trans	*tp;
>  	int			error;
> =20
> @@ -1041,10 +1041,14 @@ xfs_vn_update_time(
>  		return error;
> =20
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	if (flags & S_CTIME)
> +	if (flags & S_CTIME) {
>  		inode->i_ctime =3D *now;
> -	if (flags & S_MTIME)
> +		log_flags &=3D ~XFS_ILOG_NOIVER;
> +	}
> +	if (flags & S_MTIME) {
>  		inode->i_mtime =3D *now;
> +		log_flags &=3D ~XFS_ILOG_NOIVER;
> +	}
>  	if (flags & S_ATIME)
>  		inode->i_atime =3D *now;

I think you should also clear XFS_ILOG_NOIVER is S_VERSION is set, but
otherwise this looks sane to me.

Thanks,
NeilBrown

> =20
> --=20
> 2.37.2
>=20
>=20
