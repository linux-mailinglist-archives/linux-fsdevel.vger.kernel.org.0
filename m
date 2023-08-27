Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D020789C59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjH0IxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjH0Iw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B69F1;
        Sun, 27 Aug 2023 01:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75C262167;
        Sun, 27 Aug 2023 08:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E012C433C7;
        Sun, 27 Aug 2023 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693126375;
        bh=TMfQl3Pz+V2rPjEjmQALnP4xXEsGHixS96zlrjaSDkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcuXk0cHMQUqSoJaQxUN0GjNbCw6l/tR9z3vAAx/SvsyRN24m121+4Mm7dIoTxW7v
         5fK4XWmIcYyx+QsW/8XtADuugqrtXZ71fza0xnva4BDTHxFklL7gQjp/XcRgtoDm7R
         vgblHvZGSuNaISMjxJ6GfdIPZq+No+VdCEJ3gtTE=
Date:   Sun, 27 Aug 2023 10:52:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     "# v4 . 16+" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5.4 0/1] mm: allow a controlled amount of unfairness in
 the page lock
Message-ID: <2023082742-mourner-amaze-7ff9@gregkh>
References: <20230821222547.483583-1-saeed.mirzamohammadi@oracle.com>
 <2023082248-parting-backed-2ab0@gregkh>
 <D13FD910-FB1B-4DD8-9FFC-1BAF2C1390BF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D13FD910-FB1B-4DD8-9FFC-1BAF2C1390BF@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:20:50PM +0000, Saeed Mirzamohammadi wrote:
> 
> 
> > On Aug 22, 2023, at 12:08 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Mon, Aug 21, 2023 at 03:25:45PM -0700, Saeed Mirzamohammadi wrote:
> >> We observed a 35% of regression running phoronix pts/ramspeed and also 16%
> >> with unixbench. Regression is caused by the following commit:
> >> dd0f194cfeb5 | mm: rewrite wait_on_page_bit_common() logic
> > 
> > That is not a valid git id in Linus's or in the linux-stable repo that I
> > can see.  Are you sure that it is correct?
> 
> Sorry for the incorrect sha. Here are the correct ones:
> 
>   kernel_dot_org/linux-stable.git    linux-5.4.y            - c32ab1c1959a
>   kernel_dot_org/torvalds_linux.git  master                 - 2a9127fcf229
>   kernel_dot_org/linux-stable.git    master                 - 2a9127fcf229
> ---
>   subject          : mm: rewrite wait_on_page_bit_common() logic
>   author           : torvalds@linux-foundation.org
>   author date      : 2020-07-23 17:16:49

Thanks, now queued up.

greg k-h
