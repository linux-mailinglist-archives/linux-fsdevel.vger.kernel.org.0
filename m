Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745EC67DE40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 08:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjA0HJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 02:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjA0HJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:09:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3038EA9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 23:09:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id br9so6775287lfb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 23:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WemP22SNSMVMbLWy+Pc4nysxoGXi6mbk91cpruNFrDU=;
        b=E1MVf/aQXs+c4b3AC/WhtICxVhvPHRbx3ZYDVojqsIgNloReWpa6Z9wbGURFKohm6i
         +Lcj/4AxwcN61+pn+ZVDUY80BhrTEI9DZADjx21rJYtjd7Q2Q1n6ORlMJTUgY8cx0CdS
         5AsfCIO8ZdkXKbInYPUeydRKgYwR+YUW4tqU2jdxy5a3uf6w/D2v1d+4ojTf3eG2rKXm
         z61NptGViFXeCptS2VvwJPLaeWPm1Vuony7VgmeGNl7EzIxDNwm4b7B4iAVheLet4OaL
         T/6yo2dLI8cLsHu/4gYzGoNrcWeH4KwHVFMIwUQRxfCDEr5QKQjso0H8HPcNNPPzGzZ5
         mmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WemP22SNSMVMbLWy+Pc4nysxoGXi6mbk91cpruNFrDU=;
        b=zA1Y4MkTUp/v5Nw1jCFlFbCc98RgPe3aUED6ODVwtuZOO5ypoAsPsdP7E+WXlFQDjX
         +vk9l8fGUGwmU2m0L5yCe0BDz5QQkSdDW6LPuGdOcdF1dq7rf7crjCDzYE1c7G+MGO+O
         vEogDKdLodDoyN9sN/tv3Fv6NVhp5yTSz6EaHFFhwWDdLAJLpOOvkAda4ZTYliJRiqrf
         qQgfFAz4DFjLYM5WrnVQY9FPpPYztw4hWzQpgpAHoICahISrJWXCm72saW7wrembIMNc
         +BCcX4A1Sx407fTH1NpCAkabjmQkawJjc9NoRGHrlbxrfV2+fr3relZVAvSROd5a+tW+
         VC5w==
X-Gm-Message-State: AFqh2krHj4UtR97rLSjNoAA7k1qpemISIoCLAfFcszucDszK504hh56S
        2oe6/zXtonfFKtracbXb6nJs480tvvPcnA9P1CoUTQ==
X-Google-Smtp-Source: AMrXdXtU8P5hhlqeiJHPIC4HN23au/K/crO29UIaMieQS5VJNVl9PP2xWiYFAsjJY5jbTyxF2z6gILNBjNQ6CiBxs5Y=
X-Received: by 2002:a19:7712:0:b0:4cc:9c4b:6dfa with SMTP id
 s18-20020a197712000000b004cc9c4b6dfamr1998600lfc.307.1674803359488; Thu, 26
 Jan 2023 23:09:19 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009ecbf205dda227bd@google.com> <0000000000004dc42605f31dd05c@google.com>
 <20230126131424.ufk6zspn6fyzw5l6@revolver>
In-Reply-To: <20230126131424.ufk6zspn6fyzw5l6@revolver>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:09:07 +0100
Message-ID: <CACT4Y+b3P8=0aehSvEhX09A5vTNFTaME1Qse93J-zCR6zns6HQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_nentry
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com>,
        brauner@kernel.org, dan.carpenter@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, wanjiabing@vivo.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Jan 2023 at 14:14, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> syz fix: fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
>
> * syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com> [230125 17:04]:
> > syzbot suspects this issue was fixed by commit:

syzbot needs the hash to parse the command:

#syz fix: fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()

> > commit 59f2f4b8a757412fce372f6d0767bdb55da127a8
> > Author: Liam Howlett <liam.howlett@oracle.com>
> > Date:   Mon Nov 7 20:11:42 2022 +0000
> >
> >     fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129e8afe480000
> > start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7170d66493145b71afd4
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bfb2a9880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b1d319880000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
