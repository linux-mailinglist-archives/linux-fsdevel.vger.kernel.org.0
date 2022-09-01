Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3285A91FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiIAIV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiIAIVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:21:16 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B2AD997;
        Thu,  1 Sep 2022 01:20:40 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id i67so7886978vkb.2;
        Thu, 01 Sep 2022 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LGnLFW6yPESHX+DAC4jzdLUcy7kE4ClWL1XfjHPmqqA=;
        b=QwHelFVXzfmM4/EysT5tZOAf8LTkUs1vC+WzbOiLSd6cfKqbV1b+Z1iS7P1cqVK4VK
         05iPjC8ldpsIAHbcek332F4BOebdOxw2s69XHe0H5CoRmAXOUQzVb9KeTI4PH1Yhy33c
         0D0jcj+ONGknboXbkyvJoMweMqnsvkAQ79Y+TdbYoFMTEWcV4+nty2kb0pdJqBuvdOxr
         Mn8G68YcW0Jfciw+c2PkCX9MC85FPUUsqQJwWu2qANDpN8qYXZNNb7m/02bmTXCves1r
         8wM8iOSpDJ2W9hi3vE5EFHE+KWEC5E5eYfFI7F9TMhvVZCM61sLeezagrLIftTifbZLA
         R4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LGnLFW6yPESHX+DAC4jzdLUcy7kE4ClWL1XfjHPmqqA=;
        b=qOz5fR1Ky1sM+/uUQPKoMZYEWNJomAVV87OL2JSf13IRlL42u1JyBpGTsbpOHfFvTL
         D/lRqkP04COvU++9e8eLdDS7twB1XDFW7eKvXc5bOw2leKCq74eNcpSekHs8APtrt+5w
         IOge29JLPNWm5Xk/CNT53NpApVSqy/dL1lZj7O4tpNbxck4vVyyHmEGWMAMFQcmW+Ov8
         Dqb/ZtgUWkLHdXNLIq4XMvQk8CW9G3RRcrLmU7CHF0hKC879dXzgl4oI5P6zD0waWxde
         3/lDRrnOlHV9HwMgCI2kLetRqaU9lNWXtmNu0d17IpXVwbUSPxQ/XJMm+A9GxmfVv6YK
         0qDw==
X-Gm-Message-State: ACgBeo0YZ4l2ZGFFMxn0qYqY1vi8FE9A+AhcVaH5GZzgTrnAfurUM76w
        T5zJynu0vPsmDaSXo+OgRcoOEEbpW/XnKnyndVY=
X-Google-Smtp-Source: AA6agR4FO9JoeFxtHWua0hNC49l8PA/DNsBd9h4keicBNDZCmaRAhWIyDhSpOGnLRQ0GI9as5iQYPtm1sPCxXm7PNMQ=
X-Received: by 2002:a1f:19cf:0:b0:375:6144:dc41 with SMTP id
 198-20020a1f19cf000000b003756144dc41mr8092825vkz.3.1662020439493; Thu, 01 Sep
 2022 01:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220830152858.14866-1-cgzones@googlemail.com>
 <20220830152858.14866-2-cgzones@googlemail.com> <Yw/eEufm/QpKg5Pq@ZenIV>
In-Reply-To: <Yw/eEufm/QpKg5Pq@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Sep 2022 11:20:28 +0300
Message-ID: <CAOQ4uxgp3_6KKSCvQvwGXq4WmkndcvzsBnk7QqQZvBZGF-6yZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fs/xattr: add *at family syscalls
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 1, 2022 at 2:10 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> [linux-arch Cc'd for ABI-related stuff]
>
> On Tue, Aug 30, 2022 at 05:28:39PM +0200, Christian G=C3=B6ttsche wrote:
> > Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
> > removexattrat() to enable extended attribute operations via file
> > descriptors.  This can be used from userspace to avoid race conditions,
> > especially on security related extended attributes, like SELinux labels
> > ("security.selinux") via setfiles(8).
> >
> > Use the do_{name}at() pattern from fs/open.c.
> > Use a single flag parameter for extended attribute flags (currently
> > XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
> > syscall arguments in setxattrat().
>
>         I've no problems with the patchset aside of the flags part;
> however, note that XATTR_CREATE and XATTR_REPLACE are actually exposed
> to the network - the values are passed to nfsd by clients.
> See nfsd4_decode_setxattr() and
>         BUILD_BUG_ON(XATTR_CREATE !=3D SETXATTR4_CREATE);
>         BUILD_BUG_ON(XATTR_REPLACE !=3D SETXATTR4_REPLACE);
> in encode_setxattr() on the client side.
>
>         Makes me really nervous about constraints like that.  Sure,
> AT_... flags you are using are in the second octet and these are in
> the lowest one, but...

In this context, I would like to point at

AT_EACCESS
AT_REMOVEDIR

Which are using the same namespace as the AT_ flags but define
a flag in a "private section" of that namespace for faccessat() and
for unlinkat().
unlinkat() does not technically support any of the generic AT_ flags,
but the sycall name does suggest that it is the same namespace.

At the risk of getting shouted at, I propose that we retroactively
formalize this practice and also define
AT_XATTR_* and AT_RENAME_* constants
with the accompanied BUILD_BUG_ON()
and document above the AT_ definitions that the lowest 10 bits
are reserved as private namespace for the specific syscall.

There are also the AT_STATX_*SYNC* flags that could fall
into the category of syscall private namespace, but those flags could
actually be made more generic as there are other syscalls that may
benefit from supporting them.

linkat() is one example that comes to mind.
Similar suggestions have been posted in the past:
https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.=
com/
https://lore.kernel.org/linux-fsdevel/CAOQ4uxit0KYiShpEXt8b8SvN8bWWp3Ky929b=
+UWNDozTCUeTxg@mail.gmail.com/

Thanks,
Amir.
