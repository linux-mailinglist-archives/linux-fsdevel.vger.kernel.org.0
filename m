Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0375F8F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 15:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGXNyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXNyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:54:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82773268F;
        Mon, 24 Jul 2023 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kSn9lV4vudoTTwyV0i7jCpPn7hBfXbWHV74eMs9f/8g=; b=j4kIojTCOg98Fw6ZFrGzkYPujC
        kCMHHdYaeasub7NeINN3HYoTGMhECncDowHv89ci2pgAVGZyOQt3++6JqmJIuv8sRW0VCQQO1RsHA
        6x+RtwoP9TwHaNrtpMdi9k9XBVc7RQK2FKmptWdh/ZAhIyyfyEQZac1ny04d9ljai6Gql2vv9WX8z
        9w2hB5qCGYx1nvS475F0BJeQsCHKHKAMk735kj2zj7B57Z46j+IMbH55S2as0bCYYaSfmmlExCwuP
        FAy8PY5+G/M2ZhBvCUJeXgBcU9GGXHo3UtLZnWGtEhPsJ1rrLwXLaO4q4+iGahV+DkbqHbyfFvr5V
        8qgx02Xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNvxi-004SZV-Ja; Mon, 24 Jul 2023 13:50:58 +0000
Date:   Mon, 24 Jul 2023 14:50:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] softirq: fix integer overflow in function show_stat()
Message-ID: <ZL6BwiHhvQneJZYH@casper.infradead.org>
References: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
 <20230724132224.916-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132224.916-2-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:22:23PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The statistics function of softirq is supported by commit aa0ce5bbc2db
> ("softirq: introduce statistics for softirq") in 2009. At that time,
> 64-bit processors should not have many cores and would not face
> significant count overflow problems. Now it's common for a processor to
> have hundreds of cores. Assume that there are 100 cores and 10
> TIMER_SOFTIRQ are generated per second, then the 32-bit sum will be
> overflowed after 50 days.

50 days is long enough to take a snapshot.  You should always be using
difference between, not absolute values, and understand that they can
wrap.  We only tend to change the size of a counter when it can wrap
sufficiently quickly that we might miss a wrap (eg tens of seconds).
