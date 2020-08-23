Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881DD24EC9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHWJso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 05:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgHWJsn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:48:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5282074D;
        Sun, 23 Aug 2020 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598176122;
        bh=RSOHL3CuM5pG6W7EsM5hNhVchje6eBG/hfRKV0DR5pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2LZKMUJb1hYtw1zvCHGH8GEWB8rooQJlzeJRyofmijWC5YoKTJD7ScGonKJaSgtx
         jXKR5Ya5QvsNLTBk9A8+r7IDSgb1Up+3NbOmXzevmhRwwL3b6TuMdfwmMFV/cvzUcQ
         5cn+ipOvJIHI/yufJIz7jCfd2Af2zI9+vM7XgPTg=
Received: by pali.im (Postfix)
        id E3C93EA3; Sun, 23 Aug 2020 11:48:39 +0200 (CEST)
Date:   Sun, 23 Aug 2020 11:48:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] fs/ntfs3: Add file operations and implementation
Message-ID: <20200823094839.nb2kchfbvwvynorq@pali>
References: <f8b5a938664e43c3b81df41f5c430c68@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8b5a938664e43c3b81df41f5c430c68@paragon-software.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Konstantin!

On Friday 21 August 2020 16:25:15 Konstantin Komarov wrote:
> diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
> new file mode 100644
> index 000000000000..5f1105f1283c
> --- /dev/null
> +++ b/fs/ntfs3/dir.c
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/fs/ntfs3/dir.c
> + *
> + * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
> + *
> + *  directory handling functions for ntfs-based filesystems
> + *
> + */
> +#include <linux/blkdev.h>
> +#include <linux/buffer_head.h>
> +#include <linux/fs.h>
> +#include <linux/iversion.h>
> +#include <linux/nls.h>
> +
> +#include "debug.h"
> +#include "ntfs.h"
> +#include "ntfs_fs.h"
> +
> +/*
> + * Convert little endian Unicode 16 to UTF-8.

I guess that by "Unicode 16" you mean UTF-16, right?

Anyway, comment is incorrect as function does not support UTF-16 nor
UTF-8. This function works only with UCS-2 encoding (not full UTD-16)
and converts input buffer to NLS encoding, not UTF-8. Moreover kernel's
NLS API does not support full UTF-8 and NLS's UTF-8 encoding is semi
broken and limited to just 3-byte sequences. Which means it does not
allow to access all UNICODE filenames.

So result is that comment for uni_to_x8 function is incorrect.

I would suggest to not use NLS API for encoding from/to UTF-8, but
rather use utf16s_to_utf8s() and utf8s_to_utf16s() functions.

See for example how it is implemented in exfat driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/exfat/nls.c
Look for functions exfat_utf16_to_nls() and exfat_nls_to_utf16().

Ideally check if you can store character 💩 (Pile of Poo, U+1F4A9, does
not fit into 3byte UTF-8 sequence) into filename and if there is correct
interoperability between Windows and this new ntfs3 implementation.

> + */
> +int uni_to_x8(ntfs_sb_info *sbi, const struct le_str *uni, u8 *buf, int buf_len)
> +{
> +	const __le16 *ip = uni->name;
> +	u8 *op = buf;
> +	struct nls_table *nls = sbi->nls;
> +	int uni_len = uni->len;
> +
> +	static_assert(sizeof(wchar_t) == sizeof(__le16));
> +
> +	while (uni_len--) {
> +		u16 ec;
> +		int charlen;
> +
> +		if (buf_len < NLS_MAX_CHARSET_SIZE) {
> +			ntfs_warning(
> +				sbi->sb,
> +				"filename was truncated while converting.");
> +			break;
> +		}
> +
> +		ec = le16_to_cpu(*ip++);
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
> +	*op = 0;
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
> +/*
> + * Convert input string to unicode
> + * max_ulen - maximum possible unicode length
> + * endian - unicode endian
> + */
> +int x8_to_uni(ntfs_sb_info *sbi, const u8 *name, u32 name_len,
> +	      struct cpu_str *uni, u32 max_ulen, enum utf16_endian endian)
> +{
> +	int i, ret, clen;
> +	u32 tail;
> +	const u8 *str = name;
> +	const u8 *end = name + name_len;
> +	u16 *uname = uni->name;
> +	struct nls_table *nls = sbi->nls;
> +	int warn = 0;
> +
> +	static_assert(sizeof(wchar_t) == sizeof(u16));
> +
> +	for (ret = 0; str < end; ret += 1, uname += 1, str += clen) {
> +		if (ret >= max_ulen)
> +			return -ENAMETOOLONG;
> +		tail = end - str;
> +
> +		clen = nls->char2uni(str, tail, uname);
> +		if (clen > 0)
> +			continue;
> +
> +		if (!warn) {
> +			warn = 1;
> +			ntfs_warning(
> +				sbi->sb,
> +				"%s -> unicode failed: '%.*s', pos %d, chars %x %x %x",
> +				nls->charset, name_len, name, (int)(str - name),
> +				str[0], tail > 1 ? str[1] : 0,
> +				tail > 2 ? str[2] : 0);
> +		}
> +
> +		if (ret + 3 > max_ulen)
> +			return -ENAMETOOLONG;
> +
> +		uname[0] = '%';
> +		uname[1] = get_digit(*str >> 4);
> +		uname[2] = get_digit(*str >> 0);
> +
> +		uname += 2;
> +		ret += 2; // +1 will be added in for ( .... )
> +		clen = 1;
> +	}
> +
> +#ifdef __BIG_ENDIAN
> +	if (endian == UTF16_LITTLE_ENDIAN) {
> +		__le16 *uname = (__le16 *)uni->name;
> +
> +		for (i = 0; i < ret; i++, uname++)
> +			*uname = cpu_to_le16(*name);
> +	}
> +#else
> +	if (endian == UTF16_BIG_ENDIAN) {
> +		__be16 *uname = (__be16 *)uni->name;
> +
> +		for (i = 0; i < ret; i++, uname++)
> +			*uname = cpu_to_be16(*name);
> +	}
> +#endif
> +
> +	uni->len = ret;
> +	return ret;
> +}
