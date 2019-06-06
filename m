Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 723F3374E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFFNKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 09:10:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFNKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:10:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so2409925wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 06:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2FitUWKVKV8mjyDwh1uba5xd/jN5daEj8Rd7jaIslw=;
        b=fPLASyK6Go9q5nhiiBpMVuqjcRzW7M8JLvBgPdOJ5K53gCSerhS+o+MhN+UQ1lVEx3
         J4qMQI1+qYrNN+d93CL4BLf8volxfWmTSTvv2zSYwZR6JOVIwFpqWmxvjRi8AuN5rRzh
         oLjkU7obnQwiUA3wmsI+WNXP4QbZTOfQypUaWspgUtm6v29U0CkjJVqO60Xz6M4BTTO7
         GaHxg/cOWX6DHBxeTkb7n7tFiC5NM7MyQjFj9g7iwvbPMXReAp7jt+qlWU+apOCFjFaL
         YgAgCOzfkNOHU/2rkk7RQv3G9t8MSwCQoX2g++z5YvjikihjQ6i9pG6GwuS2dq6dDBGT
         dy2Q==
X-Gm-Message-State: APjAAAVF53ODcsnZ/iDD6mSYdI5Mi6NMdfWCJ/zwCUh3+dKS6rSeLULx
        fOd59IXJcTXj4Ry42PQQsKLzMYxqvF0=
X-Google-Smtp-Source: APXvYqxTgOhxM72JKlHlV5kMOY6sc1yIRmuh5WoXO9ljecQdzkuGFhUtsjPJO8ZqJx199FLTbeUtzw==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr2712506wmg.135.1559826651950;
        Thu, 06 Jun 2019 06:10:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y2sm2074305wrl.4.2019.06.06.06.10.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 06:10:51 -0700 (PDT)
Subject: Re: [PATCH v11] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20190606104618.28321-2-hdegoede@redhat.com>
 <20190606104618.28321-1-hdegoede@redhat.com>
 <27351.1559821872@warthog.procyon.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <399587cf-9983-8e4f-98ca-6d3e0c9a0103@redhat.com>
Date:   Thu, 6 Jun 2019 15:10:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <27351.1559821872@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you for the quick review.

On 06-06-19 13:51, David Howells wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> +enum {
>> +	SHFL_FN_QUERY_MAPPINGS = 1,	/* Query mappings changes. */
>> +	SHFL_FN_QUERY_MAP_NAME,		/* Query map name. */
>> +	SHFL_FN_CREATE,			/* Open/create object. */
>> +	SHFL_FN_CLOSE,			/* Close object handle. */
>> +	SHFL_FN_READ,			/* Read object content. */
>> +	SHFL_FN_WRITE,			/* Write new object content. */
>> +	SHFL_FN_LOCK,			/* Lock/unlock a range in the object. */
>> +	SHFL_FN_LIST,			/* List object content. */
>> +	SHFL_FN_INFORMATION,		/* Query/set object information. */
>> +	/* Note function number 10 is not used! */
>> +	SHFL_FN_REMOVE = 11,		/* Remove object */
>> +	SHFL_FN_MAP_FOLDER_OLD,		/* Map folder (legacy) */
>> +	SHFL_FN_UNMAP_FOLDER,		/* Unmap folder */
>> +	SHFL_FN_RENAME,			/* Rename object */
>> +	SHFL_FN_FLUSH,			/* Flush file */
>> +	SHFL_FN_SET_UTF8,		/* Select UTF8 filename encoding */
>> +	SHFL_FN_MAP_FOLDER,		/* Map folder */
>> +	SHFL_FN_READLINK,		/* Read symlink dest (as of VBox 4.0) */
>> +	SHFL_FN_SYMLINK,		/* Create symlink (as of VBox 4.0) */
>> +	SHFL_FN_SET_SYMLINKS,		/* Ask host to show symlinks (as of 4.0) */
>> +};
> 
> If these are protocol numbers that can't be changed, I would assign the value
> on all of them.

Ok, will do for the next version.

> If they're used by userspace, should they be moved into a
> uapi header (and the same for the other stuff in this file)?

This is the protocol between the guest and the hypervisor, so it is not uapi.

>> +static const struct fs_parameter_spec vboxsf_param_specs[] = {
>> +	fsparam_string("nls", opt_nls),
>> +	fsparam_u32("uid", opt_uid),
>> +	fsparam_u32("gid", opt_gid),
>> +	fsparam_u32("ttl", opt_ttl),
>> +	fsparam_u32oct("dmode", opt_dmode),
>> +	fsparam_u32oct("fmode", opt_fmode),
>> +	fsparam_u32oct("dmask", opt_dmask),
>> +	fsparam_u32oct("fmask", opt_fmask),
>> +	{}
>> +};
> 
> I would format this with tabs so that everything nicely lines up:
> 
> 	static const struct fs_parameter_spec vboxsf_param_specs[] = {
> 		fsparam_string	("nls",		opt_nls),
> 		fsparam_u32	("uid",		opt_uid),
> 		fsparam_u32	("gid",		opt_gid),
> 		fsparam_u32	("ttl",		opt_ttl),
> 		fsparam_u32oct	("dmode",	opt_dmode),
> 		fsparam_u32oct	("fmode",	opt_fmode),
> 		fsparam_u32oct	("dmask",	opt_dmask),
> 		fsparam_u32oct	("fmask",	opt_fmask),
> 		{}
> 	};
> 
> but, otherwise, good!

Ok, will fix.

>> +	case opt_uid:
>> +		ctx->o.uid = result.uint_32;
>> +		break;
>> +	case opt_gid:
>> +		ctx->o.gid = result.uint_32;
>> +		break;
> 
> Should you be using kuid/kgid transforms for the appropriate namespace?

That is probably a good idea, will do for the next version.

> 
> 		opts->fs_uid = make_kuid(current_user_ns(), option);
> 		if (!uid_valid(opts->fs_uid))
> 			return -EINVAL;
> 
> sort of thing (excerpt from fs/fat/inode.c).

Shouldn't this use the user-namespace from the filesystem-context?

> 
>> +	case opt_ttl:
>> +		ctx->o.ttl = msecs_to_jiffies(result.uint_32);
>> +		break;
> 
> Is 0 valid?

Yes, 0 means to always pass any stat() calls through to the host
instead of relying on cached values.

> 
>> +	case opt_dmode:
>> +		ctx->o.dmode = result.uint_32;
>> +		break;
>> +	case opt_fmode:
>> +		ctx->o.fmode = result.uint_32;
>> +		break;
>> +	case opt_dmask:
>> +		ctx->o.dmask = result.uint_32;
>> +		break;
>> +	case opt_fmask:
>> +		ctx->o.fmask = result.uint_32;
>> +		break;
> 
> Do these need vetting?  I guess you kind of do:

Well I could refuse values where (result.uint_32 & 0777)
is true here I guess; and then remove the & 0777 below:

> 		inode->i_mode =
> 			sf_g->o.dmode != ~0 ? (sf_g->o.dmode & 0777) : mode;
> 		inode->i_mode &= ~sf_g->o.dmask;
> 
> I'm guessing you're stuck with the mount options?

More or less, yes. Changing them is going to be quite painful
from a userspace compat pov.

> 
>> +struct vboxsf_options {
>> +	int ttl;
> 
> jiffies are unsigned long.

Ok.

>> +	int uid;
>> +	int gid;
> 
> kuid_t & kgid_t.

Ok.

> 
>> +	int dmode;
>> +	int fmode;
>> +	int dmask;
>> +	int fmask;
>> +};
> 
> umode_t.

Ok.

Regards,

Hans

