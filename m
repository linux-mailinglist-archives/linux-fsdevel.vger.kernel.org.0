Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38F3707A1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjERGNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 02:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjERGNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 02:13:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5DFE52;
        Wed, 17 May 2023 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUXAJM70NL/Fd5rldq4mZ1aqp0fhWfHkm4c4mJHbDSA=; b=EBU9eSZ1dH5VaE7cg8KlYcTF9h
        7m1KKHh/K1aPmWrxxrgbnkbUORpsrjPEhCJ+tADU2x06HzxL7hV1Fex0G+NveA2elz1YBfT/TxRT9
        /5K+Jmz99LuASie2VQgfAvcSyCrlT6EsFYP6z2MLF4zTrIBIpfXTMkJOLx6ILZgt2hNAos0X4Ib/h
        mrutpAU5XaMvWpWfZeE1MLEvuLbqkQoDiBNDGIo4/YMKWXZzajUicub2WpvOfrB8OLb5DgaJ4mMLF
        6oA+dLO4p5jS4l3WHI8yLwy1Uw8Q0LOEWdQSd90h1CfyY9hHDBRPbW3i8mVJpkOvNeNCJeLqD6qBo
        ZXyqZxBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWtG-00C2eQ-0w;
        Thu, 18 May 2023 06:13:30 +0000
Date:   Wed, 17 May 2023 23:13:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 1/5] iomap: Rename iomap_page_create/release() to
 iop_alloc/free()
Message-ID: <ZGXCCoGFXhtcbkBX@infradead.org>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <03639dbe54a0a0ef2bd789f4e8318df22a4c5d12.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03639dbe54a0a0ef2bd789f4e8318df22a4c5d12.1683485700.git.ritesh.list@gmail.com>
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

On Mon, May 08, 2023 at 12:57:56AM +0530, Ritesh Harjani (IBM) wrote:
> This patch renames the iomap_page_create/release() functions to
> iop_alloc/free() calls. Later patches adds more functions for
> handling iop structure with iop_** naming conventions.
> Hence iop_alloc/free() makes more sense.

I can't say I like the iop_* naming all that much, especially as we
it is very generic and we use an iomap_ prefix every else.

> Note, this patch also move folio_detach_private() to happen later
> after checking for bitmap_full(). This is just another small refactor
> because in later patches we will move bitmap_** helpers to iop_** related
> helpers which will only take a folio and hence we should move
> folio_detach_private() to the end before calling kfree(iop).

Please don't mix renames and code movements.
