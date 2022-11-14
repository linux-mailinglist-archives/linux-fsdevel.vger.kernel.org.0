Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19239627C63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiKNLcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNLcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:32:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDF264A;
        Mon, 14 Nov 2022 03:32:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 793BD22154;
        Mon, 14 Nov 2022 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668425539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCp2FLnHV48qc8WbEJswrBVN0V4a5iE3kG9lCUWVaQM=;
        b=iLMOepeRsQUPz74YqIGAatxyIeS0i7bdGE1cTM7o5LXEXJvEYarrdnyXzkBl69CrXN+r9b
        2ojRa3xVVIYDR1A8sYhPXxMgZtDn3LNqTmqqUKCOPQIBvaKeEgJn1CQgN/SGBDVmbYSJUR
        MRnelYOdv9yHKoRY57sB0sHBoZXGBqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668425539;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCp2FLnHV48qc8WbEJswrBVN0V4a5iE3kG9lCUWVaQM=;
        b=g5u6Gu+DWAC81gcL3HvriHavxgMirXPFvai9XRgZp0iHwmGmWtIh3moIMZV33V5t2gjpN5
        jpBt99diVES3k5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E55F513A92;
        Mon, 14 Nov 2022 11:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZHcjNUIncmMkfAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 14 Nov 2022 11:32:18 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 73d269cf;
        Mon, 14 Nov 2022 11:33:18 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] vfs: fix copy_file_range() averts filesystem freeze
 protection
References: <20221110155522.556225-1-amir73il@gmail.com>
Date:   Mon, 14 Nov 2022 11:33:18 +0000
In-Reply-To: <20221110155522.556225-1-amir73il@gmail.com> (Amir Goldstein's
        message of "Thu, 10 Nov 2022 17:55:22 +0200")
Message-ID: <877czx22kh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> Commit 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs
> copies") removed fallback to generic_copy_file_range() for cross-fs
> cases inside vfs_copy_file_range().
>
> To preserve behavior of nfsd and ksmbd server-side-copy, the fallback to
> generic_copy_file_range() was added in nfsd and ksmbd code, but that
> call is missing sb_start_write(), fsnotify hooks and more.
>
> Ideally, nfsd and ksmbd would pass a flag to vfs_copy_file_range() that
> will take care of the fallback, but that code would be subtle and we got
> vfs_copy_file_range() logic wrong too many times already.
>
> Instead, add a flag to explicitly request vfs_copy_file_range() to
> perform only generic_copy_file_range() and let nfsd and ksmbd use this
> flag only in the fallback path.
>
> This choise keeps the logic changes to minimum in the non-nfsd/ksmbd code
> paths to reduce the risk of further regressions.
>
> Fixes: 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs c=
opies")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Al,
>
> Another fix for the long tradition of copy_file_range() regressions.
> This one only affected cross-fs server-side-copy from nfsd/ksmbd.
>
> I ran the copy_range fstests group on ext4/xfs/overlay to verify no
> regressions in local fs and nfsv3/nfsv4 to test server-side-copy.
>
> I also patched copy_file_range() to test the nfsd fallback code on
> local fs.
>
> Namje, could you please test ksmbd.

For what is worth, I've also done some testing with ceph and I didn't saw
any regression either.  So, feel free to add my

Tested-by: Lu=C3=ADs Henriques <lhenriques@suse.de>

Cheers,
--=20
Lu=C3=ADs

>
> Thanks,
> Amir.
>
>  fs/ksmbd/vfs.c     |  6 +++---
>  fs/nfsd/vfs.c      |  4 ++--
>  fs/read_write.c    | 19 +++++++++++++++----
>  include/linux/fs.h |  8 ++++++++
>  4 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 8de970d6146f..94b8ed4ef870 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1794,9 +1794,9 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *w=
ork,
>  		ret =3D vfs_copy_file_range(src_fp->filp, src_off,
>  					  dst_fp->filp, dst_off, len, 0);
>  		if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
> -			ret =3D generic_copy_file_range(src_fp->filp, src_off,
> -						      dst_fp->filp, dst_off,
> -						      len, 0);
> +			ret =3D vfs_copy_file_range(src_fp->filp, src_off,
> +						  dst_fp->filp, dst_off, len,
> +						  COPY_FILE_SPLICE);
>  		if (ret < 0)
>  			return ret;
>=20=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f650afedd67f..5cf11cde51f8 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -596,8 +596,8 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 sr=
c_pos, struct file *dst,
>  	ret =3D vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>=20=20
>  	if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
> -		ret =3D generic_copy_file_range(src, src_pos, dst, dst_pos,
> -					      count, 0);
> +		ret =3D vfs_copy_file_range(src, src_pos, dst, dst_pos, count,
> +					  COPY_FILE_SPLICE);
>  	return ret;
>  }
>=20=20
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 328ce8cf9a85..24b9668d6377 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1388,6 +1388,8 @@ ssize_t generic_copy_file_range(struct file *file_i=
n, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {
> +	lockdep_assert(sb_write_started(file_inode(file_out)->i_sb));
> +
>  	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
>  				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
>  }
> @@ -1424,7 +1426,9 @@ static int generic_copy_file_checks(struct file *fi=
le_in, loff_t pos_in,
>  	 * and several different sets of file_operations, but they all end up
>  	 * using the same ->copy_file_range() function pointer.
>  	 */
> -	if (file_out->f_op->copy_file_range) {
> +	if (flags & COPY_FILE_SPLICE) {
> +		/* cross sb splice is allowed */
> +	} else if (file_out->f_op->copy_file_range) {
>  		if (file_in->f_op->copy_file_range !=3D
>  		    file_out->f_op->copy_file_range)
>  			return -EXDEV;
> @@ -1474,8 +1478,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>  			    size_t len, unsigned int flags)
>  {
>  	ssize_t ret;
> +	bool splice =3D flags & COPY_FILE_SPLICE;
>=20=20
> -	if (flags !=3D 0)
> +	if (flags & ~COPY_FILE_SPLICE)
>  		return -EINVAL;
>=20=20
>  	ret =3D generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &l=
en,
> @@ -1501,14 +1506,14 @@ ssize_t vfs_copy_file_range(struct file *file_in,=
 loff_t pos_in,
>  	 * same sb using clone, but for filesystems where both clone and copy
>  	 * are supported (e.g. nfs,cifs), we only call the copy method.
>  	 */
> -	if (file_out->f_op->copy_file_range) {
> +	if (!splice && file_out->f_op->copy_file_range) {
>  		ret =3D file_out->f_op->copy_file_range(file_in, pos_in,
>  						      file_out, pos_out,
>  						      len, flags);
>  		goto done;
>  	}
>=20=20
> -	if (file_in->f_op->remap_file_range &&
> +	if (!splice && file_in->f_op->remap_file_range &&
>  	    file_inode(file_in)->i_sb =3D=3D file_inode(file_out)->i_sb) {
>  		ret =3D file_in->f_op->remap_file_range(file_in, pos_in,
>  				file_out, pos_out,
> @@ -1528,6 +1533,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, l=
off_t pos_in,
>  	 * consistent story about which filesystems support copy_file_range()
>  	 * and which filesystems do not, that will allow userspace tools to
>  	 * make consistent desicions w.r.t using copy_file_range().
> +	 *
> +	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
>  	 */
>  	ret =3D generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>  				      flags);
> @@ -1582,6 +1589,10 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_=
t __user *, off_in,
>  		pos_out =3D f_out.file->f_pos;
>  	}
>=20=20
> +	ret =3D -EINVAL;
> +	if (flags !=3D 0)
> +		goto out;
> +
>  	ret =3D vfs_copy_file_range(f_in.file, pos_in, f_out.file, pos_out, len,
>  				  flags);
>  	if (ret > 0) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..59ae95ddb679 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2089,6 +2089,14 @@ struct dir_context {
>   */
>  #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
>=20=20
> +/*
> + * These flags control the behavior of vfs_copy_file_range().
> + * They are not available to the user via syscall.
> + *
> + * COPY_FILE_SPLICE: call splice direct instead of fs clone/copy ops
> + */
> +#define COPY_FILE_SPLICE		(1 << 0)
> +
>  struct iov_iter;
>  struct io_uring_cmd;
>=20=20
> --=20
>
> 2.25.1
>

