Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8134165529C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiLWQPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 11:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWQPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:15:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611BC1B;
        Fri, 23 Dec 2022 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PUXaL81v9ixhveI1y9slD5wpL/BUpbYpH4I48L2Byhk=; b=A3MDzYNkq3o6prrVtTB3b9qUeX
        eicu7h8sY+r2OFexZ1eYtcAow7uE1pPUZYzjRPIFuMlUH3UhljDVufEzLCmVBSTvN83AGzKCfHJ69
        Is/MlPwCrTzXQ8ODunaOhmiCz91ncSeZOROYT4ERVpYzCEOIXDEmqGIql907H0iWYhrGXR2LF826x
        Z4Jt55d6hx4zb/N+8UKHYFskwnRFQIJxXd047bey1qRImDAoFbEnv0k+lfAu6Z+HDVEry9HBdMjAK
        R8uckQuHkB096HHkavZbVNMhNXNcjXZDWKRt4TmioIqs64KodSiYbWUOxmyAEVSAoVbxf3It5oCt1
        kbavMveg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8ki3-009sAa-2J; Fri, 23 Dec 2022 16:15:47 +0000
Date:   Fri, 23 Dec 2022 08:15:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] iomap: zeroing needs to be pagecache aware
Message-ID: <Y6XUM2aAvene63BJ@infradead.org>
References: <20221201005214.3836105-1-david@fromorbit.com>
 <Y4gMhHsGriqPhNsR@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4gMhHsGriqPhNsR@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 06:08:04PM -0800, Darrick J. Wong wrote:
> I've been wondering for a while if we ought to rename iomap_iter.iomap
> to write_iomap and iomap_iter.srcmap to read_iomap, and change all the
> ->iomap_begin and ->iomap_end functions as needed.

I'd do src vs dst, but yes, something like that is long overdue.
