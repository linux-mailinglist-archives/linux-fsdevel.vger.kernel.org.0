Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D659752E9EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiETKcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348135AbiETKc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 06:32:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C68CB3E;
        Fri, 20 May 2022 03:32:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1914B21C3B;
        Fri, 20 May 2022 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653042744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se0O+Pmmx7T7bG9ciKf5iYkSWkZFYvL8Glc6PyiN4CY=;
        b=1nz5pCwWKOHvcXIHQeFCeYSzIVs0AyRZUsEa75u5WVebO5t2oicgfxu2QAl26lUb7PpQxa
        XR0nuJiCT06E3NN4+N64CIeOhj/Kv0CZgU5fq4gjgtqf1pXHvL0QFJ0POV7L4jlQkC5Ctl
        nzT9+yjynA96ch/OG9MGqVmTjVH9boQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653042744;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se0O+Pmmx7T7bG9ciKf5iYkSWkZFYvL8Glc6PyiN4CY=;
        b=V1cCR3TD36xC+53qzxxXC9FhB8skB5/vdbF2KS61xUIxcGj5CUojBVN+uaYfC4Y+cP/OX5
        q/3rKu254CbJdTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 662AD13AF4;
        Fri, 20 May 2022 10:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GibiFTduh2JODwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 20 May 2022 10:32:23 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 1adf4034;
        Fri, 20 May 2022 10:33:00 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        He Zhe <zhe.he@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v13] vfs: fix copy_file_range regression in cross-fs copies
References: <20220520082111.2066400-1-amir73il@gmail.com>
Date:   Fri, 20 May 2022 11:33:00 +0100
In-Reply-To: <20220520082111.2066400-1-amir73il@gmail.com> (Amir Goldstein's
        message of "Fri, 20 May 2022 11:21:11 +0300")
Message-ID: <87ilq0334z.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> From: Luis Henriques <lhenriques@suse.de>
>
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymo=
re
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> Another regression has been reported by He Zhe and Paul Gortmaker -
> WARN_ON_ONCE(ret =3D=3D -EOPNOTSUPP) can be triggered from userspace when
> copying from a sysfs file whose read operation may return -EOPNOTSUPP:
>
>   xfs_io -f -c "copy_range /sys/class/net/lo/phys_switch_id" /tmp/foo
>
> Since we do not have test coverage for copy_file_range() between any
> two types of filesystems, the best way to avoid with this sort of issues
> in the future is for the kernel to be more picky about filesystems that
> are allowed to do copy_file_range().
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").
>
> Filesystems that implement copy_file_range() or remap_file_range() may
> still fall-back to the generic_copy_file_range() implementation when the
> filesystem cannot handle the copy, so kernel can maintain a consistent
> story about which filesystems support copy_file_range().
> That will allow userspace tools to make consistent desicions w.r.t using
> copy_file_range().
>
> nfsd is also modified to fall-back into generic_copy_file_range() in case
> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drin=
kcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=
=3DZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff=
707bc1efa17f5366057d60603c45f@changeid/
> Link: https://lore.kernel.org/linux-fsdevel/20210630161320.29006-1-lhenri=
ques@suse.de/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> Fixes: 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
> Link: https://lore.kernel.org/linux-fsdevel/20f17f64-88cb-4e80-07c1-85cb9=
6c83619@windriver.com/
> Reported-by: He Zhe <zhe.he@windriver.com>
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Al,
>
> Please take this patch to fix several issues that started to pop up
> as userspace tools started using copy_file_range(), which could only
> get more popular in the future.
>
> I've decides to pick this up from Luis' v12 last year [1] following
> some recent bug report. Although Luis' patch was reviewed by me back
> then and tested by Olga on nfs, I tested it now and found that it
> regressed fstests on xfs,btrfs, so decided on a slightly differnt logic.
>
> The rationale behind my change is that given src fs and dst fs, the
> outcomes of EOPNOTSUPP and EXDEV are consistent, while keeping the
> fs that may return success from this syscall to a minimum.
>
> I've tested this with the -g copy_range tests from fstests on
> ext4,xfs,btrfs,nfs,overlayfs (over xfs).
>
> For ext4, all tests are skipping as expected.
> For xfs,btrfs (support clone) the cross-fs copy test (genric/565)
> is skipped.
> For nfs,overlayfs the tests pass including the cross-fs copy test.

Thanks a lot for taking care of this, Amir.  I've also tested it with ceph
and didn't saw anything breaking (well... there was a bug in a
ceph-specific test, but that's unrelated).  So, FWIW:

Reviewed-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
Tested-by: Lu=C3=ADs Henriques <lhenriques@suse.de>

Cheers
--=20
Lu=C3=ADs

>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxh6PegaOtMXQ9WmU=3D05bhQf=
YTeweGjFWR7T+XVAbuR09A@mail.gmail.com/
>
>  fs/nfsd/vfs.c   |  8 ++++-
>  fs/read_write.c | 79 +++++++++++++++++++++++++++----------------------
>  2 files changed, 50 insertions(+), 37 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c22ad0532e8e..74f7fef48504 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -577,6 +577,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
>  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file =
*dst,
>  			     u64 dst_pos, u64 count)
>  {
> +	ssize_t ret;
>=20=20
>  	/*
>  	 * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> @@ -587,7 +588,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 s=
rc_pos, struct file *dst,
>  	 * limit like this and pipeline multiple COPY requests.
>  	 */
>  	count =3D min_t(u64, count, 1 << 22);
> -	return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +	ret =3D vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +
> +	if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
> +		ret =3D generic_copy_file_range(src, src_pos, dst, dst_pos,
> +					      count, 0);
> +	return ret;
>  }
>=20=20
>  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e643aec2b0ef..a8f12e91762f 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1381,28 +1381,6 @@ ssize_t generic_copy_file_range(struct file *file_=
in, loff_t pos_in,
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
>=20=20
> -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> -				  struct file *file_out, loff_t pos_out,
> -				  size_t len, unsigned int flags)
> -{
> -	/*
> -	 * Although we now allow filesystems to handle cross sb copy, passing
> -	 * a file of the wrong filesystem type to filesystem driver can result
> -	 * in an attempt to dereference the wrong type of ->private_data, so
> -	 * avoid doing that until we really have a good reason.  NFS defines
> -	 * several different file_system_type structures, but they all end up
> -	 * using the same ->copy_file_range() function pointer.
> -	 */
> -	if (file_out->f_op->copy_file_range &&
> -	    file_out->f_op->copy_file_range =3D=3D file_in->f_op->copy_file_ran=
ge)
> -		return file_out->f_op->copy_file_range(file_in, pos_in,
> -						       file_out, pos_out,
> -						       len, flags);
> -
> -	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -				       flags);
> -}
> -
>  /*
>   * Performs necessary checks before doing a file copy
>   *
> @@ -1424,6 +1402,25 @@ static int generic_copy_file_checks(struct file *f=
ile_in, loff_t pos_in,
>  	if (ret)
>  		return ret;
>=20=20
> +	/*
> +	 * Although we now allow filesystems to handle cross sb copy, passing
> +	 * a file of the wrong filesystem type to filesystem driver can result
> +	 * in an attempt to dereference the wrong type of ->private_data, so
> +	 * avoid doing that until we really have a good reason.  NFS defines
> +	 * several different file_system_type structures, but they all end up
> +	 * using the same ->copy_file_range() function pointer.
> +	 */
> +	if (file_out->f_op->copy_file_range) {
> +		if (file_in->f_op->copy_file_range !=3D
> +		    file_out->f_op->copy_file_range)
> +			return -EXDEV;
> +	} else if (file_in->f_op->remap_file_range) {
> +		if (file_inode(file_in)->i_sb !=3D file_inode(file_out)->i_sb)
> +			return -EXDEV;
> +	} else {
> +                return -EOPNOTSUPP;
> +	}
> +
>  	/* Don't touch certain kinds of inodes */
>  	if (IS_IMMUTABLE(inode_out))
>  		return -EPERM;
> @@ -1489,26 +1486,36 @@ ssize_t vfs_copy_file_range(struct file *file_in,=
 loff_t pos_in,
>  	file_start_write(file_out);
>=20=20
>  	/*
> -	 * Try cloning first, this is supported by more file systems, and
> -	 * more efficient if both clone and copy are supported (e.g. NFS).
> +	 * Cloning is supported by more file systems, so we implement copy on
> +	 * same sb using clone, but for filesystems were both clone and copy
> +	 * are supported (e.g. NFS), we only call the copy method.
>  	 */
> -	if (file_in->f_op->remap_file_range &&
> -	    file_inode(file_in)->i_sb =3D=3D file_inode(file_out)->i_sb) {
> -		loff_t cloned;
> -
> -		cloned =3D file_in->f_op->remap_file_range(file_in, pos_in,
> +	if (file_out->f_op->copy_file_range) {
> +		ret =3D file_out->f_op->copy_file_range(file_in, pos_in,
> +						      file_out, pos_out,
> +						      len, flags);
> +	} else if (file_in->f_op->remap_file_range &&
> +		   file_inode(file_in)->i_sb =3D=3D file_inode(file_out)->i_sb) {
> +		ret =3D file_in->f_op->remap_file_range(file_in, pos_in,
>  				file_out, pos_out,
>  				min_t(loff_t, MAX_RW_COUNT, len),
>  				REMAP_FILE_CAN_SHORTEN);
> -		if (cloned > 0) {
> -			ret =3D cloned;
> -			goto done;
> -		}
>  	}
>=20=20
> -	ret =3D do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -				flags);
> -	WARN_ON_ONCE(ret =3D=3D -EOPNOTSUPP);
> +	if (ret > 0)
> +		goto done;
> +
> +	/*
> +	 * We can get here if filesystem supports clone but rejected the clone
> +	 * request (e.g. because it was not block aligned).
> +	 * In that case, fall back to kernel copy so we are able to maintain a
> +	 * consistent story about which filesystems support copy_file_range()
> +	 * and which filesystems do not, that will allow userspace tools to
> +	 * make consistent desicions w.r.t using copy_file_range().
> +	 */
> +	ret =3D generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> +				      flags);
> +
>  done:
>  	if (ret > 0) {
>  		fsnotify_access(file_in);
> --=20
>
> 2.25.1
>

