Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4164F45A5A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 15:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhKWObi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 09:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhKWObi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:31:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF7C061574;
        Tue, 23 Nov 2021 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VdR8LLvBLWrqnrpdlyTKI+gDqZJrqlfeRGOFFJ7KOAo=; b=a9v27IUTrPvnQGKKXhGGsgPctQ
        4Z8wtGf8VWe8KjefD3bLO12QKeqz/ULQebrjab7+Cqz3DCAZ9X3K1dajOU/cJjqCrZSyElVWUBqBj
        Y6h33zMlARkXpf3FyiQKZakYB4b2ellOYLOJ2e5SLUHS7hnoJfAr0QXLpbrbYgrNn0D/qzyvoakp4
        ZnKYMD5+NF/sckuR+gIQ8F8oV/jBbNrElnxsHNeqxK/k14iMGzRfCSmiVxXn18G99Sl82O0KLjO7t
        uOkq8+nGSW3evlqr7JSZRncdXIOzLV1IK/1pWmNWJl60/bxT5r0tg2xCm1FzLtm+LCKBUtz5Nb5Nb
        XBAjLNfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpWma-002cKJ-SG; Tue, 23 Nov 2021 14:28:28 +0000
Date:   Tue, 23 Nov 2021 06:28:28 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Message-ID: <YZz6jAVXun8yC/6k@infradead.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:39:11AM +0000, Johannes Thumshirn wrote:
> I think we have to differentiate two cases here:
> A "regular" REQ_OP_ZONE_APPEND bio and a RAID stripe REQ_OP_ZONE_APPEND
> bio. The 1st one (i.e. the regular REQ_OP_ZONE_APPEND bio) can't be split
> because we cannot guarantee the order the device writes the data to disk. 
> For the RAID stripe bio we can split it into the two (or more) parts that
> will end up on _different_ devices. All we need to do is a) ensure it 
> doesn't cross the device's zone append limit and b) clamp all 
> bi_iter.bi_sector down to the start of the target zone, a.k.a sticking to
> the rules of REQ_OP_ZONE_APPEND.

Exactly.  A stacking driver must never split a REQ_OP_ZONE_APPEND bio.
But the file system itself can of course split it as long as each split
off bio has it's own bi_end_io handler to record where it has been
written to.
