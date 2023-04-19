Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBD6E7606
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjDSJMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjDSJMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0B107;
        Wed, 19 Apr 2023 02:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D010616F2;
        Wed, 19 Apr 2023 09:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80449C433EF;
        Wed, 19 Apr 2023 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681895551;
        bh=6YUk6AAUM3ORtZrVrup0K5gL81Envy2abVP09sfpCtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcNT5UtHpG5io2IFoZ/G9pv2UUsfH2QQ/hC3mndggqwowNMEe+Gpb9i6hJO6ZQ9At
         z3plzTA9Lme0bPCMpxtKRU7uAAFLVx4fuy1ptVuYrCdFHzN8jLA16+TZQyuab7I6/u
         /aeFTe52sGK6zM7lQJZrfRAQOuJhxFlbw3ciP6ncyT+XW9XsuLZioZXA7CBcxcYveD
         3w996/ZwzUPCH+VHOaPAe6ZjG0261i5jT/wBFMYXMBrLDzs44mia4hUuW0dpCWR7OB
         k2Zm4L1Vo1xIJkgHgOo6JbZKlPuQbc03OTcyvntPC1MNofXLCRMdafYR7zRKOWiglN
         nr/TJXLxohPQA==
Date:   Wed, 19 Apr 2023 11:12:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore
 eventfd to reduce cpu utilization
Message-ID: <20230419-blinzeln-sortieren-343826ee30ce@brauner>
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
 <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
 <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
 <7dded5a8-32c1-e994-52a0-ce32011d5e6b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dded5a8-32c1-e994-52a0-ce32011d5e6b@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 08:15:03PM -0600, Jens Axboe wrote:
> On 4/17/23 10:32?AM, Wen Yang wrote:
> > 
> > ? 2023/4/17 22:38, Jens Axboe ??:
> >> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
> >>> From: Wen Yang <wenyang.linux@foxmail.com>
> >>>
> >>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
> >>> then a read(2) returns 8 bytes containing that value, and the counter's
> >>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
> >>> N event_writes vs ONE event_read is possible.
> >>>
> >>> However, the current implementation wakes up the read thread immediately
> >>> in eventfd_write so that the cpu utilization increases unnecessarily.
> >>>
> >>> By adding a configurable delay after eventfd_write, these unnecessary
> >>> wakeup operations are avoided, thereby reducing cpu utilization.
> >> What's the real world use case of this, and what would the expected
> >> delay be there? With using a delayed work item for this, there's
> >> certainly a pretty wide grey zone in terms of delay where this would
> >> perform considerably worse than not doing any delayed wakeups at all.
> > 
> > 
> > Thanks for your comments.
> > 
> > We have found that the CPU usage of the message middleware is high in
> > our environment, because sensor messages from MCU are very frequent
> > and constantly reported, possibly several hundred thousand times per
> > second. As a result, the message receiving thread is frequently
> > awakened to process short messages.
> > 
> > The following is the simplified test code:
> > https://github.com/w-simon/tests/blob/master/src/test.c
> > 
> > And the test code in this patch is further simplified.
> > 
> > Finally, only a configuration item has been added here, allowing users
> > to make more choices.
> 
> I think you'd have a higher chance of getting this in if the delay
> setting was per eventfd context, rather than a global thing.

That patch seems really weird. Is that an established paradigm to
address problems like this through a configured wakeup delay? Because
naively this looks like a pretty brutal hack.
