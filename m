Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF00F425B8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhJGTdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhJGTda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:33:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C50C061570;
        Thu,  7 Oct 2021 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ov7Y3AdM9RNZqm8EP9Y9K5HZHbQg0Tk3kW4wZrNisU=; b=wIKTf0/Xx58Dcd+75FXYhO6TpO
        wOvrjbzdXRPaGAIp1B1H3BfnXW/D/XaSolWgQH7tlfq4Jkqz+w13NdPhBwQa3QV/yChIvCwtXUxso
        llNdNzLEvCd44R612N2acyNWet3H8LjMs4GXuI1A2tSElqgflZNgdsKHJ9XbDW2BOTjlqUTFANF/A
        3vFjuUiA3Dau1FUjzThJ9z2w3yu8YuEnDod1RVht3dwOmgeVVFr7NLtIiP2prd4UiHnbjBwuMK6m+
        udsyXpFpBz7v7cN55kp3uNmjx6cn+wVK4eXBw7osEDLtkQe3jsdQosqK70vT1MqP0CV/diU2dGLLh
        qpAYb5kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYZ5t-002MV4-KT; Thu, 07 Oct 2021 19:30:32 +0000
Date:   Thu, 7 Oct 2021 20:30:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] fs: proc: task_mmu: fix sparse warnings
Message-ID: <YV9KyR/I76oODMFD@casper.infradead.org>
References: <20211007191636.541041-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007191636.541041-1-anders.roxell@linaro.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 09:16:36PM +0200, Anders Roxell wrote:
> When building the kernel with sparse enabled 'C=1' the following
> warnings can be seen:
> 
> fs/proc/task_mmu.c:587:17: warning: context imbalance in 'smaps_pte_range' - unexpected unlock
> fs/proc/task_mmu.c:1145:28: warning: context imbalance in 'clear_refs_pte_range' - unexpected unlock
> fs/proc/task_mmu.c:1473:28: warning: context imbalance in 'pagemap_pmd_range' - unexpected unlock
> fs/proc/task_mmu.c:1811:28: warning: context imbalance in 'gather_pte_stats' - unexpected unlock
> 
> Rework to add __acquire() and __release() to tell sparse that it is all good.

Surely the root problem here is that pmd_trans_huge_lock() isn't
marked with __cond_lock() like, eg, get_locked_pte() is?
