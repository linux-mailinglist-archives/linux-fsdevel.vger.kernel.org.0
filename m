Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21425D7D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgIDLvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 07:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDLuw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:50:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4945520791;
        Fri,  4 Sep 2020 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599220251;
        bh=7cXKQGwPVNPUPzK9+FfVH8ML9JGgpLnasoHSFwYrCZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0fca43Dbk2+AB48bgZS9lpYtkNALjVoXdU2Q4QCcMQnHTek2KfZcXtimEnXwD+VV
         9mrRY5JLZHHOIhra/8EYhKsQhFz1m6Kcq73VIv8KkhGyOkNRNUb2Ye6p5TGczo6Gt1
         GJ6OFI8RZQuKBv08/nn4QFC8Df4JEUTEND3FR6D4=
Received: by pali.im (Postfix)
        id 58B206EC; Fri,  4 Sep 2020 13:50:49 +0200 (CEST)
Date:   Fri, 4 Sep 2020 13:50:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com
Subject: Re: [PATCH v3 04/10] fs/ntfs3: Add file operations and implementation
Message-ID: <20200904115049.i6zjfwba7egalxnp@pali>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Konstantin!

On Friday 28 August 2020 07:39:32 Konstantin Komarov wrote:
> +/*
> + * Convert little endian utf16 to UTF-8.

There is mistake in comment. This function converts UTF-16 to some NLS.
It does not have to be UTF-8.

> + */
> +int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
> +		      u8 *buf, int buf_len)
> +{
> +	int ret, uni_len;
> +	const __le16 *ip;
> +	u8 *op;
> +	struct nls_table *nls = sbi->nls;
> +
> +	static_assert(sizeof(wchar_t) == sizeof(__le16));
> +
> +	if (!nls) {
> +		/* utf16 -> utf8 */
> +		ret = utf16s_to_utf8s((wchar_t *)uni->name, uni->len,
> +				      UTF16_HOST_ENDIAN, buf, buf_len);

In comment you wrote that input is little endian, but here you use host
endian. Can you check what should be correct behavior (little or host
endian) and update code or comment?

> +		buf[ret] = '\0';
> +		return ret;
> +	}
> +
> +	ip = uni->name;
> +	op = buf;
> +	uni_len = uni->len;
> +
> +	while (uni_len--) {
> +		u16 ec;
> +		int charlen;
> +
> +		if (buf_len < NLS_MAX_CHARSET_SIZE) {
> +			ntfs_printk(sbi->sb, KERN_WARNING
> +				    "filename was truncated while converting.");
> +			break;
> +		}
> +
> +		ec = le16_to_cpu(*ip++);

In this branch (when nls variable is non-NULL) you expects that input is
in UTF-16 little endian. So probably in above utf16s_to_utf8s() call
should be used UTF-16 little endian too. But please recheck it.

> +		charlen = nls->uni2char(ec, op, buf_len);
> +
> +		if (charlen > 0) {
> +			op += charlen;
> +			buf_len -= charlen;
> +		} else {
> +			*op++ = ':';
> +			op = hex_byte_pack(op, ec >> 8);
> +			op = hex_byte_pack(op, ec);
> +			buf_len -= 5;
> +		}
> +	}
> +
> +	*op = '\0';
> +	return op - buf;
> +}
> +
> +static inline u8 get_digit(u8 d)
> +{
> +	u8 x = d & 0xf;
> +
> +	return x <= 9 ? ('0' + x) : ('A' + x - 10);
> +}
> +
> +#define PLANE_SIZE 0x00010000
> +
> +#define SURROGATE_PAIR 0x0000d800
> +#define SURROGATE_LOW 0x00000400
> +#define SURROGATE_BITS 0x000003ff
> +
> +/*
> + * modified version of 'utf8s_to_utf16s' allows to
> + * - detect -ENAMETOOLONG
> + * - convert problem symbols into triplet %XX

In this UTF-8 context it is not 'symbols', but rather 'bytes'.

Anyway, what is the purpose of converting invalid UTF-8 bytes into
triplet %XX? UNICODE standard defines standard algorithm how to handle
malformed UTF-8 input, so I think we should use it here, instead of
defining new own/custom way. This algorithm decodes malformed UTF-8 byte
sequence as sequence of UNICODE code points U+FFFD.

> + */
> +static int _utf8s_to_utf16s(const u8 *s, int inlen, wchar_t *pwcs, int maxout)
> +{
> +	u16 *op;
> +	int size;
> +	unicode_t u;
> +
> +	op = pwcs;
> +	while (inlen > 0 && *s) {
> +		if (*s & 0x80) {
> +			size = utf8_to_utf32(s, inlen, &u);
> +			if (size < 0) {
> +				if (maxout < 3)
> +					return -ENAMETOOLONG;
> +
> +				op[0] = '%';
> +				op[1] = get_digit(*s >> 4);
> +				op[2] = get_digit(*s >> 0);
> +
> +				op += 3;
> +				maxout -= 3;
> +				inlen--;
> +				s++;
> +				continue;
> +			}
> +
> +			s += size;
> +			inlen -= size;
> +
> +			if (u >= PLANE_SIZE) {
> +				if (maxout < 2)
> +					return -ENAMETOOLONG;
> +				u -= PLANE_SIZE;
> +
> +				op[0] = SURROGATE_PAIR |
> +					((u >> 10) & SURROGATE_BITS);
> +				op[1] = SURROGATE_PAIR | SURROGATE_LOW |
> +					(u & SURROGATE_BITS);
> +				op += 2;
> +				maxout -= 2;
> +			} else {
> +				if (maxout < 1)
> +					return -ENAMETOOLONG;
> +
> +				*op++ = u;
> +				maxout--;
> +			}
> +		} else {
> +			if (maxout < 1)
> +				return -ENAMETOOLONG;
> +
> +			*op++ = *s++;
> +			inlen--;
> +			maxout--;
> +		}
> +	}
> +	return op - pwcs;
> +}
> +
> +/*
> + * Convert input string to utf16
> + *
> + * name, name_len - input name
> + * uni, max_ulen - destination memory
> + * endian - endian of target utf16 string
> + *
> + * This function is called:
> + * - to create ntfs names (max_ulen == NTFS_NAME_LEN == 255)
> + * - to create symlink
> + *
> + * returns utf16 string length or error (if negative)
> + */
> +int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
> +		      struct cpu_str *uni, u32 max_ulen,
> +		      enum utf16_endian endian)
> +{
> +	int i, ret, slen, warn;
> +	u32 tail;
> +	const u8 *str, *end;
> +	wchar_t *uname = uni->name;
> +	struct nls_table *nls = sbi->nls;
> +
> +	static_assert(sizeof(wchar_t) == sizeof(u16));
> +
> +	if (!nls) {
> +		/* utf8 -> utf16 */
> +		ret = _utf8s_to_utf16s(name, name_len, uname, max_ulen);
> +		if (ret < 0)
> +			return ret;
> +		goto out;
> +	}
> +
> +	str = name;
> +	end = name + name_len;
> +	warn = 0;
> +
> +	while (str < end && *str) {
> +		if (!max_ulen)
> +			return -ENAMETOOLONG;
> +		tail = end - str;
> +
> +		/*str -> uname*/
> +		slen = nls->char2uni(str, tail, uname);
> +		if (slen > 0) {

I'm not sure, but is not zero return value from char2uni also valid
conversion? I'm not sure if some NLSs could use escape sequences and
processing escape sequence would lead to no output, but still it is
valid conversion to UNICODE.

I looked into exfat driver and it treats only negative value from
char2uni as error.

> +			max_ulen -= 1;
> +			uname += 1;
> +			str += slen;
> +			continue;
> +		}
> +
> +		if (!warn) {
> +			warn = 1;
> +			ntfs_printk(
> +				sbi->sb,
> +				KERN_ERR
> +				"%s -> utf16 failed: '%.*s', pos %d, chars %x %x %x",
> +				nls->charset, name_len, name, (int)(str - name),
> +				str[0], tail > 1 ? str[1] : 0,
> +				tail > 2 ? str[2] : 0);
> +		}
> +
> +		if (max_ulen < 3)
> +			return -ENAMETOOLONG;
> +
> +		uname[0] = '%';
> +		uname[1] = get_digit(*str >> 4);
> +		uname[2] = get_digit(*str >> 0);
> +
> +		max_ulen -= 3;
> +		uname += 3;
> +		str += 1;
> +	}
> +
> +	ret = uname - uni->name;
> +out:
> +	uni->len = ret;
> +
> +#ifdef __BIG_ENDIAN
> +	if (endian == UTF16_LITTLE_ENDIAN) {
> +		i = ret;
> +		uname = uni->name;
> +
> +		while (i--) {
> +			__cpu_to_le16s(uname);
> +			uname++;
> +		}
> +	}
> +#else
> +	if (endian == UTF16_BIG_ENDIAN) {
> +		i = ret;
> +		uname = uni->name;
> +
> +		while (i--) {
> +			__cpu_to_be16s(uname);
> +			uname++;
> +		}
> +	}
> +#endif
> +
> +	return ret;
> +}
> +


...

> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> new file mode 100644
> index 000000000000..72c6a263b5bc
> --- /dev/null
> +++ b/fs/ntfs3/file.c
> @@ -0,0 +1,1214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/fs/ntfs3/file.c
> + *
> + * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
> + *
> + *  regular file handling primitives for ntfs-based filesystems
> + */
> +#include <linux/backing-dev.h>
> +#include <linux/buffer_head.h>
> +#include <linux/compat.h>
> +#include <linux/falloc.h>
> +#include <linux/fiemap.h>
> +#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
> +#include <linux/nls.h>
> +
> +#include "debug.h"
> +#include "ntfs.h"
> +#include "ntfs_fs.h"
> +
> +static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
> +{
> +	struct fstrim_range __user *user_range;
> +	struct fstrim_range range;
> +	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
> +	int err;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (!blk_queue_discard(q))
> +		return -EOPNOTSUPP;
> +
> +	user_range = (struct fstrim_range __user *)arg;
> +	if (copy_from_user(&range, user_range, sizeof(range)))
> +		return -EFAULT;
> +
> +	range.minlen = max_t(u32, range.minlen, q->limits.discard_granularity);
> +
> +	err = ntfs_trim_fs(sbi, &range);
> +	if (err < 0)
> +		return err;
> +
> +	if (copy_to_user(user_range, &range, sizeof(range)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
> +	u32 __user *user_attr = (u32 __user *)arg;
> +
> +	switch (cmd) {
> +	case FAT_IOCTL_GET_ATTRIBUTES:
> +		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
> +
> +	case FAT_IOCTL_GET_VOLUME_ID:
> +		return put_user(sbi->volume.ser_num, user_attr);

Question for fs maintainers: Do we want to reuse FAT ioctls in NTFS driver?

> +	case FITRIM:
> +		return ntfs_ioctl_fitrim(sbi, arg);
> +	}
> +	return -ENOTTY; /* Inappropriate ioctl for device */
> +}
> +
