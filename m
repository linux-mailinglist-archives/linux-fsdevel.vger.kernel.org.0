Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16B41A122D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDGQxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 12:53:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGQxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aQzvPY6P3iydskLOeavKdhj3BZ24WNCbamd1YLvtMc=; b=Yan50L4r4SH02Y5KjAnXeGPag/
        +C6OrFkmuVaIxuRx9Gq1tmwisY+drtt8SsLd8DqLQN4S3+affvR0Q08AkhRnoTJ00aqAiCEb8Ya+C
        Z/lSo+hRorpkqhJ4leGXhzZE6s1Y3cqIxhLDpnBxa+7XgIAUS3fKNaqV/zctg9k5u7tvj4ofA45xw
        SxX1ajMfELyo6wR4WfUBYTnbYCZwPFDwzakOqJdEJ5rQ+JkbxH8umtl1D3/0E5LxzFp6CGsnsrarl
        /659hgUV/4J52CGbBMcfFK4MwFqSLgD0plKszeGTNF490axLHoVp9wJWZglwsyKmsgzIyk0IPS7d9
        GBPW2R9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrTy-0007tO-KS; Tue, 07 Apr 2020 16:53:50 +0000
Date:   Tue, 7 Apr 2020 09:53:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 03/10] block: introduce blk_req_zone_write_trylock
Message-ID: <20200407165350.GC13893@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-4-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403101250.33245-4-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So this new callback is exectured just before blk_revalidate_zone_cb
returns and thus control is transferred back to the driver.  What
speaks against just implementing this logic after the callback returns?
->report_zones is not just called for validation, but does that matter?
If yes we can pass a flag, which still seems a bit better than a
code flow with multiple callbacks.
