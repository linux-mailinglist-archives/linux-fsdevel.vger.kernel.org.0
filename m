Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635A565F09A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 16:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjAEP4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 10:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjAEP4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:56:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128B6326
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672934132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBNU3VIvv0Lg3ecO5+t5pdiiz768VTqxLlFC0U2szuc=;
        b=QCTF7UBeiddeQ8/EmCdNhA9AvhUuftcGnt98pJ7gEWA4MB4Rg5J//bRCKqaSwVA/7ykUYP
        r5DyZ13p2AQ/4Cj9o7bD5mqdJmDXW1CXWHsbaLK7oHajGPmO3qEnKIE/F5b7dbgFfZe1sB
        WWRcAtZYv9FymKN01DoUZAYJDOTcLCM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-xBELkGlOP_GhWdD0I2u_Lw-1; Thu, 05 Jan 2023 10:55:31 -0500
X-MC-Unique: xBELkGlOP_GhWdD0I2u_Lw-1
Received: by mail-vk1-f200.google.com with SMTP id w22-20020a1fad16000000b003d5d7c16e71so3068380vke.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 07:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBNU3VIvv0Lg3ecO5+t5pdiiz768VTqxLlFC0U2szuc=;
        b=l3wxLFhrQQH3SDQ3GgL0PVFGO4fZrxOSt/hAfntXwbqILK6DmRPkK80O3rCEFDo8/d
         oKU5R4zCT78pVU3WcdcG25ShdFi67FUa/zKxJbPAjZpsoNZY0/1r8+WSrIRMBxPQsz6Q
         xWTJXLbSDWgCDCsmkWmz+SmCTlyomFcTfij32FouHQMcrsjSycChHohOVQqUR3hz0Ev5
         h5KGErNtaYV3v2L9OwXEM7fmL8kWPOAMWQ2iXB9kBdRjMPi5L6l6SekNlWCDfi/ZPK9A
         iB1x9qFnGRxAfJ9k642k3ix+M+WOLd0N69MEeZ4PyqAeFRGNgsZHHEnND9u45ahlRkU0
         NNwA==
X-Gm-Message-State: AFqh2ko2TFEP04zDUs3WtFH6n+fQ21aB6yUxkw7fwspRkZGIfKtyfv70
        x9u60wjsl/67TVKeOTsi3p7+VXXzPygDx5aBMp18QtkF+qwwh2+4fR69YGJQ1nSIn8vkOcdbaRu
        iQFWWNDUyHBdBC9MQNPc/oNm/fQ==
X-Received: by 2002:a05:6122:4d:b0:3d5:ec83:511c with SMTP id q13-20020a056122004d00b003d5ec83511cmr5525306vkn.12.1672934130769;
        Thu, 05 Jan 2023 07:55:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuLtn4rKDFfRiehYDUfitP/nNOf/5dbrgvceHVBDB3sl1tUmeZ5RWi95BuWEHBzKFVscMnExA==
X-Received: by 2002:a05:6122:4d:b0:3d5:ec83:511c with SMTP id q13-20020a056122004d00b003d5ec83511cmr5525294vkn.12.1672934130505;
        Thu, 05 Jan 2023 07:55:30 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a05620a0d8a00b006b949afa980sm25726912qkl.56.2023.01.05.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:55:29 -0800 (PST)
Date:   Thu, 5 Jan 2023 10:55:28 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH 2/6] composefs: Add on-disk layout
Message-ID: <Y7by8Pv6z+Z1o3pu@x1>
References: <cover.1669631086.git.alexl@redhat.com>
 <cbe0d67a97c8b5157de06cedb67c88794c9c304e.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe0d67a97c8b5157de06cedb67c88794c9c304e.1669631086.git.alexl@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:16:23PM +0100, Alexander Larsson wrote:
> This commit adds the on-disk layout header file of composefs.
> 
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Add Co-Developed-By: Giuseppe ... ?

Full disclosure: I'm not a file system developer but I'll attempt to
help with the review of this series.

> ---
>  fs/composefs/cfs.h | 242 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 fs/composefs/cfs.h
> 
> diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
> new file mode 100644
> index 000000000000..8f001fd28d6b
> --- /dev/null
> +++ b/fs/composefs/cfs.h
> @@ -0,0 +1,242 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * composefs
> + *
> + * Copyright (C) 2021 Giuseppe Scrivano
> + * Copyright (C) 2022 Alexander Larsson
> + *
> + * This file is released under the GPL.
> + */
> +
> +#ifndef _CFS_H
> +#define _CFS_H
> +
> +#include <asm/byteorder.h>
> +#include <crypto/sha2.h>
> +#include <linux/fs.h>
> +#include <linux/stat.h>
> +#include <linux/types.h>
> +
> +#define CFS_VERSION 1
> +
> +#define CFS_MAGIC 0xc078629aU
> +
> +#define CFS_MAX_DIR_CHUNK_SIZE 4096
> +#define CFS_MAX_XATTRS_SIZE 4096
> +
> +static inline u16 cfs_u16_to_file(u16 val)
> +{
> +	return cpu_to_le16(val);
> +}
> +
> +static inline u32 cfs_u32_to_file(u32 val)
> +{
> +	return cpu_to_le32(val);
> +}
> +
> +static inline u64 cfs_u64_to_file(u64 val)
> +{
> +	return cpu_to_le64(val);
> +}
> +
> +static inline u16 cfs_u16_from_file(u16 val)
> +{
> +	return le16_to_cpu(val);
> +}
> +
> +static inline u32 cfs_u32_from_file(u32 val)
> +{
> +	return le32_to_cpu(val);
> +}
> +
> +static inline u64 cfs_u64_from_file(u64 val)
> +{
> +	return le64_to_cpu(val);
> +}

I don't see where the cfs_xxx_{to,from}_file() approach is used in other
filesystems. Instead, move the cpu() functions directly into the code.

> +static inline int cfs_xdigit_value(char c)
> +{
> +	if (c >= '0' && c <= '9')
> +		return c - '0';
> +	if (c >= 'A' && c <= 'F')
> +		return c - 'A' + 10;
> +	if (c >= 'a' && c <= 'f')
> +		return c - 'a' + 10;
> +	return -1;
> +}

There's some utilities in lib/hexdump.c that you can use. hex_to_bin()
will convert a single character and hex2bin() will convert a string for
you.

> +static inline int cfs_digest_from_payload(const char *payload,
> +					  size_t payload_len,
> +					  u8 digest_out[SHA256_DIGEST_SIZE])
> +{
> +	const char *p, *end;
> +	u8 last_digit = 0;
> +	int digit = 0;
> +	size_t n_nibbles = 0;

Put in reverse Christmas tree order.

> +
> +	end = payload + payload_len;
> +	for (p = payload; p != end; p++) {
> +		/* Skip subdir structure */
> +		if (*p == '/')
> +			continue;
> +
> +		/* Break at (and ignore) extension */
> +		if (*p == '.')
> +			break;

A comment would be helpful in this area that shows what the payload is
expected to be.

> +
> +		if (n_nibbles == SHA256_DIGEST_SIZE * 2)
> +			return -1; /* Too long */

return -EINVAL; ?

> +
> +		digit = cfs_xdigit_value(*p);
> +		if (digit == -1)
> +			return -1; /* Not hex digit */

-EINVAL here as well

> +
> +		n_nibbles++;
> +		if ((n_nibbles % 2) == 0) {
> +			digest_out[n_nibbles / 2 - 1] =
> +				(last_digit << 4) | digit;
> +		}
> +		last_digit = digit;
> +	}
> +
> +	if (n_nibbles != SHA256_DIGEST_SIZE * 2)
> +		return -1; /* Too short */

-EINVAL here as well

> +
> +	return 0;
> +}
> +
> +struct cfs_vdata_s {
> +	u64 off;
> +	u32 len;
> +} __packed;
> +
> +struct cfs_header_s {
> +	u8 version;
> +	u8 unused1;
> +	u16 unused2;
> +
> +	u32 magic;

Should the magic number appear first?

> +	u64 data_offset;
> +	u64 root_inode;
> +
> +	u64 unused3[2];
> +} __packed;
> +
> +enum cfs_inode_flags {
> +	CFS_INODE_FLAGS_NONE = 0,
> +	CFS_INODE_FLAGS_PAYLOAD = 1 << 0,
> +	CFS_INODE_FLAGS_MODE = 1 << 1,
> +	CFS_INODE_FLAGS_NLINK = 1 << 2,
> +	CFS_INODE_FLAGS_UIDGID = 1 << 3,
> +	CFS_INODE_FLAGS_RDEV = 1 << 4,
> +	CFS_INODE_FLAGS_TIMES = 1 << 5,
> +	CFS_INODE_FLAGS_TIMES_NSEC = 1 << 6,
> +	CFS_INODE_FLAGS_LOW_SIZE = 1 << 7, /* Low 32bit of st_size */
> +	CFS_INODE_FLAGS_HIGH_SIZE = 1 << 8, /* High 32bit of st_size */
> +	CFS_INODE_FLAGS_XATTRS = 1 << 9,
> +	CFS_INODE_FLAGS_DIGEST = 1
> +				 << 10, /* fs-verity sha256 digest of content */

Include << 10 on line above

Brian

