Return-Path: <linux-fsdevel+bounces-15134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A988759D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62751C22C37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0F82898;
	Fri, 22 Mar 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="r6lIeHgW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120082892
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148990; cv=none; b=sKCVWyKsMfDbwHCBu25TgQxPNww1xjL51MzH2bnIPztCxuAs4T2xk1iSlKwowNbwiC+ZC9YuCuKIunOVX1ftECtGvFSbrPJn4oK3ngSxI3gdELMkoGB7BbvcoKfZTQW7/hlPQ8SKGrwKhyJcCKvZ33wx+5eNQlLAvyEHfDOXCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148990; c=relaxed/simple;
	bh=jeRa4DLXFpSDpuRSoBN3nhwwrFS7Vdvq6WsBPRRQVYA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=O5t5ftOERdyx33SQPwssjwk2JQCXUOeYo7kmUmSMGJZknpaIMEkDzJp+OMcZQuIVU4D9j/IxgeomKpdcNrFklaGrPDasMrkOBRgEeAmBMFfM7olbCgQCAirRuLRsiaglw7dFbAnRof/tggn4rNJsh8RaM6levjYBUpjqTXRCotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=r6lIeHgW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430a25ed4e7so17794351cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1711148987; x=1711753787; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgF3TbhMPygJT52i6+DbefarjcSqH9PqI9CndRYXlNM=;
        b=r6lIeHgWaOMGOa15DtWUBFRgkMrxGaaQSyTZn0k41tjJmtJNMwDBeyfPwB3CnSiabj
         HJWqDycnOjnAEzUHsuksdbqzTiHpn+qU+kvNOnWMBJQqPuWkOxczHqIJ1/NoLF7idATn
         RAHSDnba6elQ4ipkpvn0E5y6Yaj2pJ5ObD8MyBTmfxHMlDkaYo4CX3nWUR5pbEKvxcML
         pvNCEUHmCRjYemR7vS/21fOEdNYQtQlCe4XBRDj0H7D8UC+wCXkJ4henp84JSvRFTpxd
         73jO5XKkiEvk92x9SShcA9+p+FX8218tXhSCbHBz1drbcaZtkBqoLg5S0aNv8DH29oPg
         JKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711148987; x=1711753787;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgF3TbhMPygJT52i6+DbefarjcSqH9PqI9CndRYXlNM=;
        b=azxCKEKZ4cd64D3AddQvPp0pf/jlg/+LcjxB8LnOH31NEXoNV8asJrxC6c4m2A+5uv
         AAXD68CcM2vry2b6JzoPbHORUDnY/gOgI8CbN0YWajnc1kc/DrfWRj90C58BNhynUtS6
         LsH2KuBUfreEgHTXrejWvNf2sh3jAXjVjYrlwDtgo8lb51llwvkVF/E3umROL06v8ZYl
         4+dtLgWg5NTjXuI0SCxxD0vWOp8+PQ42zQtNx54ljA9thWgNG+SiUb895fPPX3TWy7R/
         2wnpKTFC1o2o+XNqfOBV/XPdhXgZbjV3B+PDiubYa8L2huBKASjRppqXCKmD+VJoTztT
         0Z7w==
X-Forwarded-Encrypted: i=1; AJvYcCW1AFnsv+K+AixxgzOpV+pqYUmyUo4CAsncaVJ/rpzqtWCU3PrkT3Ze3dZi62s5NdEIFHD650tMnQy7BFTJtNrybaU1Z2yXFZaOP9IejQ==
X-Gm-Message-State: AOJu0YzVhJIcrF/riq+HOCOtg7260tF4nPq/f377Qfsp9UWFZVaDbBZ+
	ULqsK7dz7FZNuBWw/aDMDoxNvDTM1wG0w+/ox/OckFycQ/b3OhMyO0pBEWmbVVFcWlNqU9xlwbj
	v
X-Google-Smtp-Source: AGHT+IHspXHKhz8WInyW4vAxHJQUDuGtWZzH6YtVqtNIFEMIDwzLF/84EH/yEaD/1c+LSyHKkBcfGA==
X-Received: by 2002:a05:6a21:33a2:b0:1a1:48aa:2827 with SMTP id yy34-20020a056a2133a200b001a148aa2827mr1151796pzb.39.1711148534968;
        Fri, 22 Mar 2024 16:02:14 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id t184-20020a625fc1000000b006e7243bbd35sm304301pfb.172.2024.03.22.16.02.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 16:02:13 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <157E2709-34C2-4C45-BF68-BF55780480A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Date: Fri, 22 Mar 2024 17:03:03 -0600
In-Reply-To: <20240315035308.3563511-4-kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 14, 2024, at 9:53 PM, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
>=20
> the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> filesystem in a fs agnostic way, potentially nudging us towards
> standarizing some of our reporting.

I find it ironic that we are adding an ioctl to be able to get the
sysfs path, which was originally created to avoid adding ioctls...
But, the days of jumping through hoops to find stuff in sysfs for
each filesystem arrived long ago, so we may as well make it easier. :-)

Cheers, Andreas

>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org
> ---
> fs/ext4/super.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f5e5a44778cf..cb82b23a4d98 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context =
*fc, struct super_block *sb)
> 	sb->s_quota_types =3D QTYPE_MASK_USR | QTYPE_MASK_GRP | =
QTYPE_MASK_PRJ;
> #endif
> 	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> +	super_set_sysfs_name_bdev(sb);
>=20
> 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
> 	mutex_init(&sbi->s_orphan_lock);
> --
> 2.43.0
>=20


Cheers, Andreas






--Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmX+DicACgkQcqXauRfM
H+CJgw/+PaOI0yH8X6md/q6dpGtw7cT+GJNkNUqlr1yw/LAXo5PILhX8BoeGtNn0
xVUkNjlKa5esWlZzNALY9MVdlc3Vnrqny11EzovQn9cS046ZGOfPgKJr3rHxND0B
Uik9qVHxqimn5XPydHnHw0ieGMSSEqCnMWTjx+AydPcETDakFYTefQdUSk5tQoGK
1XuLbZI4m+7waWOA0UPCx79n/qHr9cRvBCbGDrIorO6/A59w+k/bawKY06z0gUu0
/eERceymgH28673XZX464zh8es0u8D82gpN84SM6awJbWF/1btgM41WVuQMRQml7
kZk3uHXy1OFz3Va4WDA2pgROcuBVCbjC+50iE2zJ7NH6qAOiITsxpvzk2C8zf62x
Xnu4MPZff989gurDKSjtmvzdZ1tUoQpVxb5uSLqDNar0Z6GI+IGCUdkXNH6hGb1T
hspCIGhg1xzDud3/HTHnjzQswYM2A750U/b2FwBTnig8DVjpcca5qsRqkj4KEo/H
NAK6xP4g3Lhw/b5tBwCRwvH5cgtmiW37WuKk+RFpIILXHxo0FHOPvNQ1CrF8Hwk2
Q7MJ2XdscsCaUfkVYKCRITjGtPqtgBBsaOteo+2eP2zMHgYW4DSA/qOiHtVUj2wJ
L/cX1nOSkk2LQlphDL3eOLa0C+8Az0j7w2kzeYHw5ELW8neQc6Q=
=ABi7
-----END PGP SIGNATURE-----

--Apple-Mail=_9A948BF3-167F-40B7-B1E4-3D6BCCDB7976--

