Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A84C2065
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 01:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiBXALY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 19:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiBXALX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:11:23 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C05F27F;
        Wed, 23 Feb 2022 16:10:55 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d66f95f1d1so8435137b3.0;
        Wed, 23 Feb 2022 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3ZrLZGoDaxWbsFP1d+KF7dHhK6vrM0KU3io68wZLg8=;
        b=YIaZo6IMYJROX/vWqdeXYInhR0K4D3UIRkcZY1vK72JnUPrdFzkNY2hFw2BdOkI0BN
         xvH7KmfkVdMrFmPlFZh0ZSNIVaQKCvrE9lk6lLAtDXc9kLjSMommM+f76D2mKN8X9KWB
         cVCO9y9WgbrtAqpuOit2PToD4boay7BI9rOkVlzwAWe6pm6Ewc+GpJg91Y9j8m6v6EBS
         1JgeTeiWl3tE0P0D1NSLaJtaX6/NZNgMZZZm7vsq7UTpeYlCrmAr+eiPalpfJaMOdQEL
         Rbq8OWuR/I12yABl5nLdp9n1ULvY983Xk2mcCCKCyn5nS+6MZO8DaVnEVRuzTsJTfeK/
         pq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3ZrLZGoDaxWbsFP1d+KF7dHhK6vrM0KU3io68wZLg8=;
        b=mA8bXVSYp3vZLIfUo6ctg9+Hx3HsvEPklL1olBXFPayEulzF3Mwdyg1H/JMPEO4iwN
         yW5cppKcaRCNNGg4C3lWAZjOv0HHJ2uPskMWBtK6EBQRBB5fhMKVWgLMN8l4j2+Q+u5L
         eAhAWwMTjYkEBqWehOWONjzgwwraqdY+oJy7k8mf1JfjV+sCsyRqrlEZ2AcHj/ld/FHN
         37CNhG/Az/7UySCxn9RYigOmEBR7DR537VYLRWJ3PYXxn0UJDueLP3oFqCRzQv1K0Dz4
         a1tl2YXdJtMlkOg/MS1cY00aS4o77ER2wE6Z9et3bzwNrqmJGzylZpYg80n7u46XkCMT
         bHpA==
X-Gm-Message-State: AOAM531CkNCV+3nBDpCarjvp5tl/OB7UjCqEIcscErMMVDBkSZlO+g73
        rKkUuCQuAaq+wKAcX85E/d4uXHGJFRp2K4cheHs=
X-Google-Smtp-Source: ABdhPJzckbUtxMWN/xFjl4Me7UdG+Y2zooKnpYSQ2EkQyLiLuE4UfhGD/sgzFE778xVksOrp/VQQMY7667A/gD8WJyo=
X-Received: by 2002:a0d:f681:0:b0:2d0:a6ac:42f1 with SMTP id
 g123-20020a0df681000000b002d0a6ac42f1mr71656ywf.407.1645661454003; Wed, 23
 Feb 2022 16:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20220223231752.52241-1-ppbuk5246@gmail.com> <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
 <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
In-Reply-To: <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 24 Feb 2022 09:10:43 +0900
Message-ID: <CAM7-yPSk35UoGmRY_rCo2=RryBvwbQEjeWfL2tz1ADUosCXNjw@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 8:59 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> On Thu, Feb 24, 2022 at 8:24 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Feb 24, 2022 at 08:17:52AM +0900, Levi Yun wrote:
> > > Suppose a module registers its own binfmt (custom) and formats is like:
> > >
> > > +---------+    +----------+    +---------+
> > > | custom  | -> |  format1 | -> | format2 |
> > > +---------+    +----------+    +---------+
> > >
> > > and try to call unregister_binfmt with custom NOT in __exit stage.
> >
> > Explain, please.  Why would anyone do that?  And how would such
> > module decide when it's safe to e.g. dismantle data structures
> > used by methods of that binfmt, etc.?
> > Could you give more detailed example?
>
> I think if someone wants to control their own binfmt via "ioctl" not
> on time on LOAD.
> For example, someone wants to control exec (notification,
> allow/disallow and etc..)
> and want to enable and disable own's control exec via binfmt reg / unreg
> In that situation, While the module is loaded, binfmt is still live
> and can be reused by
> reg/unreg to enable/disable his exec' control.
>
> module can decide it's safe to unload by tracing the stack and
> confirming whether some tasks in the custom binfmt's function after it
> unregisters its own binfmt.
>
> > Because it looks like papering over an inherently unsafe use of binfmt interfaces..
>
> I think the above example it's quite a trick and stupid.  it's quite
> unsafe to use as you mention.
> But, misuse allows that situation to happen without any warning.
> As a robustness, I just try to avoid above situation But,
> I think it's better to restrict unregister binfmt unregister only when
> there is no module usage.

And not only stupid exmaple,
if someone loadable custom binfmt register in __init and __exit via
register and unregister_binfmt,
I think that situation could happen.
