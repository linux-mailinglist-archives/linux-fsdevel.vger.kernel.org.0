Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153005B618D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiILTPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiILTPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:15:11 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37998D11C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 12:15:10 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MRGWb6NxJzMqqX1;
        Mon, 12 Sep 2022 21:15:07 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MRGWb2gglzMppMm;
        Mon, 12 Sep 2022 21:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663010107;
        bh=rcgOJ/wLO9IAEb+mxcf6Hw9OYMIuL4Iul0xUdfset0Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qnTXKC/9Ro4ZoxJ1XBXV1TGzOJmv+K1aP9xqTlscViz0MJy8C0dI09JAgz5jrmRnf
         YIxyn4hfYrLnbC+hpw/8jweToZbWiMoyrCUbm2kzftCbz5P7vOVqoRmjbMWssBbo00
         N6ebuZkNeGwklvGsXBF1AGpvLo4ebiIS0iKhiJXc=
Message-ID: <7f6e5b08-379d-2670-2869-3a0e3843b222@digikod.net>
Date:   Mon, 12 Sep 2022 21:15:06 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 5/5] landlock: Document Landlock's file truncation
 support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-6-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220908195805.128252-6-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 08/09/2022 21:58, Günther Noack wrote:
> Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> 
> Adapt the backwards compatibility example and discussion to remove the
> truncation flag where needed.
> 
> Point out potential surprising behaviour related to truncate.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   Documentation/userspace-api/landlock.rst | 62 +++++++++++++++++++++---
>   1 file changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b8ea59493964..57802fd1e09b 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>   =====================================
>   
>   :Author: Mickaël Salaün
> -:Date: May 2022
> +:Date: September 2022
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
> @@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
>   using.  To avoid binary enforcement (i.e. either all security features or
>   none), we can leverage a dedicated Landlock command to get the current version
>   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> -starting with the second version of the ABI.
> +remove the `LANDLOCK_ACCESS_FS_REFER` or `LANDLOCK_ACCESS_FS_TRUNCATE` access
> +rights, which are only supported starting with the second and third version of
> +the ABI.
>   
>   .. code-block:: c
>   
>       int abi;
>   
>       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> -    if (abi < 2) {
> -        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +    switch (abi) {
> +    case -1:
> +            perror("The running kernel does not enable to use Landlock");
> +            return 1;

I think it would be easier to understand to explicitly check for abi < 0 
in a dedicated block as in the sample, instead of case -1, and return 0 
(instead of 1) with a comment to inform that Landlock is not handled but 
it is OK (expected error).


> +    case 1:
> +            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +            __attribute__((fallthrough));
> +    case 2:
> +            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>       }
>   
>   This enables to create an inclusive ruleset that will contain our rules.
