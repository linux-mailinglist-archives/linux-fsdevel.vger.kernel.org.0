Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53766B53E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 02:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAPB3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 20:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAPB3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:29:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21065BA5
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jan 2023 17:29:09 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso29642971pjf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jan 2023 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M99cieRI+weLmSDxkSaR7znpx2pt3wlg3kJDip+weFc=;
        b=WhRhzJ4H8l8bVlHeNjwO76z7iqBCp61PKRYqMxBfZx/IoImSJpRAgX2QItw/KpfxN5
         /6LjIIb+WQ0yiYq6DsCCXddl/YTfS/0BtPmoRD1MeOPhGKbvdmczG5AN1O7mcgqc70YH
         4RLCQ1KTPorvfMNmQb4vTQz0XwJtzGi97xXtIEAFQ2Fjjed0ov8NS7+We+Xu8/zQZQcU
         Hu5S9nZyGE3eEI11tHflW9ddk3ZMJymJUkDju8BRCkNTOjF8jtMM3GBgmPpNa2zGDKkv
         wOqQJ6NQ3JhWK20xQqtkwsO0M8tut5UFGAMM3RothP/xipOUORAtrTLCZQw+Edf593pV
         6A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M99cieRI+weLmSDxkSaR7znpx2pt3wlg3kJDip+weFc=;
        b=iI4EeFCJG3SV0s7OmDtI3FdHpGT8drza8Dbge3y0wDr3FYyY4Q3zNge4XtTbqrcObW
         7pCfIJgWrpO+pIdI2y65nuwfgZGSo6yHDumwVUiUo2upWJYVfU70sfUjzyG3oU2t77wX
         Os0YJqnlh6Fc9vZ339D7HrVM21xwLk0F3nmCFHrdku9kDJJTAxS9LyGWZlIOEL7/jFsW
         /3b+OwHz5ENN1PFjRTlDrM/C06myrVqp7/XxnND9pcKMyHBf9aQsa+cZFUjeE0sKMOGd
         MkZRvRz++iDhT2f+L76U4OSvGN6OQ35e/CDa7pwTwq/N1Taw3MdcKB9gHIwqM1Cr5PT3
         E6KQ==
X-Gm-Message-State: AFqh2kpVJlso0nmSq0eYoA+NIVV/lZJ+cW+ZMcJxg2bB64m7QYanLvN2
        BCpmQUsKTd/fOKBXKvKztLMFziBFFY/+ht0M
X-Google-Smtp-Source: AMrXdXu0W2+qjimqXdB16vFVNkd9cp9BTixVwvKUVBTDj5+OwXkovDBBraT0J0fEfvMN5r1/NXCIWA==
X-Received: by 2002:a17:902:d545:b0:194:5fc9:f55a with SMTP id z5-20020a170902d54500b001945fc9f55amr17337723plf.35.1673832548904;
        Sun, 15 Jan 2023 17:29:08 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0019338ecad52sm13231786plh.190.2023.01.15.17.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 17:29:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pHEJ6-003Zoj-KZ; Mon, 16 Jan 2023 12:29:04 +1100
Date:   Mon, 16 Jan 2023 12:29:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH v2 2/6] composefs: Add on-disk layout
Message-ID: <20230116012904.GJ2703033@dread.disaster.area>
References: <cover.1673623253.git.alexl@redhat.com>
 <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:33:55PM +0100, Alexander Larsson wrote:
> This commit adds the on-disk layout header file of composefs.

This isn't really a useful commit message.

Perhaps it should actually explain what the overall goals of the
on-disk format are - space usage, complexity trade-offs, potential
issues with validation of variable payload sections, etc.

> 
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  fs/composefs/cfs.h | 203 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 fs/composefs/cfs.h
> 
> diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
> new file mode 100644
> index 000000000000..658df728e366
> --- /dev/null
> +++ b/fs/composefs/cfs.h
> @@ -0,0 +1,203 @@
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

This should start with a description of the on-disk format for the
version 1 format.


> +
> +#define CFS_MAGIC 0xc078629aU
> +
> +#define CFS_MAX_DIR_CHUNK_SIZE 4096
> +#define CFS_MAX_XATTRS_SIZE 4096

How do we store 64kB xattrs in this format if the max attr size is
4096 bytes? Or is that the maximum total xattr storage?

A comment telling us what these limits are would be nice.

> +
> +static inline int cfs_digest_from_payload(const char *payload, size_t payload_len,
> +					  u8 digest_out[SHA256_DIGEST_SIZE])
> +{
> +	const char *p, *end;
> +	u8 last_digit = 0;
> +	int digit = 0;
> +	size_t n_nibbles = 0;
> +
> +	/* This handles payloads (i.e. path names) that are "essentially" a
> +	 * digest as the digest (if the DIGEST_FROM_PAYLOAD flag is set). The
> +	 * "essential" part means that we ignore hierarchical structure as well
> +	 * as any extension. So, for example "ef/deadbeef.file" would match the
> +	 * (too short) digest "efdeadbeef".
> +	 *
> +	 * This allows images to avoid storing both the digest and the pathname,
> +	 * yet work with pre-existing object store formats of various kinds.
> +	 */
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
> +
> +		if (n_nibbles == SHA256_DIGEST_SIZE * 2)
> +			return -EINVAL; /* Too long */
> +
> +		digit = hex_to_bin(*p);
> +		if (digit == -1)
> +			return -EINVAL; /* Not hex digit */
> +
> +		n_nibbles++;
> +		if ((n_nibbles % 2) == 0)
> +			digest_out[n_nibbles / 2 - 1] = (last_digit << 4) | digit;
> +		last_digit = digit;
> +	}
> +
> +	if (n_nibbles != SHA256_DIGEST_SIZE * 2)
> +		return -EINVAL; /* Too short */
> +
> +	return 0;
> +}

Too big to be a inline function.

> +
> +struct cfs_vdata_s {

Drop the "_s" suffix to indicate the type is a structure - that's
waht "struct" tells us.

> +	u64 off;
> +	u32 len;

If these are on-disk format structures, why aren't the defined as
using the specific endian they are encoded in? i.e. __le64, __le32,
etc? Otherwise a file built on a big endian machine won't be
readable on a little endian machine (and vice versa).

> +} __packed;
> +
> +struct cfs_header_s {
> +	u8 version;
> +	u8 unused1;
> +	u16 unused2;

Why are you hyper-optimising these structures for minimal space
usage? This is 2023 - we can use a __le32 for the version number,
the magic number and then leave....
> +
> +	u32 magic;
> +	u64 data_offset;
> +	u64 root_inode;
> +
> +	u64 unused3[2];

a whole heap of space to round it up to at least a CPU cacheline
size using something like "__le64 unused[15]".

That way we don't need packed structures nor do we care about having
weird little holes in the structures to fill....

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

Why do we need to complicate things by splitting the inode size
like this?

> +	CFS_INODE_FLAGS_XATTRS = 1 << 9,
> +	CFS_INODE_FLAGS_DIGEST = 1 << 10, /* fs-verity sha256 digest */
> +	CFS_INODE_FLAGS_DIGEST_FROM_PAYLOAD = 1 << 11, /* Compute digest from payload */
> +};
> +
> +#define CFS_INODE_FLAG_CHECK(_flag, _name)                                     \
> +	(((_flag) & (CFS_INODE_FLAGS_##_name)) != 0)

Check what about a flag? If this is a "check that a feature is set",
then open coding it better, but if you must do it like this, then
please use static inline functions like:

	if (cfs_inode_has_xattrs(inode->flags)) {
		.....
	}

> +#define CFS_INODE_FLAG_CHECK_SIZE(_flag, _name, _size)                         \
> +	(CFS_INODE_FLAG_CHECK(_flag, _name) ? (_size) : 0)

This doesn't seem particularly useful, because you've still got to
test is the return value is valid. i.e.

	size = CFS_INODE_FLAG_CHECK_SIZE(inode->flags, XATTRS, 32);
	if (size == 32) {
		/* got xattrs, decode! */
	}

vs
	if (cfs_inode_has_xattrs(inode->flags)) {
		/* decode! */
	}



> +
> +#define CFS_INODE_DEFAULT_MODE 0100644
> +#define CFS_INODE_DEFAULT_NLINK 1
> +#define CFS_INODE_DEFAULT_NLINK_DIR 2
> +#define CFS_INODE_DEFAULT_UIDGID 0
> +#define CFS_INODE_DEFAULT_RDEV 0
> +#define CFS_INODE_DEFAULT_TIMES 0

Where do these get used? Are they on disk defaults or something
else? (comment, please!)

> +struct cfs_inode_s {
> +	u32 flags;
> +
> +	/* Optional data: (selected by flags) */

WHy would you make them optional given that all the fields are still
defined in the structure?

It's much simpler just to decode the entire structure into memory
than to have to check each flag value to determine if a field needs
to be decoded...

> +	/* This is the size of the type specific data that comes directly after
> +	 * the inode in the file. Of this type:
> +	 *
> +	 * directory: cfs_dir_s
> +	 * regular file: the backing filename
> +	 * symlink: the target link
> +	 *
> +	 * Canonically payload_length is 0 for empty dir/file/symlink.
> +	 */
> +	u32 payload_length;

How do you have an empty symlink?

> +	u32 st_mode; /* File type and mode.  */
> +	u32 st_nlink; /* Number of hard links, only for regular files.  */
> +	u32 st_uid; /* User ID of owner.  */
> +	u32 st_gid; /* Group ID of owner.  */
> +	u32 st_rdev; /* Device ID (if special file).  */
> +	u64 st_size; /* Size of file, only used for regular files */
> +
> +	struct cfs_vdata_s xattrs; /* ref to variable data */

This is in the payload that follows the inode?  Is it included in
the payload_length above?

If not, where is this stuff located, how do we validate it points to
the correct place in the on-disk format file, the xattrs belong to
this specific inode, etc? I think that's kinda important to
describe, because xattrs often contain important security
information...


> +
> +	u8 digest[SHA256_DIGEST_SIZE]; /* fs-verity digest */

Why would you have this in the on-disk structure, then also have
"digest from payload" that allows the digest to be in the payload
section of the inode data?

> +
> +	struct timespec64 st_mtim; /* Time of last modification.  */
> +	struct timespec64 st_ctim; /* Time of last status change.  */
> +};

This really feels like an in-memory format inode, not an on-disk
format inode, because this:

> +
> +static inline u32 cfs_inode_encoded_size(u32 flags)
> +{
> +	return sizeof(u32) /* flags */ +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, PAYLOAD, sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, MODE, sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, NLINK, sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, UIDGID, sizeof(u32) + sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, RDEV, sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES, sizeof(u64) * 2) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES_NSEC, sizeof(u32) * 2) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, LOW_SIZE, sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, HIGH_SIZE, sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, XATTRS, sizeof(u64) + sizeof(u32)) +
> +	       CFS_INODE_FLAG_CHECK_SIZE(flags, DIGEST, SHA256_DIGEST_SIZE);
> +}

looks like the on-disk format is an encoded format hyper-optimised
for minimal storage space usage?

Without comments to explain it, I'm not exactly sure what is stored
in the on-disk format inodes, nor the layout of the variable
payload section or how payload sections are defined and verified.

Seems overly complex to me - it's far simpler just to have a fixed
inode structure and just decode it directly into the in-memory
structure when it is read....

> +struct cfs_dentry_s {
> +	/* Index of struct cfs_inode_s */

Not a useful (or correct!) comment :/

Also, the typical term for this on disk structure in a filesystem is
a "dirent", and this is also what readdir() returns to userspace.
dentry is typically used internally in the kernel to refer to the
VFS cache layer objects, not the filesystem dirents the VFS layers
look up to populate it's dentry cache.

> +	u64 inode_index;
> +	u8 d_type;
> +	u8 name_len;
> +	u16 name_offset;

What's this name_offset refer to? 

> +} __packed;
> +
> +struct cfs_dir_chunk_s {
> +	u16 n_dentries;
> +	u16 chunk_size;
> +	u64 chunk_offset;

What's this chunk offset refer to?

> +} __packed;
> +
> +struct cfs_dir_s {
> +	u32 n_chunks;
> +	struct cfs_dir_chunk_s chunks[];
> +} __packed;

So directory data is packed in discrete chunks? Given that this is a
static directory format, and the size of the directory is known at
image creation time, why does the storage need to be chunked?

> +
> +#define cfs_dir_size(_n_chunks)                                                \
> +	(sizeof(struct cfs_dir_s) + (_n_chunks) * sizeof(struct cfs_dir_chunk_s))

static inline, at least.

Also, this appears to be the size of the encoded directory
header, not the size of the directory itself. cfs_dir_header_size(),
perhaps, to match the cfs_xattr_header_size() function that does the
same thing?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
