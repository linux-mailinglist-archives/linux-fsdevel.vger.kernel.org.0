Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3159E744F41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGBRun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBRum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65983E5C;
        Sun,  2 Jul 2023 10:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0091660C39;
        Sun,  2 Jul 2023 17:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29493C433C7;
        Sun,  2 Jul 2023 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688320240;
        bh=qtq4xZmGJHF0roAxc5vd3g28SRKktcLfa1D78W6Jf6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gsSTkqumocKHhTHBiF5BxV7PJywcvJ65EU/wzK3pcqggkdIOjqXoJGHeJkLnV2SOQ
         LprCWHTOTZJdHrnbySXPI88NtO2xcDPjaYotcqNyoRNn9hmYU6KvmFF5qn+GV+AvxI
         qA+UvqgVsfUu3tbRA/XulHtN3BUIUKwRUrxqv4PU=
Date:   Sun, 2 Jul 2023 10:50:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
Message-Id: <20230702105038.5d0f729109d329013af4caa3@linux-foundation.org>
In-Reply-To: <20230630211957.1341547-1-surenb@google.com>
References: <20230630211957.1341547-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jun 2023 14:19:51 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> When per-VMA locks were introduced in [1] several types of page faults
> would still fall back to mmap_lock to keep the patchset simple. Among them
> are swap and userfault pages. The main reason for skipping those cases was
> the fact that mmap_lock could be dropped while handling these faults and
> that required additional logic to be implemented.
> Implement the mechanism to allow per-VMA locks to be dropped for these
> cases.
> First, change handle_mm_fault to drop per-VMA locks when returning
> VM_FAULT_RETRY or VM_FAULT_COMPLETED to be consistent with the way
> mmap_lock is handled. Then change folio_lock_or_retry to accept vm_fault
> and return vm_fault_t which simplifies later patches. Finally allow swap
> and uffd page faults to be handled under per-VMA locks by dropping per-VMA
> and retrying, the same way it's done under mmap_lock.
> Naturally, once VMA lock is dropped that VMA should be assumed unstable
> and can't be used.

Is there any measurable performance benefit from this?
