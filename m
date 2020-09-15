Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1746F269A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgIOAjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgIOAjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:39:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DCDC06174A;
        Mon, 14 Sep 2020 17:39:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHyzq-00GESe-C0; Tue, 15 Sep 2020 00:38:58 +0000
Date:   Tue, 15 Sep 2020 01:38:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mateusznosek0@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: micro-optimization remove branches by adjusting
 flag values
Message-ID: <20200915003858.GK3421308@ZenIV.linux.org.uk>
References: <20200914174338.9808-1-mateusznosek0@gmail.com>
 <20200914180629.GT6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914180629.GT6583@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:06:29PM +0100, Matthew Wilcox wrote:
> $ objdump -d test.o
> 0000000000000000 <a>:
>    0:   89 f8                   mov    %edi,%eax
>    2:   83 e0 03                and    $0x3,%eax
>    5:   c3                      retq   
> 
> Please stop submitting uglifying patches without checking they actually
> improve anything.  GCC is smarter than you think it is.

His main point isn't that - it's reshuffling LOOKUP_... bits to make that
kind of optimisation possible.  However, doing that sets us up for PITA
down the road (e.g. reshuffling LOOKUP_... bits becomes forbidden, etc.)
and I'd rather not go there unless we have a real-world evidence that it
does buy us anything.
