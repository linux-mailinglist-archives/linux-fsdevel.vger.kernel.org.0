Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAFE266525
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgIKQyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 12:54:05 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49158 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgIKQx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:53:26 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8471837;
        Fri, 11 Sep 2020 19:52:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599843171;
        bh=VJ0776qjV4c3Wyytib3Pl9r8vEqWoZFPo+fv5SVZaO8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=M08zoi/+bJ0BsBIKm99pa96Jpdtuw47s1u2rjap0edvoWBkB9Wn/A25QtlF5JtvHa
         1+rfLliOwqNB5vA3mih0/YqJPPZnM6iasuxYqsoY/VWi9J5b7VhwY/wBi5t5wuAEzt
         E0NZjio21ZlOUnfN7UhugeaCb6l9OtV7kLEvftP0=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 11 Sep 2020 19:52:51 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 11 Sep 2020 19:52:51 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>
Subject: RE: [PATCH v3 04/10] fs/ntfs3: Add file operations and implementation
Thread-Topic: [PATCH v3 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Index: AQHWfUkmGGliHMdep0qOFBeV9s6Y96lYNmaAgAt9wEA=
Date:   Fri, 11 Sep 2020 16:52:50 +0000
Message-ID: <820d8a637a41448194f60dee4361dea0@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
 <20200904115049.i6zjfwba7egalxnp@pali>
In-Reply-To: <20200904115049.i6zjfwba7egalxnp@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pali Roh=E1r <pali@kernel.org>
Sent: Friday, September 4, 2020 2:51 PM
>=20
> Hello Konstantin!
>=20
> On Friday 28 August 2020 07:39:32 Konstantin Komarov wrote:
> > +/*
> > + * Convert little endian utf16 to UTF-8.
>=20
> There is mistake in comment. This function converts UTF-16 to some NLS.
> It does not have to be UTF-8.

Hi Pali! Thanks! Fixed, please check out the v5.

>=20
> > + */
> > +int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *u=
ni,
> > +		      u8 *buf, int buf_len)
> > +{
> > +	int ret, uni_len;
> > +	const __le16 *ip;
> > +	u8 *op;
> > +	struct nls_table *nls =3D sbi->nls;
> > +
> > +	static_assert(sizeof(wchar_t) =3D=3D sizeof(__le16));
> > +
> > +	if (!nls) {
> > +		/* utf16 -> utf8 */
> > +		ret =3D utf16s_to_utf8s((wchar_t *)uni->name, uni->len,
> > +				      UTF16_HOST_ENDIAN, buf, buf_len);
>=20
> In comment you wrote that input is little endian, but here you use host
> endian. Can you check what should be correct behavior (little or host
> endian) and update code or comment?
>=20

Fixed in v5 as well.

> > +		buf[ret] =3D '\0';
> > +		return ret;
> > +	}
> > +
> > +	ip =3D uni->name;
> > +	op =3D buf;
> > +	uni_len =3D uni->len;
> > +
> > +	while (uni_len--) {
> > +		u16 ec;
> > +		int charlen;
> > +
> > +		if (buf_len < NLS_MAX_CHARSET_SIZE) {
> > +			ntfs_printk(sbi->sb, KERN_WARNING
> > +				    "filename was truncated while converting.");
> > +			break;
> > +		}
> > +
> > +		ec =3D le16_to_cpu(*ip++);
>=20
> In this branch (when nls variable is non-NULL) you expects that input is
> in UTF-16 little endian. So probably in above utf16s_to_utf8s() call
> should be used UTF-16 little endian too. But please recheck it.
>=20
> > +		charlen =3D nls->uni2char(ec, op, buf_len);
> > +
> > +		if (charlen > 0) {
> > +			op +=3D charlen;
> > +			buf_len -=3D charlen;
> > +		} else {
> > +			*op++ =3D ':';
> > +			op =3D hex_byte_pack(op, ec >> 8);
> > +			op =3D hex_byte_pack(op, ec);
> > +			buf_len -=3D 5;
> > +		}
> > +	}
> > +
> > +	*op =3D '\0';
> > +	return op - buf;
> > +}
> > +
> > +static inline u8 get_digit(u8 d)
> > +{
> > +	u8 x =3D d & 0xf;
> > +
> > +	return x <=3D 9 ? ('0' + x) : ('A' + x - 10);
> > +}
> > +
> > +#define PLANE_SIZE 0x00010000
> > +
> > +#define SURROGATE_PAIR 0x0000d800
> > +#define SURROGATE_LOW 0x00000400
> > +#define SURROGATE_BITS 0x000003ff
> > +
> > +/*
> > + * modified version of 'utf8s_to_utf16s' allows to
> > + * - detect -ENAMETOOLONG
> > + * - convert problem symbols into triplet %XX
>=20
> In this UTF-8 context it is not 'symbols', but rather 'bytes'.
>=20
> Anyway, what is the purpose of converting invalid UTF-8 bytes into
> triplet %XX? UNICODE standard defines standard algorithm how to handle
> malformed UTF-8 input, so I think we should use it here, instead of
> defining new own/custom way. This algorithm decodes malformed UTF-8 byte
> sequence as sequence of UNICODE code points U+FFFD.
>=20

Thanks for pointing that out. This was a piece of logic we've implemented
as a workaround for a custom case (mixed utf8/latin1 encoding in file names=
).
Instead of throwing an error (which utf8s_to_utf16s() does) we've converted
this into triplets. However, trying to reach the Linux Kernel with the code=
,
it's better to stick to standard. We've replaced this part of code in v5 an=
d
now process the situation the same way as kernel's utf8s_to_utf16s() does.
Please also take a look at other parts of the utf8s_to_utf16s() in our code=
.
It seems the kernel implementation misses the ENAMETOOLONG return in the ca=
se
if IN string exceeds the size. Do you think this change may be needed/profi=
table
for the kernel implementation as well? In our v5 code, this ENAMETOOLONG th=
ing is the
single difference compared to kernel implementation.

> > + */
> > +static int _utf8s_to_utf16s(const u8 *s, int inlen, wchar_t *pwcs, int=
 maxout)
> > +{
> > +	u16 *op;
> > +	int size;
> > +	unicode_t u;
> > +
> > +	op =3D pwcs;
> > +	while (inlen > 0 && *s) {
> > +		if (*s & 0x80) {
> > +			size =3D utf8_to_utf32(s, inlen, &u);
> > +			if (size < 0) {
> > +				if (maxout < 3)
> > +					return -ENAMETOOLONG;
> > +
> > +				op[0] =3D '%';
> > +				op[1] =3D get_digit(*s >> 4);
> > +				op[2] =3D get_digit(*s >> 0);
> > +
> > +				op +=3D 3;
> > +				maxout -=3D 3;
> > +				inlen--;
> > +				s++;
> > +				continue;
> > +			}
> > +
> > +			s +=3D size;
> > +			inlen -=3D size;
> > +
> > +			if (u >=3D PLANE_SIZE) {
> > +				if (maxout < 2)
> > +					return -ENAMETOOLONG;
> > +				u -=3D PLANE_SIZE;
> > +
> > +				op[0] =3D SURROGATE_PAIR |
> > +					((u >> 10) & SURROGATE_BITS);
> > +				op[1] =3D SURROGATE_PAIR | SURROGATE_LOW |
> > +					(u & SURROGATE_BITS);
> > +				op +=3D 2;
> > +				maxout -=3D 2;
> > +			} else {
> > +				if (maxout < 1)
> > +					return -ENAMETOOLONG;
> > +
> > +				*op++ =3D u;
> > +				maxout--;
> > +			}
> > +		} else {
> > +			if (maxout < 1)
> > +				return -ENAMETOOLONG;
> > +
> > +			*op++ =3D *s++;
> > +			inlen--;
> > +			maxout--;
> > +		}
> > +	}
> > +	return op - pwcs;
> > +}
> > +
> > +/*
> > + * Convert input string to utf16
> > + *
> > + * name, name_len - input name
> > + * uni, max_ulen - destination memory
> > + * endian - endian of target utf16 string
> > + *
> > + * This function is called:
> > + * - to create ntfs names (max_ulen =3D=3D NTFS_NAME_LEN =3D=3D 255)
> > + * - to create symlink
> > + *
> > + * returns utf16 string length or error (if negative)
> > + */
> > +int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 na=
me_len,
> > +		      struct cpu_str *uni, u32 max_ulen,
> > +		      enum utf16_endian endian)
> > +{
> > +	int i, ret, slen, warn;
> > +	u32 tail;
> > +	const u8 *str, *end;
> > +	wchar_t *uname =3D uni->name;
> > +	struct nls_table *nls =3D sbi->nls;
> > +
> > +	static_assert(sizeof(wchar_t) =3D=3D sizeof(u16));
> > +
> > +	if (!nls) {
> > +		/* utf8 -> utf16 */
> > +		ret =3D _utf8s_to_utf16s(name, name_len, uname, max_ulen);
> > +		if (ret < 0)
> > +			return ret;
> > +		goto out;
> > +	}
> > +
> > +	str =3D name;
> > +	end =3D name + name_len;
> > +	warn =3D 0;
> > +
> > +	while (str < end && *str) {
> > +		if (!max_ulen)
> > +			return -ENAMETOOLONG;
> > +		tail =3D end - str;
> > +
> > +		/*str -> uname*/
> > +		slen =3D nls->char2uni(str, tail, uname);
> > +		if (slen > 0) {
>=20
> I'm not sure, but is not zero return value from char2uni also valid
> conversion? I'm not sure if some NLSs could use escape sequences and
> processing escape sequence would lead to no output, but still it is
> valid conversion to UNICODE.
>=20
> I looked into exfat driver and it treats only negative value from
> char2uni as error.
>=20

Looks like this part of code will become an infinite loop in case if
char2uni will be 0 ( fs/exfat/namei.c ):
for (i =3D 0; i < len; i +=3D charlen) {
    charlen =3D t->char2uni(&name[i], len - i, &c);
    if (charlen < 0)
        return charlen;
    hash =3D partial_name_hash(exfat_toupper(sb, c), hash);
}

> > +			max_ulen -=3D 1;
> > +			uname +=3D 1;
> > +			str +=3D slen;
> > +			continue;
> > +		}
> > +
> > +		if (!warn) {
> > +			warn =3D 1;
> > +			ntfs_printk(
> > +				sbi->sb,
> > +				KERN_ERR
> > +				"%s -> utf16 failed: '%.*s', pos %d, chars %x %x %x",
> > +				nls->charset, name_len, name, (int)(str - name),
> > +				str[0], tail > 1 ? str[1] : 0,
> > +				tail > 2 ? str[2] : 0);
> > +		}
> > +
> > +		if (max_ulen < 3)
> > +			return -ENAMETOOLONG;
> > +
> > +		uname[0] =3D '%';
> > +		uname[1] =3D get_digit(*str >> 4);
> > +		uname[2] =3D get_digit(*str >> 0);
> > +
> > +		max_ulen -=3D 3;
> > +		uname +=3D 3;
> > +		str +=3D 1;
> > +	}
> > +
> > +	ret =3D uname - uni->name;
> > +out:
> > +	uni->len =3D ret;
> > +
> > +#ifdef __BIG_ENDIAN
> > +	if (endian =3D=3D UTF16_LITTLE_ENDIAN) {
> > +		i =3D ret;
> > +		uname =3D uni->name;
> > +
> > +		while (i--) {
> > +			__cpu_to_le16s(uname);
> > +			uname++;
> > +		}
> > +	}
> > +#else
> > +	if (endian =3D=3D UTF16_BIG_ENDIAN) {
> > +		i =3D ret;
> > +		uname =3D uni->name;
> > +
> > +		while (i--) {
> > +			__cpu_to_be16s(uname);
> > +			uname++;
> > +		}
> > +	}
> > +#endif
> > +
> > +	return ret;
> > +}
> > +
>=20
>=20
> ...
>=20
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> > new file mode 100644
> > index 000000000000..72c6a263b5bc
> > --- /dev/null
> > +++ b/fs/ntfs3/file.c
> > @@ -0,0 +1,1214 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  linux/fs/ntfs3/file.c
> > + *
> > + * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
> > + *
> > + *  regular file handling primitives for ntfs-based filesystems
> > + */
> > +#include <linux/backing-dev.h>
> > +#include <linux/buffer_head.h>
> > +#include <linux/compat.h>
> > +#include <linux/falloc.h>
> > +#include <linux/fiemap.h>
> > +#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
> > +#include <linux/nls.h>
> > +
> > +#include "debug.h"
> > +#include "ntfs.h"
> > +#include "ntfs_fs.h"
> > +
> > +static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long a=
rg)
> > +{
> > +	struct fstrim_range __user *user_range;
> > +	struct fstrim_range range;
> > +	struct request_queue *q =3D bdev_get_queue(sbi->sb->s_bdev);
> > +	int err;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	if (!blk_queue_discard(q))
> > +		return -EOPNOTSUPP;
> > +
> > +	user_range =3D (struct fstrim_range __user *)arg;
> > +	if (copy_from_user(&range, user_range, sizeof(range)))
> > +		return -EFAULT;
> > +
> > +	range.minlen =3D max_t(u32, range.minlen, q->limits.discard_granulari=
ty);
> > +
> > +	err =3D ntfs_trim_fs(sbi, &range);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (copy_to_user(user_range, &range, sizeof(range)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
> > +{
> > +	struct inode *inode =3D file_inode(filp);
> > +	struct ntfs_sb_info *sbi =3D inode->i_sb->s_fs_info;
> > +	u32 __user *user_attr =3D (u32 __user *)arg;
> > +
> > +	switch (cmd) {
> > +	case FAT_IOCTL_GET_ATTRIBUTES:
> > +		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
> > +
> > +	case FAT_IOCTL_GET_VOLUME_ID:
> > +		return put_user(sbi->volume.ser_num, user_attr);
>=20
> Question for fs maintainers: Do we want to reuse FAT ioctls in NTFS drive=
r?
>=20

On this, we'll keep the code in the state which will be acceptable for main=
tainers.

> > +	case FITRIM:
> > +		return ntfs_ioctl_fitrim(sbi, arg);
> > +	}
> > +	return -ENOTTY; /* Inappropriate ioctl for device */
> > +}
> > +
