Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585058F39E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiHJUoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 16:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHJUoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:44:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F06D54A;
        Wed, 10 Aug 2022 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2OvXf0xNBrC73fYE6Jm87Hbjynk6ZxeWJjR7VarX35Q=; b=gEODEB38kcppLQMxi1gGLTBcNG
        vPtqrQGHUkRiR6z40NXWr6mQEaG3SCllkR8BBz+NuAzZ/I6GTwxDhNTjm8LaKwLb9ot7PcDUfeP9B
        4jA/9I21BcJiJe7B4ei0IH4v89wLgUTUg5XzPxirgD54exk/8BVbhpqQ/PyBX1m2R1tOT4StHcoM3
        Tt6EyPgywRfMynTOoUS8fQ7wJF5nKTT2Rd20wh4a35VEEyFqpF0DnNkcN/DQrhVZ5ILVVspTxWy9L
        thdCit1bkMPm62iZTi56/jdjicr6r5syVPMQKtbZyuKGA8cEQUry1MujjCCyMsPnMT4BorAjTFVHj
        K/iU4Rag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLsYY-00HF0P-FL; Wed, 10 Aug 2022 20:43:58 +0000
Date:   Wed, 10 Aug 2022 21:43:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove iomap_writepage v2
Message-ID: <YvQYjpDHH5KckCrw@casper.infradead.org>
References: <20220719041311.709250-1-hch@lst.de>
 <20220728111016.uwbaywprzkzne7ib@quack3>
 <20220729092216.GE3493@suse.de>
 <20220729141145.GA31605@lst.de>
 <Yufx5jpyJ+zcSJ4e@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yufx5jpyJ+zcSJ4e@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:31:50AM -0400, Johannes Weiner wrote:
> XFS hasn't had a ->writepage call for a while. After LSF I internally
> tested dropping btrfs' callback, and the results looked good: no OOM
> kills with dirty/writeback pages remaining, performance parity. Then I
> went on vacation and Christoph beat me to the patch :)

To avoid duplicating work with you or Christoph ... it seems like the
plan is to kill ->writepage entirely soon, so there's no point in me
doing a sweep of all the filesystems to convert ->writepage to
->write_folio, correct?

I assume the plan for filesystems which have a writepage but don't have
a ->writepages (9p, adfs, affs, bfs, ecryptfs, gfs2, hostfs, jfs, minix,
nilfs2, ntfs, ocfs2, reiserfs, sysv, ubifs, udf, ufs, vboxsf) is to give
them a writepages, modelled on iomap_writepages().  Seems that adding
a block_writepages() might be a useful thing for me to do?

