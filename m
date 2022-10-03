Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA155F39DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 01:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJCX3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 19:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJCX3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:29:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6010075;
        Mon,  3 Oct 2022 16:29:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A060218A4;
        Mon,  3 Oct 2022 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664839785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ylh5NknchpDJmmWXadWza1FBLEcM+AFNWAGmj/nYQZQ=;
        b=BSj3tr9sTDeqdJeGQP4ZGWYAfe2GurPqfXcrwI7dpSAUi9nnWhQ0ARkzclH16yM6OME+eo
        WEnSo6liQ6S1JACvPEV2lFjTW1OkD4sAEMPxv8QLF80GNrfc9D73k5G3lWYskN4tzkkc/9
        dpxpCeP7hxgrDdvoH2EnicWhSND/S6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664839785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ylh5NknchpDJmmWXadWza1FBLEcM+AFNWAGmj/nYQZQ=;
        b=r9Bl3jZCX3+ZTbK9iFlIEEtPIebrcKn2vW6M23N/MXhRr4h2JPtKU76vRpJYtXXjvBCG6H
        Giiony6XklzUI6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72DC213522;
        Mon,  3 Oct 2022 23:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6XYmC2FwO2PFGAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 23:29:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 4/9] nfs: report the inode version in getattr if requested
In-reply-to: <20220930111840.10695-5-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-5-jlayton@kernel.org>
Date:   Tue, 04 Oct 2022 10:29:33 +1100
Message-id: <166483977325.14457.7085950126736913468@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sep 2022, Jeff Layton wrote:
> Allow NFS to report the i_version in getattr requests. Since the cost to
> fetch it is relatively cheap, do it unconditionally and just set the
> flag if it looks like it's valid. Also, conditionally enable the
> MONOTONIC flag when the server reports its change attr type as such.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/inode.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index bea7c005119c..5cb7017e5089 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -830,6 +830,8 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
>  		reply_mask |=3D STATX_UID | STATX_GID;
>  	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
>  		reply_mask |=3D STATX_BLOCKS;
> +	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
> +		reply_mask |=3D STATX_VERSION;
>  	return reply_mask;
>  }
> =20
> @@ -848,7 +850,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, cons=
t struct path *path,
> =20
>  	request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
>  			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
> -			STATX_INO | STATX_SIZE | STATX_BLOCKS;
> +			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_VERSION;
> =20
>  	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
>  		if (readdirplus_enabled)
> @@ -877,7 +879,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, cons=
t struct path *path,
>  	/* Is the user requesting attributes that might need revalidation? */
>  	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
>  					STATX_MTIME|STATX_UID|STATX_GID|
> -					STATX_SIZE|STATX_BLOCKS)))
> +					STATX_SIZE|STATX_BLOCKS|STATX_VERSION)))
>  		goto out_no_revalidate;
> =20
>  	/* Check whether the cached attributes are stale */
> @@ -915,6 +917,10 @@ int nfs_getattr(struct user_namespace *mnt_userns, con=
st struct path *path,
> =20
>  	generic_fillattr(&init_user_ns, inode, stat);
>  	stat->ino =3D nfs_compat_user_ino64(NFS_FILEID(inode));
> +	stat->version =3D inode_peek_iversion_raw(inode);

This looks wrong.
1/ it includes the I_VERSION_QUERIED bit, which should be hidden.
2/ it doesn't set that bit.

I understand that the bit was already set when the generic code called
inode_query_iversion(), but it might have changed if we needed to
refresh the attrs.

I'm beginning to think I shouldn't have approved the 3/9 patch.  The
stat->version shouldn't be set in vfs_getattr_nosec() - maybe in
generic_fillattr(), but not a lot of point.

> +	stat->attributes_mask |=3D STATX_ATTR_VERSION_MONOTONIC;
> +	if (server->change_attr_type !=3D NFS4_CHANGE_TYPE_IS_UNDEFINED)
> +		stat->attributes |=3D STATX_ATTR_VERSION_MONOTONIC;

So if the server tells us that the change attrs is based on time
metadata, we accept that it will be monotonic (and RFC7862 encourages
this), even though we seem to worry about timestamps going backwards
(which we know that can)...  Interesting.

Thanks,
NeilBrown


>  	if (S_ISDIR(inode->i_mode))
>  		stat->blksize =3D NFS_SERVER(inode)->dtsize;
>  out:
> --=20
> 2.37.3
>=20
>=20
