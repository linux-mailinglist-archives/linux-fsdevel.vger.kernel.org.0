Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3800750D60B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiDXXtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 19:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiDXXtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 19:49:09 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3C24F39
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 16:46:07 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 1A0DA121943;
        Sun, 24 Apr 2022 23:46:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 5DB292F;
        Sun, 24 Apr 2022 23:46:04 +0000 (UTC)
Message-ID: <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Date:   Sun, 24 Apr 2022 16:46:03 -0700
In-Reply-To: <20220421234837.3629927-7-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
         <20220421234837.3629927-7-kent.overstreet@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Stat-Signature: zqbu5f4uew1ywmsw5h8z43gedmymbkfq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5DB292F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+UuhWGGV8DOnuXU/zVKG4cn1mdOYheV60=
X-HE-Tag: 1650843964-516463
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-04-21 at 19:48 -0400, Kent Overstreet wrote:
> This adds printbufs: simple heap-allocated strings meant for building up
> structured messages, for logging/procfs/sysfs and elsewhere. They've
> been heavily used in bcachefs for writing .to_text() functions/methods -
> pretty printers, which has in turn greatly improved the overall quality
> of error messages.
> 
> Basic usage is documented in include/linux/printbuf.h.

Given the maximum printk output is less than 1024 bytes, why should
this be allowed to be larger than that or larger than PAGE_SIZE?

> + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> + * readable units.

Why not extend vsprintf for this using something like %pH[8|16|32|64] 
or %pH[c|s|l|ll|uc|us|ul|ull] ?


