Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3010218592
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGHLIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGHLIT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:08:19 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8311D20739;
        Wed,  8 Jul 2020 11:08:17 +0000 (UTC)
Date:   Wed, 8 Jul 2020 12:08:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: memory leak in inotify_update_watch
Message-ID: <20200708110814.GA6308@gaia>
References: <000000000000a47ace05a9c7b825@google.com>
 <20200707152411.GD25069@quack2.suse.cz>
 <20200707181710.GD32331@gaia>
 <CACT4Y+ZLx3wT3uvsMr9EOQ35wF+tw3SN_kzgwn2B+K5dTtHrOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZLx3wT3uvsMr9EOQ35wF+tw3SN_kzgwn2B+K5dTtHrOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 09:17:37AM +0200, Dmitry Vyukov wrote:
> On Tue, Jul 7, 2020 at 8:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Kmemleak never performs well under heavy load. Normally you'd need to
> > let the system settle for a bit before checking whether the leaks are
> > still reported. The issue is caused by the memory scanning not stopping
> > the whole machine, so pointers may be hidden in registers on different
> > CPUs (list insertion/deletion for example causes transient kmemleak
> > confusion).
> >
> > I think the syzkaller guys tried a year or so ago to run it in parallel
> > with kmemleak and gave up shortly. The proposal was to add a "stopscan"
> > command to kmemleak which would do this under stop_machine(). However,
> > no-one got to implementing it.
> >
> > So, in this case, does the leak still appear with the reproducer, once
> > the system went idle?
> 
> This report came from syzbot, so obviously we did not give up :)

That's good to know ;).

> We don't run scanning in parallel with fuzzing and do a very intricate
> multi-step dance to overcome false positives:
> https://github.com/google/syzkaller/blob/5962a2dc88f6511b77100acdf687c1088f253f6b/executor/common_linux.h#L3407-L3478
> and only report leaks that are reproducible.
> So far I have not seen any noticable amount of false positives, and
> you can see 70 already fixed leaks here:
> https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-gce-leak
> https://syzkaller.appspot.com/upstream?manager=ci-upstream-gce-leak

Thanks for the information and the good work here. If you have time, you
could implement the stop_machine() kmemleak scan as well ;).

-- 
Catalin
