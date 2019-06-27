Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953E35858B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfF0P2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 11:28:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfF0P2J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:28:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 726F6AC41;
        Thu, 27 Jun 2019 15:28:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4598EDA811; Thu, 27 Jun 2019 17:28:54 +0200 (CEST)
Date:   Thu, 27 Jun 2019 17:28:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED
 mode
Message-ID: <20190627152854.GC20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-8-naohiro.aota@wdc.com>
 <20190617223007.GI19057@twin.jikos.cz>
 <SN6PR04MB5231F5D34D067832760BF33A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB5231F5D34D067832760BF33A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:49:00AM +0000, Naohiro Aota wrote:
> On 2019/06/18 7:29, David Sterba wrote:
> > On Fri, Jun 07, 2019 at 10:10:13PM +0900, Naohiro Aota wrote:
> >> +	u64 unusable;
> > 
> > 'unusable' is specific to the zones, so 'zone_unusable' would make it
> > clear. The terminilogy around space is confusing already (we have
> > unused, free, reserved, allocated, slack).
> 
> Sure. I will change the name.
> 
> Or, is it better toadd new struct "btrfs_seq_alloc_info" and move all
> these variable there? Then, I can just add one pointer to the struct here.

There are 4 new members, but the block group structure is large already
(528 bytes) so adding a few more will not make the allocations worse.
There are also holes or inefficient types used so the size can be
squeezed a bit, but this is unrelated to this patchset.
