Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82B86D9BA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbjDFPEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbjDFPER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00736A40;
        Thu,  6 Apr 2023 08:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E38618D3;
        Thu,  6 Apr 2023 15:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B78C433D2;
        Thu,  6 Apr 2023 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793430;
        bh=2IEmxNUrt29vTnWXKg7IZkBRsXl0srtJ3bvncLKpcD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D05IXfIR2sQ2YuySOPjeJd95zplkJ0xgy/6DXBN4VxCoo3NibPkoO5RwrMe+LkICi
         LozhRtNeKmr3pCsgm2z4ay4ul0v8+6wSBSkPyWVOitFtFUQx8smroMeliae+ayLZbR
         gCyj5vj9r+E6khchCo++9ET3CHd4RwK4ypLT5/5UyFSZ9VImTkciUKnsl2dODSP7IX
         dRPPYTtaicmDRW9iYtl2kEMZze6ZYScrl4zpokvs3fFXmRmXn2aLwaomQqTIEAlWeD
         Z+hUD2lP6Pc8Xl8pfsDpA/OeoCrvwUAhshY4qMNkt/zhOxNIIOtESY6ukwH4WpCwX+
         YXsChVEjlO2qw==
Date:   Thu, 6 Apr 2023 17:03:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] eventfd: use
 wait_event_interruptible_locked_irq() helper
Message-ID: <20230406-hinarbeiten-gebadet-0165cff8d191@brauner>
References: <tencent_F38839D00FE579A60A97BA24E86AF223DD05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_F38839D00FE579A60A97BA24E86AF223DD05@qq.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:42:08AM +0800, wenyang.linux@foxmail.com wrote:
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
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
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

Confused... Did you see the earlier reply?
https://lore.kernel.org/lkml/20230406-kernig-parabel-d12963a4e7fa@brauner
