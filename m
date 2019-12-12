Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5711D944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfLLWT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbfLLWT6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:19:58 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311EB2173E;
        Thu, 12 Dec 2019 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576189196;
        bh=6wqM/8nuJbTo8PW4nFbDaXSi3DHfDv/lnU1COiTALT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C76X7I0W/t6+u5063t1CUZHbu2JgTgOITbvJUNsHXwayJspBGLMpc+rJIUgo55wUs
         CrsJuLwBlLeAT5tyll96S6sUmKgWNFrH/Qy5R93yQVPUkyMy9R7ahMIrkh3jN3EcwY
         hifbQMvc3earqiuVJYueHl3lcBab6aVb05yEPy10=
Date:   Fri, 13 Dec 2019 07:19:47 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Message-ID: <20191212221947.GA32142@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:16:29AM +0000, Chaitanya Kulkarni wrote:
> * Current state of the work:-
> -----------------------------------------------------------------------
> 
> RFC implementations [3] has been posted with the addition of new IOCTLs
> which is far from the production so that it can provide a basis to get
> the discussion started.
> 
> This RFC implementation provides:-
> 1. Extended bits to track new trace categories.
> 2. Support for tracing per trace priorities.
> 3. Support for priority mask.
> 4. New IOCTLs so that user-space tools can setup the extensions.
> 5. Ability to track the integrity fields.
> 6. blktrace and blkparse implementation which supports the above
>     mentioned features.
> 
> Bart and Martin has suggested changes which I've incorporated in the RFC 
> revisions.
> 
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session for Storage track to go over the following
> discussion points:-
> 
> 1. What is the right approach to move this work forward?
> 2. What are the other information bits we need to add which will help
>     kernel community to speed up the development and improve tracing?
> 3. What are the other tracepoints we need to add in the block layer
>     to improve the tracing?
> 4. What are device driver callbacks tracing we can add in the block
>     layer?

I would like seeing driver/protocol specific tracepoint decoding for
users common under a single blkparse utility. For nvme, it'd be great if
we could set a fixed ABI, as people keep changing it by burdening the
kernel with making events more human readable. I'd prefer to simplify
the driver's tracepoints and do the decoding from userspace so that it's
forward compatible.

> 5. Since polling is becoming popular what are the new tracepoints
>     we need to improve debugging ?

Regarding polling, but not tracepoint related, but it'd be nice if
we had a new cpu state for this. Right now it just looks like all CPU
utilization from systat says 'system', which isn't really helpful with
analyzing how the hardware is doing.
