Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA16174E9DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGKJHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKJHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493FCE5C;
        Tue, 11 Jul 2023 02:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D186A6136C;
        Tue, 11 Jul 2023 09:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558BEC433C7;
        Tue, 11 Jul 2023 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066461;
        bh=F9j7QSkCdEGLHSTYKupjSgHRjPvmMCsP/Dnn5N7amao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXir5RtXPR1h/1vENjENygKXbfM+5LZPSFNVaUI/IVb252c7CCGzFqcOQGKyfW9nt
         44m/DTsuw2i1oBA26bzQrxtocX/pQBw22Qq7TSagMMmeAHCygFQ/kHYuVtdd1lvMOU
         SWg9HgbsRe0SMd/C3TlI6eAq8VTs2w89oRQByNKBEeY47j2FWraO4gyn7EBqZ3B3j/
         XDdzCejUoJUQ+e9ShQQOd47b8f9Vm1mIbFBcyuXN5NY2hf+Z3kWYh01djIH6QU/v4U
         XCZXGxttGtXNKCgvUUTeT2dH44fQhB+JxIVl9IaZqxeeQrYtu+0/cFtUbGw8juSKL6
         af0PBlU04G20w==
Date:   Tue, 11 Jul 2023 11:07:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Wen Yang <wenyang.linux@foxmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is
 0
Message-ID: <20230711-kroll-wellen-f6a9059e943d@brauner>
References: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
 <20230710-fahrbahn-flocken-03818a6b2e91@brauner>
 <tencent_BCEA8520DBC99F741C6666BF8167B32A2007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_BCEA8520DBC99F741C6666BF8167B32A2007@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:02:33PM +0800, Wen Yang wrote:
> 
> On 2023/7/10 22:12, Christian Brauner wrote:
> > On Sun, Jul 09, 2023 at 02:54:51PM +0800, wenyang.linux@foxmail.com wrote:
> > > From: Wen Yang <wenyang.linux@foxmail.com>
> > > 
> > > For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
> > > eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.
> > > 
> > > Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
> > > Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Dylan Yudaken <dylany@fb.com>
> > > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > So this looks ok but I would like to see an analysis how the overflow
> > can happen. I'm looking at the callers and it seems that once ctx->count
> > hits 0 eventfd_read() won't call eventfd_ctx_do_read() anymore. So is
> > there a caller that can call directly or indirectly
> > eventfd_ctx_do_read() on a ctx->count == 0?
> eventfd_read() ensures that ctx->count is not 0 before calling
> eventfd_ctx_do_read() and it is correct.
> 
> But it is not appropriate for eventfd_ctx_remove_wait_queue() to call
> eventfd_ctx_do_read() unconditionally,
> 
> as it may not only causes ctx->count to overflow, but also unnecessarily
> calls wake_up_locked_poll().

Hm, so I think you're right and an underflow can be triggered for at
least three subsystems:

(1) virt/kvm/eventfd.c
(2) drivers/vfio/virqfd.c
(3) drivers/virt/acrn/irqfd.c

where (2) and (3) are just modeled after (1). The eventfd must've been
set to EFD_SEMAPHORE and ctx->count must been or decremented zero. The
only way I can see the _underflow_ happening is if the irqfd is shutdown
through an ioctl() like KVM_IRQFD with KVM_IRQFD_FLAG_DEASSIGN raised
while ctx->count is zero:

kvm_vm_ioctl()
-> kvm_irqfd()
   -> kvm_irqfd_deassign()
      -> irqfd_deactivate()
         -> irqfd_shutdown()
            -> eventfd_ctx_remove_wait_queue(&cnt)

which would underflow @cnt and cause a spurious wakeup. Userspace would
still read one because of EFD_SEMAPHORE semantics and wouldn't notice
the underflow.

I think it's probably not that bad because afaict, this really can only
happen when (1)-(3) are shutdown. But we should still fix it ofc.

> 
> 
> I am sorry for just adding the following string in the patch:
> Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
> 
> 
> Looking forward to your suggestions.

What I usually look for is some callchain/analysis that explain under
what circumstance what this is fixing can happen. That makes life for
reviewers a lot easier because they don't have to dig out that work
themselves which takes time.
