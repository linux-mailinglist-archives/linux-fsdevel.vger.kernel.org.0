Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16561AC17B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635923AbgDPMki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635882AbgDPMkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:40:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C2C061A0C;
        Thu, 16 Apr 2020 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gEnaWlGS84NierZI6llqCDgBNTWLatCjCR9GTHoMdEQ=; b=JX4i7xSLoqFZNQ+NeEVHTtjLaG
        M1qAv+7ijEnvLN4aBijenT56nR/7ThCEkCaCgwERPOWnebL4kP8evXQW/+fb0UoTBx1CIu05BBa2Q
        x5b9ct51aYnL8kPghel4aG1aPcVo2s3X5aYvlrKny35Cn6lZy7MZnDbiJrj/n4TNiqq334mvodm/s
        a2UC5owuWTYkfRUkyH0rPPSPBzsTwVaC3tO2WQkCm65LxAxRllcj1zYMADZH3xhnEy7z5bsx7YFzo
        6MRaPSyW+89j6WJROdkFIRP5WgpP10kuevf6eZ8AWxZA7/qVESQXqJMQv2mLtAUs0NUv4RkfP1Xge
        j3gJTPbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP3oR-0000jv-9k; Thu, 16 Apr 2020 12:40:11 +0000
Date:   Thu, 16 Apr 2020 05:40:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] scsi: free sgtables in case command setup fails
Message-ID: <20200416124011.GA23647@infradead.org>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415090513.5133-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:05:03PM +0900, Johannes Thumshirn wrote:
> In case scsi_setup_fs_cmnd() fails we're not freeing the sgtables
> allocated by scsi_init_io(), thus we leak the allocated memory.
> 
> So free the sgtables allocated by scsi_init_io() in case
> scsi_setup_fs_cmnd() fails.
> 
> Technically scsi_setup_scsi_cmnd() does not suffer from this problem, as
> it can only fail if scsi_init_io() fails, so it does not have sgtables
> allocated. But to maintain symmetry and as a measure of defensive
> programming, free the sgtables on scsi_setup_scsi_cmnd() failure as well.
> scsi_mq_free_sgtables() has safeguards against double-freeing of memory so
> this is safe to do.
> 
> While we're at it, rename scsi_mq_free_sgtables() to scsi_free_sgtables().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
