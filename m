Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDD6EB2CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjDUUPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 16:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjDUUPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:15:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E82719;
        Fri, 21 Apr 2023 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7jDGoKVRVE8/8Iw2EXqkPonvmAc0gvYRAzqps4fjwwg=; b=mr+zjn1yXtzKk4APmgRaOn77YC
        qyrdJusW0V5fFBehp0H4LgJmcOzWB0HiZ/19FHS9XzMMBWYiQQiK2ov9vzahR7YBu95NK76q9JJZs
        AkLKN4MUKm/MQ5+LZ/SLYHWNNTKsZIr04BKzck1FGkgdltQkKD7lNhCvCFoMTcFExtsIMgiMKVPre
        m9Im6jnJmlKaq2x+wCYrcuNfTZjtNWDTsZNJmxJoZAgKC50KnsIBoeDx/zoi7hd2VV9XP++ihIvTA
        tOEZ5yH+/ubaSmLHWmwzD23OC6iMGfb2/N5vqIvhKd4FYrTP8/q/0FOd4KBWDZDlc9qXT016NGn1F
        NwwreEtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppxA3-00FZsC-AG; Fri, 21 Apr 2023 20:15:15 +0000
Date:   Fri, 21 Apr 2023 21:15:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        hare@suse.de, p.raghav@samsung.com, da.gomez@samsung.com,
        kbusch@kernel.org
Subject: Re: [PATCH 1/5] dm integrity: simplify by using PAGE_SECTORS_SHIFT
Message-ID: <ZELu017UCTZWrCjv@casper.infradead.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421195807.2804512-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:58:03PM -0700, Luis Chamberlain wrote:
> -	*pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
> +	*pl_index = sector >> (PAGE_SECTORS_SHIFT);

You could/should remove the () around PAGE_SECTORS_SHIFT

(throughout)
