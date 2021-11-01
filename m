Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7B441B2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhKAMc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhKAMc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:32:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9BC061714;
        Mon,  1 Nov 2021 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PkMQ2aJC5jezjXsciOSDQbUm9uMWZMe4Y1Gl5dY5vr0=; b=h1m/EAFtW978XdTXPT9VI3eSSs
        Rm/LHrexjjf0ZpiaT2BBewklmkA2WYaF71sRT3lVkJ3Tce5PhHw+KnRlLsfOM2OePLeDp4gzblujB
        ijQ6bGk53HecrdKHmrlS5N1LkWfCQwWqeXogkr5VxiESNCMmbbv8qF3oDu3Tn9wDOPfagv4FupEVS
        BG4pw5+12Qdw1lnN5q/OFCtkADiFiM1g9hRBxfhG1KLgg2K6kL/RjYXUeJzaC1K1pS+NQ6LooCC05
        yMTYafz5P7DVpu0rZ8Az8yInteCcEZAG6rHwXwfnum3CBuHVSS4YTgBXir/YvkbDvrH6bTs8D6Kq6
        nd2R0pxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhWNs-003lTn-1h; Mon, 01 Nov 2021 12:26:44 +0000
Date:   Mon, 1 Nov 2021 12:25:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gou Hao <gouhao@uniontech.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiaofenfang@uniontech.com
Subject: Re: [PATCH] fs: remove fget_many and fput_many interface
Message-ID: <YX/c0IKikjZ5DAlG@casper.infradead.org>
References: <20211101051931.21544-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101051931.21544-1-gouhao@uniontech.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:19:31PM +0800, Gou Hao wrote:
> From: gouhao <gouhao@uniontech.com>
> 
> These two interface were added in 091141a42 commit,
> but now there is no place to call them.

For completeness, the only user of these APIs was removed in commit
62906e89e63b ("io_uring: remove file batch-get optimisation").
A user of get_file_rcu_many() (which you didn't mention) were also
removed in f073531070d2 ("init: add an init_dup helper").

> And replace atomic_long_sub/add to atomic_long_dec/inc
> can improve performance.
> 
> Here are the test results of unixbench:
> 
> Cmd: ./Run -c 64 context1
> 
> Without patch:
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> Pipe-based Context Switching                   4000.0    2798407.0   6996.0
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         6996.0
> 
> With patch:
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> Pipe-based Context Switching                   4000.0    3486268.8   8715.7
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         8715.7

This seems impressive.  What's the stddev of this benchmark?
