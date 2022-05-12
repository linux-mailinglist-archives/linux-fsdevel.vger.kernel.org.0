Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509675257E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 00:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359228AbiELWh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359204AbiELWh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 18:37:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007F261943;
        Thu, 12 May 2022 15:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAC00B82910;
        Thu, 12 May 2022 22:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049ACC385B8;
        Thu, 12 May 2022 22:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652395074;
        bh=iXYbrakwOy8fAS30CpfPw/fAsO6kge5ixveO1uxKU/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PMBURyUly2UezZiNvUykZHn33IlAWIMcuk7bTxPjWZyZ3Ag10LKIXURsFE3JF4NJx
         SYgAhZDbYdpgl394L62xDISq1OGnn8EsEJqmcO3utNvrphDGTsPxMz/vc6xBZydBrT
         YORPRsmlAVMS5yX+P3jHKm16rK21uDwj7kqO7/IU=
Date:   Thu, 12 May 2022 15:37:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     cgel.zte@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, corbet@lwn.net,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
Message-Id: <20220512153753.6f999fa8f5519753d43b8fd5@linux-foundation.org>
In-Reply-To: <5820954.lOV4Wx5bFT@natalenko.name>
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
        <5820954.lOV4Wx5bFT@natalenko.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 May 2022 15:30:36 +0200 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> > If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> > of this mm to be involved in KSM scanning without explicitly calling
> > madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
> > the klob of /sys/kernel/mm/ksm/run is set as 1.
> > 
> > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > process (fallback to the default state) and unmerge those merged pages
> > belonging to VMAs which is not madvised as MADV_MERGEABLE of this process,
> > but still leave MADV_MERGEABLE areas merged.
> 
> To my best knowledge, last time a forcible KSM was discussed (see threads [1], [2], [3] and probably others) it was concluded that a) procfs was a horrible interface for things like this one; and b) process_madvise() syscall was among the best suggested places to implement this (which would require a more tricky handling from userspace, but still).
> 
> So, what changed since that discussion?
> 
> P.S. For now I do it via dedicated syscall, but I'm not trying to upstream this approach.

Why are you patching the kernel with a new syscall rather than using
process_madvise()?

