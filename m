Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3F4164AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbhIWRzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242158AbhIWRzv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E02060FDC;
        Thu, 23 Sep 2021 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632419660;
        bh=Kgu4niKvjFx+GzALLxKmra8ei7WGl2xi2rfOhBjEL0s=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=tAXc45TIR4TL1vim7Ozo5WIbYHZYbZIpKDzr4dIggZid8/AqkZQzeQD21kzDbfGB6
         qWwiQcEzDHOSYyAMoYjTdRlpwXBpfT1mNnc2fRhpdLrFEzfwn02FIHcBkGF51tT4C3
         8lh3nAKIcfW0dVi7vlsjESYkJo6GTG+UaC0fiThoLh866z83BDIPM/Q8P4F2/OFyQ1
         WzMolk7H2mQ5IphjsWf6ry0mqYnkldyW04PIryExRcroVWg91Q6izzM3XHto+IQYrU
         HHgMiiMzgNexdDFMi3nulinqjPDvumFdF8kAPo5LIC/6O0AAsU3XHq+SzrpTBhYLE5
         BZFzusdYI0JyQ==
Message-ID: <792f0377a0aa982ebb476be05eef5f21fd45c429.camel@kernel.org>
Subject: Re: [syzbot] possible deadlock in f_getown
From:   Jeff Layton <jlayton@kernel.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        syzbot <syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com>,
        asm@florahospitality.com, bfields@fieldses.org,
        boqun.feng@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Date:   Thu, 23 Sep 2021 13:54:17 -0400
In-Reply-To: <ff026440-590e-6268-6ced-326f4da27be2@gmail.com>
References: <000000000000ed2e6705cca36282@google.com>
         <ff026440-590e-6268-6ced-326f4da27be2@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-09-23 at 13:20 -0400, Desmond Cheong Zhi Xi wrote:
> On 23/9/21 2:03 am, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit f671a691e299f58835d4660d642582bf0e8f6fda
> > Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> > Date:   Fri Jul 2 09:18:30 2021 +0000
> > 
> >      fcntl: fix potential deadlocks for &fown_struct.lock
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fa8017300000
> > start commit:   293837b9ac8d Revert "i915: fix remap_io_sg to verify the p..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8073030e235a5a84dd31
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171390add00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10050553d00000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> > 
> > #syz fix: fcntl: fix potential deadlocks for &fown_struct.lock
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > 
> 
> #syz fix: fcntl: fix potential deadlocks for &fown_struct.lock
> 
> Think I got jumbled a bit when marking the dups. This bug shares the 
> same root cause as [1], and is fixed by the same patch. Nice that Syzbot 
> noticed.
> 
> Link: https://syzkaller.appspot.com/bug?extid=e6d5398a02c516ce5e70 [1]


Yeah, I had forgotten about that syzkaller report entirely.

I'm not sure we can do much about it now that the patch is already
merged though. Is there a process for amending changelogs for patches
already in Linus' tree?

If I had gotten this email while it was still sitting in linux-next, I
would have added that line. The syzkaller folks might want to consider
occasionally doing these sorts of checks vs. linux-next to catch this
sort of thing, if they care about the attribution.
-- 
Jeff Layton <jlayton@kernel.org>

