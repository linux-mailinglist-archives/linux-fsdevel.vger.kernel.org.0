Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFD37353
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFFLvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 07:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfFFLvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:51:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C9DA89C31;
        Thu,  6 Jun 2019 11:51:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB3868408;
        Thu,  6 Jun 2019 11:51:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190606104618.28321-2-hdegoede@redhat.com>
References: <20190606104618.28321-2-hdegoede@redhat.com> <20190606104618.28321-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11] fs: Add VirtualBox guest shared folder (vboxsf) support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27350.1559821872.1@warthog.procyon.org.uk>
Date:   Thu, 06 Jun 2019 12:51:12 +0100
Message-ID: <27351.1559821872@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 06 Jun 2019 11:51:14 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> +enum {
> +	SHFL_FN_QUERY_MAPPINGS = 1,	/* Query mappings changes. */
> +	SHFL_FN_QUERY_MAP_NAME,		/* Query map name. */
> +	SHFL_FN_CREATE,			/* Open/create object. */
> +	SHFL_FN_CLOSE,			/* Close object handle. */
> +	SHFL_FN_READ,			/* Read object content. */
> +	SHFL_FN_WRITE,			/* Write new object content. */
> +	SHFL_FN_LOCK,			/* Lock/unlock a range in the object. */
> +	SHFL_FN_LIST,			/* List object content. */
> +	SHFL_FN_INFORMATION,		/* Query/set object information. */
> +	/* Note function number 10 is not used! */
> +	SHFL_FN_REMOVE = 11,		/* Remove object */
> +	SHFL_FN_MAP_FOLDER_OLD,		/* Map folder (legacy) */
> +	SHFL_FN_UNMAP_FOLDER,		/* Unmap folder */
> +	SHFL_FN_RENAME,			/* Rename object */
> +	SHFL_FN_FLUSH,			/* Flush file */
> +	SHFL_FN_SET_UTF8,		/* Select UTF8 filename encoding */
> +	SHFL_FN_MAP_FOLDER,		/* Map folder */
> +	SHFL_FN_READLINK,		/* Read symlink dest (as of VBox 4.0) */
> +	SHFL_FN_SYMLINK,		/* Create symlink (as of VBox 4.0) */
> +	SHFL_FN_SET_SYMLINKS,		/* Ask host to show symlinks (as of 4.0) */
> +};

If these are protocol numbers that can't be changed, I would assign the value
on all of them.  If they're used by userspace, should they be moved into a
uapi header (and the same for the other stuff in this file)?

> +static const struct fs_parameter_spec vboxsf_param_specs[] = {
> +	fsparam_string("nls", opt_nls),
> +	fsparam_u32("uid", opt_uid),
> +	fsparam_u32("gid", opt_gid),
> +	fsparam_u32("ttl", opt_ttl),
> +	fsparam_u32oct("dmode", opt_dmode),
> +	fsparam_u32oct("fmode", opt_fmode),
> +	fsparam_u32oct("dmask", opt_dmask),
> +	fsparam_u32oct("fmask", opt_fmask),
> +	{}
> +};

I would format this with tabs so that everything nicely lines up:

	static const struct fs_parameter_spec vboxsf_param_specs[] = {
		fsparam_string	("nls",		opt_nls),
		fsparam_u32	("uid",		opt_uid),
		fsparam_u32	("gid",		opt_gid),
		fsparam_u32	("ttl",		opt_ttl),
		fsparam_u32oct	("dmode",	opt_dmode),
		fsparam_u32oct	("fmode",	opt_fmode),
		fsparam_u32oct	("dmask",	opt_dmask),
		fsparam_u32oct	("fmask",	opt_fmask),
		{}
	};

but, otherwise, good!

> +	case opt_uid:
> +		ctx->o.uid = result.uint_32;
> +		break;
> +	case opt_gid:
> +		ctx->o.gid = result.uint_32;
> +		break;

Should you be using kuid/kgid transforms for the appropriate namespace?

		opts->fs_uid = make_kuid(current_user_ns(), option);
		if (!uid_valid(opts->fs_uid))
			return -EINVAL;

sort of thing (excerpt from fs/fat/inode.c).

> +	case opt_ttl:
> +		ctx->o.ttl = msecs_to_jiffies(result.uint_32);
> +		break;

Is 0 valid?

> +	case opt_dmode:
> +		ctx->o.dmode = result.uint_32;
> +		break;
> +	case opt_fmode:
> +		ctx->o.fmode = result.uint_32;
> +		break;
> +	case opt_dmask:
> +		ctx->o.dmask = result.uint_32;
> +		break;
> +	case opt_fmask:
> +		ctx->o.fmask = result.uint_32;
> +		break;

Do these need vetting?  I guess you kind of do:

		inode->i_mode =
			sf_g->o.dmode != ~0 ? (sf_g->o.dmode & 0777) : mode;
		inode->i_mode &= ~sf_g->o.dmask;

I'm guessing you're stuck with the mount options?

> +struct vboxsf_options {
> +	int ttl;

jiffies are unsigned long.

> +	int uid;
> +	int gid;

kuid_t & kgid_t.

> +	int dmode;
> +	int fmode;
> +	int dmask;
> +	int fmask;
> +};

umode_t.
