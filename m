Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC32348202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhCXTeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhCXTdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:33:47 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328AC0613DE;
        Wed, 24 Mar 2021 12:33:44 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F5JLt5wb8zMq2dR;
        Wed, 24 Mar 2021 20:33:42 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F5JLr3wPFzlh8Td;
        Wed, 24 Mar 2021 20:33:40 +0100 (CET)
Subject: Re: [PATCH v31 01/12] landlock: Add object management
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-2-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <3908b240-8a4b-9bd7-bb5f-b59eaed7cb1f@digikod.net>
Date:   Wed, 24 Mar 2021 20:34:19 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20210324191520.125779-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/03/2021 20:15, Mickaël Salaün wrote:
[...]
> diff --git a/security/landlock/object.h b/security/landlock/object.h
> new file mode 100644
> index 000000000000..3e5d5b6941c3
> --- /dev/null
> +++ b/security/landlock/object.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock LSM - Object management
> + *
> + * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2018-2020 ANSSI
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_OBJECT_H
> +#define _SECURITY_LANDLOCK_OBJECT_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/refcount.h>
> +#include <linux/spinlock.h>
> +
> +struct landlock_object;
> +
> +/**
> + * struct landlock_object_underops - Operations on an underlying object
> + */
> +struct landlock_object_underops {
> +	/**
> +	 * @release: Releases the underlying object (e.g. iput() for an inode).
> +	 */
> +	void (*release)(struct landlock_object *const object)
> +		__releases(object->lock);
> +};
> +
> +/**
> + * struct landlock_object - Security blob tied to a kernel object
> + *
> + * The goal of this structure is to enable to tie a set of ephemeral access
> + * rights (pertaining to different domains) to a kernel object (e.g an inode)
> + * in a safe way.  This implies to handle concurrent use and modification.
> + *
> + * The lifetime of a &struct landlock_object depends of the rules referring to

You should read "depends on"…
