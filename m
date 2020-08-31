Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5E2576C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 11:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaJp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 05:45:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11829 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726312AbgHaJp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:45:27 -0400
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="98732429"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Aug 2020 17:45:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0D1B148990D9;
        Mon, 31 Aug 2020 17:45:11 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 31 Aug 2020 17:45:15 +0800
Subject: Re: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
To:     Dave Chinner <david@fromorbit.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <y-goto@fujitsu.com>
References: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
 <20200827063748.GA12096@dread.disaster.area>
 <6b3b3439-2199-8f00-ceca-d65769e94fe0@cn.fujitsu.com>
 <20200828003541.GD12096@dread.disaster.area>
 <d7852ad6-d304-895d-424d-3053bf07f0f5@cn.fujitsu.com>
 <20200831003407.GE12096@dread.disaster.area>
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <9bb0144b-dcb7-293c-0b44-a4c2f0fbf05e@cn.fujitsu.com>
Date:   Mon, 31 Aug 2020 17:45:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200831003407.GE12096@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 0D1B148990D9.ADF54
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/8/31 8:34, Dave Chinner wrote:
> On Fri, Aug 28, 2020 at 05:04:14PM +0800, Li, Hao wrote:
> > On 2020/8/28 8:35, Dave Chinner wrote:
> > > On Thu, Aug 27, 2020 at 05:58:07PM +0800, Li, Hao wrote:
> > > > On 2020/8/27 14:37, Dave Chinner wrote:
> > > > > On Fri, Aug 21, 2020 at 09:59:53AM +0800, Hao Li wrote:
> > > > > > Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
> > > > > > set from being killed, so the corresponding inode can't be evicted. If
> > > > > > the DAX policy of an inode is changed, we can't make policy changing
> > > > > > take effects unless dropping caches manually.
> > > > > >
> > > > > > This patch fixes this problem and flushes the inode to disk to prepare
> > > > > > for evicting it.
> > > > > >
> > > > > > Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> > > > > > ---
> > > > > >  fs/dcache.c | 3 ++-
> > > > > >  fs/inode.c  | 2 +-
> > > > > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > > > > index ea0485861d93..486c7409dc82 100644
> > > > > > --- a/fs/dcache.c
> > > > > > +++ b/fs/dcache.c
> > > > > > @@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
> > > > > >       */
> > > > > >      smp_rmb();
> > > > > >      d_flags = READ_ONCE(dentry->d_flags);
> > > > > > -    d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
> > > > > > +    d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
> > > > > > +            | DCACHE_DONTCACHE;
> > > > > Seems reasonable, but you need to update the comment above as to
> > > > > how this flag fits into this code....
> > > > Yes. I will change it. Thanks.
> > > >
> > > > > >      /* Nothing to do? Dropping the reference was all we needed? */
> > > > > >      if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
> > > > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > > > index 72c4c347afb7..5218a8aebd7f 100644
> > > > > > --- a/fs/inode.c
> > > > > > +++ b/fs/inode.c
> > > > > > @@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
> > > > > >      }
> > > > > >  
> > > > > >      state = inode->i_state;
> > > > > > -    if (!drop) {
> > > > > > +    if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
> > > > > >          WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> > > > > >          spin_unlock(&inode->i_lock);
> > > > > What's this supposed to do? We'll only get here with drop set if the
> > > > > filesystem is mounting or unmounting.
> > > > The variable drop will also be set to True if I_DONTCACHE is set on
> > > > inode->i_state.
> > > > Although mounting/unmounting will set the drop variable, it won't set
> > > > I_DONTCACHE if I understand correctly. As a result,
> > > > drop && (inode->i_state & I_DONTCACHE) will filter out mounting/unmounting.
> > > So what does this have to do with changing the way the dcache
> > > treats DCACHE_DONTCACHE?
> > After changing the way the dcache treats DCACHE_DONTCACHE, the dentry with
> > DCACHE_DONTCACHE set will be killed unconditionally even if
> > DCACHE_REFERENCED is set, and its inode will be processed by iput_final().
> > This inode has I_DONTCACHE flag, so op->drop_inode() will return true,
> > and the inode will be evicted _directly_ even though it has dirty pages.
>
> Yes. But this doesn't rely on DCACHE_DONTCACHE behaviour. Inodes
> that are looked up and cached by the filesystem without going
> through dentry cache pathwalks can have I_DONTCACHE set and then get
> evicted...
>
> i.e. we can get I_DONTCACHE set on inodes that do not have dentries
> attached to them. That's the original functionality that got pulled
> up from XFS - internal iteration of inodes, either via quotacheck or
> bulkstat....

Oh, I see!

>
> > I think the kernel will run into error state because it doesn't writeback
> > dirty pages of this inode before evicting. This is why I write back this
> > inode here.
> >
> > According to my test, if I revert the second hunk of this patch, kernel
> > will hang after running the following command:
> > echo 123 > test.txt && xfs_io -c "chattr +x" test.txt
> >
> > The backtrace is:
> >
> > xfs_fs_destroy_inode+0x204/0x24d
> > destroy_inode+0x3b/0x65
> > evict+0x150/0x1aa
> > iput+0x117/0x19a
> > dentry_unlink_inode+0x12b/0x12f
> > __dentry_kill+0xee/0x211
> > dentry_kill+0x112/0x22f
> > dput+0x79/0x86
> > __fput+0x200/0x23f
> > ____fput+0x25/0x28
> > task_work_run+0x144/0x177
> > do_exit+0x4fb/0xb94
> >
> > This backtrace is printed with an ASSERT(0) statement in xfs_fs_destroy_inode().
>
> Sure, that's your messenger. That doesn't mean the bug can't be
> triggered by other means.
>
> > > Also, if I_DONTCACHE is set, but the inode has also been unlinked or
> > > is unhashed, should we be writing it back? i.e. it might have been
> > > dropped for a different reason to I_DONTCACHE....
> > This is a problem I didn't realize. You are right. If the inode has been
> > unlinked/unhashed and the I_DONTCACHE is also set, the appended condition
> > will lead to unnecessary writeback.
> >
> > I think I need to handle the inode writeback more carefully. Maybe I can
> > revert the second hunk and remove I_DONTCACHE from generic_drop_inode()
> > and then change
> >
> > if (!drop && (sb->s_flags & SB_ACTIVE))
> >
> > to
> >
> > if (!drop && !(inode->i_state & I_DONTCACHE) && (sb->s_flags & SB_ACTIVE))
> >
> > This approach would be more suitable.
>
> Yup, that's pretty much what I was thinking, but as a standalone
> patch and preceding the DCACHE_DONTCACHE behaviour change. Thanks! :)

I see. I will send a new patch to fix I_DONTCACHE first.

Thanks,
Hao Li

>
> Cheers,
>
> Dave.



