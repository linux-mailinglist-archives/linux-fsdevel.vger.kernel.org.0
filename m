Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66915025B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350534AbiDOGly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 02:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:41:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36562196;
        Thu, 14 Apr 2022 23:39:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 39DF368B05; Fri, 15 Apr 2022 08:39:21 +0200 (CEST)
Date:   Fri, 15 Apr 2022 08:39:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] fs-writeback: Flush plug before next iteration in
 wb_writeback()
Message-ID: <20220415063920.GB24262@lst.de>
References: <20220415013735.1610091-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415013735.1610091-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 09:37:35AM +0800, Zhihao Cheng wrote:
> +		if (progress) {
> +			/*
> +			 * The progress may be false postive in page redirty
> +			 * case (which is caused by failing to get buffer head
> +			 * lock), which will requeue dirty inodes and start
> +			 * next writeback iteration, and other tasks maybe
> +			 * stuck for getting tags for new requests. So, flush
> +			 * plug to schedule requests holding tags.
> +			 *
> +			 * The code can be removed after buffer head
> +			 * disappering from linux.
> +			 */
> +			blk_flush_plug(current->plug, false);

This basically removes plugging entirely, so we might as well stop
adding the plug if we can't solve it any other way.  But it seems
like that fake progress needs to be fixed instead.
