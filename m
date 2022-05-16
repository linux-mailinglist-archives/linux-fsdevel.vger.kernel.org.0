Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338A85294AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350088AbiEPXGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbiEPXGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 19:06:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3C33E9B
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:06:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h14so2731988wrc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWbhKr4uIgUJdqioayLfv0a/97vu9JuV374NJIuj07k=;
        b=srCDnu0GFgxUWJi+fbEi5+IRCNr5P8YyBqD/ANuYnVBRNhOZlxyc1Kq7tP5Ujjbef8
         GD6tlfL7VBbP+GzV3JA7qP4xgQJb3w+9iU82QMe3jKpf8n203zwYotjwe+bylMxPtAkh
         B6Qd+jBHp39THWYfGS8RQbMOBPNCKvhsqdkbhmfKAf8JpN0MSZ3on0uj413fBDi7rekB
         3w7C51qoVD9+iYGB8NdvyksbJsGVPX4wePRpRuYeQSko03SZP7uyt2UE2xoGli6DwoYJ
         yEwideiPF+2R6hD8GsSU3lM7MuE40Q2peGFuEbND5FTsIiCZaKIkhvtLhNFK4VcYkVgb
         YWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWbhKr4uIgUJdqioayLfv0a/97vu9JuV374NJIuj07k=;
        b=hnC1IunuLvcc641Mf4sv/OvqY+GXBDqhCuZIUHKwKO/RAz/ASWAFsy4pA2cYQYBDtt
         UJ3R4T9H+p1UrrQy939+TXKDj29GeAvVtkjpeIRWhUhfOCcBpG0V1aZ4HV0/dz+u8o9P
         zjz8WE/QDxPdOOWIypPMF3vP6y5eWomj8A9/yO8+hEo1kcuMzFrC5aRWOVRy9SICIFRA
         sPyL822zcu4dB5vb8X/J3qPzmC+/5S2K4aRcLKavEij1fyrx/IPBKR2p4NKRc9b+bfNS
         O3SBKEs1sY7uKaZTr0hnNz3MCYHYdFXkBJsqQN2FapJntcBUyyDtkI0T/wWB9VY4M89A
         44Sw==
X-Gm-Message-State: AOAM533w4rL54RLq48r9MSISlsDn+19wctpcPVTy/NvD4VX/jkvrg7hG
        MGF6dcommaCmMB9R+WtCV87Gs3vOH/4ZAsDjqf8k
X-Google-Smtp-Source: ABdhPJzMOUlYHtDAXxonPowZHZVLJu4wBPBpRYjA/BeHhRo120bLMO/D+T6lSRrgQH7hQWbqtYdTp3CU8xpDNFGiNn0=
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id
 l6-20020a5d4806000000b0020ada03711bmr15470768wrq.395.1652742396890; Mon, 16
 May 2022 16:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652730821.git.rgb@redhat.com> <b70eb9b7620fdda8c46acf055dfd518b81ae2931.1652730821.git.rgb@redhat.com>
In-Reply-To: <b70eb9b7620fdda8c46acf055dfd518b81ae2931.1652730821.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 May 2022 19:06:26 -0400
Message-ID: <CAHC9VhRaDV21BE+UuiOpwnwtdmi39iTNO7pUuLiJZ8ABZH+83g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fanotify: Ensure consistent variable type for response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 4:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The user space API for the response variable is __u32. This patch makes
> sure that the whole path through the kernel uses u32 so that there is
> no sign extension or truncation of the user space response.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/12617626.uLZWGnKmhe@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.h      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 6 +++---
>  include/linux/audit.h              | 6 +++---
>  kernel/auditsc.c                   | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

We're at -rc7, so this should wait until after the upcoming merge
window, but it looks okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
