Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC34326C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhJRSqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 14:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRSqE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:46:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32EF36103C;
        Mon, 18 Oct 2021 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634582632;
        bh=H3l6oRMr0L9AgsGKguVWXHWB0Kjms53ahKLBQ0RTSWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q/1WxzcG7z261AoQfugx2edEXS+zsK0tf/QatW/mnNvREcNMWDsfaqZkL1JB640lJ
         97DSLSno9TypB5MIqczA3GCTn/OIg9CnKessQzxe8pHKFmdUBFwA/Qa/QEb/rfb6rK
         rVgSevWZbw23i4E0pyO7syOaI4swCRYbn/EYpAU8=
Date:   Mon, 18 Oct 2021 11:43:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhengyuan Liu <liuzhengyuang521@gmail.com>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        mysql@lists.mysql.com, linux-ext4@vger.kernel.org,
        =?UTF-8?Q?=E5=88=98=E4=BA=91?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: Re: Problem with direct IO
Message-Id: <20211018114349.b80a27af9bfa7f16162b0ec4@linux-foundation.org>
In-Reply-To: <CAOOPZo4ZycbV8W2w48oD+bM8a1+WqejSjjYuheZPyxm2uE-=rA@mail.gmail.com>
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
        <CAOOPZo4ZycbV8W2w48oD+bM8a1+WqejSjjYuheZPyxm2uE-=rA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Oct 2021 09:09:06 +0800 Zhengyuan Liu <liuzhengyuang521@gmail.com> wrote:

> Ping.
> 
> I think this problem is serious and someone may  also encounter it in
> the future.
> 
> 
> On Wed, Oct 13, 2021 at 9:46 AM Zhengyuan Liu
> <liuzhengyuang521@gmail.com> wrote:
> >
> > Hi, all
> >
> > we are encounting following Mysql crash problem while importing tables :
> >
> >     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
> >     fsync() returned EIO, aborting.
> >     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
> >     Assertion failure: ut0ut.cc:555 thread 281472996733168
> >
> > At the same time , we found dmesg had following message:
> >
> >     [ 4328.838972] Page cache invalidation failure on direct I/O.
> >     Possible data corruption due to collision with buffered I/O!
> >     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
> >     625 Comm: kworker/42:1
> >
> > Firstly, we doubled Mysql has operating the file with direct IO and
> > buffered IO interlaced, but after some checking we found it did only
> > do direct IO using aio. The problem is exactly from direct-io
> > interface (__generic_file_write_iter) itself.
> >
> > ssize_t __generic_file_write_iter()
> > {
> > ...
> >         if (iocb->ki_flags & IOCB_DIRECT) {
> >                 loff_t pos, endbyte;
> >
> >                 written = generic_file_direct_write(iocb, from);
> >                 /*
> >                  * If the write stopped short of completing, fall back to
> >                  * buffered writes.  Some filesystems do this for writes to
> >                  * holes, for example.  For DAX files, a buffered write will
> >                  * not succeed (even if it did, DAX does not handle dirty
> >                  * page-cache pages correctly).
> >                  */
> >                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
> >                         goto out;
> >
> >                 status = generic_perform_write(file, from, pos = iocb->ki_pos);
> > ...
> > }
> >
> > From above code snippet we can see that direct io could fall back to
> > buffered IO under certain conditions, so even Mysql only did direct IO
> > it could interleave with buffered IO when fall back occurred. I have
> > no idea why FS(ext3) failed the direct IO currently, but it is strange
> > __generic_file_write_iter make direct IO fall back to buffered IO, it
> > seems  breaking the semantics of direct IO.

That makes sense.

> > The reproduced  environment is:
> > Platform:  Kunpeng 920 (arm64)
> > Kernel: V5.15-rc
> > PAGESIZE: 64K
> > Mysql:  V8.0
> > Innodb_page_size: default(16K)

This is all fairly mature code, I think.  Do you know if earlier
kernels were OK, and if so which versions?

Thanks.
