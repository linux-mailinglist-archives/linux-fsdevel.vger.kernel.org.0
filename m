Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E833987F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhFBLW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhFBLWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84009C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 04:21:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id r17so1873474qkp.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gchpafLKJ6F6uOATukxao5S0fzx1QuO5gM2w3naYObs=;
        b=RYDTY0QjdOGb7GBWzWXSIgmp3riEMTtlJ6ePjnS+zHZaqHYFqkBg61i+LUjT8vT0yX
         0aFpRQzdhdiMFqLC0g8cGKUzYmQ+6Uvp5324tCxg7MgufCsg5COzkVbUDxigOpidKyj0
         DfE61GhP1X/GTu1+yxXuVjsqsxs+5CW7o4mkpLeONuCCNft/BESAatIMWgCmnsIdnmvl
         aR9+WJswy89YDIvJ/HT1wB296lsOy7zulRpyVy1u04f604IifYk4496HUh8S5UOkGiKq
         VXJ4JzhBsS2k6HdiksLiL0UqPD8JZjTSwUNnY9Td8DpldjOrRbnm7CLOtyewUJAz7VnE
         QFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gchpafLKJ6F6uOATukxao5S0fzx1QuO5gM2w3naYObs=;
        b=i3wmlPrSE5ZF3Zb7gGIp9fyDo4/tJKmtG7k76+le6RmayYwTmjHOhCnoQC/l3d44DH
         83r3WdTmhxHMsAwo41nQsHedLKt0kxy0MgIczqSL+shNXVmrYNPVKLYWAX3adBtTGU8v
         lAZ2OQWc4Rj9O5CDCHk7toVbrpzC0Fsy8Xd3mtnnPM2wZ5aqFVYGkyWqqpSsoBHVo3MG
         E+TRlTJa0TykQNnwiO5NPqiJITbwgcHJEpjc3XHgI0FalutSQVjNL/GpIWQLhq0XYXR6
         i/uusjjXWl68SeWeSFpZt5xZaRYy5SyeA+C5gtWhtMP1wf8c1xuclS3lk2yZ71cpv0l5
         H+EA==
X-Gm-Message-State: AOAM533Rg6KjohScLue21R7Cx7vg16uaNQH/QYzQbomug7h4j8MevAVW
        WDiYe1mwkkF/uXbKGlTigrH29YZG0r3EJwiWSXkG0A==
X-Google-Smtp-Source: ABdhPJxkQvzCyua+2YCHkeNe+i/7cmwbKWtNkqHYzH1bZ1etsu2/XFklrkSEo8/9k2tD2Ih4LDt8IMgD4M2z0xhIp6w=
X-Received: by 2002:a05:620a:15b:: with SMTP id e27mr19426423qkn.501.1622632869281;
 Wed, 02 Jun 2021 04:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c98d7205ae300144@google.com> <0000000000003e409f05c3c5f190@google.com>
 <YLdo77SkmGLgPUBi@casper.infradead.org>
In-Reply-To: <YLdo77SkmGLgPUBi@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jun 2021 13:20:57 +0200
Message-ID: <CACT4Y+YUa41KMCO3n9WSvsbLqXo=F5nxpnoYWyiyB=AFWZ-KVA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in idr_get_next
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com>,
        anmol.karan123@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        dsahern@kernel.org, Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Necip Fazil Yildiran <necip@google.com>,
        netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 2, 2021 at 1:19 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> #syz fixed qrtr: Convert qrtr_ports from IDR to XArray

This would be:

#syz fix: qrtr: Convert qrtr_ports from IDR to XArray

Thanks for looking up the proper fix.


> On Wed, Jun 02, 2021 at 03:30:06AM -0700, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 43016d02cf6e46edfc4696452251d34bba0c0435
> > Author: Florian Westphal <fw@strlen.de>
> > Date:   Mon May 3 11:51:15 2021 +0000
>
> Your bisect went astray.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/YLdo77SkmGLgPUBi%40casper.infradead.org.
