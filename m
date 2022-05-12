Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984FC524B84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353313AbiELLWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353390AbiELLVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:09 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD8B15EE41
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 04:20:05 -0700 (PDT)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 12 May 2022 20:20:03 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 12 May 2022 20:20:03 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     tj@kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tytso@mit.edu, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, mcgrof@kernel.org, holt@sgi.com
Subject: Re: [REPORT] syscall reboot + umh + firmware fallback
Date:   Thu, 12 May 2022 20:18:24 +0900
Message-Id: <1652354304-17492-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <YnzQHWASAxsGL9HW@slm.duckdns.org>
References: <YnzQHWASAxsGL9HW@slm.duckdns.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tejun wrote:
> Hello,

Hello,

> I'm not sure I'm reading it correctly but it looks like "process B" column

I think you're interpreting the report correctly.

> is superflous given that it's waiting on the same lock to do the same thing
> that A is already doing (besides, you can't really halt the machine twice).

Indeed! I've been in a daze. I thought kernel_halt() can be called twice
by two different purposes. Sorry for the noise.

> What it's reporting seems to be ABBA deadlock between A waiting on
> umhelper_sem and C waiting on fw_st->completion. The report seems spurious:
>
> 1. wait_for_completion_killable_timeout() doesn't need someone to wake it up
>    to make forward progress because it will unstick itself after timeout
>    expires.

I have a question about this one. Yes, it would never been stuck thanks
to timeout. However, IIUC, timeouts are not supposed to expire in normal
cases. So I thought a timeout expiration means not a normal case so need
to inform it in terms of dependency so as to prevent further expiraton.
That's why I have been trying to track even timeout'ed APIs.

Do you think DEPT shouldn't track timeout APIs? If I was wrong, I
shouldn't track the timeout APIs any more.

> 2. complete_all() from __fw_load_abort() isn't the only source of wakeup.
>    The fw loader can be, and mainly should be, woken up by firmware loading
>    actually completing instead of being aborted.

This is the point I'd like to ask. In normal cases, fw_load_done() might
happen, of course, if the loading gets completed. However, I was
wondering if the kernel ensures either fw_load_done() or fw_load_abort()
to be called by *another* context while kernel_halt().

> Thanks.

Thank you very much!

	Byungchul

> 
> -- 
> tejun
> 
