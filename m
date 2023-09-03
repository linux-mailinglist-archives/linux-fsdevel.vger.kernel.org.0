Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76624790D99
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbjICS5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjICS53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:57:29 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A1C6;
        Sun,  3 Sep 2023 11:57:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1cc61f514baso234499fac.1;
        Sun, 03 Sep 2023 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693767444; x=1694372244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMMrVY62BX52PnYnRhXHZEwws09HRCPJ2xE2obQ/f5E=;
        b=UU95mS1XAyDKuXtEsVvrbYwHtSZD1EJF24BLY0RcYJsjL1uGNN2WW3LHqPOZhP5s54
         YXDw5IWtpSQfcwrLUd3zgjru1DbtG1OZZ0A3tJKii5c8F/SypCTzFR+i9X3HBuBszl68
         xu7gIbInOEK6zdJc77G3Kb+drXDtIdUC1IIM4jhSaRmjWerHEMD1SN7S7uXx17HvGpLh
         S7jqL+Wr51kByf4LlG8WlZaYPWwr0/KgggF+YYmYfjLmn4jNdg1q3sRh48JWu2L/H+KJ
         VVv+HRLM8tqCLsGdBDZqrYZ/mzJqQ6FuMXxbZ31iZ9hyHo5DPueLP0dgihe+4C1kLLZO
         5skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693767444; x=1694372244;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMMrVY62BX52PnYnRhXHZEwws09HRCPJ2xE2obQ/f5E=;
        b=F6T0TJo6Kemj+VlEdJB/ix7JYKjIvtLNrh3jwW3YfW6FMdQLmMTiRvTPmgYIYWhjwV
         BEGcCBSuEWFXpPs3L6Yb1UnpN7zdsUewlRLyvd7CJO/9eitKzI2NpvYZez6L2UwAQ3L+
         lcQJ3+AucUFPSW6IKKG8XNXTx/sa45iSaIGREnBk4d3x1EwRirzXjH4U8n11VcrCrecF
         T8qz0VMrnqLUl5vfKsV/w/qgQqJtiZi22Em7uhTwcLldA8VEYuSvPdzTAg1xpZ0n2mN6
         YHDawuBJ8cSfU+F1YhDUT+IfsPyTHf+rESAaFiYnDzRPlCr+2GmDH35p5KqbJ1te84uv
         RuMA==
X-Gm-Message-State: AOJu0YwMb99AJcPC9OjhnGlc85RcoV9Skhcgu1JwGQqnWFx8d60YVLog
        1gK+oZjRiFcjou5q7IZ4OWiYyUSZktqF3RBU0LRIzl5KoVE=
X-Google-Smtp-Source: AGHT+IG8+sFlKjEGDDMkjOW83R6jcwQ6CXuYvApexjZvBi7QvlhzGAt9kBlWzH1W6j8KZbe2DiWrwtBvanLpNZ3KzuI=
X-Received: by 2002:a05:6870:b687:b0:1bb:a992:223d with SMTP id
 cy7-20020a056870b68700b001bba992223dmr7997718oab.44.1693767443793; Sun, 03
 Sep 2023 11:57:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 11:57:23 -0700 (PDT)
In-Reply-To: <20230903180126.GL3390869@ZenIV>
References: <000000000000e6432a06046c96a5@google.com> <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f> <20230903180126.GL3390869@ZenIV>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 3 Sep 2023 20:57:23 +0200
Message-ID: <CAGudoHHjnRct1jEAjNSHmmPt9u_y+tYhrb56uRKXez8DKydNaQ@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksandr Nogikh <nogikh@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Sep 03, 2023 at 10:33:57AM +0200, Mateusz Guzik wrote:
>> On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
>> > On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
>> > > Hello,
>> > >
>> > > syzbot found the following issue on:
>> > >
>> > > HEAD commit:    b97d64c72259 Merge tag
>> > > '6.6-rc-smb3-client-fixes-part1' of..
>> > > git tree:       upstream
>> > > console output:
>> > > https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
>> > > kernel config:
>> > > https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
>> > > dashboard link:
>> > > https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
>> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
>> > > Debian) 2.40
>> > >
>> > > Unfortunately, I don't have any reproducer for this issue yet.
>> >
>> > Been happening for months, apparently, yet for some reason it now
>> > thinks a locking hang in __fdget_pos() is an XFS issue?
>> >
>> > #syz set subsystems: fs
>> >
>>
>> The report does not have info necessary to figure this out -- no
>> backtrace for whichever thread which holds f_pos_lock. I clicked on a
>> bunch of other reports and it is the same story.
>>
>> Can the kernel be configured to dump backtraces from *all* threads?
>>
>> If there is no feature like that I can hack it up.
>
> <break>t
>
> over serial console, or echo t >/proc/sysrq-trigger would do it...
>

This does not dump backtraces, just a list of tasks + some stats.

The closest to useful here I found are 'w' ("Dumps tasks that are in
uninterruptable (blocked) state.") and 'l' ("Shows a stack backtrace
for all active CPUs."), both of which can miss the task which matters
(e.g., stuck in a very much *interruptible* state with f_pos_lock
held).

Unless someone can point at a way to get all these stacks, I'm going
to hack something up in the upcoming week, if only for immediate
syzbot usage.

-- 
Mateusz Guzik <mjguzik gmail.com>
