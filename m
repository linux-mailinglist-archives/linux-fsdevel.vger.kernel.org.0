Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E642185CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgGHLPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHLPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:15:13 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7AC08E6DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:15:13 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so34085781qtq.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mi6TL9T9iKfT5X0caZoWFf4L6ARlFDMGl6M6HUbAyGQ=;
        b=oR6mc7oXySioKIzpAZZS+JHd5d+4ZTUEYZi/yss9U0fkOuZo40/tparovX9Ueoos6v
         kOL2BlB3OVJnT9TYSGkFIkw1wRcR2b4G+Qs/l/o/QjiKD37PwGsiOQFBO6ee0cMMX6EN
         e0/BF/D9gdAKMXV08vSlx6b01PpCxrKoANdz6XjdNITkozPTjWilO8xoDBxeFiwyOzZS
         ioVwvbF16lpoIb4GVmeBEcB6B9q+SZRM9XUq1+Rgf5dvl7XdRD9RYz2eHw0wu/O9/zsB
         OtmSn++vBAbqSlmhKfRp1UGX5z9i3HU0Q2ac/5TVOq0bYpiQs8RUhhyLdlTY9mZNMJtC
         /dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi6TL9T9iKfT5X0caZoWFf4L6ARlFDMGl6M6HUbAyGQ=;
        b=G0tz5Ctkje7B0kQtJBqWvyg2Q9o+M5gi/ZUeQK5L1ov2oK40YEe4qeE+4795HLjSmB
         IiGNP3Bpi5TrL9PyVpNrAnZQaXjqZfLC0xlElqbHUaQF/xEq/qom0QZYw8e3tHqA97e8
         IsefKPDl2ZXU15AP9ST7Nqu9OBNpDPxGagtcN9mtZdsR4/Y4dUtgoOT99/aXnLZ4T7bX
         CrmdxawDoDth2cI4v7WgRePEhD+W9gbFe8RNPRvM8hydrvC21ktCj1ihBHXhW35AXzCI
         zMtdppoPEqxrwEfdssfd6PaVSs7sjYQgQfUNfMxLjK5DqxQy2YH+WAm9G+uDqUQQ54oU
         gjUw==
X-Gm-Message-State: AOAM530v+fYSM/LopltdFNSOP1ao0iM/cyVuh8GfHHBReHFmnfXbl+AI
        W9V2mj0pLdkiYXlFN07TmHkQFYSG/qYOSR4xYQBPz88borupVQ==
X-Google-Smtp-Source: ABdhPJz0cuf2U1RcCfJfUPmZLeauOtF48OOTeofNCW7eLZV45C29Pz+WifPZjuIr9BN+3xKxRdS7nyJmcjvANfOCiIA=
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr57010251qtv.57.1594206912372;
 Wed, 08 Jul 2020 04:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a47ace05a9c7b825@google.com> <20200707152411.GD25069@quack2.suse.cz>
 <20200707181710.GD32331@gaia> <CACT4Y+ZLx3wT3uvsMr9EOQ35wF+tw3SN_kzgwn2B+K5dTtHrOg@mail.gmail.com>
 <20200708110814.GA6308@gaia>
In-Reply-To: <20200708110814.GA6308@gaia>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Jul 2020 13:15:00 +0200
Message-ID: <CACT4Y+YSP8+Oy0Hm4ss8sH-eoas3ZHgUe18rVwDif8uba+qTxA@mail.gmail.com>
Subject: Re: memory leak in inotify_update_watch
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 8, 2020 at 1:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jul 08, 2020 at 09:17:37AM +0200, Dmitry Vyukov wrote:
> > On Tue, Jul 7, 2020 at 8:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Kmemleak never performs well under heavy load. Normally you'd need to
> > > let the system settle for a bit before checking whether the leaks are
> > > still reported. The issue is caused by the memory scanning not stopping
> > > the whole machine, so pointers may be hidden in registers on different
> > > CPUs (list insertion/deletion for example causes transient kmemleak
> > > confusion).
> > >
> > > I think the syzkaller guys tried a year or so ago to run it in parallel
> > > with kmemleak and gave up shortly. The proposal was to add a "stopscan"
> > > command to kmemleak which would do this under stop_machine(). However,
> > > no-one got to implementing it.
> > >
> > > So, in this case, does the leak still appear with the reproducer, once
> > > the system went idle?
> >
> > This report came from syzbot, so obviously we did not give up :)
>
> That's good to know ;).
>
> > We don't run scanning in parallel with fuzzing and do a very intricate
> > multi-step dance to overcome false positives:
> > https://github.com/google/syzkaller/blob/5962a2dc88f6511b77100acdf687c1088f253f6b/executor/common_linux.h#L3407-L3478
> > and only report leaks that are reproducible.
> > So far I have not seen any noticable amount of false positives, and
> > you can see 70 already fixed leaks here:
> > https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-gce-leak
> > https://syzkaller.appspot.com/upstream?manager=ci-upstream-gce-leak
>
> Thanks for the information and the good work here. If you have time, you
> could implement the stop_machine() kmemleak scan as well ;).

stop_machine will only help with pointers stored in registers/jumping
in memory. But there may be other sources of false positives like
hidden pointers via some hashing, offsets, reused low/high bits. Doing
several scans and crc checksum of object contents helps with these as
well and is orthogonal to stop_machine.
So now I wonder if using stop_machine will actually solve all
problems... because if not, then doing this work but then having to do
several scans and checksums anyway is kinda pointless...
