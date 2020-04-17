Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748771ADCE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgDQMHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:47050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDQMHP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D9FDAD83;
        Fri, 17 Apr 2020 12:07:13 +0000 (UTC)
Date:   Fri, 17 Apr 2020 14:07:12 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200417120712.wmqnz4vpfjgzmprl@carbon>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-5-johannes.thumshirn@wdc.com>
 <20200417074228.jxqk2znfqjfhrwf2@carbon>
 <SN4PR0401MB35987433364CCC2F8BEE7E689BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987433364CCC2F8BEE7E689BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 08:42:12AM +0000, Johannes Thumshirn wrote:
> On 17/04/2020 09:42, Daniel Wagner wrote:
> > Stupid question. At the end of this function I see:
> > 
> > 	/*
> > 	 * If the host/device is unable to accept more work, inform the
> > 	 * caller of that.
> > 	 */
> > 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
> > 		return false;
> > 
> > Why is BLK_STS_ZONE_RESOURCE missing?
> 
> Because technically the device can still accept more work, it is just 
> the zone-write lock for one (or more) zone(s) is locked. So we can still 
> try to dispatch work to the device, like reads or writes to other zones 
> in order to not starve any readers or writers to different zones.

Okay thanks for explaining.

As far as I can review it, it looks good. The code matches the commit message.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
