Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836F873962B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 06:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFVEIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 00:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjFVEIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:08:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE71BDA;
        Wed, 21 Jun 2023 21:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VHct6KpsbWHWIj6IoNv83jCmcVA22kr6p9gJJdV1aoM=; b=bzJo6uYDrIqm90UIvjciQYasWq
        CCx+ab9SRXCVk+MacTPF805gp2u4fLWkl1Z/wsreRi8N4KP81wA9koxdz7FqtjRT8Fupod/9yskDf
        uiuhogPedh+4hWZBmcxW+iX+KSltn5zqUEBEuUULLW5AbQZihlTMddNezY7JlBSOtSE1jkOW7Hy0L
        59Gt8NA470yYq6hUq8Ncu4Et3aXxvdmf62kQKpsCej1gjP9KOD8xlcqErrfhHCCGddn6GsUWOSPia
        X7HEs3mtmL2fwNieAULkUEyDgjvNQ13mwSb6cMZt+H7ggO1RSLRhF79Fhj7M0nVucVQAiXTRN5bcE
        cM3Ba9Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qCBc3-00Gkel-0O;
        Thu, 22 Jun 2023 04:08:03 +0000
Date:   Wed, 21 Jun 2023 21:08:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/1] iomap regression for aio dio 4k writes
Message-ID: <ZJPJI1t/wdj/L1W2@infradead.org>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <ZJOO4SobNFaQ+C5g@dread.disaster.area>
 <ZJOqC7Cfjr5AoW7S@dread.disaster.area>
 <ZJO4OAYhJlXOBXMf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJO4OAYhJlXOBXMf@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 03:55:52AM +0100, Matthew Wilcox wrote:
> Latency is important for reads, but why is it important for writes?
> There's such a thing as a dependent read, but writes are usually buffered
> and we can wait as long as we like for a write to complete.

That was exactly my reasoning on why I did always defer the write
completions in the initial iomap direct I/O code, and until now no
one has complained.

I could see why people care either about synchronous writes, or polled
io_uring writes, for which we might be able to do the work in the
completion thread context, but for aio writes this feels a bit odd.
