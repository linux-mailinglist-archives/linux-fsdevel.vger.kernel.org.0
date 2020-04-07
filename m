Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D41A1257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDGRAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 13:00:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgDGRAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tNQyfLNqU7qCmNq/0+xe1GL3GGWyC9mTyT5OlXwK0m4=; b=bakfM/P/xOizKiA8X5AI2xLblY
        gfjtaDUNBOpMH+vk6LEPrmqbcWyNok0q/l0PsH2yuWaXTYO2h36KgEWAEURHw8jEU9k0PeaAFLSW7
        8T3hsawgUZlOhWZWoaeykIqe2gUqBt8e5lpBhspfrpX5HRc9dntZycXIwNHD34cCEh0cZj91HFWoK
        RidTkNviXCkwkusXlZgyE2n0fpUG/7nrwmeLILhQm4wEU1rspjeRdMZToZ2+1EGtt2hSIP70+ovRU
        zvhPORNramRiNvlMIMMDIpStu2p2gzGHikgZCKNhlu2Gitdz5njHqSjPvt9LExf2K5J2MIGKv/Zco
        QyKTdlwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrai-0005bP-NN; Tue, 07 Apr 2020 17:00:48 +0000
Date:   Tue, 7 Apr 2020 10:00:48 -0700
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
Subject: Re: [PATCH v4 06/10] scsi: export scsi_mq_uninit_cmnd
Message-ID: <20200407170048.GE13893@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403101250.33245-7-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:12:46PM +0900, Johannes Thumshirn wrote:
> scsi_mq_uninit_cmnd is used to free the sg_tables, uninitialize the
> command and delete it from the command list.
> 
> Export this function so it can be used from modular code to free the
> memory allocated by scsi_init_io() if the caller of scsi_init_io() needs
> to do error recovery.

Hmm.  scsi_mq_uninit_cmnd does three things:

 - calls ->uninit_command, but that is something the driver can
   trivially do itself.
 - scsi_mq_free_sgtables - yes, this would need to be done by the driver
   and actually is what undoes scsi_init_io.  I think you want to export
   this instead (and remove the _mq in the name while you are at it)
 - scsi_del_cmd_from_list - this undoes scsi_add_cmd_to_list, which
   is not related to what the upper level driver does
