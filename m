Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410069A48C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 04:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBQDqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 22:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBQDqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892583C6;
        Thu, 16 Feb 2023 19:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC4BB829AB;
        Fri, 17 Feb 2023 03:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0987C433D2;
        Fri, 17 Feb 2023 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676605570;
        bh=TzTJFO3XRPwl5gaxtwSPuOLgGN0YCWKHoM8VsGLTZ4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwQu5ItXVv6iw2g3RuMyjlxNdiMlhvF0GwEhOPbXFNgtFXnLG45xzvRdR5K+w0J8H
         dmFBfB5z4h44IbBJbEmgHIRtMrdIUjuAkSgAas25BM795LzcATzcKDsOUa1Cs19SL+
         8kezDdpO1UmCOj2iTyiVwbFidlcTfDD254zKl9cHdYEM5330Uh+LKL2N53da3M1Fy3
         m+uGb/LFscKSrWXSkdTtS7r9iJ/JFEB6RfSNJAq+oCBQ2lzDXCG6cRfP1BnYuMgjmS
         txY0g4LyyIOSPSBFXQTnQFXuB3enClAw9fnM88H5gXmmi5YD+1I7XmSw2Oli5i5O+j
         gBmREC3K6RI0Q==
Date:   Thu, 16 Feb 2023 19:46:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] eventfd: use wait_event_interruptible_locked_irq()
 helper
Message-ID: <Y+74gAWLLOu4mNhC@sol.localdomain>
References: <tencent_98334C552AB55C90FCE4523A327393DFF606@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_98334C552AB55C90FCE4523A327393DFF606@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:29:48AM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> wait_event_interruptible_locked_irq was introduced by commit 22c43c81a51e
> ("wait_event_interruptible_locked() interface"), but older code such as
> eventfd_{write,read} still uses the open code implementation.
> Inspired by commit 8120a8aadb20
> ("fs/timerfd.c: make use of wait_event_interruptible_locked_irq()"), this
> patch replaces the open code implementation with a single macro call.
> 
> No functional change intended.
> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dylan Yudaken <dylany@fb.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Fu Wei <wefu@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/eventfd.c | 41 +++++++----------------------------------
>  1 file changed, 7 insertions(+), 34 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
