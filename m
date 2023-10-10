Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE017BF1BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 05:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442082AbjJJD6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441973AbjJJD6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:58:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8101492;
        Mon,  9 Oct 2023 20:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4gNQmNubIN/TBepTlzBZaBxA4jjJVnAEm3nKv56gu28=; b=lI5Bw8KIWB5ZsFRFGMi6BGGMWF
        ZdN2uYMoYxzFmMf154Bbrb6BxetbqIcXc4zdguYF/cYSzs3HUoDfrU0M+yv+RcNJ5vqOIcUirBrxM
        q5XZKPnayu/uk5a/tHzH0NycAsKNLdQ1rP3yum1YVQWyqK1Dj4cZNxPk0JhLFBDvUxNgLNSlVykLO
        6IpsXvyuheU6TLg3ushd2jYq2j7aFASGYPIwNUE2U1/dB2Oc1sgEbXipKii01NjZGUDRxGXKRZYz3
        vopBhBePi88Er41e3iXTIJaIElpWZtjDqS5jki8zbB/hAUUF5LAEjPRggq0VjByXxWNsQ1zF62MUS
        sKBwGsmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qq3sc-002HYA-JP; Tue, 10 Oct 2023 03:57:58 +0000
Date:   Tue, 10 Oct 2023 04:57:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bin Lai <sclaibin@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Bin Lai <robinlai@tencent.com>
Subject: Re: [PATCH] sched/wait: introduce endmark in __wake_up_common
Message-ID: <ZSTLxuiJssT9aYb0@casper.infradead.org>
References: <20231010032833.398033-1-robinlai@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010032833.398033-1-robinlai@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:28:33AM +0800, Bin Lai wrote:
> Without this patch applied, it can cause the waker to fall into an
> infinite loop in some cases. The commit 2554db916586 ("sched/wait: Break
> up long wake list walk") introduces WQ_FLAG_BOOKMARK to break up long
> wake list walk. When the number of walked entries reach 64, the waker
> will record scan position and release the queue lock, which reduces
> interrupts and rescheduling latency.

Maybe we could try removing bookmarks instead?  There was a thread a
while ago where we agreed they weren't actually useful any more.

Patches to follow ...
