Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1A7605F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 04:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGYCpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 22:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGYCpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:45:01 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F081FC0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 19:44:32 -0700 (PDT)
Date:   Mon, 24 Jul 2023 22:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690252995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRlrLYqhm+DPWxs7qL0A08DMpLwzB/CFij0sa/3sknc=;
        b=VSIgW8uv8ZpGeForKyxp5LXrl5qslkkkhEn9qNjeG9qTCU4POVXOOYUylXGypZcMWWZmvn
        SdaODHDbZ5GG80ZkjdvF7HKp5q/RI24bsVi1BIh0WuEQjtnIo8Rs++eMnE9lKrB3BUaLoT
        OtPtHX4794EPxbB++CXEbjcq6hzLpD4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/20] block: Allow bio_iov_iter_get_pages() with
 bio->bi_bdev unset
Message-ID: <20230725024312.alq7df33ckede2gb@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-6-kent.overstreet@linux.dev>
 <ZL62HKrAJapXfcaR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL62HKrAJapXfcaR@infradead.org>
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

On Mon, Jul 24, 2023 at 10:34:20AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 05:11:00PM -0400, Kent Overstreet wrote:
> > bio_iov_iter_get_pages() trims the IO based on the block size of the
> > block device the IO will be issued to.
> > 
> > However, bcachefs is a multi device filesystem; when we're creating the
> > bio we don't yet know which block device the bio will be submitted to -
> > we have to handle the alignment checks elsewhere.
> 
> So, we've been trying really hard to always make sure to pass a bdev
> to anything that allocates a bio, mostly due due the fact that we
> actually derive information like the blk-cgroup associations from it.
> 
> The whole blk-cgroup stuff is actually a problem for non-trivial
> multi-device setups.  XFS gets away fine because each file just
> sits on either the main or RT device and no user I/O goes to the
> log device, and btrfs papers over it in a weird way by always
> associating with the last added device, which is in many ways gross
> and wrong, but at least satisfies the assumptions made in blk-cgroup.
> 
> How do you plan to deal with this?  Because I really don't want folks
> just to go ahead and ignore the issues, we need to actually sort this
> out.

Doing the blk-cgroup association at bio alloc time sounds broken to me,
because of stacking block devices - why was the association not done at
generic_make_request() time?
