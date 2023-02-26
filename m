Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C526A35BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 00:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBZX4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 18:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZX4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:56:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C98B778;
        Sun, 26 Feb 2023 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lW/wg0tYOwtLe0fNlN6RQV8MoXm3XvvaM7RX+PB1rcs=; b=lSotNIKPYNfB5PJj+GkIPEoJUB
        0Z9PKPCPfNhtzehHRbbduhjQCIPTGpGmTB1sPWXK7II8VN4kbpkOmvMfpDGPPpO9lVpTIPyb/8RHj
        7WAwR6pmxfI4Rp8gk6wri9CdVkTzdmPfqVuZVQ2aUKt5B0kkA3z/7Xlloe02SjdkQtqi5A/FFcPiJ
        +jTTCvOerM7ZzcrNWX3n+fmKE0NkkieSUjLJl/0T4hOqt5EDYFzAZEIMEP8QsO7MBBcK+A6to9CQf
        MatDBURKJT3apaTrZ+/OTmQBtQuIcfh9+HNx7B23Cs8bKNjg6B6E1OdGt0qTlE2nP5FcjyFctW/Iy
        jYAYQw5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWQs9-00HFcc-8k; Sun, 26 Feb 2023 23:56:05 +0000
Date:   Sun, 26 Feb 2023 23:56:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv3 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <Y/vxlVUJ31PZYaRa@casper.infradead.org>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
 <20230226234814.GX360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226234814.GX360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:48:14AM +1100, Dave Chinner wrote:
> > +static void iomap_iop_set_range_dirty(struct folio *folio,
> > +		struct iomap_page *iop, size_t off, size_t len)
> > +{
> > +	struct inode *inode = folio->mapping->host;
> > +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> > +	unsigned first = (off >> inode->i_blkbits);
> > +	unsigned last = ((off + len - 1) >> inode->i_blkbits);
> 
> first_bit, last_bit if we are leaving this code unchanged.

first_blk, last_blk, surely?
