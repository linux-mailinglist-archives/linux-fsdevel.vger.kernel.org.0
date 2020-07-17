Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12046223BB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGQMwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgGQMwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:52:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10FC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNibDQKRTSpHh1kC08skSoMoEf0glZ+BjYqtkUF+Z7M=; b=vVVrTqcZguMdBEhetaQYV3eAp+
        mpD+o7IHjABac70XmmymIApQgcgmoOcZmXM74jY9jsVzZgeOjAI4YW2w2p2rEssq1Tn9/vdPg/+6k
        yd3ucjtRWK3nA0bWZKYeDvD57ey8I7IOuHDEMRRXK4u4I/u73qZv+EoasQxRGIx0tbcgQP0PRyt8Q
        C2xn/eLE8ktf0nCx62MVl+i2oPa0zpL4y4ibhvxu8r6PMERuxWeRqqguiICRlrz2LnbYCbhiVPaEL
        vGMTfJY15xl0KRWlHvmZ4j6P6DdpcDv43HSSJ/vWntJ/f2hdg49SqCV7yYF35+Z3Xn8Df4f8L0oT4
        MZwk0RtA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwPqS-0002b6-Jt; Fri, 17 Jul 2020 12:52:08 +0000
Date:   Fri, 17 Jul 2020 13:52:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-fsdevel@vger.kernel.org,
        it+linux-fsdevel@molgen.mpg.de
Subject: Re: `ls` blocked with SSHFS mount
Message-ID: <20200717125208.GP12769@casper.infradead.org>
References: <874de72a-e196-66a7-39f7-e7fe8aa678ee@molgen.mpg.de>
 <CAJfpegs7qxiA+bKvS3_e_QNJEn+5YQxR=kEQ95W0wRFCeunWKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs7qxiA+bKvS3_e_QNJEn+5YQxR=kEQ95W0wRFCeunWKw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 02:39:03PM +0200, Miklos Szeredi wrote:
> On Fri, Jul 17, 2020 at 10:07 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > [105591.121285] INFO: task ls:21242 blocked for more than 120 seconds.
> > [105591.121293]       Not tainted 5.7.0-1-amd64 #1 Debian 5.7.6-1
> > [105591.121295] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [105591.121298] ls              D    0 21242    778 0x00004004
> > [105591.121304] Call Trace:
> > [105591.121319]  __schedule+0x2da/0x770
> > [105591.121326]  schedule+0x4a/0xb0
> > [105591.121339]  request_wait_answer+0x122/0x210 [fuse]
> > [105591.121349]  ? finish_wait+0x80/0x80
> > [105591.121357]  fuse_simple_request+0x198/0x290 [fuse]
> > [105591.121366]  fuse_do_getattr+0xcf/0x2c0 [fuse]
> > [105591.121376]  vfs_statx+0x96/0xe0
> >
> > The `ls` process cannot be killed. The SSHFS issue *Fuse sshfs blocks
> > standby (Visual Studio Code?)* from 2018 already reported this for Linux
> > 4.17, and the SSHFS developers asked to report this to the Linux kernel.
> 
> This is a very old and fundamental issue.   Theoretical solution for
> killing the stuck process exists, but it's not trivial and since the
> above mentioned workarounds work well in all cases it's not high
> priority right now.

What?  All you need to do is return -EINTR from fuse_do_getattr() if
there's a fatal signal.  What "fundamental issue"?
