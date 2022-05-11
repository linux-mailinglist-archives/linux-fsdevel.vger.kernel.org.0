Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A018522DB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiEKHyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbiEKHyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 03:54:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D65535B
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 00:54:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z2so2371546ejj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzMMkfZrMvKIqp74yjxexWNbsddCucXysK/8AjnMuDo=;
        b=pLiNabLa/1a+ha0S9TA8mb6EqMuFaSFp6lI+B8ZJs1QHVz443lyvLCA4NFPFnOLUZD
         3WsWPRE+2hYt5cOx5pT17iCJttShm71pAV3g8ZniLBW8UpQq+9eMEyELPkMucGdQw8mD
         PlIVO06Hp++fL5XGA4WSNyXc9MHMPZZPmhMW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzMMkfZrMvKIqp74yjxexWNbsddCucXysK/8AjnMuDo=;
        b=6lYG1b+PIvYqyCD5+q8nP5j/giUb25SeaE7pVFEKwOabgMc2G8/zpcAnOfx4JGu4Qo
         2V3uv5eABSUX+NaNdMrjuHFRqxFD3bQhjNa4fL1Fqx1/lPr5FK04eMBJHV9FkxSGwLws
         Vd16MT2U172jLGaxSogukoo/KS90WMrEpt8Nkra6VOsyo0O3HZz0+u18VvboSmYrwBzf
         tuIOKRQPlTAOWtqax09unBQ2pak2VNYgeOUXrThM9GQQXmgbW06ex7HXajuCRit+tyy7
         0Kfvge8bIPtk6a7XFozghuiHoVq97E5DlfLgWspy6dxZoHZnBiUATZEBVX5Dhf6EJRuP
         2r7g==
X-Gm-Message-State: AOAM533p2PI8c4lZAV1/mYtHNMXuOcb82CVCAiFRKc3TYgdoSCe1wS0u
        BckwzufhAkRjgbtVreVEblYd131AhgU1qVe5+fZraQ==
X-Google-Smtp-Source: ABdhPJzFUKRUdzxU5TNwfPDyXzdiiYp66WWDo52LhcoNHXWE+EFeeVvN0N5J/3fC+A6zU8LzJvxII++mfCnSkaiuHf8=
X-Received: by 2002:a17:907:3f15:b0:6fc:30f0:6561 with SMTP id
 hq21-20020a1709073f1500b006fc30f06561mr6325814ejc.691.1652255659176; Wed, 11
 May 2022 00:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
In-Reply-To: <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 09:54:07 +0200
Message-ID: <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 May 2022 at 09:36, Daniil Lunev <dlunev@chromium.org> wrote:
>
> On Wed, May 11, 2022 at 5:07 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 11 May 2022 at 03:31, Daniil Lunev <dlunev@chromium.org> wrote:
> > >
> > > Force unmount of fuse severes the connection between FUSE driver and its
> > > userspace counterpart.
> >
> > Why is forced umount being used in the first place?
>
> To correctly suspend-resume. We have been using this force unmount historically
> to circumvent the suspend-resume issues which periodically occur with fuse.
> We observe FUSE rejecting to remount the device because of the issue this
> patchset attempts to address after the resume if there are still open
> file handles
> holding old super blocks. I am not sure if fuse's interaction with suspend is
> something that has been resolved systematically (we are also trying to
> figure that
> out).

No progress has been made in the past decade with regard to suspend.
I mainly put that down to lack of interest.

>  Regardless of that, doing force unmount of a mount point is a legitimate
> operation, and with FUSE it may leave the system in a state that is returning
> errors for other legitimate operations.

It is a legitimate operation, but one that is not guaranteed to leave
the system in a clean state.

Thanks,
Miklos
