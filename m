Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8AB78105B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378635AbjHRQ3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378669AbjHRQ2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:28:55 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F213C35
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 09:28:50 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RS6kl5nZ9zMq1MM;
        Fri, 18 Aug 2023 16:28:47 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RS6kk58mWz11p;
        Fri, 18 Aug 2023 18:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692376127;
        bh=9DMDGEfPisEXlp15346TGMIklbX6npniTNA6DNlXEWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9V33hCBG0M2Jj7Ulkn/VMlFW1Rcpd3u6BZihpa/yoiuSi6A03pFN+NKY0imIEARU
         ndGiAQv/LUxeDPJH2p5uu2mhPIfire+fJGTwaEuOYfmum1FWRt7kdhmrAx8a4v2lbL
         FW4rLpbjFgG5R0jjjAAbFS1NSGR0vm0piSgGtBQE=
Date:   Fri, 18 Aug 2023 18:28:41 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] landlock: Document ioctl support
Message-ID: <20230818.ShaiGhu3wae9@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230814172816.3907299-6-gnoack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814172816.3907299-6-gnoack@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks good!

On Mon, Aug 14, 2023 at 07:28:16PM +0200, Günther Noack wrote:
> In the paragraph above the fallback logic, use the shorter phrasing
> from the landlock(7) man page.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  Documentation/userspace-api/landlock.rst | 74 ++++++++++++++++++------
>  1 file changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index d8cd8cd9ce25..e0e35e474307 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -61,18 +61,17 @@ the need to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>              LANDLOCK_ACCESS_FS_MAKE_SYM |
>              LANDLOCK_ACCESS_FS_REFER |
> -            LANDLOCK_ACCESS_FS_TRUNCATE,
> +            LANDLOCK_ACCESS_FS_TRUNCATE |
> +            LANDLOCK_ACCESS_FS_IOCTL,
>      };
>  
>  Because we may not know on which kernel version an application will be
>  executed, it is safer to follow a best-effort security approach.  Indeed, we
>  should try to protect users as much as possible whatever the kernel they are
> -using.  To avoid binary enforcement (i.e. either all security features or
> -none), we can leverage a dedicated Landlock command to get the current version
> -of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
> -access rights, which are only supported starting with the second and third
> -version of the ABI.
> +using.
> +
> +To be compatible with older Linux versions, we detect the available Landlock ABI
> +version, and only use the available subset of access rights:
>  
>  .. code-block:: c
>  
> @@ -92,6 +91,9 @@ version of the ABI.
>      case 2:
>          /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> +    case 3:
> +        /* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 4 */
> +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL;
>      }
>  
>  This enables to create an inclusive ruleset that will contain our rules.
> @@ -190,6 +192,7 @@ access rights per directory enables to change the location of such directory
>  without relying on the destination directory access rights (except those that
>  are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
>  documentation).
> +
>  Having self-sufficient hierarchies also helps to tighten the required access
>  rights to the minimal set of data.  This also helps avoid sinkhole directories,
>  i.e.  directories where data can be linked to but not linked from.  However,
> @@ -283,18 +286,24 @@ It should also be noted that truncating files does not require the
>  system call, this can also be done through :manpage:`open(2)` with the flags
>  ``O_RDONLY | O_TRUNC``.
>  
> -When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE``
> -right is associated with the newly created file descriptor and will be used for
> -subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavior is
> -similar to opening a file for reading or writing, where permissions are checked
> -during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
> +The truncate right is associated with the opened file (see below).
> +
> +Rights associated with file descriptors
> +---------------------------------------
> +
> +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE`` and
> +``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly created file
> +descriptor and will be used for subsequent truncation and ioctl attempts using
> +:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is similar to
> +opening a file for reading or writing, where permissions are checked during
> +:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
>  :manpage:`write(2)` calls.
>  
> -As a consequence, it is possible to have multiple open file descriptors for the
> -same file, where one grants the right to truncate the file and the other does
> -not.  It is also possible to pass such file descriptors between processes,
> -keeping their Landlock properties, even when these processes do not have an
> -enforced Landlock ruleset.
> +As a consequence, it is possible to have multiple open file descriptors
> +referring to the same file, where one grants the truncate or ioctl right and the
> +other does not.  It is also possible to pass such file descriptors between
> +processes, keeping their Landlock properties, even when these processes do not
> +have an enforced Landlock ruleset.
>  
>  Compatibility
>  =============
> @@ -422,6 +431,27 @@ Memory usage
>  Kernel memory allocated to create rulesets is accounted and can be restricted
>  by the Documentation/admin-guide/cgroup-v1/memory.rst.
>  
> +IOCTL support
> +-------------
> +
> +The ``LANDLOCK_ACCESS_FS_IOCTL`` access right restricts the use of
> +:manpage:`ioctl(2)`, but it only applies to newly opened files.  This means
> +specifically that pre-existing file descriptors like STDIN, STDOUT and STDERR

According to man pages (and unlike IOCTL commands) we should not
capitalize stdin, stdout and stderr.

> +are unaffected.
> +
> +Users should be aware that TTY devices have traditionally permitted to control
> +other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINUX`` IOCTL
> +commands.  It is therefore recommended to close inherited TTY file descriptors.

Good to see such warnings in the documentation.

We could also propose a simple solution to still uses stdin, stdout and
stderr without complex TTY proxying: re-opening the TTY, or replacing
related FD thanks to /proc/self/fd/*

For instance, with shell scripts it would look like this:
exec </proc/self/fd/0
exec >/proc/self/fd/1
exec 2>/proc/self/fd/2

Because of TIOCGWINSZ and TCGETS, an interactive shell may not work as
expected though.

> +The :manpage:`isatty(3)` function checks whether a given file descriptor is a
> +TTY.
> +
> +Landlock's IOCTL support is coarse-grained at the moment, but may become more
> +fine-grained in the future.  Until then, users are advised to establish the
> +guarantees that they need through the file hierarchy, by only permitting the
> +``LANDLOCK_ACCESS_FS_IOCTL`` right on files where it is really harmless.  In
> +cases where you can control the mounts, the ``nodev`` mount option can help to
> +rule out that device files can be accessed.
> +
>  Previous limitations
>  ====================
>  
> @@ -451,6 +481,16 @@ always allowed when using a kernel that only supports the first or second ABI.
>  Starting with the Landlock ABI version 3, it is now possible to securely control
>  truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
>  
> +Ioctl (ABI < 4)
> +---------------
> +
> +IOCTL operations could not be denied before the fourth Landlock ABI, so
> +:manpage:`ioctl(2)` is always allowed when using a kernel that only supports an
> +earlier ABI.
> +
> +Starting with the Landlock ABI version 4, it is possible to restrict the use of
> +:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL`` access right.
> +
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
