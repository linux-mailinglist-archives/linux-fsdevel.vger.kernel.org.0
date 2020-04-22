Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD61B37C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDVGqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVGqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:46:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39478C03C1A6;
        Tue, 21 Apr 2020 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nO5S4Mem5T7AE8D4mNvpR/dKuA8HQ3I/M8cHAjY7mEY=; b=U6eAKM1P6raiQPKAXnGudvah86
        5gZxV3RZv7weXB3T5bcnf5Vff/nk95WpIrWBwL0wRbcBCWNQdxXk9JKaTQBP/ITpO/kCV7Lln3JEb
        KlsvzkxjkfHGyvnxBonxmkOE3NKRfBINQ9zkIHVWX4r0TRm5Si6BN6MTBJX3YHPhUsrTDVCPK2gfb
        Q/rBP8fcoSvOuyzcoEsK68mewrQDOoLyFZ8fMMJl9NPgv2Q3bXRp5hgObCjwsRCBoevCjA6vMUdEY
        7Wkwjdg1010GoY7qtTERi3sdWY1pymW2kvIe0vM15dFUaLD4/EnunTvcuh6kXqT0ZN/T7JIJhsdOE
        efUKkE/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR99S-0007e0-R6; Wed, 22 Apr 2020 06:46:30 +0000
Date:   Tue, 21 Apr 2020 23:46:30 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/11] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200422064630.GH20318@infradead.org>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-5-johannes.thumshirn@wdc.com>
 <373bc820-95f2-5728-c102-c4ca9fa8eea5@acm.org>
 <BY5PR04MB6900E3323E8FB58C8AB42D24E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6900E3323E8FB58C8AB42D24E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:30:25AM +0000, Damien Le Moal wrote:
> > 
> > Why the start sector instead of any sector in the target zone? Wouldn't
> > the latter make it easier to write software that uses REQ_OP_ZONE_APPEND?
> 
> We could do that, but we choose to have the interface match that of other zone
> operations (e.g. REQ_OP_ZONE_RESET/OPEN/CLOSE/FINISH) which also require the
> zone start sector.

It also would not simply anything.  The fs block allocator needs to pick
a zone, and the device picks the actual LBA,  So specifying any "random"
LBA in the zone would not actualy benefit the fs.
