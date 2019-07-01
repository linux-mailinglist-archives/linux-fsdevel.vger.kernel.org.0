Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398C05BCA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfGANNX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 1 Jul 2019 09:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANNX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAEBF308FEC0;
        Mon,  1 Jul 2019 13:13:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B90601001B20;
        Mon,  1 Jul 2019 13:13:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190701104048.c2t5aful2sabngmr@brauner.io>
References: <20190701104048.c2t5aful2sabngmr@brauner.io> <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk> <156173662509.14042.3867242748127323502.stgit@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 01/11] vfs: syscall: Add fsinfo() to query filesystem information [ver #15]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27311.1561986796.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 01 Jul 2019 14:13:16 +0100
Message-ID: <27313.1561986796@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 01 Jul 2019 13:13:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> > +config FSINFO
> 
> Hm, any reason why we would hide that syscalls under a config option?

Rasmus Villemoes asked for it to be made conditional.

https://lore.kernel.org/lkml/f3646774-ee9e-d5b7-8a11-670012034d59@rasmusvillemoes.dk/

> Do we, not have any dumb helpers for scenarios like this?:
> 
> #define strlen_literal(x) (sizeof(""x"") - 1)
> #define strlen_array(x) (sizeof(x) - 1)

git grep doesn't find them under this name.

> > +	while (!signal_pending(current)) {
> > +		params->usage = 0;
> > +		ret = fsinfo(path, params);
> > +		if (IS_ERR_VALUE((long)ret))
> > +			return ret; /* Error */
> > +		if ((unsigned int)ret <= params->buf_size)
> 
> if ((size_t)ret ...? Just for the sake of clarity if for nothing else.
> 
> > +			return ret; /* It fitted */
> 
> Ok, a little confused here, tbh. params->buf_size is size_t

It's "unsigned int".

> and this function returns an int. Forgot whether you mentioned this before,
> buf_size exceed can't exceed INT_MAX?

It's mentioned in the documentation (ie. fsinfo.rst).  I'll mention it in the
comments adjacent to the attribute definition table also.

> Is it really wort it to have this code generating stuff in there?

From a readability PoV, yes, tabulation is awesome, IMO;-).  Up to 5 lines per
attribute is too much vertical space and expanding it makes the whole thing
much less readable.  Add to that that not all attributes will be the same
number of lines.

It would be easier if the I could get away with making the constant names
lower case, but the thou-shalt-capitalise-constantists dislike that, so, given
that I don't know of a way to make the C preprocessor change the case of a
symbol, I have to include both parts.

I have four pieces of information: type, depth, constant name, struct name (if
applicable), and I can fit them on one line this way.

You really find this:

static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
	[FSINFO_ATTR_STATFS] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_statfs)
	},
	[FSINFO_ATTR_FSINFO] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_fsinfo)
	},
	[FSINFO_ATTR_IDS] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_ids)
	},
	[FSINFO_ATTR_LIMITS] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_limits)
	},
	[FSINFO_ATTR_CAPABILITIES] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_capabilities)
	},
	[FSINFO_ATTR_SUPPORTS] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_supports)
	},
	[FSINFO_ATTR_TIMESTAMP_INFO] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_timestamp_info)
	},
	[FSINFO_ATTR_VOLUME_ID] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_VOLUME_UUID] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_volume_uuid)
	},
	[FSINFO_ATTR_VOLUME_NAME] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_NAME_ENCODING] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_NAME_CODEPAGE] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_PARAM_DESCRIPTION] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_param_description)
	},
	[FSINFO_ATTR_PARAM_SPECIFICATION] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_N,
		.size	= sizeof(struct fsinfo_param_specification)
	},
	[FSINFO_ATTR_PARAM_ENUM] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_N,
		.size	= sizeof(struct fsinfo_param_enum)
	},
	[FSINFO_ATTR_PARAMETERS] = {
		.type	= __FSINFO_OPAQUE,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_LSM_PARAMETERS] = {
		.type	= __FSINFO_OPAQUE,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_SERVER_NAME] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_N,
	},
	[FSINFO_ATTR_SERVER_ADDRESS] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_NM,
		.size	= sizeof(struct fsinfo_server_address)
	},
	[FSINFO_ATTR_AFS_CELL_NAME] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_MOUNT_INFO] = {
		.type	= __FSINFO_STRUCT,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_mount_info)
	},
	[FSINFO_ATTR_MOUNT_DEVNAME] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_SINGLE,
	},
	[FSINFO_ATTR_MOUNT_CHILDREN] = {
		.type	= __FSINFO_STRUCT_ARRAY,
		.flags	= __FSINFO_SINGLE,
		.size	= sizeof(struct fsinfo_mount_child)
	},
	[FSINFO_ATTR_MOUNT_SUBMOUNT] = {
		.type	= __FSINFO_STRING,
		.flags	= __FSINFO_N,
	},
};

is easier to read than this?:

static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
	FSINFO_STRUCT		(STATFS,		statfs),
	FSINFO_STRUCT		(FSINFO,		fsinfo),
	FSINFO_STRUCT		(IDS,			ids),
	FSINFO_STRUCT		(LIMITS,		limits),
	FSINFO_STRUCT		(CAPABILITIES,		capabilities),
	FSINFO_STRUCT		(SUPPORTS,		supports),
	FSINFO_STRUCT		(TIMESTAMP_INFO,	timestamp_info),
	FSINFO_STRING		(VOLUME_ID),
	FSINFO_STRUCT		(VOLUME_UUID,		volume_uuid),
	FSINFO_STRING		(VOLUME_NAME),
	FSINFO_STRING		(NAME_ENCODING),
	FSINFO_STRING		(NAME_CODEPAGE),
	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
	FSINFO_OPAQUE		(PARAMETERS),
	FSINFO_OPAQUE		(LSM_PARAMETERS),
	FSINFO_STRING_N		(SERVER_NAME),
	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
	FSINFO_STRING		(AFS_CELL_NAME),
	FSINFO_STRUCT		(MOUNT_INFO,		mount_info),
	FSINFO_STRING		(MOUNT_DEVNAME),
	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
	FSINFO_STRING_N		(MOUNT_SUBMOUNT),
};

The latter also has the advantage that I can take this and drop it into the
test program and change the helper macros to make it do other things.  With
the fully expanded code, that isn't possible.

One thing I will grant you, though, I can simplify:

#define __FSINFO_STRUCT		0
#define __FSINFO_STRING		1
#define __FSINFO_OPAQUE		2
#define __FSINFO_STRUCT_ARRAY	3
#define __FSINFO_0		0
#define __FSINFO_N		0x0001
#define __FSINFO_NM		0x0002

#define _Z(T, F, S) { .type = __FSINFO_##T, .flags = __FSINFO_##F, .size = S }
#define FSINFO_STRING(X)	 [FSINFO_ATTR_##X] = _Z(STRING, 0, 0)
#define FSINFO_STRUCT(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, 0, sizeof(struct fsinfo_##Y))
#define FSINFO_STRING_N(X)	 [FSINFO_ATTR_##X] = _Z(STRING, N, 0)
#define FSINFO_STRUCT_N(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, N, sizeof(struct fsinfo_##Y))
#define FSINFO_STRING_NM(X)	 [FSINFO_ATTR_##X] = _Z(STRING, NM, 0)
#define FSINFO_STRUCT_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, NM, sizeof(struct fsinfo_##Y))
#define FSINFO_OPAQUE(X)	 [FSINFO_ATTR_##X] = _Z(OPAQUE, 0, 0)
#define FSINFO_STRUCT_ARRAY(X,Y) [FSINFO_ATTR_##X] = _Z(STRUCT_ARRAY, 0, sizeof(struct fsinfo_##Y))

a bit:

#define __FSINFO_STRUCT		0
#define __FSINFO_STRING		1
#define __FSINFO_OPAQUE		2
#define __FSINFO_STRUCT_ARRAY	3
#define __FSINFO_N		0x01
#define __FSINFO_NM		0x02

#define _Z(T, S)    { .type = __FSINFO_##T, .flags = 0,		  .size = S }
#define _Z_N(T, S)  { .type = __FSINFO_##T, .flags = __FSINFO_N,  .size = S }
#define _Z_NM(T, S) { .type = __FSINFO_##T, .flags = __FSINFO_NM, .size = S }
#define FSINFO_STRING(X)	 [FSINFO_ATTR_##X] = _Z(STRING, 0)
#define FSINFO_STRUCT(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, sizeof(struct fsinfo_##Y))
#define FSINFO_STRING_N(X)	 [FSINFO_ATTR_##X] = _Z_N(STRING, 0)
#define FSINFO_STRUCT_N(X,Y)	 [FSINFO_ATTR_##X] = _Z_N(STRUCT, sizeof(struct fsinfo_##Y))
#define FSINFO_STRING_NM(X)	 [FSINFO_ATTR_##X] = _Z_NM(STRING, 0)
#define FSINFO_STRUCT_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z_NM(STRUCT, sizeof(struct fsinfo_##Y))
#define FSINFO_OPAQUE(X)	 [FSINFO_ATTR_##X] = _Z(OPAQUE, 0)
#define FSINFO_STRUCT_ARRAY(X,Y) [FSINFO_ATTR_##X] = _Z(STRUCT_ARRAY, sizeof(struct fsinfo_##Y))

> I urge you to think about git grep users. For them this is an absolute
> nightmare. :)

That's a valid point, but it's a problem all over the kernel.  We use
macroisation everywhere.  See all the declaration and define macros that nest
layers deep.

If that's your main worry, The attribute type name could be fully expanded in
the table, eg.:

	FSINFO_STRUCT		(FSINFO_ATTR_CAPABILITIES,	capabilities),
	FSINFO_STRING_N		(FSINFO_ATTR_MOUNT_SUBMOUNT),

> > +	unsigned int result_size;
> 
> Wouldn't it be better if this could be a size_t?

Why?  size_t takes more space on a 64-bit system, but I'm not allowing the
filesystem to return that much data, mainly because I don't really want to be
allocating a >2G buffer.

In fact, for large objects there's something to be said for writing directly
to userspace rather than going through a buffer, but for the fact that I want
to hold, say, the RCU readlock across the entire transaction in some
instances.

> > +	if (!user_buffer || !user_buf_size) {
> 
> Maybe we could be a little more strict and require both be set to their
> respective zero values, i.e. only support reporting the size if
> !user_buffer && user_buf_size = 0 for that to work. If only one of them
> is set to their zero value we report EINVAL.

That's an option, certainly.

> Hm, I'm not sure that "capabilities" is a good name here. This is
> potentially misleading because of other uses of "capabilities" we
> already have. Like, I don't want thes capabilities to pop up when I do
> git grep capabilities. Just a short way until someone also speaks of
> "fscaps" or "fsinfocaps" and then confusion is basically guaranteed. :)
> 
> Maybe "features" would be better?

Yeah - that's probably better.  The only issue is that it doesn't have a nice
short hypocoristicon like "cap", though I could use "feat" I guess.

> > +#define _ATFILE_SOURCE
> 
> nit: Defining fsinfoat() implicitly or what's that supposed to do? If that's
> the case wouldn't it be nicer to just explicitly declare fsinfoat()

Um...  fsinfo() takes AT_* flags.  It's fsinfoat(), ffsinfo() and lfsinfo()
all rolled into one, plus a couple of extra bits.  It doesn't really need an
at-suffix on the name as there's no at-less original.

David
