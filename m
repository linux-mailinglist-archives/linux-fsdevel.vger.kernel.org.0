Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AB5F5A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJES5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJES5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:57:42 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD47FE54
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 11:57:40 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjP2p3ZByzMqJ2s;
        Wed,  5 Oct 2022 20:57:38 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjP2n6xnMzMpqBh;
        Wed,  5 Oct 2022 20:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664996258;
        bh=AikZju/a9kBTV3If2Je225YSS4yslrynNtNIxE5ZElY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pePWPNm1/x9tCePr+CJGnaCXa4Ilp/ytW4OJvbRay1Ikf6L5xhXKhCfDP/TuSmc3k
         eVb5yN3ikC2or8wjqjvv/l9iKZn2y+d1hsDEboz/8E7YiZts2zXihOi4Jeu4zu3mtp
         KwDvuHV4Eg1LKQIM15B7VuzdzJ0/TeJzKd12fbmQ=
Message-ID: <9c340d63-c90b-6049-ac4d-1415a93a5fc6@digikod.net>
Date:   Wed, 5 Oct 2022 20:57:37 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 9/9] landlock: Document Landlock's file truncation
 support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-10-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221001154908.49665-10-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 01/10/2022 17:49, Günther Noack wrote:
> Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> 
> Adapt the backwards compatibility example and discussion to remove the
> truncation flag where needed.
> 
> Point out potential surprising behaviour related to truncate.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   Documentation/userspace-api/landlock.rst | 66 +++++++++++++++++++++---
>   1 file changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b8ea59493964..44d6f598b63d 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>   =====================================
>   
>   :Author: Mickaël Salaün
> -:Date: May 2022
> +:Date: October 2022
>   
>   The goal of Landlock is to enable to restrict ambient rights (e.g. global
>   filesystem access) for a set of processes.  Because Landlock is a stackable
> @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
>               LANDLOCK_ACCESS_FS_MAKE_FIFO |
>               LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>               LANDLOCK_ACCESS_FS_MAKE_SYM |
> -            LANDLOCK_ACCESS_FS_REFER,
> +            LANDLOCK_ACCESS_FS_REFER |
> +            LANDLOCK_ACCESS_FS_TRUNCATE,
>       };
>   
>   Because we may not know on which kernel version an application will be
> @@ -69,16 +70,27 @@ should try to protect users as much as possible whatever the kernel they are
>   using.  To avoid binary enforcement (i.e. either all security features or
>   none), we can leverage a dedicated Landlock command to get the current version
>   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> -starting with the second version of the ABI.
> +remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
> +access rights, which are only supported starting with the second and third
> +version of the ABI.
>   
>   .. code-block:: c
>   
>       int abi;
>   
>       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> -    if (abi < 2) {
> +    if (abi < 0) {
> +        perror("The running kernel does not enable to use Landlock");

Please insert in a dedicated line this comment: /* Degrades gracefully 
if Landlock is not handled. */


> +        return 0;  /* Degrade gracefully if Landlock is not handled. */
> +    }
> +    switch (abi) {
> +    case 1:
> +        /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
>           ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +        __attribute__((fallthrough));
> +    case 2:
> +        /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>       }
>   
>   This enables to create an inclusive ruleset that will contain our rules.
> @@ -127,8 +139,8 @@ descriptor.
>   
>   It may also be required to create rules following the same logic as explained
>   for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because
> -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> +ABI version.  In this example, this is not required because all of the requested
> +``allowed_access`` rights are already available in ABI 1.
>   
>   We now have a ruleset with one rule allowing read access to ``/usr`` while
>   denying all other handled accesses for the filesystem.  The next step is to
> @@ -251,6 +263,37 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>   process, a sandboxed process should have a subset of the target process rules,
>   which means the tracee must be in a sub-domain of the tracer.
>   
> +Truncating files
> +----------------
> +
> +The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
> +``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and sometimes
> +overlap in non-intuitive ways.  It is recommended to always specify both of
> +these together.
> +
> +A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> +that this system call requires the rights to create and write files.  However,
> +it also requires the truncate right if an existing file under the same name is
> +already present.
> +
> +It should also be noted that truncating files does not require the
> +``LANDLOCK_ACCESS_FS_WRITE_FILE`` right.  Apart from the :manpage:`truncate(2)`
> +system call, this can also be done through :manpage:`open(2)` with the flags
> +``O_RDONLY | O_TRUNC``.
> +
> +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE``
> +right is associated with the newly created file descriptor and will be used for
> +subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavior is
> +similar to opening a file for reading or writing, where permissions are checked
> +during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
> +:manpage:`write(2)` calls.
> +
> +As a consequence, it is possible to have multiple open file descriptors for the
> +same file, where one grants the right to truncate the file and the other does
> +not.  It is also possible to pass such file descriptors between processes,
> +keeping their Landlock properties, even when these processes do not have an
> +enforced Landlock ruleset.
> +
>   Compatibility
>   =============
>   
> @@ -397,6 +440,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
>   control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
>   access right.
>   
> +File truncation (ABI < 3)
> +-------------------------
> +
> +File truncation could not be denied before the third Landlock ABI, so it is
> +always allowed when using a kernel that only supports the first or second ABI.
> +
> +Starting with the Landlock ABI version 3, it is now possible to securely control
> +truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
> +
>   .. _kernel_support:
>   
>   Kernel support
