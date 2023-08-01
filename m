Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38A76BD3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjHATFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjHATE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:04:58 -0400
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [IPv6:2001:41d0:1004:224b::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39C187;
        Tue,  1 Aug 2023 12:04:54 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690916693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfWGV5dMuNA+1k/g0x2HPi2H3e0sQoZ0G+P7Z3UTKNQ=;
        b=QQrRaj1ammrSYgVJVT6ObcpMXwgOV38s9kvPJfy82b5gHdJMp1WAsVtgLGKa65gpyvlcag
        WTqlG597lqZ+dZnqsaAGv3dUX4pFNtyr1eKaQyX/U5G9WR9ZUOPM6Ex+UFnw08PMzAzCLM
        kSbNMBV/jcYfsAtS0ja5nm2uT1jxcqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/20] block: Allow bio_iov_iter_get_pages() with
 bio->bi_bdev unset
Message-ID: <20230801190450.3lbr2hjdi7t52anx@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-6-kent.overstreet@linux.dev>
 <ZL62HKrAJapXfcaR@infradead.org>
 <20230725024312.alq7df33ckede2gb@moria.home.lan>
 <ZMEeOZZcOu2p0SDP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEeOZZcOu2p0SDP@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:23:05AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 10:43:12PM -0400, Kent Overstreet wrote:
> > Doing the blk-cgroup association at bio alloc time sounds broken to me,
> > because of stacking block devices - why was the association not done at
> > generic_make_request() time?
> 
> Because blk-cgroup not only works at the lowest level in the stack,
> but also for stackable block devices.  It's not a design decision I
> particularly agree with, but it's been there forever.

You're setting the association only to the highest block device in the
stack - how on earth is it supposed to work with anything lower?

And looking at bio_associate_blkg(), this code looks completely broken.
It's checking bio->bi_blkg, but that's just been set to NULL in
bio_init().

And this is your code, so I think you need to go over this again.

Anyways, bio_associate_blkg() is also called by bio_set_dev(), which
means passing the block device to bio_init() was a completely pointless
change. bcachefs uses bio_set_dev(), so everything is fine.
