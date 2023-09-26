Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454157AF515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjIZU2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjIZU2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:28:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0E116
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 13:28:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c61bde0b4bso42956355ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695760090; x=1696364890; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MABH9GA8jjTb/eq+ePSu9hPAXG0GliCYwShqwMmM4kk=;
        b=w+7GWiK/Lg0nOWOjTlyRb5gdSBm+4UAKT1zyrAFRKAGI8nn6gyRJbKiJHkBAP8in5z
         YikWwIxDm2E8/+wguiMga7K1v7nR0Ck8JZ+B1rJHpJuybm3b1+7N6+zkPRfrY5o1RGlM
         /uRoeOKhpulh7OKVGt6xj05EhtIL0WPUmgOlIC2TJsyeUJEZE5B+KgotobeerM7L661a
         qy8X7BCFe2MGUJc6QG6IxUX6k5Sm94fY7eWsDnMSNKm90KnzoAdsoCVeK/up4pcGPJ+A
         xBdgCmkupKlrAHFprVDwR2OzBTvGv7CstiLijit2NY/byDENxQbb0P+Tmv1zjq0/eMOt
         CKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760090; x=1696364890;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MABH9GA8jjTb/eq+ePSu9hPAXG0GliCYwShqwMmM4kk=;
        b=ZDvo6Di5lcfpVPg9lXryVjguqAwwhM6oITtxBEzhAfyparhFf8UWBshu7JeDroAyD3
         AyRFzhQKdO0CARtaZcJkEXAqY3Pqv9l8DZp2uFV9YKkFmV3ZaIQznpNJocsgiMLfyhaE
         vWwaEHrWmDNQIFbnOU8Sn2l2S7rbhB7JM2r2KIVFaW4C2YaGy8ml/2ugJJb5pCTtUW2X
         1Mml4b8kdiRkljn2hXJnjeCJpLzDJOpiR99ojME5BksuM3NZS1G870IocP416wNZNAcB
         7HjYIqgpc/IqwaLT/d5X6RfGqAP3yklV7b8IgpnaBOe0J2EAFWOP30PHZ+IpKDOod2Tr
         YvpQ==
X-Gm-Message-State: AOJu0YzTwr55rgfKXlUAIg17iD1D8G80s6sPDHfdSUI/1ld0vHSBFq0l
        L3Hfz2TbwUSc5+wJIuiF8k72mEBdOuhUvAW0vNg=
X-Google-Smtp-Source: AGHT+IEsUwGPTgwLp3yp5xwQp04ETmnep2MzB73jG8EueQ7X38/OciCC9jhJE4JC4xMQy44+sd30ww==
X-Received: by 2002:a17:902:e847:b0:1c6:a0b:7b8a with SMTP id t7-20020a170902e84700b001c60a0b7b8amr10561076plg.50.1695760089750;
        Tue, 26 Sep 2023 13:28:09 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b890b3bbb1sm11409554plg.211.2023.09.26.13.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:28:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E5CA9BA7-513A-4D63-B183-B137B727D026@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9664A8AF-642A-4DE5-9063-B986EE9B3E2A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] tmpfs: Add project quota interface support for
 get/set attr
Date:   Tue, 26 Sep 2023 14:28:06 -0600
In-Reply-To: <20230925130028.1244740-4-cem@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
To:     cem@kernel.org
References: <20230925130028.1244740-1-cem@kernel.org>
 <20230925130028.1244740-4-cem@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_9664A8AF-642A-4DE5-9063-B986EE9B3E2A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I've added Dave to the CC list, since he has a deep understanding
of the projid code since it originated from XFS.

On Sep 25, 2023, at 7:00 AM, cem@kernel.org wrote:
>=20
> From: Carlos Maiolino <cem@kernel.org>
>=20
> Not project quota support is in place, enable users to use it.

There is a peculiar behavior of project quotas, that rename across
directories with different project IDs and PROJINHERIT set should
cause the project ID to be updated (similar to BSD setgid).

For renaming regular files and other non-directories, it is OK to
change the projid and update the quota for the old and new IDs
to avoid copying all of the data needlessly.  For directories this
(unfortunately) means that the kernel should return -EXDEV if the
project IDs don't match, and then "mv" will create a new target
directory and resume moving the files (which are thankfully still
done with a rename() call if possible).

The reason for this is that just renaming the directory does not
atomically update the projid on all of the (possibly millions of)
sub-files/sub-dirs, which is required for PROJINHERIT directories.


Another option for tmpfs to maintain this PROJINHERIT behavior would
be to rename the directory and then spawn a background kernel thread
to change the projids on the whole tree.  Since tmpfs is an in-memory
filesystem there will be a "limited" number of files and subdirs
to update, and you don't need to worry about error handling if the
system crashes before the projid updates are done.

While not 100% atomic, it is not *less* atomic than having "mv"
recursively copy the whole directory tree to the target name when
the projid on the source and target don't match.  It is also a
*lot* less overhead than doing a million mkdir() + rename() calls.

There would be a risk that the target directory projid could go over
quota, but the alternative (that "mv" is half-way between moving the
directory tree from the source to the destination before it fails,
or fills up the filesystem because it can't hold another full copy
of the tree being renamed) is not better.

>=20
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> mm/shmem.c | 35 +++++++++++++++++++++++++++++++----
> 1 file changed, 31 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4d2b713bff06..744a39251a31 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3571,6 +3571,23 @@ static int shmem_fileattr_get(struct dentry =
*dentry, struct fileattr *fa)
>=20
> 	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE);
>=20
> +	fa->fsx_projid =3D (u32)from_kprojid(&init_user_ns, =
info->i_projid);
> +	return 0;
> +}
> +
> +static int shmem_set_project(struct inode *inode, __u32 projid)
> +{
> +	int err =3D -EOPNOTSUPP;
> +	kprojid_t kprojid =3D make_kprojid(&init_user_ns, =
(projid_t)projid);
> +
> +	if (projid_eq(kprojid, SHMEM_I(inode)->i_projid))
> +		return 0;
> +
> +	err =3D dquot_initialize(inode);
> +	if (err)
> +		return err;
> +
> +	SHMEM_I(inode)->i_projid =3D kprojid;
> 	return 0;
> }

(defect) this also needs to __dquot_transfer() the quota away from the
previous projid, or the accounting will be broken.


I think one hole in project quotas is the fact that any user can set
the projid of their files to any project they want.  Changing the =
projid/PROJINHERIT is restricted outside of the init namespace by
fileattr_set_prepare(), which is good in itself, but I think it makes
sense for root/CAP_SYS_RESOURCE to be needed to change =
projid/PROJINHERIT
even in the init namespace. Otherwise project quota is only an estimate
of space usage in a directory, if users are not actively subverting it.

> @@ -3579,19 +3596,29 @@ static int shmem_fileattr_set(struct mnt_idmap =
*idmap,
> {
> 	struct inode *inode =3D d_inode(dentry);
> 	struct shmem_inode_info *info =3D SHMEM_I(inode);
> +	int err =3D -EOPNOTSUPP;
> +
> +	if (fa->fsx_valid &&
> +	   ((fa->fsx_xflags & ~FS_XFLAG_COMMON) ||
> +	   fa->fsx_extsize !=3D 0 || fa->fsx_cowextsize !=3D 0))
> +		goto out;
>=20
> -	if (fileattr_has_fsx(fa))
> -		return -EOPNOTSUPP;
> 	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
> -		return -EOPNOTSUPP;
> +		goto out;
>=20
> 	info->fsflags =3D (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
> 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
>=20
> 	shmem_set_inode_flags(inode, info->fsflags);
> +	err =3D shmem_set_project(inode, fa->fsx_projid);
> +		if (err)
> +			goto out;
> +
> 	inode_set_ctime_current(inode);
> 	inode_inc_iversion(inode);
> -	return 0;
> +
> +out:
> +	return err;
> }



There were also some patches to add projid support to statx() that =
didn't
quite get merged:

=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449184-7942-3-gi=
t-send-email-wshilong1991@gmail.com/
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449184-7942-2-gi=
t-send-email-wshilong1991@gmail.com/
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-6-gi=
t-send-email-wshilong1991@gmail.com/
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-7-gi=
t-send-email-wshilong1991@gmail.com/
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-8-gi=
t-send-email-wshilong1991@gmail.com/
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1551449141-7884-9-gi=
t-send-email-wshilong1991@gmail.com/

They were part of a larger series to allow setting projid directly with
the fchownat(2), but that got bogged down in how the interface should
work, and whether i_projid should be moved to struct inode, but I think
the statx() functionality was uncontroversial and could land as-is.

Cheers, Andreas






--Apple-Mail=_9664A8AF-642A-4DE5-9063-B986EE9B3E2A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUTPtYACgkQcqXauRfM
H+AyNA/9EpdEeVDiwfjDgj6Mesy5sNjSKgznlMz6VUhUuWNkM6odeKbH+GleOB8Q
FmEVcSEve4mNVQWmV3ieHEJeJaabDmMNbCxxrxAxN7C6HnGEqdgnck/qsa7Zu3Vx
qLalCgGvnJrThg3Id3hiTiuSZaeOZa0rbA9lTlTdSohgDah25ce+AxV92AYJ7Xka
Fb1IqqmaDD6ORA4NIWdX62ii7z/O7GhMdqLmXq17FAoQ5RgVzwjxkjDPKTlsayyt
KebpfCfEq528sOYeaoHwSUa95QLYjY2fAarPk+P86txvBOfdcoVZmuGWorUszC0p
BEsg2pT/t3D4NCPkXBaxToluEoxg3y1PChsX2y+THl84bqxqqBZnm7kQVqAG87hN
XSUw49nddjTGlECr+ehURy2hMCDgn2Oe6eRvjw0//uZlR/+NPa8dk/8RBioyMZ9g
2aO5xg6fuoiAwj2d9Vr0q746vi2geA12HoD6KkHmPgiyXVi0ffSc/ueoLgOMlB6g
3kIDeLvhYmTm0wDb6kc7fmknKJ1OYqP/cuN3gZcoAEprKmV0zElhjjUhL1RWhTgy
Zm1x9KgrVTiCRlb3TAn2PmRaslMRjZFpu3neKZtdwyMbxXG2WGfj8V1r8XviMtrI
lBRHsGKuaS1emd2uJiGMiIbm64f0TK4Q9earmRLq/tO+xLbOj1Y=
=ViUY
-----END PGP SIGNATURE-----

--Apple-Mail=_9664A8AF-642A-4DE5-9063-B986EE9B3E2A--
