Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15A84B3FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiBNC7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Feb 2022 21:59:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiBNC7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:59:03 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22AA154FBF;
        Sun, 13 Feb 2022 18:58:53 -0800 (PST)
Received: from dread.disaster.area (pa49-186-85-251.pa.vic.optusnet.com.au [49.186.85.251])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EFDDD10C71FF;
        Mon, 14 Feb 2022 13:58:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nJRZh-00BlIw-Ju; Mon, 14 Feb 2022 13:58:49 +1100
Date:   Mon, 14 Feb 2022 13:58:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>,
        djwong@kernel.org, fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <20220214025849.GP59729@dread.disaster.area>
References: <000000000000f2075605d04f9964@google.com>
 <00000000000011f55805d7d8352c@google.com>
 <20220213143410.qdqxlixuzgtq56yl@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213143410.qdqxlixuzgtq56yl@riteshh-domain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6209c56b
        a=2CV4XU02g+4RbH+qqUnf+g==:117 a=2CV4XU02g+4RbH+qqUnf+g==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=edf1wS77AAAA:8 a=7-415B0cAAAA:8
        a=9nmZ6OI4_2a5T7hfYiMA:9 a=CjuIK1q_8ugA:10 a=DcSpbTIhAlouE1Uv7lRv:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 13, 2022 at 08:04:10PM +0530, Ritesh Harjani wrote:
> On 22/02/12 12:41PM, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    83e396641110 Merge tag 'soc-fixes-5.17-1' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11fe01a4700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f8cad2700000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132c16ba700000
> 
> FYI - I could reproduce with above C reproduer on my setup 5.17-rc3.
> I was also able to hit it with XFS <below stack shows that>
> 
> So here is some initial analysis on this one. I haven't completely debugged it
> though. I am just putting my observations here for others too.
> 
> It seems iomap_dio_rw is getting called with a negative iocb->ki_pos value.
> (I haven't yet looked into when can this happen. Is it due to negative loop
> device mapping range offset or something?)
> 
> i.e.
> (gdb) p iocb->ki_pos
> $101 = -2147483648
> (gdb) p /x iocb->ki_pos
> $102 = 0xffffffff80000000
> (gdb)
> 
> This when passed to ->iomap_begin() sometimes is resulting into iomap->offset
> which is a positive value and hence hitting below warn_on_once in
> iomap_iter_done().
> 
> 		WARN_ON_ONCE(iter->iomap.offset > iter->pos)
> 
> 1. So I think the question here is what does it mean when xfs/ext4_file_read_iter()
>    is called with negative iocb->ki_pos value?
> 2. Also when can iocb->ki_pos be negative?

Sounds like a bug in the loop driver, not a problem with the iomap
DIO code. The IO path normally checks the position via
rw_verify_area() high up in the IO path, so by the time iocb->ki_pos
gets to filesystems and low level IO routines it's supposed to have
already been checked against overflows. Looks to me like the loop
driver is not checking the back end file position it calculates for
overflows...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
