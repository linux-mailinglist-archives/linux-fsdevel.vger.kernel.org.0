Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418654417D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiFIC2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFIC2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:28:11 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C3132748;
        Wed,  8 Jun 2022 19:28:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFpSfjg_1654741682;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VFpSfjg_1654741682)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 10:28:04 +0800
Date:   Thu, 9 Jun 2022 10:28:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YqFashbvU+v5lGZy@B-P7TQMD6M-0146.local>
Mail-Followup-To: Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
 <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
 <YhbYOeMUv5+U1XdQ@B-P7TQMD6M-0146.local>
 <YqFUc8jhYp5ijS/C@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqFUc8jhYp5ijS/C@T590>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:01:23AM +0800, Ming Lei wrote:
> On Thu, Feb 24, 2022 at 08:58:33AM +0800, Gao Xiang wrote:
> > On Thu, Feb 24, 2022 at 07:40:47AM +0900, Damien Le Moal wrote:
> > > On 2/23/22 17:11, Gao Xiang wrote:
> > > > On Wed, Feb 23, 2022 at 04:46:41PM +0900, Damien Le Moal wrote:
> > > >> On 2/23/22 14:57, Gao Xiang wrote:
> > > >>> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
> > > >>>> I'd like to discuss an interface to implement user space block devices,
> > > >>>> while avoiding local network NBD solutions.  There has been reiterated
> > > >>>> interest in the topic, both from researchers [1] and from the community,
> > > >>>> including a proposed session in LSFMM2018 [2] (though I don't think it
> > > >>>> happened).
> > > >>>>
> > > >>>> I've been working on top of the Google iblock implementation to find
> > > >>>> something upstreamable and would like to present my design and gather
> > > >>>> feedback on some points, in particular zero-copy and overall user space
> > > >>>> interface.
> > > >>>>
> > > >>>> The design I'm pending towards uses special fds opened by the driver to
> > > >>>> transfer data to/from the block driver, preferably through direct
> > > >>>> splicing as much as possible, to keep data only in kernel space.  This
> > > >>>> is because, in my use case, the driver usually only manipulates
> > > >>>> metadata, while data is forwarded directly through the network, or
> > > >>>> similar. It would be neat if we can leverage the existing
> > > >>>> splice/copy_file_range syscalls such that we don't ever need to bring
> > > >>>> disk data to user space, if we can avoid it.  I've also experimented
> > > >>>> with regular pipes, But I found no way around keeping a lot of pipes
> > > >>>> opened, one for each possible command 'slot'.
> > > >>>>
> > > >>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> > > >>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> > > >>>
> > > >>> I'm interested in this general topic too. One of our use cases is
> > > >>> that we need to process network data in some degree since many
> > > >>> protocols are application layer protocols so it seems more reasonable
> > > >>> to process such protocols in userspace. And another difference is that
> > > >>> we may have thousands of devices in a machine since we'd better to run
> > > >>> containers as many as possible so the block device solution seems
> > > >>> suboptimal to us. Yet I'm still interested in this topic to get more
> > > >>> ideas.
> > > >>>
> > > >>> Btw, As for general userspace block device solutions, IMHO, there could
> > > >>> be some deadlock issues out of direct reclaim, writeback, and userspace
> > > >>> implementation due to writeback user requests can be tripped back to
> > > >>> the kernel side (even the dependency crosses threads). I think they are
> > > >>> somewhat hard to fix with user block device solutions. For example,
> > > >>> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com
> > > >>
> > > >> This is already fixed with prctl() support. See:
> > > >>
> > > >> https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/
> > > > 
> > > > As I mentioned above, IMHO, we could add some per-task state to avoid
> > > > the majority of such deadlock cases (also what I mentioned above), but
> > > > there may still some potential dependency could happen between threads,
> > > > such as using another kernel workqueue and waiting on it (in principle
> > > > at least) since userspace program can call any syscall in principle (
> > > > which doesn't like in-kernel drivers). So I think it can cause some
> > > > risk due to generic userspace block device restriction, please kindly
> > > > correct me if I'm wrong.
> > > 
> > > Not sure what you mean with all this. prctl() works per process/thread
> > > and a context that has PR_SET_IO_FLUSHER set will have PF_MEMALLOC_NOIO
> > > set. So for the case of a user block device driver, setting this means
> > > that it cannot reenter itself during a memory allocation, regardless of
> > > the system call it executes (FS etc): all memory allocations in any
> > > syscall executed by the context will have GFP_NOIO.
> > 
> > I mean,
> > 
> > assuming PR_SET_IO_FLUSHER is already set on Thread A by using prctl,
> > but since it can call any valid system call, therefore, after it
> > received data due to direct reclaim and writeback, it is still
> > allowed to call some system call which may do something as follows:
> > 
> >    Thread A (PR_SET_IO_FLUSHER)   Kernel thread B (another context)
> > 
> >    (call some syscall which)
> > 
> >    submit something to Thread B
> >                                   
> >                                   ... (do something)
> > 
> >                                   memory allocation with GFP_KERNEL (it
> >                                   may trigger direct memory reclaim
> >                                   again and reenter the original fs.)
> > 
> >                                   wake up Thread A
> > 
> >    wait Thread B to complete
> > 
> > Normally such system call won't cause any problem since userspace
> > programs cannot be in a context out of writeback and direct reclaim.
> > Yet I'm not sure if it works under userspace block driver
> > writeback/direct reclaim cases.
> 
> Hi Gao Xiang,
> 
> I'd rather to reply you in this original thread, and the recent
> discussion is from the following link:
> 
> https://lore.kernel.org/linux-block/Yp1jRw6kiUf5jCrW@B-P7TQMD6M-0146.local/
> 
> kernel loop & nbd is really in the same situation.
> 
> For example of kernel loop, PF_MEMALLOC_NOIO is added in commit
> d0a255e795ab ("loop: set PF_MEMALLOC_NOIO for the worker thread"),
> so loop's worker thread can be thought as the above Thread A, and
> of course, writeback/swapout IO can reach the loop worker thread(
> the above Thread A), then loop just calls into FS from the worker
> thread for handling the loop IO, that is same with user space driver's
> case, and the kernel 'thread B' should be in FS code.
> 
> Your theory might be true, but it does depend on FS's implementation,
> and we don't see such report in reality.
> 
> Also you didn't mentioned that what kernel thread B exactly is? And what
> the allocation is in kernel thread B.
> 
> If you have actual report, I am happy to take account into it, otherwise not
> sure if it is worth of time/effort in thinking/addressing one pure theoretical
> concern.

Hi Ming,

Thanks for your look & reply.

That is not a wild guess. That is a basic difference between
in-kernel native block-based drivers and user-space block drivers.

That is userspace block driver can call _any_ system call if they want.
Since users can call any system call and any _new_ system call can be
introduced later, you have to audit all system calls "Which are safe
and which are _not_ safe" all the time. Otherwise, attacker can make
use of it to hung the system if such userspace driver is used widely.

IOWs, in my humble opinion, that is quite a fundamental security
concern of all userspace block drivers.

Actually, you cannot ignore block I/O requests if they actually push
into block layer, since that is too late if I/O actually is submitted
by some FS. And you don't even know which type of such I/O is.

On the other side, user-space FS implementations can avoid this since
FS can know if under direct reclaim and don't do such I/O requests.

Thanks,
Gao Xiangn

> 
> 
> Thanks,
> Ming
