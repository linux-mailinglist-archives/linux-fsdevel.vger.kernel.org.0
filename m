Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B255B616E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 21:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiILTFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiILTFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:05:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A68011177;
        Mon, 12 Sep 2022 12:05:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so11674862wmk.3;
        Mon, 12 Sep 2022 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=EAe4FwsmdcOkY4KLXuYmT6cZKD/9cGkpEmyUE2e9zZE=;
        b=dZmFRnDg34Gd/ZkCKrV4H9dh7X+7SBSuI//Ub00QWtR+v0S3ILA3A8aJtqTbbPfFNK
         22ZTWoE3oaydf1cYIwXxkylRo2grq+lr0cVudSHKDKdMZTv7Pf5/N1cgHNdl+01an6Q6
         fdO6RLHWmx6WL1qHE7euNsCEF9APnLHMbc25MhGi9g66g9eWNwkOELlw7jUjhk2dC0Bt
         ceQ3wWc6nyphsfNdvTc0skpyiFOylCcp8Vmim9fAazJL0eGqKhPhWD8Xikl5yMePTEoU
         6YeVQdvhRgSgSL7mAhYbaU0RwXOG4BVX7v7h46Tf2hOu8Xch9HaB8Wmjci2klzFfaxR3
         whXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EAe4FwsmdcOkY4KLXuYmT6cZKD/9cGkpEmyUE2e9zZE=;
        b=XKKEcpRobZ1PfOP5q4xi4yArqa/ZFvGRTXWM4paYfoGeLor+4lYsbe+8L0F0MLVJWt
         WniaoUGSTc0uAm8YoDAGbjIXtD8W3kFyn6hOZpYnFBXH4ruCDVeJPG2bsP13Wn4dM9Vq
         HXJuoWGGCcCg2qihPM0nqVKVCyM0NgZGbJoTrTUSWjsfu+RTUabpSprNhF2emnZdSDIZ
         gEpYXZFniubUgO9Y5EQbbhGhiacJmQsUaS20fZWXk31UqKqxO0NuUFYHbD1PW9rzAKLP
         0tiqqNVauwk5JgZz2CATwDXkESDKv0f6GNBUTNBZguPfmPBLUwsYEen2frLmbSNKUN2e
         0hLg==
X-Gm-Message-State: ACgBeo3GKHjfSr32o8X1To+XVXpSFkDgzohtBZXDrObdrzKvCQV8OqmP
        QRIisFDmcXJjc8fMcLiXQ0g=
X-Google-Smtp-Source: AA6agR5XY9OHRYXc/l7EuPyeu/TnrZXbvkcfP7vYC4MrmwphBVJeHzSP/Ai0oaD40pnW+zvtVKFfLw==
X-Received: by 2002:a1c:7916:0:b0:3b4:7575:d2f9 with SMTP id l22-20020a1c7916000000b003b47575d2f9mr7626999wme.27.1663009539034;
        Mon, 12 Sep 2022 12:05:39 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a331c6bffdsm11046787wmr.47.2022.09.12.12.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:05:38 -0700 (PDT)
Date:   Mon, 12 Sep 2022 21:05:37 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 5/5] landlock: Document Landlock's file truncation
 support
Message-ID: <Yx+DAaoQ+lPTOdpx@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-6-gnoack3000@gmail.com>
 <2f9c6131-3140-9c47-cf95-f7fa3cf759ee@digikod.net>
 <Yx9UZocFXQ9TbZnO@nuc>
 <b0bdf697-1789-d579-6b6b-a6aca73d4b11@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0bdf697-1789-d579-6b6b-a6aca73d4b11@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 07:47:11PM +0200, Mickaël Salaün wrote:
> On 12/09/2022 17:46, Günther Noack wrote:
> > On Fri, Sep 09, 2022 at 03:51:35PM +0200, Mickaël Salaün wrote:
> > > On 08/09/2022 21:58, Günther Noack wrote:
> > > > Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> > > > 
> > > > Adapt the backwards compatibility example and discussion to remove the
> > > > truncation flag where needed.
> > > > 
> > > > Point out potential surprising behaviour related to truncate.
> > > > 
> > > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > > ---
> > > >    Documentation/userspace-api/landlock.rst | 62 +++++++++++++++++++++---
> > > >    1 file changed, 54 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > > > index b8ea59493964..57802fd1e09b 100644
> > > > --- a/Documentation/userspace-api/landlock.rst
> > > > +++ b/Documentation/userspace-api/landlock.rst
> > > > @@ -8,7 +8,7 @@ Landlock: unprivileged access control
> > > >    =====================================
> > > >    :Author: Mickaël Salaün
> > > > -:Date: May 2022
> > > > +:Date: September 2022
> > > >    The goal of Landlock is to enable to restrict ambient rights (e.g. global
> > > >    filesystem access) for a set of processes.  Because Landlock is a stackable
> > > > @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
> > > >                LANDLOCK_ACCESS_FS_MAKE_FIFO |
> > > >                LANDLOCK_ACCESS_FS_MAKE_BLOCK |
> > > >                LANDLOCK_ACCESS_FS_MAKE_SYM |
> > > > -            LANDLOCK_ACCESS_FS_REFER,
> > > > +            LANDLOCK_ACCESS_FS_REFER |
> > > > +            LANDLOCK_ACCESS_FS_TRUNCATE,
> > > >        };
> > > >    Because we may not know on which kernel version an application will be
> > > > @@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
> > > >    using.  To avoid binary enforcement (i.e. either all security features or
> > > >    none), we can leverage a dedicated Landlock command to get the current version
> > > >    of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> > > > -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> > > > -starting with the second version of the ABI.
> > > > +remove the `LANDLOCK_ACCESS_FS_REFER` or `LANDLOCK_ACCESS_FS_TRUNCATE` access
> > > > +rights, which are only supported starting with the second and third version of
> > > > +the ABI.
> > > >    .. code-block:: c
> > > >        int abi;
> > > >        abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> > > > -    if (abi < 2) {
> > > > -        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > > > +    switch (abi) {
> > > > +    case -1:
> > > > +            perror("The running kernel does not enable to use Landlock");
> > > > +            return 1;
> > > > +    case 1:
> > > > +            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> > > > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > > > +            __attribute__((fallthrough));
> > > > +    case 2:
> > > > +            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> > > > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> > > >        }
> > > >    This enables to create an inclusive ruleset that will contain our rules.
> > > > @@ -127,8 +138,8 @@ descriptor.
> > > >    It may also be required to create rules following the same logic as explained
> > > >    for the ruleset creation, by filtering access rights according to the Landlock
> > > > -ABI version.  In this example, this is not required because
> > > > -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> > > > +ABI version.  In this example, this is not required because all of the requested
> > > > +``allowed_access`` rights are already available in ABI 1.
> > > 
> > > This fix is correct, but it should not be part of this series. FYI, I have a
> > > patch almost ready to fix some documentation style issues. Please remove
> > > this hunk for the next series. I'll deal with the merge conflicts if any.
> > 
> > Can you please clarify what part of it should not be part of this
> > series?
> 
> My mistake, I guess I was reviewing something else… I was thinking about
> style changes, but it is not the case here. Using "``" is correct.
> 
> 
> > 
> > In this hunk, I've started using double backquote, but I've also
> > changed the meaning of the sentence slightly so that it is still
> > correct when the truncate right is introduced.
> > 
> > It is still correct that the backwards compatibility check is not
> > required because LANDLOCK_ACCESS_FS_REFER is not allowed by any rule.
> > But with the new truncate flag, LANDLOCK_ACCESS_FS_TRUNCATE may also
> > not be allowed by any rule so that we can skip this check.
> > 
> > Should I remove this hunk entirely?
> 
> Keep your changes, it's better like this.

Thanks, reverted that part then.

—Günther

-- 
