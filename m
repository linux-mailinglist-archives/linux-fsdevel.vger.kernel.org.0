Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4A544254
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 06:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiFIEHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 00:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFIEHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 539D93A4
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654747625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfsgIEBSD3MKhVEVos6ZeDV40VyqPqMeZ8H4o3Wfok4=;
        b=WwZaSdNJ7XF7qgCpbELdlMAEidfRy/wQp4y3ECbsnmlQNHLWNYjBl66sxwvWGivNq3YUgq
        EnEBVJsCiyPOgE5TdX+cEbY3o5/9VseuZzGHP+2bwOjVomiTDFLaVw1vTOENlSh5oA3VEI
        VYbpUY8utujyWNlUhTXv9/kAlkvfyUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-g3OkGcopPEOm5tDSln5Oew-1; Thu, 09 Jun 2022 00:07:01 -0400
X-MC-Unique: g3OkGcopPEOm5tDSln5Oew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8977800124;
        Thu,  9 Jun 2022 04:07:00 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B28040EC002;
        Thu,  9 Jun 2022 04:06:54 +0000 (UTC)
Date:   Thu, 9 Jun 2022 12:06:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YqFx2GGACopPmLaM@T590>
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
 <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
 <YhbYOeMUv5+U1XdQ@B-P7TQMD6M-0146.local>
 <YqFUc8jhYp5ijS/C@T590>
 <YqFashbvU+v5lGZy@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqFashbvU+v5lGZy@B-P7TQMD6M-0146.local>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:28:02AM +0800, Gao Xiang wrote:
> On Thu, Jun 09, 2022 at 10:01:23AM +0800, Ming Lei wrote:
> > On Thu, Feb 24, 2022 at 08:58:33AM +0800, Gao Xiang wrote:
> > > On Thu, Feb 24, 2022 at 07:40:47AM +0900, Damien Le Moal wrote:
> > > > On 2/23/22 17:11, Gao Xiang wrote:
> > > > > On Wed, Feb 23, 2022 at 04:46:41PM +0900, Damien Le Moal wrote:
> > > > >> On 2/23/22 14:57, Gao Xiang wrote:
> > > > >>> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
> > > > >>>> I'd like to discuss an interface to implement user space block devices,
> > > > >>>> while avoiding local network NBD solutions.  There has been reiterated
> > > > >>>> interest in the topic, both from researchers [1] and from the community,
> > > > >>>> including a proposed session in LSFMM2018 [2] (though I don't think it
> > > > >>>> happened).
> > > > >>>>
> > > > >>>> I've been working on top of the Google iblock implementation to find
> > > > >>>> something upstreamable and would like to present my design and gather
> > > > >>>> feedback on some points, in particular zero-copy and overall user space
> > > > >>>> interface.
> > > > >>>>
> > > > >>>> The design I'm pending towards uses special fds opened by the driver to
> > > > >>>> transfer data to/from the block driver, preferably through direct
> > > > >>>> splicing as much as possible, to keep data only in kernel space.  This
> > > > >>>> is because, in my use case, the driver usually only manipulates
> > > > >>>> metadata, while data is forwarded directly through the network, or
> > > > >>>> similar. It would be neat if we can leverage the existing
> > > > >>>> splice/copy_file_range syscalls such that we don't ever need to bring
> > > > >>>> disk data to user space, if we can avoid it.  I've also experimented
> > > > >>>> with regular pipes, But I found no way around keeping a lot of pipes
> > > > >>>> opened, one for each possible command 'slot'.
> > > > >>>>
> > > > >>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> > > > >>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> > > > >>>
> > > > >>> I'm interested in this general topic too. One of our use cases is
> > > > >>> that we need to process network data in some degree since many
> > > > >>> protocols are application layer protocols so it seems more reasonable
> > > > >>> to process such protocols in userspace. And another difference is that
> > > > >>> we may have thousands of devices in a machine since we'd better to run
> > > > >>> containers as many as possible so the block device solution seems
> > > > >>> suboptimal to us. Yet I'm still interested in this topic to get more
> > > > >>> ideas.
> > > > >>>
> > > > >>> Btw, As for general userspace block device solutions, IMHO, there could
> > > > >>> be some deadlock issues out of direct reclaim, writeback, and userspace
> > > > >>> implementation due to writeback user requests can be tripped back to
> > > > >>> the kernel side (even the dependency crosses threads). I think they are
> > > > >>> somewhat hard to fix with user block device solutions. For example,
> > > > >>> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com
> > > > >>
> > > > >> This is already fixed with prctl() support. See:
> > > > >>
> > > > >> https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/
> > > > > 
> > > > > As I mentioned above, IMHO, we could add some per-task state to avoid
> > > > > the majority of such deadlock cases (also what I mentioned above), but
> > > > > there may still some potential dependency could happen between threads,
> > > > > such as using another kernel workqueue and waiting on it (in principle
> > > > > at least) since userspace program can call any syscall in principle (
> > > > > which doesn't like in-kernel drivers). So I think it can cause some
> > > > > risk due to generic userspace block device restriction, please kindly
> > > > > correct me if I'm wrong.
> > > > 
> > > > Not sure what you mean with all this. prctl() works per process/thread
> > > > and a context that has PR_SET_IO_FLUSHER set will have PF_MEMALLOC_NOIO
> > > > set. So for the case of a user block device driver, setting this means
> > > > that it cannot reenter itself during a memory allocation, regardless of
> > > > the system call it executes (FS etc): all memory allocations in any
> > > > syscall executed by the context will have GFP_NOIO.
> > > 
> > > I mean,
> > > 
> > > assuming PR_SET_IO_FLUSHER is already set on Thread A by using prctl,
> > > but since it can call any valid system call, therefore, after it
> > > received data due to direct reclaim and writeback, it is still
> > > allowed to call some system call which may do something as follows:
> > > 
> > >    Thread A (PR_SET_IO_FLUSHER)   Kernel thread B (another context)
> > > 
> > >    (call some syscall which)
> > > 
> > >    submit something to Thread B
> > >                                   
> > >                                   ... (do something)
> > > 
> > >                                   memory allocation with GFP_KERNEL (it
> > >                                   may trigger direct memory reclaim
> > >                                   again and reenter the original fs.)
> > > 
> > >                                   wake up Thread A
> > > 
> > >    wait Thread B to complete
> > > 
> > > Normally such system call won't cause any problem since userspace
> > > programs cannot be in a context out of writeback and direct reclaim.
> > > Yet I'm not sure if it works under userspace block driver
> > > writeback/direct reclaim cases.
> > 
> > Hi Gao Xiang,
> > 
> > I'd rather to reply you in this original thread, and the recent
> > discussion is from the following link:
> > 
> > https://lore.kernel.org/linux-block/Yp1jRw6kiUf5jCrW@B-P7TQMD6M-0146.local/
> > 
> > kernel loop & nbd is really in the same situation.
> > 
> > For example of kernel loop, PF_MEMALLOC_NOIO is added in commit
> > d0a255e795ab ("loop: set PF_MEMALLOC_NOIO for the worker thread"),
> > so loop's worker thread can be thought as the above Thread A, and
> > of course, writeback/swapout IO can reach the loop worker thread(
> > the above Thread A), then loop just calls into FS from the worker
> > thread for handling the loop IO, that is same with user space driver's
> > case, and the kernel 'thread B' should be in FS code.
> > 
> > Your theory might be true, but it does depend on FS's implementation,
> > and we don't see such report in reality.
> > 
> > Also you didn't mentioned that what kernel thread B exactly is? And what
> > the allocation is in kernel thread B.
> > 
> > If you have actual report, I am happy to take account into it, otherwise not
> > sure if it is worth of time/effort in thinking/addressing one pure theoretical
> > concern.
> 
> Hi Ming,
> 
> Thanks for your look & reply.
> 
> That is not a wild guess. That is a basic difference between
> in-kernel native block-based drivers and user-space block drivers.

Please look at my comment, wrt. your pure theoretical concern, userspace
block driver is same with kernel loop/nbd.

Did you see such report on loop & nbd? Can you answer my questions wrt.
kernel thread B?

> 
> That is userspace block driver can call _any_ system call if they want.
> Since users can call any system call and any _new_ system call can be
> introduced later, you have to audit all system calls "Which are safe
> and which are _not_ safe" all the time. Otherwise, attacker can make

Isn't nbd server capable of calling any system call? Is there any
security risk for nbd?

> use of it to hung the system if such userspace driver is used widely.

From the beginning, only ADMIN can create ubd, that is same with
nbd/loop, and it gets default permission as disk device.

ubd is really in same situation with nbd wrt. security, the only difference
is just that nbd uses socket for communication, and ubd uses io_uring, that
is all.

Yeah, Stefan Hajnoczi and I discussed to make ubd as one container
block device, so normal user can create & use ubd, but it won't be done
from the beginning, and won't be enabled until the potential security
risks are addressed, and there should be more limits on ubd when normal user
can create & use it, such as:

- not allow unprivileged ubd device to be mounted
- not allow unprivileged ubd device's partition table to be read from
  kernel
- not support buffered io for unprivileged ubd device, and only direct io
  is allowed
- maybe more limit for minimizing security risk.

> 
> IOWs, in my humble opinion, that is quite a fundamental security
> concern of all userspace block drivers.

But nbd is still there and widely used, and there are lots of people who
shows interest in userspace block device. Then think about who is wrong?

As one userspace block driver, it is normal to see some limits there,
but I don't agree that there is fundamental security issue.

> 
> Actually, you cannot ignore block I/O requests if they actually push

Who wants to ignore block I/O? And why ignore it?

> into block layer, since that is too late if I/O actually is submitted
> by some FS. And you don't even know which type of such I/O is.

We do know the I/O type.

> 
> On the other side, user-space FS implementations can avoid this since
> FS can know if under direct reclaim and don't do such I/O requests.

But it is nothing to do with userspace block device.



Thanks,
Ming

