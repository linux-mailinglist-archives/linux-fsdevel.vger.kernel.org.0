Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE45F39F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJCXm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJCXm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:42:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6941D39;
        Mon,  3 Oct 2022 16:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88171218B2;
        Mon,  3 Oct 2022 23:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664840573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdlqWohLAXyvbiJ7UUX8gc1uMGPGidl0RixkGVcc1G8=;
        b=oazOe3qb7PDv6hlDfcF/Uk1TaL26iTiVn/BTMM0LYmQMfQ16VQc1TkMEP7bBSC5bd5zSam
        J2DF6jg0obes4vFDqeBhrVg+FiEmWDCYErVXIi8oZLaZnDl4pNV20plwFRKHCUrLYy+dQh
        NMlJN8I8swIBSwrNjelwgvIRszfXExE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664840573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdlqWohLAXyvbiJ7UUX8gc1uMGPGidl0RixkGVcc1G8=;
        b=HtjLqEmd50XBnUBSx47D7E/mdgmQeYZ65Fa1iuaqYvo89glzGrAVRtJhT+u+Tt6VbjOaIJ
        xFWKTTEBAFkaFEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 421C313522;
        Mon,  3 Oct 2022 23:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DdXEOnJzO2OaHAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 23:42:42 +0000
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
Subject: Re: [PATCH v6 7/9] vfs: expose STATX_VERSION to userland
In-reply-to: <20220930111840.10695-8-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-8-jlayton@kernel.org>
Date:   Tue, 04 Oct 2022 10:42:39 +1100
Message-id: <166484055905.14457.14231369028013027820@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sep 2022, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
>=20
> Claim one of the spare fields in struct statx to hold a 64-bit inode
> version attribute. When userland requests STATX_VERSION, copy the
> value from the kstat struct there, and stop masking off
> STATX_ATTR_VERSION_MONOTONIC.
>=20
> Update the test-statx sample program to output the change attr and
> MountId.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/stat.c                 | 12 +++---------
>  include/linux/stat.h      |  9 ---------
>  include/uapi/linux/stat.h |  6 ++++--
>  samples/vfs/test-statx.c  |  8 ++++++--
>  4 files changed, 13 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/stat.c b/fs/stat.c
> index e7f8cd4b24e1..8396c372022f 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -593,11 +593,9 @@ cp_statx(const struct kstat *stat, struct statx __user=
 *buffer)
> =20
>  	memset(&tmp, 0, sizeof(tmp));
> =20
> -	/* STATX_VERSION is kernel-only for now */
> -	tmp.stx_mask =3D stat->result_mask & ~STATX_VERSION;
> +	tmp.stx_mask =3D stat->result_mask;
>  	tmp.stx_blksize =3D stat->blksize;
> -	/* STATX_ATTR_VERSION_MONOTONIC is kernel-only for now */
> -	tmp.stx_attributes =3D stat->attributes & ~STATX_ATTR_VERSION_MONOTONIC;
> +	tmp.stx_attributes =3D stat->attributes;
>  	tmp.stx_nlink =3D stat->nlink;
>  	tmp.stx_uid =3D from_kuid_munged(current_user_ns(), stat->uid);
>  	tmp.stx_gid =3D from_kgid_munged(current_user_ns(), stat->gid);
> @@ -621,6 +619,7 @@ cp_statx(const struct kstat *stat, struct statx __user =
*buffer)
>  	tmp.stx_mnt_id =3D stat->mnt_id;
>  	tmp.stx_dio_mem_align =3D stat->dio_mem_align;
>  	tmp.stx_dio_offset_align =3D stat->dio_offset_align;
> +	tmp.stx_version =3D stat->version;
> =20
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> @@ -636,11 +635,6 @@ int do_statx(int dfd, struct filename *filename, unsig=
ned int flags,
>  	if ((flags & AT_STATX_SYNC_TYPE) =3D=3D AT_STATX_SYNC_TYPE)
>  		return -EINVAL;
> =20
> -	/* STATX_VERSION is kernel-only for now. Ignore requests
> -	 * from userland.
> -	 */
> -	mask &=3D ~STATX_VERSION;
> -
>  	error =3D vfs_statx(dfd, filename, flags, &stat, mask);
>  	if (error)
>  		return error;
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 4e9428d86a3a..69c79e4fd1b1 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -54,13 +54,4 @@ struct kstat {
>  	u32		dio_offset_align;
>  	u64		version;
>  };
> -
> -/* These definitions are internal to the kernel for now. Mainly used by nf=
sd. */
> -
> -/* mask values */
> -#define STATX_VERSION		0x40000000U	/* Want/got stx_change_attr */
> -
> -/* file attribute values */
> -#define STATX_ATTR_VERSION_MONOTONIC	0x8000000000000000ULL /* version mono=
tonically increases */
> -
>  #endif
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7cab2c65d3d7..4a0a1f27c059 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -127,7 +127,8 @@ struct statx {
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u64	stx_version; /* Inode change attribute */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };
> =20
> @@ -154,6 +155,7 @@ struct statx {
>  #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
>  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
>  #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info =
*/
> +#define STATX_VERSION		0x00004000U	/* Want/got stx_version */
> =20
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx e=
xpansion */
> =20
> @@ -189,6 +191,6 @@ struct statx {
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
>  #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
> -
> +#define STATX_ATTR_VERSION_MONOTONIC	0x00400000 /* stx_version increases w=
/ every change */
> =20
>  #endif /* _UAPI_LINUX_STAT_H */
> diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> index 49c7a46cee07..bdbc371c9774 100644
> --- a/samples/vfs/test-statx.c
> +++ b/samples/vfs/test-statx.c
> @@ -107,6 +107,8 @@ static void dump_statx(struct statx *stx)
>  	printf("Device: %-15s", buffer);
>  	if (stx->stx_mask & STATX_INO)
>  		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
> +	if (stx->stx_mask & STATX_MNT_ID)
> +		printf(" MountId: %llx", stx->stx_mnt_id);
>  	if (stx->stx_mask & STATX_NLINK)
>  		printf(" Links: %-5u", stx->stx_nlink);
>  	if (stx->stx_mask & STATX_TYPE) {
> @@ -145,7 +147,9 @@ static void dump_statx(struct statx *stx)
>  	if (stx->stx_mask & STATX_CTIME)
>  		print_time("Change: ", &stx->stx_ctime);
>  	if (stx->stx_mask & STATX_BTIME)
> -		print_time(" Birth: ", &stx->stx_btime);
> +		print_time("Birth: ", &stx->stx_btime);
> +	if (stx->stx_mask & STATX_VERSION)
> +		printf("Inode Version: 0x%llx\n", stx->stx_version);

Why hex? not decimal?  I don't really care but it seems like an odd choice.

> =20
>  	if (stx->stx_attributes_mask) {
>  		unsigned char bits, mbits;
> @@ -218,7 +222,7 @@ int main(int argc, char **argv)
>  	struct statx stx;
>  	int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
> =20
> -	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
> +	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME | STATX_MNT_ID | ST=
ATX_VERSION;
> =20
>  	for (argv++; *argv; argv++) {
>  		if (strcmp(*argv, "-F") =3D=3D 0) {
> --=20
> 2.37.3
>=20
>=20

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown
