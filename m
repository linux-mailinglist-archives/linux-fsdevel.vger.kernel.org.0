Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70977A4CD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjIRPmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRPmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:42:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20A188;
        Mon, 18 Sep 2023 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fouKrDKKt6aBJ1Dc7SZubYvnayge8ritkFh73nhsd4Q=; b=UZIQNYhRDQTdkBDYOcz0+SM+gy
        PhbgdFp3PR3FZmJkJRm8QhxP+lhCo7mj5i3ONdaDEiJvZdlSZ65qos6zjkF3whhbuQDtydXheCbMj
        vac5GX7N7rNPLLBPb1uQAe4xEnEo73pCNJaeW998jYdNxWgG1aQMvsDzYSSosgmRD16wa6CQA8mIo
        djZq2mb+j1ArpIUxl59UjXY5pf09nJnH+uuGm5Ijk85WToAZetMfFNKb98Ego2nh+HdWmYX9AxEaH
        fxqoKqY+l5j/I5kKigBh+pUrixJ9g1WH+/KSDxoNXnViVqzjxirqs8Ex7APTmlfwhvOHv5UE6WeL1
        QxweI1+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiEnK-00BN1a-1b; Mon, 18 Sep 2023 14:00:10 +0000
Date:   Mon, 18 Sep 2023 15:00:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/18] fs/buffer: use mapping order in grow_dev_page()
Message-ID: <ZQhX6Zt5iqZp4GJ0@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-10-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-10-hare@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:05:01PM +0200, Hannes Reinecke wrote:
> Use the correct mapping order in grow_dev_page() to ensure folios
> are created with the correct order.

I see why you did this, but I think it's fragile.  __filemap_get_folio()
will happily decrease 'order' if memory allocation fails.  I think
__filemap_get_folio() needs to become aware of the minimum folio
order for this mapping, and then we don't need this patch.

Overall, I like bits of this patchset and I like bits of Pankaj's ;-)
