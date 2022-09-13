Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E35B6DF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiIMNHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIMNH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:07:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39BC1E3FA;
        Tue, 13 Sep 2022 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663074443;
  x=1694610443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fjdWymekn3UIiOUWJEmNK3vReR/+Xpw8sXAn58G/p98=;
  b=US/NqJ6CW1rVgd3VDD8Zc8ac3mADQ7coGG6CmUlRyB9rMRgnWbvvRjvj
   YPCkA7NOCVLwldUnt7xkEzF0iN8idj4UXpM1vuqUaMpE0mshB895go1Gz
   OB2N1NNcYiFn3HSGy0H+dkcopcleCmtWi3UO1I0kDtstkhvCeEZ7ItAMJ
   hI1whieVTeYRCsWysCVOvW0CE8x384z4WrWN+Wjz6A5lxFX8qh2hIspum
   TrIyn/NUUTIfKXBEVVUFuryHdBbAFHMM85+a0SEjGPmlPcQsHAEVzpvuZ
   1gO6DtVbZsBjV5mQQ7Z84+UFCJ7cDIA1iEss2q5ydlqHI3mJY3h5TPc1G
   A==;
Date:   Tue, 13 Sep 2022 15:07:20 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     kernel <kernel@axis.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] proc: Enable smaps_rollup without ptrace rights
Message-ID: <YyCAiAMvaNihNUAH@axis.com>
References: <20220908093919.843346-1-vincent.whitchurch@axis.com>
 <20220908145934.4565620db7cbc3b9ceb90e3b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220908145934.4565620db7cbc3b9ceb90e3b@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:59:34PM +0200, Andrew Morton wrote:
> On Thu, 8 Sep 2022 11:39:19 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > smaps_rollup is currently only allowed on processes which the user has
> > ptrace permissions for, since it uses a common proc open function used
> > by other files like mem and smaps.
> > 
> > However, while smaps provides detailed, individual information about
> > each memory map in the process (justifying its ptrace rights
> > requirement), smaps_rollup only provides a summary of the memory usage,
> > which is not unlike the information available from other places like the
> > status and statm files, which do not need ptrace permissions.
> > 
> > The first line of smaps_rollup could however be sensitive, since it
> > exposes the randomized start and end of the process' address space.
> > This information however does not seem essential to smap_rollup's
> > purpose and could be replaced with placeholder values to preserve the
> > format without leaking information.  (I could not find any user space in
> > Debian or Android which uses the information in the first line.)
> > 
> > Replace the start with 0 and end with ~0 and allow smaps_rollup to be
> > opened and read regardless of ptrace permissions.
> 
> What is the motivation for this?  Use case?  End-user value and such?

My use case is similar to Sergey's[0]: to be able to gather memory usage
information from a daemon/script running without root permissions or
ptrace rights.  Values like Pss are only available from smaps_rollup,
and not from the other files like status and statm which already provide
memory usage information without requiring elevated privileges.

[0] https://lore.kernel.org/lkml/20200929024018.GA529@jagdpanzerIV.localdomain/

smaps_rollup is however much more expensive than those other files, so I
guess that could be an argument for treating it differently, even if the
content itself does not need to be protected.
