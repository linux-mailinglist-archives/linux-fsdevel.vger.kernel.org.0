Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158FD536368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349721AbiE0NpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiE0NpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 09:45:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9149251
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kRAMak/QMX+Vy1vstuhkTyCxrdSHGLmOpRl1L9RhyIk=; b=IBVCMTh4DSp8VWNHxHqBtbgpEK
        GqoBHOYOA5U1NpQqYxp6XkELquuFW/y3sefcr3VgxPu/TQJw0qq4lK+y9rWc2ZQ5DAso7ziUT9jjs
        TCrzq93jiPI+5fFIPCCqCHDsG8FXruErDDTwYN0LdzLaaa6KhGxHAceWspCb9rVolLTUBnXEV/9CM
        tU4NtzNzVhY3+I/2C7Y4v8H3OD/K3qkpuiMAwz7BIYzW+WfQ4vYc+rt2mtBdThvingPLo+POPIsJ3
        LMSdczqXhqtY8wSEfJvzkwZ47DaxGo3R3YMS3wcoGbucKSDDuAhZQaNtvFeboC+sZarWRD76ZAfMk
        QZk29+wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuaHA-0028JT-S6; Fri, 27 May 2022 13:45:12 +0000
Date:   Fri, 27 May 2022 14:45:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 2/9] jfs: Add jfs_iomap_begin()
Message-ID: <YpDV6NPBefdYRywi@casper.infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-3-willy@infradead.org>
 <YpBkiy4zvIcEXihd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpBkiy4zvIcEXihd@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 10:41:31PM -0700, Christoph Hellwig wrote:
> I suspect this might be where your problems lies:
> 
> blockdev_direct_IO calls __blockdev_direct_IO with DIO_SKIP_HOLES set.
> DIO_SKIP_HOLES causes get_more_blocks to never set the create bit
> to get_block except for writes beyond i_size.  If we want to replicate
> that behavior with iomap, ->iomap_begin needs to return -ENOTBLK
> when it encounters a hole for writing.  To properly supporting writing
> to holes we'd need unwritten extents, which jfs does not support.
> gfs2 might be a place to look for how to implement this.

I think JFS does support unwritten extents,
fs/jfs/jfs_xtree.h:#define XAD_NOTRECORDED 0x08 /* allocated but not recorded */

However, we always pass 'false' to extAlloc() today, so I think it
hasn't been tested in a while?  I'm not sure I want to be the one to
start using new features on JFS for something that's supposed to be
a relatively quick cleanup.
