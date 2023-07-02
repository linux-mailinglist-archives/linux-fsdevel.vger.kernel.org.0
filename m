Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0C745270
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGBVLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 17:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBVLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 17:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B626EE54;
        Sun,  2 Jul 2023 14:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF4F60C7A;
        Sun,  2 Jul 2023 21:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF697C433C7;
        Sun,  2 Jul 2023 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688332279;
        bh=ozTYQx1eRJJJ+4EwI6iIprPJB77zziVTip4YVLzz3zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lno3SkkQL23XKhwFBx0qg26MXW3Io+5ES3F72CA/o+w0dAL3oBnu9VafN2JU7p4aH
         uUz+PZJRiP3DjqUClSiE3czwRX0fgA3S++quTOwSa8gpAKyUItDTvw1xqI1aHKGlTv
         H0j8q4p1heIRTU/5gWBWQ4UUlz3/MXLUZwuTM8j8=
Date:   Sun, 2 Jul 2023 14:11:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zhu, Lipeng" <lipeng.zhu@intel.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pan.deng@intel.com, yu.ma@intel.com,
        tianyou.li@intel.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH] fs/address_space: add alignment padding for i_map and
 i_mmap_rwsem to mitigate a false sharing.
Message-Id: <20230702141117.d9827596dea4ca9d6c5d1fd3@linux-foundation.org>
In-Reply-To: <20230628105624.150352-1-lipeng.zhu@intel.com>
References: <20230628105624.150352-1-lipeng.zhu@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jun 2023 18:56:25 +0800 "Zhu, Lipeng" <lipeng.zhu@intel.com> wrote:

> When running UnixBench/Shell Scripts, we observed high false sharing
> for accessing i_mmap against i_mmap_rwsem.
> 
> UnixBench/Shell Scripts are typical load/execute command test scenarios,
> the i_mmap will be accessed frequently to insert/remove vma_interval_tree.
> Meanwhile, the i_mmap_rwsem is frequently loaded. Unfortunately, they are
> in the same cacheline.

That sounds odd.  One would expect these two fields to be used in
close conjunction, so any sharing might even be beneficial.  Can you
identify in more detail what's actually going on in there?

> The patch places the i_mmap and i_mmap_rwsem in separate cache lines to avoid
> this false sharing problem.
> 
> With this patch, on Intel Sapphire Rapids 2 sockets 112c/224t platform, based
> on kernel v6.4-rc4, the 224 parallel score is improved ~2.5% for
> UnixBench/Shell Scripts case. And perf c2c tool shows the false sharing is
> resolved as expected, the symbol vma_interval_tree_remove disappeared in
> cache line 0 after this change.

There can be many address_spaces in memory, so a size increase is a
concern.  Is there anything we can do to minimize the cost of this?

