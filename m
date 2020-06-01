Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51D61EA040
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgFAIoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 04:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgFAIo3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:44:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D94206E2;
        Mon,  1 Jun 2020 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591001068;
        bh=++2cB/ePJhne1YRp0fru1zBYoji5d1nprT5N9O4udpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVfow37nJUctQuczEjtuvdKVbO338MPrWmtxn6qzZZHMLNELwOQlIvzJoFUuF/1kq
         q5DWi1Wf0naUXbCdA1uSgSP2CWJRK7dS8k1Y+Djaw8xRkHX+tVonEUHstDVdezlly+
         CKUb/UU3oTLuSzgUFnUcgt1pHUYemwJpSNjNMHJk=
Date:   Mon, 1 Jun 2020 10:44:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tao pilgrim <pilgrimtao@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, sth@linux.ibm.com,
        viro@zeniv.linux.org.uk, clm@fb.com, jaegeuk@kernel.org,
        hch@infradead.org, Mark Fasheh <mark@fasheh.com>,
        dhowells@redhat.com, balbi@kernel.org, damien.lemoal@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>, hoeppner@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-usb@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Message-ID: <20200601084426.GB1667318@kroah.com>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
 <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 01, 2020 at 03:22:01PM +0800, Tao pilgrim wrote:
> On Fri, May 29, 2020 at 10:13 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 5/29/20 8:11 AM, Kaitao Cheng wrote:
> > > There is a function named ilog2() exist which can replace blksize.
> > > The generated code will be shorter and more efficient on some
> > > architecture, such as arm64. And ilog2() can be optimized according
> > > to different architecture.
> >
> > When you posted this last time, I said:
> >
> > "I like the simplification, but do you have any results to back up
> >  that claim? Is the generated code shorter? Runs faster?"
> >
> 
> Hi  Jens Axboe:
> 
> I did a test on ARM64.
> unsigned int ckt_blksize(int size)
> {
>    return blksize_bits(size);
> }
> unsigned int ckt_ilog2(int size)
> {
>     return ilog2(size);
> }
> 
> When I compiled it into assembly code, I got the following result,
> 
> 0000000000000088 <ckt_blksize>:
>       88: 2a0003e8 mov w8, w0
>       8c: 321d03e0 orr w0, wzr, #0x8
>       90: 11000400 add w0, w0, #0x1
>       94: 7108051f cmp w8, #0x201
>       98: 53017d08 lsr w8, w8, #1
>       9c: 54ffffa8 b.hi 90 <ckt_blksize+0x8>
>       a0: d65f03c0 ret
>       a4: d503201f nop
> 
> 00000000000000a8 <ckt_ilog2>:
>       a8: 320013e8 orr w8, wzr, #0x1f
>       ac: 5ac01009 clz w9, w0
>       b0: 4b090108 sub w8, w8, w9
>       b4: 7100001f cmp w0, #0x0
>       b8: 5a9f1100 csinv w0, w8, wzr, ne
>       bc: d65f03c0 ret
> 
> The generated code of ilog2  is shorter , and  runs faster

But does this code path actually show up anywhere that is actually
measurable as mattering?

If so, please show that benchmark results.

thanks,

greg k-h
