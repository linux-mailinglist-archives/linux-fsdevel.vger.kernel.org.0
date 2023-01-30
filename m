Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6317681727
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjA3RDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 12:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjA3RC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:02:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267CB41B44;
        Mon, 30 Jan 2023 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3D2LBhk0ee9VZ1vyd7o7msc10l9KOBjiq+HvWGjHznc=; b=BNn+ghufS26HSDtYA/tcWPDLRS
        fQ46Kg0vIQbNb5UXgQLVdq5o7/UdmtkF+Qqi2WjwKiOVGAze2QPc9sKwaVohoz+QQxmhhgAeQBPW2
        OIZ4HgYX2QnuLnsT+dZBw26g//LYYAfUw4VGJbT9kaw18jGehil7dMFAa0/fNw/U/tBRbrK/tAAXn
        HwPz0xJ4pNudiuRUqm+/FUbWEmBIXyM+FJ/gNz77BiVeiv5nazhwCUtUc6gbuVIxSZ0q7Te8MNsrE
        8tpxyrRo+dC2WVrlzPpcqGZTdfMddocagic84lds2QMFEA7p2acBQPDGvt0sekIbEtJqCWeJBaICY
        YGQfXnyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMXYG-004MJL-C8; Mon, 30 Jan 2023 17:02:40 +0000
Date:   Mon, 30 Jan 2023 09:02:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 1/3] iomap: Move creation of iomap_page early in
 __iomap_write_begin
Message-ID: <Y9f4MFzpFEi73E6P@infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:44:11PM +0530, Ritesh Harjani (IBM) wrote:
> The problem is that commit[1] moved iop creation later i.e. after checking for
> whether the folio is uptodate. And if the folio is uptodate, it simply
> returns and doesn't allocate a iop.
> Now what can happen is that during __iomap_write_begin() for bs < ps,
> there can be a folio which is marked uptodate but does not have a iomap_page
> structure allocated.
> (I think one of the reason it can happen is due to memory pressure, we
> can end up freeing folio->private resource).
> 
> Thus the iop structure will only gets allocated at the time of writeback
> in iomap_writepage_map(). This I think, was a not problem till now since
> we anyway only track uptodate status in iop (no support of tracking
> dirty bitmap status which later patches will add), and we also end up
> setting all the bits in iomap_page_create(), if the page is uptodate.

delayed iop allocation is a feature and not a bug.  We might have to
refine the criteria for sub-page dirty tracking, but in general having
the iop allocates is a memory and performance overhead and should be
avoided as much as possible.  In fact I still have some unfinished
work to allocate it even more lazily.
