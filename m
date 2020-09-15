Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7125B26A052
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIOH7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 03:59:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgIOH7c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:59:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FFFFAC7D;
        Tue, 15 Sep 2020 07:59:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86CDDDA7C7; Tue, 15 Sep 2020 09:57:54 +0200 (CEST)
Date:   Tue, 15 Sep 2020 09:57:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     syzbot <syzbot+738cca7d7d9754493513@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in vfs_setxattr (3)
Message-ID: <20200915075754.GE1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        syzbot <syzbot+738cca7d7d9754493513@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000008a633505af53038f@google.com>
 <c268d760-2230-ec66-01d4-d3cd725ea522@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c268d760-2230-ec66-01d4-d3cd725ea522@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:26:26AM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.09.20 г. 7:59 ч., syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    7fe10096 Merge branch 'linus' of git://git.kernel.org/pub/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=140b0853900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=738cca7d7d9754493513
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108d45a5900000
> > 
> > The issue was bisected to:
> > 
> > commit 6a3c7f5c87854e948c3c234e5f5e745c7c553722
> > Author: Nikolay Borisov <nborisov@suse.com>
> > Date:   Thu May 28 08:05:13 2020 +0000
> > 
> >     btrfs: don't balance btree inode pages from buffered write path
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14884d21900000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=16884d21900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12884d21900000
> 
> 
> Unlikely, that patch does change the performance characteristics because
> now we don't balance metadata when doing buffered writes but I don't see
> how it can lead to a hang.

Yeah, this patch once got pointed to by syzbot bisection supposedly
causing bug in a completely unrelated subsystem, but it's more likely
that it's making the bisection unreliable.

https://lore.kernel.org/lkml/20200811065013.GI2026@twin.jikos.cz/
