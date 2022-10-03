Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF535F39AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 01:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJCXOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJCXOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:14:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3541E64;
        Mon,  3 Oct 2022 16:14:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0460C1F383;
        Mon,  3 Oct 2022 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664838882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o89FNJqcd/srxOwB7caebn/K4gYoDlX9ZBmPgRmJJfM=;
        b=gvJGE64/tLd3vaf+tDY0kPFrWPXZy8mbHC4q6Fl5w7TffGHI+r1Q6VVPMwbqeASc37W9Ai
        VFtNZBuf0zE8xZKhZ+c2b/b5ut57zpfFpFqMWmaSey5QdNDm2gGOfLfRmyH/+vMlRkccr6
        AJvBWx/YubQWi4QfuioYg8t6hdtA+Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664838882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o89FNJqcd/srxOwB7caebn/K4gYoDlX9ZBmPgRmJJfM=;
        b=u7q7+Ws2ak28Xkyyj9Y16sQHmOK497L3RPiVRPZPwMHF3zXoH1U+lwjzJ9BXXrK2S6eWNl
        2h3cmX4Xc1CIQPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BD2B1332F;
        Mon,  3 Oct 2022 23:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +EJoOdpsO2NPFAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 23:14:34 +0000
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
        linux-xfs@vger.kernel.org, "Jeff Layton" <jlayton@redhat.com>
Subject: Re: [PATCH v6 3/9] vfs: plumb i_version handling into struct kstat
In-reply-to: <20220930111840.10695-4-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-4-jlayton@kernel.org>
Date:   Tue, 04 Oct 2022 10:14:32 +1100
Message-id: <166483887224.14457.15787196896853726744@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sep 2022, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
>=20
> The NFS server has a lot of special handling for different types of
> change attribute access, depending on what sort of inode we have. In
> most cases, it's doing a getattr anyway and then fetching that value
> after the fact.
>=20
> Rather that do that, add a new STATX_VERSION flag that is a kernel-only
> symbol (for now). If requested and getattr can implement it, it can fill
> out this field. For IS_I_VERSION inodes, add a generic implementation in
> vfs_getattr_nosec. Take care to mask STATX_VERSION off in requests from
> userland and in the result mask.
>=20
> Eventually if we decide to make this available to userland, we can just
> designate a field for it in struct statx, and move the STATX_VERSION
> definition to the uapi header.

Above does not mention STATX_ATTR_VERSION_MONOTONIC, but it appears in
that patch - which is confusing.
But the patch is good, so

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/stat.c            | 17 +++++++++++++++--
>  include/linux/stat.h |  9 +++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/stat.c b/fs/stat.c
> index a7930d744483..e7f8cd4b24e1 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -17,6 +17,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/pagemap.h>
>  #include <linux/compat.h>
> +#include <linux/iversion.h>
> =20
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, struct =
kstat *stat,
>  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
>  				  STATX_ATTR_DAX);
> =20
> +	if ((request_mask & STATX_VERSION) && IS_I_VERSION(inode)) {
> +		stat->result_mask |=3D STATX_VERSION;
> +		stat->version =3D inode_query_iversion(inode);
> +	}
> +
>  	mnt_userns =3D mnt_user_ns(path->mnt);
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(mnt_userns, path, stat,
> @@ -587,9 +593,11 @@ cp_statx(const struct kstat *stat, struct statx __user=
 *buffer)
> =20
>  	memset(&tmp, 0, sizeof(tmp));
> =20
> -	tmp.stx_mask =3D stat->result_mask;
> +	/* STATX_VERSION is kernel-only for now */
> +	tmp.stx_mask =3D stat->result_mask & ~STATX_VERSION;
>  	tmp.stx_blksize =3D stat->blksize;
> -	tmp.stx_attributes =3D stat->attributes;
> +	/* STATX_ATTR_VERSION_MONOTONIC is kernel-only for now */
> +	tmp.stx_attributes =3D stat->attributes & ~STATX_ATTR_VERSION_MONOTONIC;
>  	tmp.stx_nlink =3D stat->nlink;
>  	tmp.stx_uid =3D from_kuid_munged(current_user_ns(), stat->uid);
>  	tmp.stx_gid =3D from_kgid_munged(current_user_ns(), stat->gid);
> @@ -628,6 +636,11 @@ int do_statx(int dfd, struct filename *filename, unsig=
ned int flags,
>  	if ((flags & AT_STATX_SYNC_TYPE) =3D=3D AT_STATX_SYNC_TYPE)
>  		return -EINVAL;
> =20
> +	/* STATX_VERSION is kernel-only for now. Ignore requests
> +	 * from userland.
> +	 */
> +	mask &=3D ~STATX_VERSION;
> +
>  	error =3D vfs_statx(dfd, filename, flags, &stat, mask);
>  	if (error)
>  		return error;
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index ff277ced50e9..4e9428d86a3a 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -52,6 +52,15 @@ struct kstat {
>  	u64		mnt_id;
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
> +	u64		version;
>  };
> =20
> +/* These definitions are internal to the kernel for now. Mainly used by nf=
sd. */
> +
> +/* mask values */
> +#define STATX_VERSION		0x40000000U	/* Want/got stx_change_attr */
> +
> +/* file attribute values */
> +#define STATX_ATTR_VERSION_MONOTONIC	0x8000000000000000ULL /* version mono=
tonically increases */
> +
>  #endif
> --=20
> 2.37.3
>=20
>=20
