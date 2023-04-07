Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A36DB5D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 23:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDGVhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 17:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGVg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:36:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D102BB96
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k9AhaIzz3R8tQUltfyNXuIsxxuCPynmhkdehAo0ZzCg=; b=oOc/UjE5Pi9/TzLovF2XlF5RkV
        lru0iTR6Ox6CNt0eGNGZI3rE8kdX3G5bPK36sjQgOxBU7pl3tDt2xxQKxK+6XNCq1Cu1g6vIRUyte
        m6Tn15pIf4I9AImanxHL1tAflqSpwdC7ppltWk7HJc3X9JCsczbBwHWCGpzIJsd4AvZ2Vp3dFEpl8
        lfKWnMBMNsn4PhGgjwXJokOM39tQOZkplT+o5dH6vENQd7Sq1aR0h8957LBTnqXqtCAVXYYXE7wSF
        jkgVCxwS0dtm258blMQEctm3SHV1w48EOyZMbGZMAJd7ibE1eehZGNEJAWjnMQrQeQNZjxKveu93Y
        4iEz3QQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pktlK-001E8I-G3; Fri, 07 Apr 2023 21:36:50 +0000
Date:   Fri, 7 Apr 2023 22:36:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH 1/6] mm: Allow per-VMA locks on file-backed VMAs
Message-ID: <ZDCM8hGnqgsHyP0a@casper.infradead.org>
References: <20230404135850.3673404-1-willy@infradead.org>
 <20230404135850.3673404-2-willy@infradead.org>
 <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
 <ZDB5OsBc3R7o489l@casper.infradead.org>
 <CAJuCfpGMsSRQU1Oob2HNn8PFxTx2REtiUOZfB87hYokLCBU=Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGMsSRQU1Oob2HNn8PFxTx2REtiUOZfB87hYokLCBU=Bw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 07, 2023 at 01:26:08PM -0700, Suren Baghdasaryan wrote:
> True. do_swap_page() has the same issue. Can we move these
> count_vm_event() calls to the end of handle_mm_fault():

I was going to suggest something similar, so count that as an
Acked-by.  This will change the accounting for the current retry
situation, where we drop the mmap_lock in filemap_fault(), initiate I/O
and return RETRY.  I think that's probably a good change though; I don't
see why applications should have their fault counters incremented twice
for that situation.

>        mm_account_fault(regs, address, flags, ret);
> +out:
> +       if (ret != VM_FAULT_RETRY) {
> +              count_vm_event(PGFAULT);
> +              count_memcg_event_mm(vma->vm_mm, PGFAULT);
> +       }

Nit: this is a bitmask, so we should probably have:

	if (!(ret & VM_FAULT_RETRY)) {

in case somebody's ORed it with VM_FAULT_MAJOR or something.

Hm, I wonder if we're handling that correctly; if we need to start I/O,
do we preserve VM_FAULT_MAJOR returned from the first attempt?  Not
in a position where I can look at the code right now.
