Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97391754D13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGPBt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 21:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGPBtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:49:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09E26B7;
        Sat, 15 Jul 2023 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gdtNdWSGtlBUonZNWXJY5hSZusDwU21lJKz5cRRNSYU=; b=F/yR85qc7eiKFTQURQYQIPXByy
        W0/bNYx0pn24ZTG8u5DbJXQaVsJ2ynwMHwjTaQYyjE/ocjYtQ/kChzpEh0fBW/A+6epuuLUS3ZqAR
        1Guz1MrnJnruAomrZbYJv9s8HH3HzfQ8djKA8HMD6oV2FS99wSDX4OUxWhgCbz0/2a+Z6y5lxw7g8
        HXdJPY3jkIsz9tV6L4PvZ3kQrPQMUe64gjzzj5jbKawFkUliVcd0r9B4U/1BqPVDAw7bQt0XcOwkd
        HNMKi3Pq07sCe31uSadc/DEteb+xy13cyKxYHvkg2sGcq67eUhhrAuFu82h0Og7wmiq1w46t6oJAm
        P5LsuCyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKqtR-002iOl-6l; Sun, 16 Jul 2023 01:49:49 +0000
Date:   Sun, 16 Jul 2023 02:49:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: select: reduce stack usage in do_sys_poll()
Message-ID: <ZLNMvZnHjTiqJwTD@casper.infradead.org>
References: <20230716010714.3009192-1-chao@kernel.org>
 <20230716010714.3009192-2-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716010714.3009192-2-chao@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 16, 2023 at 09:07:14AM +0800, Chao Yu wrote:
> struct poll_wqueues table caused the stack usage of do_sys_poll() to
> grow beyond the warning limit on 32-bit architectures w/ gcc.
> 
> fs/select.c: In function ‘do_sys_poll’:
> fs/select.c:1053:1: warning: the frame size of 1328 bytes is larger than 1024 bytes [-Wframe-larger-than=]

That seems particularly high.  But it's only 604 bytes, so half of the
stack frame:

struct poll_wqueues {
        poll_table                 pt;                   /*     0     8 */
        struct poll_table_page *   table;                /*     8     4 */
        struct task_struct *       polling_task;         /*    12     4 */
        int                        triggered;            /*    16     4 */
        int                        error;                /*    20     4 */
        int                        inline_index;         /*    24     4 */
        struct poll_table_entry    inline_entries[18];   /*    28   576 */

        /* size: 604, cachelines: 10, members: 7 */
        /* last cacheline: 28 bytes */
};

Also, you can see it's deliberately sized to fit on the stack (see
include/linux/poll.h).  So you're completely destroying that optimisation.

You need to figure out why the stack is now so big.  This isn't the
right solution.
