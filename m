Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F901A2693
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgDHP6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 11:58:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgDHP6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oAqogE+V5Q1TOMO6tbbAOBvo7ACtrrNqebpjCh1+YRQ=; b=rPwRkbJUkguUUDUX1yDtZfFRCP
        XvCOUHbr46TvCbjBOtQ/ruTmM02aGsUbCGu2BbVWmMQFCs/B4yzrth4NOrqyjZiRNTn5Ib65L/yIV
        KhIyjyTUD3qaJ23vebM5d7j2K153xi6qBzHlW88q/6NWOMOxn/Q1jkcPRSPmgo7A5+ggF8qG9bY8Z
        xl2/chrCArwzZdDeHypSw/MioiKPH4Zgzz37NxwgaKfk85bzj2/aS1w/dMcOHdeIL0MqCwL6aPOKf
        NmdvHKGT5jq8Hd0W+BtisjtMWi/B8csiZ31/QR5UYf8Kg6e7jOuJLH5g3nr7EJq9Z+BLjma/CF3Qu
        T3DY9m/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMD6E-0007Zz-GO; Wed, 08 Apr 2020 15:58:46 +0000
Date:   Wed, 8 Apr 2020 08:58:46 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200408155846.GC29029@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-8-johannes.thumshirn@wdc.com>
 <20200407170501.GF13893@infradead.org>
 <CH2PR04MB6902DCA5A70BBC48B66951E3E7C00@CH2PR04MB6902.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6902DCA5A70BBC48B66951E3E7C00@CH2PR04MB6902.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:14:21AM +0000, Damien Le Moal wrote:
> 
> As we discussed before, if the user is not well behaving and issuing writes and
> zone reset/finish simultaneously for the same zone, errors will likely happen
> with or without the zone write locking being used on the reset/finish side. So I
> think we can safely remove the zone locking for reset and finish of a single
> zone. If an error happens, the error recovery report zone will update the wp
> offset. All we need is the spinlock for the wp_ofst update. So we can clean this
> up further and have this locking difference you point out going away.

Thanks, that's what I remembered from last time around and why I was
a little surprised we still had this code.
