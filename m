Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD141172457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgB0RBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 12:01:10 -0500
Received: from smtp-bc0e.mail.infomaniak.ch ([45.157.188.14]:44295 "EHLO
        smtp-bc0e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgB0RBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:01:10 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 12:01:07 EST
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id DDFAA1003A4D3;
        Thu, 27 Feb 2020 18:01:05 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48SzT85slszlhCmN;
        Thu, 27 Feb 2020 18:01:00 +0100 (CET)
Subject: Re: [RFC PATCH v14 01/10] landlock: Add object and rule management
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200224160215.4136-1-mic@digikod.net>
 <20200227042002.3032-1-hdanton@sina.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <216c8e89-2906-4ad5-f8a1-ab3ec50614fe@digikod.net>
Date:   Thu, 27 Feb 2020 18:01:00 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200227042002.3032-1-hdanton@sina.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 27/02/2020 05:20, Hillf Danton wrote:
> 
> On Mon, 24 Feb 2020 17:02:06 +0100 Mickaël Salaün 
>> A Landlock object enables to identify a kernel object (e.g. an inode).
>> A Landlock rule is a set of access rights allowed on an object.  Rules
>> are grouped in rulesets that may be tied to a set of processes (i.e.
>> subjects) to enforce a scoped access-control (i.e. a domain).
>>
>> Because Landlock's goal is to empower any process (especially
>> unprivileged ones) to sandbox themselves, we can't rely on a system-wide
>> object identification such as file extended attributes.  Indeed, we need
>> innocuous, composable and modular access-controls.
>>
>> The main challenge with this constraints is to identify kernel objects
>> while this identification is useful (i.e. when a security policy makes
>> use of this object).  But this identification data should be freed once
>> no policy is using it.  This ephemeral tagging should not and may not be
>> written in the filesystem.  We then need to manage the lifetime of a
>> rule according to the lifetime of its object.  To avoid a global lock,
>> this implementation make use of RCU and counters to safely reference
>> objects.
>>
>> A following commit uses this generic object management for inodes.
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> ---
>>
>> Changes since v13:
>> * New dedicated implementation, removing the need for eBPF.
>>
>> Previous version:
>> https://lore.kernel.org/lkml/20190721213116.23476-6-mic@digikod.net/
>> ---
>>  MAINTAINERS                |  10 ++
>>  security/Kconfig           |   1 +
>>  security/Makefile          |   2 +
>>  security/landlock/Kconfig  |  15 ++
>>  security/landlock/Makefile |   3 +
>>  security/landlock/object.c | 339 +++++++++++++++++++++++++++++++++++++
>>  security/landlock/object.h | 134 +++++++++++++++
>>  7 files changed, 504 insertions(+)
>>  create mode 100644 security/landlock/Kconfig
>>  create mode 100644 security/landlock/Makefile
>>  create mode 100644 security/landlock/object.c
>>  create mode 100644 security/landlock/object.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fcd79fc38928..206f85768cd9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9360,6 +9360,16 @@ F:	net/core/skmsg.c
>>  F:	net/core/sock_map.c
>>  F:	net/ipv4/tcp_bpf.c
>>  
>> +LANDLOCK SECURITY MODULE
>> +M:	Mickaël Salaün <mic@digikod.net>
>> +L:	linux-security-module@vger.kernel.org
>> +W:	https://landlock.io
>> +T:	git https://github.com/landlock-lsm/linux.git
>> +S:	Supported
>> +F:	security/landlock/
>> +K:	landlock
>> +K:	LANDLOCK
>> +
>>  LANTIQ / INTEL Ethernet drivers
>>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>>  L:	netdev@vger.kernel.org
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 2a1a2d396228..9d9981394fb0 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -238,6 +238,7 @@ source "security/loadpin/Kconfig"
>>  source "security/yama/Kconfig"
>>  source "security/safesetid/Kconfig"
>>  source "security/lockdown/Kconfig"
>> +source "security/landlock/Kconfig"
>>  
>>  source "security/integrity/Kconfig"
>>  
>> diff --git a/security/Makefile b/security/Makefile
>> index 746438499029..2472ef96d40a 100644
>> --- a/security/Makefile
>> +++ b/security/Makefile
>> @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
>>  subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
>>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
>> +subdir-$(CONFIG_SECURITY_LANDLOCK)		+= landlock
>>  
>>  # always enable default capabilities
>>  obj-y					+= commoncap.o
>> @@ -29,6 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
>>  obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
>>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
>>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>> +obj-$(CONFIG_SECURITY_LANDLOCK)	+= landlock/
>>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
>>  
>>  # Object integrity file lists
>> diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
>> new file mode 100644
>> index 000000000000..4a321d5b3f67
>> --- /dev/null
>> +++ b/security/landlock/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config SECURITY_LANDLOCK
>> +	bool "Landlock support"
>> +	depends on SECURITY
>> +	default n
>> +	help
>> +	  This selects Landlock, a safe sandboxing mechanism.  It enables to
>> +	  restrict processes on the fly (i.e. enforce an access control policy),
>> +	  which can complement seccomp-bpf.  The security policy is a set of access
>> +	  rights tied to an object, which could be a file, a socket or a process.
>> +
>> +	  See Documentation/security/landlock/ for further information.
>> +
>> +	  If you are unsure how to answer this question, answer N.
>> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
>> new file mode 100644
>> index 000000000000..cb6deefbf4c0
>> --- /dev/null
>> +++ b/security/landlock/Makefile
>> @@ -0,0 +1,3 @@
>> +obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
>> +
>> +landlock-y := object.o
>> diff --git a/security/landlock/object.c b/security/landlock/object.c
>> new file mode 100644
>> index 000000000000..38fbbb108120
>> --- /dev/null
>> +++ b/security/landlock/object.c
>> @@ -0,0 +1,339 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Landlock LSM - Object and rule management
>> + *
>> + * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
>> + * Copyright © 2018-2020 ANSSI
>> + *
>> + * Principles and constraints of the object and rule management:
>> + * - Do not leak memory.
>> + * - Try as much as possible to free a memory allocation as soon as it is
>> + *   unused.
>> + * - Do not use global lock.
>> + * - Do not charge processes other than the one requesting a Landlock
>> + *   operation.
>> + */
>> +
>> +#include <linux/bug.h>
>> +#include <linux/compiler.h>
>> +#include <linux/compiler_types.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/fs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/rbtree.h>
>> +#include <linux/rcupdate.h>
>> +#include <linux/refcount.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "object.h"
>> +
>> +struct landlock_object *landlock_create_object(
>> +		const enum landlock_object_type type, void *underlying_object)
>> +{
>> +	struct landlock_object *object;
>> +
>> +	if (WARN_ON_ONCE(!underlying_object))
>> +		return NULL;
>> +	object = kzalloc(sizeof(*object), GFP_KERNEL);
>> +	if (!object)
>> +		return NULL;
>> +	refcount_set(&object->usage, 1);
>> +	refcount_set(&object->cleaners, 1);
>> +	spin_lock_init(&object->lock);
>> +	INIT_LIST_HEAD(&object->rules);
>> +	object->type = type;
>> +	WRITE_ONCE(object->underlying_object, underlying_object);
>> +	return object;
>> +}
>> +
>> +struct landlock_object *landlock_get_object(struct landlock_object *object)
>> +	__acquires(object->usage)
>> +{
>> +	__acquire(object->usage);
>> +	/*
>> +	 * If @object->usage equal 0, then it will be ignored by writers, and
>> +	 * underlying_object->object may be replaced, but this is not an issue
>> +	 * for release_object().
>> +	 */
>> +	if (object && refcount_inc_not_zero(&object->usage)) {
>> +		/*
>> +		 * It should not be possible to get a reference to an object if
>> +		 * its underlying object is being terminated (e.g. with
>> +		 * landlock_release_object()), because an object is only
>> +		 * modifiable through such underlying object.  This is not the
>> +		 * case with landlock_get_object_cleaner().
>> +		 */
>> +		WARN_ON_ONCE(!READ_ONCE(object->underlying_object));
>> +		return object;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static struct landlock_object *get_object_cleaner(
>> +		struct landlock_object *object)
>> +	__acquires(object->cleaners)
>> +{
>> +	__acquire(object->cleaners);
>> +	if (object && refcount_inc_not_zero(&object->cleaners))
>> +		return object;
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * There is two cases when an object should be free and the reference to the
>> + * underlying object should be put:
>> + * - when the last rule tied to this object is removed, which is handled by
>> + *   landlock_put_rule() and then release_object();
>> + * - when the object is being terminated (e.g. no more reference to an inode),
>> + *   which is handled by landlock_put_object().
>> + */
>> +static void put_object_free(struct landlock_object *object)
>> +	__releases(object->cleaners)
>> +{
>> +	__release(object->cleaners);
>> +	if (!refcount_dec_and_test(&object->cleaners))
>> +		return;
>> +	WARN_ON_ONCE(refcount_read(&object->usage));
>> +	/*
>> +	 * Ensures a safe use of @object in the RCU block from
>> +	 * landlock_put_rule().
>> +	 */
>> +	kfree_rcu(object, rcu_free);
>> +}
>> +
>> +/*
>> + * Destroys a newly created and useless object.
>> + */
>> +void landlock_drop_object(struct landlock_object *object)
>> +{
>> +	if (WARN_ON_ONCE(!refcount_dec_and_test(&object->usage)))
>> +		return;
>> +	__acquire(object->cleaners);
>> +	put_object_free(object);
>> +}
>> +
>> +/*
>> + * Puts the underlying object (e.g. inode) if it is the first request to
>> + * release @object, without calling landlock_put_object().
>> + *
>> + * Return true if this call effectively marks @object as released, false
>> + * otherwise.
>> + */
>> +static bool release_object(struct landlock_object *object)
>> +	__releases(&object->lock)
>> +{
>> +	void *underlying_object;
>> +
>> +	lockdep_assert_held(&object->lock);
>> +
>> +	underlying_object = xchg(&object->underlying_object, NULL);
> 
> A one-line comment looks needed for xchg.

Ok. This is to have a guarantee that the underlying_object (e.g. the
inode pointer) is only used once. I'll add a comment.

> 
>> +	spin_unlock(&object->lock);
>> +	might_sleep();
> 
> Have trouble working out what might_sleep is put for.

Patch 5 adds a call to landlock_release_inode(underlying_object, object)
(LANDLOCK_OBJECT_INODE case), which can sleep e.g., with a call to iput().

> 
>> +	if (!underlying_object)
>> +		return false;
>> +
>> +	switch (object->type) {
>> +	case LANDLOCK_OBJECT_INODE:
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +	}
>> +	return true;
>> +}
>> +
>> +static void put_object_cleaner(struct landlock_object *object)
>> +	__releases(object->cleaners)
>> +{
>> +	/* Let's try an early lockless check. */
>> +	if (list_empty(&object->rules) &&
>> +			READ_ONCE(object->underlying_object)) {
>> +		/*
>> +		 * Puts @object if there is no rule tied to it and the
>> +		 * remaining user is the underlying object.  This check is
>> +		 * atomic because @object->rules and @object->underlying_object
>> +		 * are protected by @object->lock.
>> +		 */
>> +		spin_lock(&object->lock);
>> +		if (list_empty(&object->rules) &&
>> +				READ_ONCE(object->underlying_object) &&
>> +				refcount_dec_if_one(&object->usage)) {
>> +			/*
>> +			 * Releases @object, in place of
>> +			 * landlock_release_object().
>> +			 *
>> +			 * @object is already empty, implying that all its
>> +			 * previous rules are already disabled.
>> +			 *
>> +			 * Unbalance the @object->cleaners counter to reflect
>> +			 * the underlying object release.
>> +			 */
>> +			if (!WARN_ON_ONCE(!release_object(object))) {
> 
> Two ! hurt more than help.

Well, it may not look nice but don't you think it is better than a
WARN_ON_ONCE(1) in the if block?

>> +				__acquire(object->cleaners);
>> +				put_object_free(object);
> 
> Why put object more than once?

I just replied to Jann about this subject. This is to "unbalance" the
counter to potentially free it (if there is no more user). I explain it
here:
https://lore.kernel.org/lkml/67465638-e22c-5d1a-df37-862b31d999a1@digikod.net/

> 
>> +			}
>> +		} else {
>> +			spin_unlock(&object->lock);
>> +		}
>> +	}
>> +	put_object_free(object);
>> +}
>> +
> 
