Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA9202F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgFVFic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 01:38:32 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:43768 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbgFVFic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:38:32 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-01.nifty.com with ESMTP id 05M5YhGn010354
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 14:34:43 +0900
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 05M5YHTq010632;
        Mon, 22 Jun 2020 14:34:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 05M5YHTq010632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592804058;
        bh=l1Wp8QkA57im+NZmeXieOSoL1AHhaVcvQ4yMPx1u/lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zka7rOiFfK4LJYPLBtdXrDwXPFTimfyqIuYntf3jwVO3e07ZfWV6HGUDX2cTVBDSg
         HS9b4J7EJsJBcwSgfbhCmVQFxQHmNHVODfq98QIpUoe2UI7kRregJKUfD6aAObmfTg
         Y3k7cM2+ut1N69s9dHw9A51qgCTCd+HlK0g/RAXLCBG8lBsJ6bYC/5yWj8I31H4EBA
         u5gidbiT0P96mHIZb9EH9HzduDTeY9EZkvY7RZjXPYfxvdRW6un3aA/Ik1YIZnPoP4
         tsZP1cvfDjNsUNO0+NxXssOhHD4GPBes/FE9Dx0nrOztTHByzfCfMCDWvQc2UrTrc2
         xspEZ8Zs8mH3A==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id s6so3661635vkb.9;
        Sun, 21 Jun 2020 22:34:17 -0700 (PDT)
X-Gm-Message-State: AOAM530mnAtZ/G1XVqkaU+olnDoj1x7Ey52CE2q0c5m/QXi0l/kZ/KtL
        yOHmwd97ulkJOhCjShGrhrFzLEIVenlIDMMg9EM=
X-Google-Smtp-Source: ABdhPJwh6BZWfd4rlU2RWuyudUqoKaTL84W4xch0jXewj8b3Y2FY7i6N6lJ2HXvrwYHzcQc/HZddEaokfWVLepAfzoU=
X-Received: by 2002:a1f:1f04:: with SMTP id f4mr14462230vkf.73.1592804056188;
 Sun, 21 Jun 2020 22:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
 <20200618233958.GV8681@bombadil.infradead.org> <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com> <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 22 Jun 2020 14:33:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARr4aWTUqcS5TGdQ-7C_u=PFQVMMuakQ2Oro3-43fYu9w@mail.gmail.com>
Message-ID: <CAK7LNARr4aWTUqcS5TGdQ-7C_u=PFQVMMuakQ2Oro3-43fYu9w@mail.gmail.com>
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:14 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> Junxiao Bi <junxiao.bi@oracle.com> reported:
> > When debugging some performance issue, i found that thousands of threads exit
> > around same time could cause a severe spin lock contention on proc dentry
> > "/proc/$parent_process_pid/task/", that's because threads needs to clean up
> > their pid file from that dir when exit.
>
> Matthew Wilcox <willy@infradead.org> reported:
> > We've looked at a few different ways of fixing this problem.
>
> The flushing of the proc dentries from the dcache is an optmization,
> and is not necessary for correctness.  Eventually cache pressure will
> cause the dentries to be freed even if no flushing happens.  Some
> light testing when I refactored the proc flushg[1] indicated that at
> least the memory footprint is easily measurable.
>
> An optimization that causes a performance problem due to a thundering
> herd of threads is no real optimization.
>
> Modify the code to only flush the /proc/<tgid>/ directory when all
> threads in a process are killed at once.  This continues to flush
> practically everything when the process is reaped as the threads live
> under /proc/<tgid>/task/<tid>.
>
> There is a rare possibility that a debugger will access /proc/<tid>/,
> which this change will no longer flush, but I believe such accesses
> are sufficiently rare to not be observed in practice.
>
> [1] 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
> Link: https://lkml.kernel.org/r/54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com


> Reported-by: Masahiro Yamada <masahiroy@kernel.org>

I did not report this.





> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---


-- 
Best Regards
Masahiro Yamada
