Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA602C82B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfE1Nzz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 09:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfE1Nzy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 09:55:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C4313092661;
        Tue, 28 May 2019 13:55:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A8507854F;
        Tue, 28 May 2019 13:55:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190418100412.19016-2-hdegoede@redhat.com>
References: <20190418100412.19016-2-hdegoede@redhat.com> <20190418100412.19016-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10] fs: Add VirtualBox guest shared folder (vboxsf) support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19228.1559051752.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 28 May 2019 14:55:52 +0100
Message-ID: <19229.1559051752@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 28 May 2019 13:55:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> +	params.create_flags = 0
> +	    | SHFL_CF_DIRECTORY
> +	    | SHFL_CF_ACT_OPEN_IF_EXISTS
> +	    | SHFL_CF_ACT_FAIL_IF_NEW | SHFL_CF_ACCESS_READ;

The 0 here would seem to be superfluous.  Also, most common practice in the
kernel would put the binary operator at the end of the preceding line.

> +/**
> + * This is called when reference count of [file] goes to zero. Notify
> + * the host that it can free whatever is associated with this directory
> + * and deallocate our own internal buffers
> + * Return: 0 or negative errno value.
> + * @inode	inode
> + * @file	file
> + */
> +static int sf_dir_release(struct inode *inode, struct file *file)

I'm pretty certain most of your kdoc comments are invalid, but I could be
wrong.  Shouldn't this be:

	/**
	 * name_of_function - Brief description
	 * @arg1: Summary arg 1
	 * @arg2: Summary arg 2
	 * @arg3: Summary arg 3
	 *
	 * Description...
	 */
	type name_of_function(type arg1, type arg2, type arg3)
	{
		...
	}

> +static int sf_get_d_type(u32 mode)

unsigned int would be preferable, I think.

> + * Return: 0 or negative errno value.
> ...
> +static int sf_getdent(struct file *dir, loff_t pos,
> +		      char d_name[NAME_MAX], int *d_type)
> ...
> +	return 1;

The return value is not concordant with the function description.

> + * This is called when vfs wants to populate internal buffers with
> + * directory [dir]s contents.

I would say "the directory" rather than "directory [dir]s".  It's fairly
obvious what the definite article refers to in this case.

> [opaque] is an argument to the
> + * [filldir]. [filldir] magically modifies it's argument - [opaque]
> + * and takes following additional arguments (which i in turn get from
> + * the host via sf_getdent):

opaque and filldir no longer exist.

> + * name : name of the entry (i must also supply it's length huh?)
> + * type : type of the entry (FILE | DIR | etc) (i ellect to use DT_UNKNOWN)
> + * pos : position/index of the entry
> + * ino : inode number of the entry (i fake those)

I would indent these more (use a tab after the '*' rather than a space).

> +		/* d_name now contains a valid entry name */
> +		sanity = ctx->pos + 0xbeef;
> +		fake_ino = sanity;
> +		/*
> +		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
> +		 * unsigned so fake_ino may overflow, check for this.
> +		 */
> +		if (sanity - fake_ino) {

Ugh.  Why '0xbeef'?  Why not '1'?  I wonder if:

	if ((ino_t)(ctx->pos + 1) != (unsigned long long)(ctx->pos + 1))

would work.

> +/* Query mappings changes. */
> +#define SHFL_FN_QUERY_MAPPINGS      (1)
> +/* Query mappings changes. */
> +#define SHFL_FN_QUERY_MAP_NAME      (2)
> ...

Enumify?

> +#define SHFL_ROOT_NIL ((u32)~0)

UINT_MAX?

> +#define SHFL_HANDLE_NIL  ((u64)~0LL)

ULONGLONG_MAX?

> +/** Shared folder filesystem properties. */
> +struct shfl_fsproperties {
> ...
> +};
> +VMMDEV_ASSERT_SIZE(shfl_fsproperties, 12);

Should this be __packed given the size assertion?

> +static const match_table_t vboxsf_tokens = {
> +	{ opt_nls, "nls=%s" },
> +	{ opt_uid, "uid=%u" },
> +	{ opt_gid, "gid=%u" },
> +	{ opt_ttl, "ttl=%u" },
> +	{ opt_dmode, "dmode=%o" },
> +	{ opt_fmode, "fmode=%o" },
> +	{ opt_dmask, "dmask=%o" },
> +	{ opt_fmask, "fmask=%o" },
> +	{ opt_error, NULL },
> +};

This needs converting to the new mount API.  See:

	Documentation/filesystems/mount_api.txt

> +	if (options[0] == VBSF_MOUNT_SIGNATURE_BYTE_0 &&
> +	    options[1] == VBSF_MOUNT_SIGNATURE_BYTE_1 &&
> +	    options[2] == VBSF_MOUNT_SIGNATURE_BYTE_2 &&
> +	    options[3] == VBSF_MOUNT_SIGNATURE_BYTE_3) {
> +		vbg_err("vboxsf: Old binary mount data not supported, remove obsolete mount.vboxsf and/or update your VBoxService.\n");
> +		return -EINVAL;
> +	}

This bit should go in your ->parse_monolithic() method.

David
