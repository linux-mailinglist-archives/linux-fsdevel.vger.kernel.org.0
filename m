Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3AF75FDBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGXRbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXRbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:31:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB30E1;
        Mon, 24 Jul 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FilRVP5bIdReycpGXPo+d2Y8wo2WCLjMqoFkGhMrdKo=; b=aCinILooTQROh4/AvSE4/BWUnI
        NxeicWVpuH5BySDSP7ADqbclwYVtL2OW9p0XOZEj4uDwzlzuFumO0c6k/GVb1ygAuEGXhiRvHfSYg
        1YRL8FzXM2X6skCEH+BJmR7VSfdX1hF/f5zsO6Aw8RoxQBZ7Mqv8M761HQTslyk4yxjLqu67ln9Ge
        vtlf2yjM2or6LfOrpvb2f6w2Dd3zYzALmZbTwlp5hAwt7N/F6tFAIqtVvNpboEso7kTROiG616cOE
        O6jCUWkbpTZj0ooyHrGbJ46/SKtqKCGckVyufxDleejKft+uxavehekRZ1uAC60511+uGBigZvEXn
        Z8r5/crg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNzOj-0053r0-01;
        Mon, 24 Jul 2023 17:31:05 +0000
Date:   Mon, 24 Jul 2023 10:31:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/20] block: Add some exports for bcachefs
Message-ID: <ZL61WIpYp/tJ6XH1@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-5-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211115.2174650-5-kent.overstreet@linux.dev>
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

On Wed, Jul 12, 2023 at 05:10:59PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
>  - bio_set_pages_dirty(), bio_check_pages_dirty() - dio path

Why?  We've so far have been able to get away without file systems
reinventing their own DIO path.  I'd really like to keep it that way,
so if you think the iomap dio code should be improved please explain
why.  And please also cycle the fsdevel list in.

>  - blk_status_to_str() - error messages
>  - bio_add_folio() - this should definitely be exported for everyone,
>    it's the modern version of bio_add_page()

These look ok to me to go in when the actual user shows up.
