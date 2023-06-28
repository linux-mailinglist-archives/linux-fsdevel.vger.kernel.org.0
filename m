Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB471740D73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjF1Jr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjF1Jcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:32:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6353591;
        Wed, 28 Jun 2023 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rs013m832eycdbI7wI/qncGLxYKg/qYM1dV7Gd0Gkgs=; b=PzravfTDeMUsb+TMMGGGfXMNm0
        /Z81cqwcqFlZ4wnimgB3S34jrQT7TtJDfeNsq0Rp9+51TvLQeQ5POCJ63GZ/JsrYDBF/FjJg24ZON
        +Y1FYmcuOWNYI6Fd9s+USoL1cvMYY/KCPFyQN8f+R7PvI5kHiCzoK5vYgDe+rwVf33838Ax7S0h9u
        j9LFUmpfLdCXULlE0/kBb/6VitpuGNSBFPrSz9JdbQpAWykCCuzGgfB1rsnSaRrFGLoCDs5SDYmSu
        LS4a38URAovV4wOLKbjiT9EQeptPqZvIcMJ/6JUG9cM6eEscXGPuj696IVXcaeus6KbfXR35xL+/Q
        TfGlmw1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEOPB-00EwSc-18;
        Wed, 28 Jun 2023 06:11:53 +0000
Date:   Tue, 27 Jun 2023 23:11:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] mm: introduce statistic for inode's gen&tier
Message-ID: <ZJvPKV+1d2+uHB1E@infradead.org>
References: <1687857438-29142-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687857438-29142-1-git-send-email-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 05:17:18PM +0800, zhaoyang.huang wrote:
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -434,6 +434,8 @@ struct address_space {
>  	struct rb_root_cached	i_mmap;
>  	struct rw_semaphore	i_mmap_rwsem;
>  	unsigned long		nrpages;
> +	atomic_long_t		gen;
> +	atomic_long_t		tier;

This increases the size of the inode by 16 byes, and better have really
good data supporting it, as increases of the inode size impact a lot
of workloads.

