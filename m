Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFBF707A37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjERGVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 02:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjERGVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 02:21:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737219BD;
        Wed, 17 May 2023 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phWYB9pxhNN/dJgPbIgKcf+9KXlKugQuKdMz/7U2dnM=; b=EGb/3+YtREeedv2XitKEIqPYGL
        4DBEZ2Zsy39SsUsT7lBjVaSNkSbxyYw6WpC3y7FO6pMCtdLUM4nhhqMqETE9zLAjEe7KmZX2ZjfZf
        451auakiSQA91zew4dQRI300Ey92sAdNtWgf5Xk/hJ0PFe3XZfzLPzGd1l4qhFvId+/v6SjXOOd/f
        vvw8ggMehlsPHYwpLSKQpUwSYdma4R08eeljsmB1Dq2k3IAbMJsi23/XU3GauYoaWyQZoroLN7P9h
        hnNV+d7I8aKmLYS36YnYzPp/bzFSr0n69u/jAwwUFnyruBffPM9Ayxc0MsY5fFeJddPBLcRyYuOnz
        o7CWcN2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzX17-00C3lW-1K;
        Thu, 18 May 2023 06:21:37 +0000
Date:   Wed, 17 May 2023 23:21:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 4/5] iomap: Allocate iop in ->write_begin() early
Message-ID: <ZGXD8T1Kv4NafQmO@infradead.org>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <e8401f45b8e441dc70effdb6b71fb67a3c92f837.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8401f45b8e441dc70effdb6b71fb67a3c92f837.1683485700.git.ritesh.list@gmail.com>
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

On Mon, May 08, 2023 at 12:57:59AM +0530, Ritesh Harjani (IBM) wrote:
> Earlier when the folio is uptodate, we only allocate iop at writeback

s/Earlier/Currently/ ?

> time (in iomap_writepage_map()). This is ok until now, but when we are
> going to add support for per-block dirty state bitmap in iop, this
> could cause some performance degradation. The reason is that if we don't
> allocate iop during ->write_begin(), then we will never mark the
> necessary dirty bits in ->write_end() call. And we will have to mark all
> the bits as dirty at the writeback time, that could cause the same write
> amplification and performance problems as it is now.
> 
> However, for all the writes with (pos, len) which completely overlaps
> the given folio, there is no need to allocate an iop during
> ->write_begin(). So skip those cases.

This reads a bit backwards, I'd suggest to mention early
allocation only happens for sub-page writes before going into the
details.

The changes themselves looks good to me.

