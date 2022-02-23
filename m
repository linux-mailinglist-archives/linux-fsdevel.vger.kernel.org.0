Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90B64C2058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 01:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiBXAAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 19:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiBXAAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:00:40 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFD45E147;
        Wed, 23 Feb 2022 16:00:11 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id u12so537605ybd.7;
        Wed, 23 Feb 2022 16:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djoY2wGo8Bskf3+H2QGMHgodNIrrUDznDojPM3Z5KCM=;
        b=TEiq5QkD0Pl37RTkVTqlCRlV6YKVYsYu/wCcfutLS/EB/bm3giMtsgoQNr6gve8ZKH
         V8lTH8chQAbx2axZpZYQNfuHNHRtw1Sl4svvF0R4GQUf7rJolYr5p5e7aUggdiL4RNSK
         hkBwe0uKkG4qhoig+dOWUPaQ2XshdD1yuo7F6v7M/hKYVL0koIOtPWDCBcZgDp5c+2Ae
         8POjP+u57Mdq+3f4UIRugZ+CBrSRe0bLZYRGyznvmVzhVIb/kXf3/oFzzhv0Z8AwSwFb
         NTYXSI4AiMA+ZgviOXY+n4BqR0PIi90KOkIHl+fhzksVjX2jiWccIjI6ijQMa6ZoPSrP
         XipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djoY2wGo8Bskf3+H2QGMHgodNIrrUDznDojPM3Z5KCM=;
        b=nSaUJ5oUPCrP2V7NPkLcuAyCvE64qZoQqZjwZtqtVfVTNcJLm1G3u4+e2e84jtKTjD
         jbLsuHcqI2LxKd1pPa1GEfF79MwwT27WKVieYNeXmaQtlHLPkotXn6bs2BVASx49NYx6
         qSfnrWPOzRNoLJQYmjzTwpa/NALoqOom5fzbARnA+CtOkQ6zcKq2uZdhsi6MuVkEjJC9
         BkvLMoGw0f9Xch5e7c/197he3Z4fKFftuMs74tRugSRn4ejeTaj6qst46SDmB1W9D9Fd
         zMSmuy5iMf64AptokkwlHisriMKc3R4AYT/8ZxgzBl98erkpUw6HwE8fIjV0+2L99yia
         YVsw==
X-Gm-Message-State: AOAM530vIA5/p7nF1jAHdw65xmkSFuU4BrwKNk3Sh/0JGxDkfTaezRnk
        5VoEXEGECVb01c8ZzJLHVZdM8PFz8wlozNQAAqk=
X-Google-Smtp-Source: ABdhPJxnPNJgf+YrSnqXFBDyu5QCocMrL/CC8kWrzc1DMjw26LnV4Jda9nnJpQ9bDsAsnicYxRD9HGYgTuiYuWFQWkk=
X-Received: by 2002:a5b:489:0:b0:623:a73e:3818 with SMTP id
 n9-20020a5b0489000000b00623a73e3818mr171822ybp.358.1645660810561; Wed, 23 Feb
 2022 16:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20220223231752.52241-1-ppbuk5246@gmail.com> <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
In-Reply-To: <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 24 Feb 2022 08:59:59 +0900
Message-ID: <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
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

On Thu, Feb 24, 2022 at 8:24 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Feb 24, 2022 at 08:17:52AM +0900, Levi Yun wrote:
> > Suppose a module registers its own binfmt (custom) and formats is like:
> >
> > +---------+    +----------+    +---------+
> > | custom  | -> |  format1 | -> | format2 |
> > +---------+    +----------+    +---------+
> >
> > and try to call unregister_binfmt with custom NOT in __exit stage.
>
> Explain, please.  Why would anyone do that?  And how would such
> module decide when it's safe to e.g. dismantle data structures
> used by methods of that binfmt, etc.?
> Could you give more detailed example?

I think if someone wants to control their own binfmt via "ioctl" not
on time on LOAD.
For example, someone wants to control exec (notification,
allow/disallow and etc..)
and want to enable and disable own's control exec via binfmt reg / unreg
In that situation, While the module is loaded, binfmt is still live
and can be reused by
reg/unreg to enable/disable his exec' control.

module can decide it's safe to unload by tracing the stack and
confirming whether some tasks in the custom binfmt's function after it
unregisters its own binfmt.

> Because it looks like papering over an inherently unsafe use of binfmt interfaces..

I think the above example it's quite a trick and stupid.  it's quite
unsafe to use as you mention.
But, misuse allows that situation to happen without any warning.
As a robustness, I just try to avoid above situation But,
I think it's better to restrict unregister binfmt unregister only when
there is no module usage.
