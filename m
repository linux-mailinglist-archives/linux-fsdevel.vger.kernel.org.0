Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1905201E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiEIQJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiEIQJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 12:09:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EEF25559A;
        Mon,  9 May 2022 09:05:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 020CD21C20;
        Mon,  9 May 2022 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652112314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VmlmF9biRWWD6ZEOc5OuT2DALSgkEXHN2KQCnNQUrA=;
        b=uqvsFZjKSPYUAd/1JTKF2JfUJXSzml6s+fX81jFhQG3nyXl+cEqw0Uhf+tewhR5YtXM9AG
        8Tf3eIk3oGyXwRDljjGhn7XWjfbXgsY9ahLXMHfyaeKJrfm1QqZ2ezKvMCwmaA+r+4w2Ep
        2+BWIVXZZveC+0mLZMzgXWYsytvAySE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652112314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VmlmF9biRWWD6ZEOc5OuT2DALSgkEXHN2KQCnNQUrA=;
        b=AF499xLUiRXWmvkOAQ8mtFhUb4QTEZQ8M1au1m8ezGfNJCVmJ2pheW9wNpJj77ljPOE2AA
        9EdqKSJ6QA8t/dAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9C7A13AA5;
        Mon,  9 May 2022 16:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XhB5MLk7eWLuKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 16:05:13 +0000
Message-ID: <627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz>
Date:   Mon, 9 May 2022 18:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-1-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/22 22:02, Yang Shi wrote:
>  include/linux/huge_mm.h        | 14 ++++++++++++
>  include/linux/khugepaged.h     | 59 ++++++++++++---------------------------------------
>  include/linux/sched/coredump.h |  3 ++-
>  kernel/fork.c                  |  4 +---
>  mm/huge_memory.c               | 15 ++++---------
>  mm/khugepaged.c                | 76 +++++++++++++++++++++++++++++++++++++-----------------------------
>  mm/mmap.c                      | 14 ++++++++----
>  mm/shmem.c                     | 12 -----------
>  8 files changed, 88 insertions(+), 109 deletions(-)
 
Resending my general feedback from mm-commits thread to include the
public ML's:

There's modestly less lines in the end, some duplicate code removed,
special casing in shmem.c removed, that's all good as it is. Also patch 8/8
become quite boring in v3, no need to change individual filesystems and also
no hook in fault path, just the common mmap path. So I would just handle
patch 6 differently as I just replied to it, and acked the rest.

That said it's still unfortunately rather a mess of functions that have
similar names. transhuge_vma_enabled(vma). hugepage_vma_check(vma),
transparent_hugepage_active(vma), transhuge_vma_suitable(vma, addr)?
So maybe still some space for further cleanups. But the series is fine as it
is so we don't have to wait for it now.

We could also consider that the tracking of which mm is to be scanned is
modelled after ksm which has its own madvise flag, but also no "always"
mode. What if for THP we only tracked actual THP madvised mm's, and in
"always" mode just scanned all vm's, would that allow ripping out some code
perhaps, while not adding too many unnecessary scans? If some processes are
being scanned without any effect, maybe track success separately, and scan
them less frequently etc. That could be ultimately more efficinet than
painfully tracking just *eligibility* for scanning in "always" mode?

Even more radical thing to consider (maybe that's a LSF/MM level topic, too
bad :) is that we scan pagetables in ksm, khugepaged, numa balancing, soon
in MGLRU, and I probably forgot something else. Maybe time to think about
unifying those scanners?
 

