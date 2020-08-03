Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD82123AA43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHCQMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:12:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB5EC06174A;
        Mon,  3 Aug 2020 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jjt0E9vK/ahlYCJCf6JgaQ1Z9HcAiypA/MZQmN7aHDI=; b=v9sEOjX05M53TG5F7vsJHkJRxP
        SUTLinHGW8UeImHcg5h5r26zVeM83lGqIf30Yy9SeON0G5OGgCTBOdtMQx8O0FmjKiLsgtkb6e4TW
        P/wXIMlPMyR86sWjfVd6waN4/ik7a+SFeewP54KG25p1OgId9RVIQG3PcPP9KxdOI5qLXOUworZDQ
        3L/fKCnhvTCxtAfV0Ya2HVHZuvGzke8HG/pf3tvNI0t944RaJoAjFGoyZd87WT7Ls8WC6RzSi59po
        Yk7XpxFG9iqhxpw3XSW9HuLbSoxqgTlM3u0WQAZYbLjSO6N6GM/jOYdW7lDMAGNZd/RXMic9r8m8s
        EP0V+iyw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2d4g-0002EU-MF; Mon, 03 Aug 2020 16:12:30 +0000
Date:   Mon, 3 Aug 2020 17:12:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 2/2] dmabuf/tracing: Add dma-buf trace events
Message-ID: <20200803161230.GB23808@casper.infradead.org>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com>
 <20200803154125.GA23808@casper.infradead.org>
 <CAJuCfpFLikjaoopvt+vGN3W=m9auoK+DLQNgUf-xUbYfC=83Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFLikjaoopvt+vGN3W=m9auoK+DLQNgUf-xUbYfC=83Mw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 09:00:00AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 3, 2020 at 8:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Aug 03, 2020 at 02:47:19PM +0000, Kalesh Singh wrote:
> > > +static void dma_buf_fd_install(int fd, struct file *filp)
> > > +{
> > > +     trace_dma_buf_fd_ref_inc(current, filp);
> > > +}
> >
> > You're adding a new file_operation in order to just add a new tracepoint?
> > NACK.
> 
> Hi Matthew,
> The plan is to attach a BPF to this tracepoint in order to track
> dma-buf users. If you feel this is an overkill, what would you suggest
> as an alternative?

I'm sure BPF can attach to fd_install and filter on file->f_ops belonging
to dma_buf, for example.
