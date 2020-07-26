Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706D622DB87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 05:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGZDVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 23:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgGZDVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:21:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8B5C0619D2;
        Sat, 25 Jul 2020 20:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oD4RRVTwdwm6r9ZTVdQiSLX7wGVogU7fmP+ZEhZCGfk=; b=bmBgUKrL49yzcCpiSOC6OXsbru
        0P3wi+tM/Bs2kyqiLW5zvezBytWqTYnuFZHSS4hRVaQ3Zm2M6FxUvf4IT8d4CDICaXy7XNi0NFEX0
        iNVa1Z60RCJ7kEbqxUEoSnwvq09zFP9RMiqjzbYPOjpOjLW9CL36jsKbVlBxVbrSwhw/wa41bfCKw
        g/KSyzgwplQtHBA6TSqeltTctEuTgmG/ztAGsq4ddrmpV+ERy+4RQaGyKd5HQvMXnv6BR5f571nZp
        mm4AHDECHtVw156/cE1N2SvNStqVhsHrAxQha+34uWpQUR+UCEj0kWP8veXiy8UMe9u38hFDnZ5Mb
        qBhZf4+w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzXDv-0001Tx-Hw; Sun, 26 Jul 2020 03:21:16 +0000
Date:   Sun, 26 Jul 2020 04:21:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+6324a37c93030377021f@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in delete_node (2)
Message-ID: <20200726032115.GE23808@casper.infradead.org>
References: <00000000000051a79d05ab471440@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000051a79d05ab471440@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:04:15AM -0700, syzbot wrote:
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 17410 at lib/radix-tree.c:571 delete_node+0x1e7/0x8a0 lib/radix-tree.c:571

Umm.  Interesting.  That's
                WARN_ON_ONCE(!list_empty(&node->private_list));
That list_head is only used by the page cache, and this node is part of
the radix tree of mounts.  So it should have been initialised to empty
and remained empty the entire time it was in use.  It'd be interesting
to get the object file that syzbot ran (at least lib/radix-tree.o) so I
could see from the register dump below what was in node->private_list.
The 'Code' snippet below is, alas, not very interesting because it's
the ud2 instruction, which gcc has correctly shuffled off to the end of
the function.

Or it's a random scribble, or it's bad ram.

> RIP: 0010:delete_node+0x1e7/0x8a0 lib/radix-tree.c:571
> Code: e2 48 c7 43 48 00 00 00 00 48 c1 ea 03 42 80 3c 2a 00 0f 85 bb 05 00 00 48 8b 55 18 49 39 d4 0f 84 8b 03 00 00 e8 e9 6c c3 fd <0f> 0b 48 c7 c6 d0 a6 b0 83 4c 89 e7 e8 b8 d7 b0 fd 4d 85 f6 0f 85
> RSP: 0018:ffffc900078afd08 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffffffff89d2df00 RCX: ffffc90013fcd000
> RDX: 0000000000040000 RSI: ffffffff83b0d377 RDI: ffff8880a9c90842
> RBP: ffff88808a91ab40 R08: 0000000000000000 R09: ffff8880a9c90a6f
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808a91ab58
> R13: dffffc0000000000 R14: ffff8880a9c90840 R15: 000000000000000a
>  __radix_tree_delete+0x190/0x370 lib/radix-tree.c:1378
>  radix_tree_delete_item+0xe7/0x230 lib/radix-tree.c:1429
>  mnt_free_id fs/namespace.c:131 [inline]
