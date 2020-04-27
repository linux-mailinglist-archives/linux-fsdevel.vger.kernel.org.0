Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC761BA2F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgD0Lww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:52:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0Lww (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:52:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1C237AB89;
        Mon, 27 Apr 2020 11:52:49 +0000 (UTC)
Subject: Re: [PATCH v8 01/11] scsi: free sgtables in case command setup fails
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-2-johannes.thumshirn@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bd91d878-b20f-4064-81d8-ad0d345382a5@suse.de>
Date:   Mon, 27 Apr 2020 13:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427113153.31246-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 1:31 PM, Johannes Thumshirn wrote:
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
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205595
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/scsi/scsi_lib.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
