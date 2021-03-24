Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F04347B95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhCXPDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbhCXPDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:03:05 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6394C0613DF;
        Wed, 24 Mar 2021 08:03:04 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F5BLY1j83zMq3Y5;
        Wed, 24 Mar 2021 16:03:01 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F5BLT1HXmzlh8TT;
        Wed, 24 Mar 2021 16:02:57 +0100 (CET)
Subject: Re: [PATCH v30 08/12] landlock: Add syscall implementations
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-9-mic@digikod.net> <202103191157.CF13C34@keescook>
 <380d65b2-f515-f3f5-5d57-7f99c528e5c7@digikod.net>
Message-ID: <9062d586-8fa7-a972-9615-ca3a5fe38cef@digikod.net>
Date:   Wed, 24 Mar 2021 16:03:36 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <380d65b2-f515-f3f5-5d57-7f99c528e5c7@digikod.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 22:53, Mickaël Salaün wrote:
> 
> On 19/03/2021 20:06, Kees Cook wrote:
>> On Tue, Mar 16, 2021 at 09:42:48PM +0100, Mickaël Salaün wrote:
>>> From: Mickaël Salaün <mic@linux.microsoft.com>

[...]

>>> +/**
>>> + * sys_landlock_create_ruleset - Create a new ruleset
>>> + *
>>> + * @attr: Pointer to a &struct landlock_ruleset_attr identifying the scope of
>>> + *        the new ruleset.
>>> + * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
>>> + *        backward and forward compatibility).
>>> + * @flags: Must be 0.
>>> + *
>>> + * This system call enables to create a new Landlock ruleset, and returns the
>>> + * related file descriptor on success.
>>> + *
>>> + * Possible returned errors are:
>>> + *
>>> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>>> + * - EINVAL: @flags is not 0, or unknown access, or too small @size;
>>> + * - E2BIG or EFAULT: @attr or @size inconsistencies;
>>> + * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
>>> + */
>>> +SYSCALL_DEFINE3(landlock_create_ruleset,
>>> +		const struct landlock_ruleset_attr __user *const, attr,
>>> +		const size_t, size, const __u32, flags)
>>> +{
>>> +	struct landlock_ruleset_attr ruleset_attr;
>>> +	struct landlock_ruleset *ruleset;
>>> +	int err, ruleset_fd;
>>> +
>>> +	/* Build-time checks. */
>>> +	build_check_abi();
>>> +
>>> +	if (!landlock_initialized)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	/* No flag for now. */
>>> +	if (flags)
>>> +		return -EINVAL;
>>> +
>>> +	/* Copies raw user space buffer. */
>>> +	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
>>> +			offsetofend(typeof(ruleset_attr), handled_access_fs),
>>
>> The use of offsetofend() here appears to be kind of the "V1", "V2", ...
>> sizes used in other extensible syscall implementations?
> 
> ruleset_attr is an extensible argument.

offsetofen() is used to set the minimum size of a valid argument. This
code will then not change with future extended ruleset_attr.
