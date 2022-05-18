Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5452BD72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiERNrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiERNrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 09:47:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9350D1A6AF2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bI6DAj8BnzIOFTFpVrTbk+sZVN0ow/TyH8efs7qJatY=; b=Ev+FHLouBo0xlEgt+mjGdhPM48
        wElqVNs86ae+FclSxaGvqAfUNM+vA45l0Nxda4A9SB4AtGJHIODXSN61GF6eybZcragS808/2X0wd
        7aWymxiuT9OO16Wcxwkvl0nktRjsbSn//e8RkC6IYqgyFMxCF3VBlc1uRuCJbx39qAaGLFbR5Y872
        H+gLO/B/3SC0EMBhbhn9CO1ZNS1UeOfdMLaHPGdH0YM/a/24VwPSCM/GlVWh/ww77L947DcWAPGuM
        OFCnWfLzhnaffr5fxIN33qG+A7ppxXfC9ipU9P1lEgaBmtuuFJXVT3z9189CGbjOByCMNAnGiY9bx
        iyWVeb0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrK1W-002MQI-3Z; Wed, 18 May 2022 13:47:34 +0000
Date:   Wed, 18 May 2022 06:47:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        jmoyer@redhat.com, jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH v2] fs: Fix page cache inconsistency when mixing buffered
 and AIO DIO for bdev
Message-ID: <YoT49tEhHu8uMUt2@infradead.org>
References: <20220507041033.9588-1-lchen@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507041033.9588-1-lchen@localhost.localdomain>
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

On Sat, May 07, 2022 at 12:10:33PM +0800, Liang Chen wrote:
> From: Liang Chen <liangchen.linux@gmail.com>
> 
> As pointed out in commit 332391a, mixing buffered reads and asynchronous
> direct writes risks ending up with a situation where stale data is left
> in page cache while new data is already written to disk. The same problem
> hits block dev fs too. A similar approach needs to be taken here.

What is the real issue here?  If you mix direct and buffered I/O
you generally get what you pay for.  Even more so on block devices that
don't even follow Posix file system semantics.
