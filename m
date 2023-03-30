Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B4C6CF7EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 02:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjC3AHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 20:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3AHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:07:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B6D2D48
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rwMt1maB7wSTZDfeA4csimMdI6qbfeQEBXDonI4XTu0=; b=lS1zLOw52xlpeQeOjZrkgJR8Rf
        G7AaelxIvh4LskD8r/WVRv6TTmWTj7uXQjHWcOy0ej1IERKYBXygXyMt0WdO4uuG6KbJYwYUQ7GlM
        OWJjurrSAIQO8QDCzaODZ8xB65+X0Jgq0uhrJuaW959zcNzYlBpt+Oh/BY9ObkgqQBTv7ajKOI1aN
        g1z41vTMnbZHn47DO+UX0Z8QZmapbi7yMQ/9VaApEtWUrPpQgUhOrIJg3Z4COzqWfLPrP9T85hLw7
        Qp/Uxf8RHkTHQ/NVEJxHroHogzBtBUp2mqwUYlHPxxiIINzIPIRh7J1h1hYnFv2snWR4oeCO9QmVw
        83rV6T5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfpK-0027Qz-2J;
        Thu, 30 Mar 2023 00:07:38 +0000
Date:   Wed, 29 Mar 2023 17:07:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
Message-ID: <ZCTSyqspQ9bEGA15@infradead.org>
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
 <ZCPzbFzjFyiOVDdl@infradead.org>
 <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
 <ZCTLi+TByEjPIGg5@infradead.org>
 <dbfe808d-1321-b043-6904-2d1c87575908@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfe808d-1321-b043-6904-2d1c87575908@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 08:57:56AM +0900, Damien Le Moal wrote:
> Not sure what you mean here. "iomap-using path fix" ?
> Do you mean adding a comment about the fact that zonefs does not fallback to
> doing buffered writes if the iomap_dio_rw() or zonefs dio append direct write fail ?

Making sure that the odd ENOTBLK error code does not leak to userspace
for this case on zonefs.
