Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597242154DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGFJnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgGFJnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:43:23 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE07C061794;
        Mon,  6 Jul 2020 02:43:23 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a6so15585515ilq.13;
        Mon, 06 Jul 2020 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LNYWgR7Suf7EUjxaqSLpnVGU//+Xb6oQLjw8lAmdkjY=;
        b=g34jrCIyQ/KBb7B0F7MtQiKZS/DMZM5vQ4aDZ7Rbx99uAPPD77YGuf8/pVtZq7xugT
         D5ddwCGsEMQWLwCqmRMyHIVBU5pbIC7CPILael5jhjkc5eLPzTuS/QhIsss7VGnAUKf2
         miudzI208yMtInG6YDRN1LwEaXr3RKS85Db0aTgl0urSoLWuykjgt+wfiYB0+dBdHmDH
         DF20Bo+m8tZCPuBXmwRgHbUAfpoDFuEd9+pW3JQHJWTBgVSVWgEkbDvgMploGeg3Wc0W
         cixDrgZDZnYUYYC/WQi8cYu7uv5SUk309u9RhaQZoyuvcSqgKJzJ5X/kmHoX6wKtKlsv
         TEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LNYWgR7Suf7EUjxaqSLpnVGU//+Xb6oQLjw8lAmdkjY=;
        b=FFWDlkCRJjsnXfeCI+Y1bD/Lk6+ZrV722sYOqVT7+/MmiDCBVNwwXfZv7JMt0IQj51
         jNNkW1dyPwbeNOzb5mvTf2bp29tGwBfCXF8oWKFnktF4zSjqQaNPzzpU1xljEfrYWSKr
         EsV8SWNZ3yTSMNTjDp8rqjxNZKEKKFol5l2ovWPpBOwLAexdYPnO/6x/RHNBTqnLDuoE
         JoNh/o+t0PQDnZpdu3yRv0elGIUHpqviBerCHsBao8lorNDYunOlJtFdCAG/h64WKigy
         cU7XJjhL2eDOAS5BZCxMwEdRpUkHSOSwaB2oqGCAQy0i4bubRIhtUvh6UWD8awgjC73R
         EPng==
X-Gm-Message-State: AOAM530dE929dweTtYT/P0RBu4P1xIUg5ZPpTsFxgUK42ZFh3kcdOYQn
        QoFjLOcGPzH7USYNHgozlsIT3yjTuYA2liHrd4/M68smzELK3g==
X-Google-Smtp-Source: ABdhPJzZyc2+uqg6q27N5tXiIMInGgcDo4bHlnmwYNtD5+OHbSWCErAfMg/ybpZlOZs4zZjYNLEKikjWhFjwBUebFaA=
X-Received: by 2002:a92:bb57:: with SMTP id w84mr29774094ili.104.1594028602542;
 Mon, 06 Jul 2020 02:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <1593698893-6371-1-git-send-email-chey84736@gmail.com>
 <20200702174346.GB25523@casper.infradead.org> <CAN_w4MWMfoDGfpON-bYHrU=KuJG2vpFj01ZbN4r-iwM4AyyuGw@mail.gmail.com>
 <20200705171810.GV25523@casper.infradead.org>
In-Reply-To: <20200705171810.GV25523@casper.infradead.org>
From:   yang che <chey84736@gmail.com>
Date:   Mon, 6 Jul 2020 17:43:06 +0800
Message-ID: <CAN_w4MVzObz8C3cmK_Ckwsdr1z6m5Q=MGnSsj+vqK_jHXCMr7g@mail.gmail.com>
Subject: Re: [RFC] hung_task:add detecting task in D state milliseconds timeout
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I will learn how to use KernelShark. Try to solve my problem,thanks
for your suggestion.
Talk about I solved a problem with  hung task milliseconds=EF=BC=9A
   the process get anon_vma read lock when it directly reclaims
memory, but other process down anon_vma write lock,
long time waiting for write lock up. Since anonymous pages can be
inherited from the parent process,
need to analyze whether the anonymous page inherits the parent
process, find is inherits parent process,
use anon_vma's red black tree and  anon_vma_chain find all child
processes have inherited this anonymous page
of the parent process,and analyze the corresponding mapping file of
the current anonymous page in vma.
find what file caused by this problem.
  I used crash+ramdump to analyze this problem before, I will try to
use KernelShark analyze this problem.

I want to ask whether the hung task can be added to support the
detection of millisecond settings=EF=BC=9F
In theory, there is no harm, and the detection time can be more accurate.

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=881:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jul 03, 2020 at 11:18:28AM +0800, yang che wrote:
> >   my understanding, KernelShark can't trigger panic, hung_task can
> > trigger. According to my use,
> > sometimes need to trigger panic to grab ramdump to analyze lock and
> > memory problems.
>
> You shouldn't need to trigger a panic to analyse locking or memory
> problems.  KernelShark is supposed to be able to help you do that without
> bringing down the system.  Give it a try, and if it doesn't work, Steven
> Rostedt is very interested in making it work for your case.
