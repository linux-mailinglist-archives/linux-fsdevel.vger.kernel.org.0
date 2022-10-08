Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D035F84FB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJHLT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJHLT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:19:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856AF014;
        Sat,  8 Oct 2022 04:19:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m15so10056630edb.13;
        Sat, 08 Oct 2022 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=se/66gn3QF2F5Lo6VpmJfEFqwp0VLrLyYHLNBf+zDrg=;
        b=KVvBq/xKCICDJZD2SDMj37lIBU8ww2AHjlVm4PGv64sRlrhWz7+A/E9vC5noaJ2K84
         OxfMv9+VPGr6ELRjK4f91ot952R8gZZ81kF01Q8ReSjoWwNKkzu+4PrSj3sASUZkaxoe
         Tdk+LuGpKYro73dPX63nHaA5KPDqfA2LJT8cMsBlqIrIy1zOvdVQCcwsArIwz+cMm1gJ
         LNf95JJ50rillKCx7VpecsTp/JMnh95Dli/MVcFNTFO3JpcqVRi/9rRI20v4ov/bFygV
         bYLsPSfOPgmLSLvOOu8wGYl6ePTzBjQi+1Bw/7KLRJIfn0L+B2NjflQ4wiWm1uwEdMqy
         RJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=se/66gn3QF2F5Lo6VpmJfEFqwp0VLrLyYHLNBf+zDrg=;
        b=TOM6WOvUtZJWL8Wnbeb2qiZiYRlBSIF1i6ALgwy++41n9DENi/uw4fL7q8Iw96nuKS
         edOuKgDi/8mws9rZ3nVcAGNxeGzrBJBI3mE8HRfMRxZEafp2f+zTQn46Jp5FGc7dYvtr
         8EG+VMQOtH7j4a7FP7rqKIoCXOfRTBYKFuvYy0ajlj8shzWMRMvoq+2NPi3O6lrgzoUJ
         FVJdRuATG+j0pVNP4kQKVOFXtWu0dV2qXfS+u2iUF7yGG7DIkta44si67lCcSlngHjH4
         L3YfjcEGf8ZZl+bKNJz+YQj5+GBOpPueR0rWdM9HiYz/l6vfhT+OB0FcUjfyfGoidRAx
         6aLQ==
X-Gm-Message-State: ACrzQf2g0VMvxiZKMdmjyvxjmeYFzGNliok4qhiHOdz8dqi0yDkZgRFJ
        Q6DXNBoPl6dRLapwLQHMa83rcB1YdMM=
X-Google-Smtp-Source: AMsMyM6Gp6q+Z6GtsALS2bH6ywkjvHK9ncABFofwxkYl8UhmG+8ZNlMOVmoUkXUjk4x6uGSjEwxnWg==
X-Received: by 2002:aa7:d392:0:b0:458:800a:c47 with SMTP id x18-20020aa7d392000000b00458800a0c47mr8470372edq.5.1665227993600;
        Sat, 08 Oct 2022 04:19:53 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id b17-20020a50b411000000b00454546561cfsm3246072edh.82.2022.10.08.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 04:19:53 -0700 (PDT)
Date:   Sat, 8 Oct 2022 13:19:51 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v9 11/11] landlock: Document Landlock's file truncation
 support
Message-ID: <Y0Fc1y5vGmiBzUHW@nuc>
References: <20221008111336.74806-1-gnoack3000@gmail.com>
 <20221008111336.74806-2-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221008111336.74806-2-gnoack3000@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, please ignore this thread -- I messed it up and accidentally sent it with the wrong Reply-To headers.

—Günther

On Sat, Oct 08, 2022 at 01:13:36PM +0200, Günther Noack wrote:
> Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> 
> Adapt the backwards compatibility example and discussion to remove the
> truncation flag where needed.
> 
> Point out potential surprising behaviour related to truncate.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 67 +++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index cec780c2f497..d8cd8cd9ce25 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: September 2022
> +:Date: October 2022
>  
>  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>  filesystem access) for a set of processes.  Because Landlock is a stackable
> @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_FS_MAKE_FIFO |
>              LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>              LANDLOCK_ACCESS_FS_MAKE_SYM |
> -            LANDLOCK_ACCESS_FS_REFER,
> +            LANDLOCK_ACCESS_FS_REFER |
> +            LANDLOCK_ACCESS_FS_TRUNCATE,
>      };
>  
>  Because we may not know on which kernel version an application will be
> @@ -69,16 +70,28 @@ should try to protect users as much as possible whatever the kernel they are
>  using.  To avoid binary enforcement (i.e. either all security features or
>  none), we can leverage a dedicated Landlock command to get the current version
>  of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the ``LANDLOCK_ACCESS_FS_REFER`` access right which is only supported
> -starting with the second version of the ABI.
> +remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
> +access rights, which are only supported starting with the second and third
> +version of the ABI.
>  
>  .. code-block:: c
>  
>      int abi;
>  
>      abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> -    if (abi < 2) {
> +    if (abi < 0) {
> +        /* Degrades gracefully if Landlock is not handled. */
> +        perror("The running kernel does not enable to use Landlock");
> +        return 0;
> +    }
> +    switch (abi) {
> +    case 1:
> +        /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
>          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +        __attribute__((fallthrough));
> +    case 2:
> +        /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>      }
>  
>  This enables to create an inclusive ruleset that will contain our rules.
> @@ -127,8 +140,8 @@ descriptor.
>  
>  It may also be required to create rules following the same logic as explained
>  for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because
> -``LANDLOCK_ACCESS_FS_REFER`` is not allowed by any rule.
> +ABI version.  In this example, this is not required because all of the requested
> +``allowed_access`` rights are already available in ABI 1.
>  
>  We now have a ruleset with one rule allowing read access to ``/usr`` while
>  denying all other handled accesses for the filesystem.  The next step is to
> @@ -252,6 +265,37 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>  process, a sandboxed process should have a subset of the target process rules,
>  which means the tracee must be in a sub-domain of the tracer.
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
>  Compatibility
>  =============
>  
> @@ -398,6 +442,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
>  control renaming and linking thanks to the new ``LANDLOCK_ACCESS_FS_REFER``
>  access right.
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
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.38.0
> 

-- 
