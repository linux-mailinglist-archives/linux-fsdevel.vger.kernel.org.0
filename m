Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC45F8706
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 21:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJHTMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJHTMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:12:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C787B2F64D;
        Sat,  8 Oct 2022 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jltrTTngI5+i4SrxqnMducvxr3z9ztoNRgWqy5Yg5Vc=; b=FRd/EQ0pfESUdqddbaFYYHkSOB
        knXxf8NqJUPmkij9EHZ/XMf1uihqgy6aFxGatF2c2c+MPn2VjCzjrauucZ3vvc4c6CRVWHuLvm2tn
        9TzuHyTdj81e4OhdbxFP66MtBMudFWz6UC0AF1pPvbv1lnSQThfunqLZ7SZXlSxFlwFJSXF+X+Uju
        c4ganqrcx6NWXJMGsCJNKV8yrJT4xNALl0T0kaR3I0xoDUCh2jc6/PMlvcpVoKO5PQi7WhNx88LFe
        dQVbBEhO8W+0GqaA5MZutsAT4xuSEe+M4y0s3/hku4/n6Vr371DyP1UbUuYTIJdaG0RATIcBgwKqb
        W5L2d3/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohFFO-002tNm-Nv; Sat, 08 Oct 2022 19:12:30 +0000
Date:   Sat, 8 Oct 2022 20:12:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in
 truncate_inode_pages_range
Message-ID: <Y0HLnmzlmJRK/tHF@casper.infradead.org>
References: <000000000000117c7505e7927cb4@google.com>
 <20220901162459.431c49b3925e99ddb448e1b3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901162459.431c49b3925e99ddb448e1b3@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:24:59PM -0700, Andrew Morton wrote:
> On Wed, 31 Aug 2022 17:13:36 -0700 syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    89b749d8552d Merge tag 'fbdev-for-6.0-rc3' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14b9661b080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5867885efe39089b339b
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5867885efe39089b339b@syzkaller.appspotmail.com
> > 
> > ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
> > ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
> > ================================================================================
> > UBSAN: array-index-out-of-bounds in mm/truncate.c:366:18
> > index 254 is out of range for type 'long unsigned int [15]'
> 
> That's
> 
> 		index = indices[folio_batch_count(&fbatch) - 1] + 1;
> 
> I looked.  I see no way in which fbatch.nr got a value of 255.

NTFS is involved.  I stopped looking at that point; it seems to be
riddled with buffer overflows.

> I must say, the the code looks rather hacky.  Isn't there a more
> type-friendly way of doing this?

Looking at the three callers, they all want to advance index.  We
should probably pass &index instead of index and have find_lock_entries
advance it for them.

Vishal, want to take this on?
