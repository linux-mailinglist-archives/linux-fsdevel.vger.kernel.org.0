Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE81ACDA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgDPQ1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 12:27:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDPQ1u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:27:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E9CFAB3D;
        Thu, 16 Apr 2020 16:27:48 +0000 (UTC)
Date:   Thu, 16 Apr 2020 18:27:48 +0200
From:   Daniel Wagner <dwagner@suse.de>
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
Message-ID: <20200416162748.4kgklej2tokhcuqy@carbon>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415090513.5133-2-johannes.thumshirn@wdc.com>
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
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I am not sure if the renaming should be part of this fix as it might
be something which should backported to stable.

Anyway, looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
