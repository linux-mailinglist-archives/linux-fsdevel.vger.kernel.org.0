Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383276AA419
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 23:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCCWVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 17:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCCWUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:20:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17AD1AC;
        Fri,  3 Mar 2023 14:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FA7uGsCNzQTX91SZa0qfeSXhiYIuU1/JhGPJURHOQ8U=; b=t1DRLpk0min/n/ZU4WczyXFDVW
        ryVT2b9FcFpkwIibnFsuQE6SI2jp1MUYCxnI8z2q1uFhPZbYpfI0HWzVFrERZOVrWeLmQlgihQEII
        zCcyytDs7ADaZDk263+X2+PIkCW+XhNmxFIgugyqGjLWJ4s+lkutfU0kvgApHcNmtLuWY7BL67qrq
        3tBdxSF19BFC+BAMGOnhyRJOpaMgHhqfafWk7+WgbWaXEESs7zULP4z+Y2FFAAHhfy1Y+1FWjrBGj
        umwyLL1lneibUf+JyKHs9uF5ONZ9rSzbZ5hivSEMQuR8M0g29myNQwQ9Igft62cmli8Z800K87Kyh
        01vGbzaw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYDcv-007hzR-Gy; Fri, 03 Mar 2023 22:11:45 +0000
Date:   Fri, 3 Mar 2023 14:11:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: =?iso-8859-1?Q?compaction?=
 =?iso-8859-1?Q?=3A_limit_illegal_input_parameters_of=A0compact=5Fmemor?=
 =?iso-8859-1?Q?y?= interface
Message-ID: <ZAJwoXJCzfk1WIBx@bombadil.infradead.org>
References: <202303030844412743985@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303030844412743985@zte.com.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 08:44:41AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Available only when CONFIG_COMPACTION is set. When 1 is written to
> the file, all zones are compacted such that free memory is available
> in contiguous blocks where possible.
> But echo others-parameter > compact_memory, this function will be
> triggered by writing parameters to the interface.
> 
> Applied this patch,
> sh/$ echo 1.1 > /proc/sys/vm/compact_memory
> sh/$ sh: write error: Invalid argument
> The start and end time of printing triggering compact_memory.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Do a huge favor and while you're at it split this into two patches,
one which takes this out of kernel/sysctl.c and move it to
mm/compaction.c and a second one that does your change here.

Since kernel/sysctl.c is being trimmed you can base your changes on
sysctl-next [0] and I'm happy to take in there if Andrew agrees to it.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
