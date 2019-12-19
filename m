Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407DE125DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 10:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLSJpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 04:45:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfLSJpp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:45:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 80B2AAE4B;
        Thu, 19 Dec 2019 09:45:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 30E2B1E0B38; Thu, 19 Dec 2019 10:45:42 +0100 (CET)
Date:   Thu, 19 Dec 2019 10:45:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+fe601f9e887449d40112@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: WARNING in unaccount_page_cache_page
Message-ID: <20191219094542.GA24349@quack2.suse.cz>
References: <00000000000046fd2f059877e20e@google.com>
 <edf89577-ff58-4085-ecb4-40e1e4588206@suse.cz>
 <c7861417-c7f1-e4f1-336d-f2990ffd325e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7861417-c7f1-e4f1-336d-f2990ffd325e@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 30-11-19 00:30:03, Tetsuo Handa wrote:
> On 2019/11/29 23:41, Vlastimil Babka wrote:
> > On 11/29/19 9:19 AM, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    089cf7f6 Linux 5.3-rc7
> > 
> > Ugh, why test previous cycle's rc7 now? Typo for 5.4?
> > 
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1210a761600000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=b89bb446a3faaba4
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=fe601f9e887449d40112
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Please open the dashboard link. The first occurrence was 5.3-rc7 and the last
> occurrence was 5.4-rc7+. In other words, this bug is likely not yet fixed.

I've briefly looked at this so I'll dump my memory state here in case
someone wants to have a look (or for me when I get more time to look into
this):

The problem always happens on block device mapping. What I think is
happening is that truncate_inode_pages() races with some filesystem on top
of that block device holding buffer_head reference and calling
mark_buffer_dirty(). The buffer_head reference makes block_invalidatepage()
fail invalidating page buffers (try_to_release_page() respectively) and
following mark_buffer_dirty() call will happily redirty the page in
whatever state it is.

Now I didn't yet made up my mind what would be a proper way to fix this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
