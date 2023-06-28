Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB17417A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjF1R5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjF1R4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:13 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF354268F
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:56:12 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687974971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBGaxPtQD+VgN+yGUO6F8SkYlDQO4TCybQMg52Fv3fA=;
        b=wyCiSsVPZVSHBvzuj1eIjqFjddFTH3Q6bXpYPGewy5UvoLOME2rGT4DHsf7gJhJIQosSl4
        4GbeoZqNq1wevSn/3BA3nylnTtTFChQ4MxP15m6uIdjqLa9Nv+SGTsnfvlqcRAjj3Ff8+/
        oC2Xk0mAEKHoQ8TVd5j3KWLijS8wdBE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628175608.hap54mrx54owdkyg@moria.home.lan>
References: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <03308df9-7a6f-4e55-40c8-6f57c5b67fe6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03308df9-7a6f-4e55-40c8-6f57c5b67fe6@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:22:15AM -0600, Jens Axboe wrote:
> On 6/28/23 8:58?AM, Jens Axboe wrote:
> > I should have something later today, don't feel like I fully understand
> > all of it just yet.
> 
> Might indeed be delayed_fput, just the flush is a bit broken in that it
> races with the worker doing the flush. In any case, with testing that, I
> hit this before I got an umount failure on loop 6 of generic/388:
> 
> fsck from util-linux 2.38.1
> recovering from clean shutdown, journal seq 14642
> journal read done, replaying entries 14642-14642
> checking allocations
> starting journal replay, 0 keys
> checking need_discard and freespace btrees
> checking lrus
> checking backpointers to alloc keys
> checking backpointers to extents
> backpointer for missing extent
>   u64s 9 type backpointer 0:7950303232:0 len 0 ver 0: bucket=0:15164:0 btree=extents l=0 offset=0:0 len=88 pos=1342182431:5745:U32_MAX, not fixing

Known bug, but it's gotten difficult to reproduce - if generic/388 ends
up being a better reproducer for this that'll be nice
