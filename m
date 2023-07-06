Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661574A119
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGFPfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjGFPfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:35:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61A171D;
        Thu,  6 Jul 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RbpdB6gvyw7jB8AtoGNLM8ZSm6EeJSVtSz8r9CUiF40=; b=z2QWXDTBBus8YxEK06DH8Xkn8w
        bAZ/G+Oh9UKEq0trlxS1+5lbnR46jrio4vxvj0bdiJ79QSWxldCxePGDB4nsDSxcJTzklnV6feN86
        VHoV02PL0asp+amvqefOaLpbSDOCe18PYIRubxJmo8jEnUfk058zaUqt4D/7E3mE9U1fVTArP/xa5
        hbFNjMMFoySkHLmmaiC/rLkCYg9qq/ZdXM/s88urScWmcBodqHRbfIptKixX1c2IKyzBcM4QiEYcr
        AvdjIiqo5HChL4D5WnJKEkMQy9w8+SgKHamowsRDUYCqoj3GfjjtcQSwcOYF1YI6rYwDVoksC12ko
        gCS9MzQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHR0t-0021Ze-0P;
        Thu, 06 Jul 2023 15:35:23 +0000
Date:   Thu, 6 Jul 2023 08:35:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/32] block: Use file->f_flags for determining exclusive
 opens in file_to_blk_mode()
Message-ID: <ZKbfO5eFJ9hVueb/@infradead.org>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704122224.16257-2-jack@suse.cz>
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

On Tue, Jul 04, 2023 at 02:21:29PM +0200, Jan Kara wrote:
> Use file->f_flags instead of file->private_data for determining whether
> we should set BLK_OPEN_EXCL flag. This allows us to remove somewhat
> awkward setting of file->private_data before calling file_to_blk_mode()
> and it also makes following conversion to blkdev_get_handle_by_dev()
> simpler.

While this looks a lot nicer, I don't think it actually works given that
do_dentry_open clears out O_EXCL, and thus it won't be set when
calling into blkdev_ioctl.
