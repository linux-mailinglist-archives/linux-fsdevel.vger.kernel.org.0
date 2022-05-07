Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700B51E48A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 07:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351687AbiEGGA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiEGGA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 02:00:58 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D5258E5F
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 22:57:11 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id p4so7489225qtq.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4QiUs7bTc9OmP7Roan38OsTnRpcW1If8vKI/brZvTE=;
        b=oBGYaeFvjV61On2wk8EzKNfiRn8JUmSdjD0PmdPbT9XuEcSJIvBHcfNiYvTk87pZOI
         j/rcKA64f7pCw1//QFrsAnNSq0O1zRyTHFk0DUNV6T2nNrcOhM+EXetGxwus9wqreBtT
         Ud8YZhtRvbsEY0sZ1usYnIfMlBkpc+7Jsk7kmrQWOAKBrSrixSbQd2EZey3O6IuKkOy7
         qeqDdBf1Iki5MSxCMsD9gXKQcMzFy4UZk4WhuFqxIVYZPzAwabJ0g1DHQJ54Tp3bvylX
         0UAB37ajpaJxgRQM+cmZlwhsen6vg9mCptjwj5Wb1L8fbryY9ygzMzz2xdJ69jSxX5fa
         7szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4QiUs7bTc9OmP7Roan38OsTnRpcW1If8vKI/brZvTE=;
        b=AC9pWRN3aAc8BVXH/RLdQOw899kK3gM/5Z+1SOH+61Wb+YEYZAYOfEq1/bHolMlIr5
         77AfdA9Irp4O5Sv1Df1DOuB6jj3ehBqMxEMhnKe0wKMRy0sKux32suWihMd4GMdZpnIw
         WCpIS1ErVTO2RA9CzhSZdmytuufre78lgm5ThMUPqRA3nLipllx8gtWJ1f5bG6REwcNc
         sjIvw6nv8l1CEpm3mvAm2bcy/9d+7ZNP5m+G+sXC5ZhkLerzppkqJtOCsJLlwisBiqLo
         2kypPLME1smxOsS0boT/WFNEGit36OJluHA0AoNzJerO1jPQ14snGhPsqZsZiPcPXDBu
         qTNg==
X-Gm-Message-State: AOAM530I3XnoioFMLckQYMA0q+anC5wtCALrlPbrfdgzFjsUXLPD7DIA
        iwFPRFz7M1+pa1Cr57W9T+vdF8tPySEjCQqAZ3M=
X-Google-Smtp-Source: ABdhPJxAeUR0SCU11P+qoFmloYPr35N+0U/HVKD6paOHjuuChGgTx4vc8t+ws2UKY6oE6vGzPeZR1IO8e/Af5iJNeKA=
X-Received: by 2002:ac8:4e46:0:b0:2e1:b933:ec06 with SMTP id
 e6-20020ac84e46000000b002e1b933ec06mr6027788qtw.684.1651903030673; Fri, 06
 May 2022 22:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220506014626.191619-1-amir73il@gmail.com> <20220506091203.yknwtnnxaz6n547d@quack3.lan>
In-Reply-To: <20220506091203.yknwtnnxaz6n547d@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 7 May 2022 08:57:00 +0300
Message-ID: <CAOQ4uxhvT=b6bNwxE5_XBmOh84nae72GhWJ_vaO8iwHgqY_ceA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: do not allow setting FAN_RENAME on non-dir
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 6, 2022 at 12:12 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 06-05-22 04:46:26, Amir Goldstein wrote:
> > The desired sematics of this action are not clear, so for now deny
> > this action.  We may relax it when we decide on the semantics and
> > implement them.
> >
> > Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
> > Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks guys. I've merged the fix to my tree (fast_track branch) and will
> push it to Linus on Monday once it gets at least some exposure to
> auto-testers.

Actually, I made a mistake.
It should not return -EINVAL, it should return -ENOTDIR, because
the error is the object not the syscall argument values.

Going forward, when Matthew implements FAN_RENAME on
non-dir, the error should be changed to -EPERM (for unpriv caller).
This will allow better documentation of behavior in kernel 5.17 and
newer kernels.

Can you please fix that before sending to Linus?

Thanks,
Amir.
