Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41672258505
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 03:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgIABJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 21:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgIABJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:09:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72BBC061757;
        Mon, 31 Aug 2020 18:09:37 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCung-008P0Q-CX; Tue, 01 Sep 2020 01:09:28 +0000
Date:   Tue, 1 Sep 2020 02:09:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@canonical.com>, paulmck@kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200901010928.GC1236603@ZenIV.linux.org.uk>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
 <20200901005131.GA3300@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901005131.GA3300@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 08:51:32PM -0400, Qian Cai wrote:
> On Fri, Aug 07, 2020 at 09:34:08PM +0900, Tetsuo Handa wrote:
> > On 2020/08/07 21:27, Al Viro wrote:
> > > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> > >> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> > >> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> > >> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> > >> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> > >> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> > >> with pipe->mutex held.
> > >>
> > >> The reason of falling into infinite busy loop is that iter_file_splice_write()
> > >> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> > >> while for_each_bvec() cannot handle .bv_len == 0.
> > > 
> > > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > > unless I'm misreading it...
> 
> I have been chasing something similar for a while as in,
> 
> https://lore.kernel.org/linux-fsdevel/89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw/
> 
> In my case, it seems the endless loop happens in iterate_iovec() instead where
> I put a debug patch here,
> 
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -33,6 +33,7 @@
>                 if (unlikely(!__v.iov_len))             \
>                         continue;                       \
>                 __v.iov_base = __p->iov_base;           \
> +               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu\n", left, n); \
>                 left = (STEP);                          \
>                 __v.iov_len -= left;                    \
>                 skip = __v.iov_len;                     \
> 
> and end up seeing overflows ("n" supposes to be less than PAGE_SIZE) before the
> soft-lockups and a dead system,
> 
> [ 4300.249180][T470195] ITER_IOVEC left = 0, n = 48566423
> 
> Thoughts?

Er...  Where does that size come from?  If that's generic_perform_write(),
I'd like to see pos, offset and bytes at the time of call...  ->iov_offset would
also be interesting to see (along with the entire iovec array, really).
