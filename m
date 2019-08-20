Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326E695F6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfHTNF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 09:05:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbfHTNFZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:05:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76112AE42;
        Tue, 20 Aug 2019 13:05:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 56B46DA7DA; Tue, 20 Aug 2019 15:05:50 +0200 (CEST)
Date:   Tue, 20 Aug 2019 15:05:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Hannes Reinecke <hare@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Message-ID: <20190820130419.GP24086@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Hannes Reinecke <hare@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-4-naohiro.aota@wdc.com>
 <edcb46f5-1c3e-0b69-a2d9-66164e64b07e@oracle.com>
 <BYAPR04MB5816FCD8F3A0330C8B3DC609E7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <86ef7944-0029-3d61-0ae3-874015726751@oracle.com>
 <20190820050737.ngyaamjkdmzvhlqj@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820050737.ngyaamjkdmzvhlqj@naota.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:07:37PM +0900, Naohiro Aota wrote:
> >>>>cannot be located over sequential zones and there is no guarantees that the
> >>>>device will have enough conventional zones to store this cache. Resolve
> >>>>this problem by disabling completely the space cache.  This does not
> >>>>introduces any problems with sequential block groups: all the free space is
> >>>>located after the allocation pointer and no free space before the pointer.
> >>>>There is no need to have such cache.
> >>>>
> >>>>For the same reason, NODATACOW is also disabled.
> >>>>
> >>>>Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
> >>>>INODE_MAP_CACHE inode.
> >>>
> >>>   A list of incompatibility features with zoned devices. This need better
> >>>   documentation, may be a table and its reason is better.
> >>
> >>Are you referring to the format of the commit message itself ? Or would you like
> >>to see a documentation added to Documentation/filesystems/btrfs.txt ?
> >
> > Documenting in the commit change log is fine. But it can be better
> > documented in a listed format as it looks like we have a list of
> > features which will be incompatible with zoned devices.
> >
> >more below..
> 
> Sure. I will add a table in the next version.
> 
> btrfs.txt seems not to have much there.

We don't use the in-kernel documentation, it's either the wiki or the
manual pages in btrfs-progs. The section 5 page contains some generic
topics, eg. the swapfile limitations are there.
