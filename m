Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8906A364887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhDSQvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 12:51:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhDSQvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:51:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10B3BB30F;
        Mon, 19 Apr 2021 16:50:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45999DA732; Mon, 19 Apr 2021 18:48:22 +0200 (CEST)
Date:   Mon, 19 Apr 2021 18:48:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Message-ID: <20210419164822.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
 <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210419093921.GA3226573@infradead.org>
 <BL0PR04MB65145DA8B6252C452EAA8BC9E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65145DA8B6252C452EAA8BC9E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 09:46:36AM +0000, Damien Le Moal wrote:
> On 2021/04/19 18:41, hch@infradead.org wrote:
> > On Mon, Apr 19, 2021 at 09:35:37AM +0000, Damien Le Moal wrote:
> >> This is only to avoid someone from running zoned-btrfs on top of dm-crypt.
> >> Without this patch, mount will be OK and file data writes will also actually be
> >> OK. But all reads will miserably fail... I would rather have this patch in than
> >> deal with the "bug reports" about btrfs failing to read files. No ?
> >>
> >> Note that like you, I dislike having to add such code. But it was my oversight
> >> when I worked on getting dm-crypt to work on zoned drives. Zone append was
> >> overlooked at that time... My bad, really.
> > 
> > dm-crypt needs to stop pretending it supports zoned devices if it
> > doesn't.  Note that dm-crypt could fairly trivially support zone append
> > by doing the same kind of emulation that the sd driver does.
> 
> I am not so sure about the "trivial" but yes, it is feasible. Let me think about
> something then. Whatever we do, performance with ZNS will no be great, for
> sure... But for SMR HDDs, we likely will not notice any difference in performance.

So this needs to be fixed outside of btrfs. The fix in btrfs would make
sense in case we can't sync the dm-crypt and btrfs in a released kernel.
Having a mount check sounds like a better option to me than to fail
reads, we can revert it in a release once everything woks as expected.
