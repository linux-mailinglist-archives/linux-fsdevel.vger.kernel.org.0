Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A443943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfFMPMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:12:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:48108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732278AbfFMNpZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:45:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 097D1AE12;
        Thu, 13 Jun 2019 13:45:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E34FDA897; Thu, 13 Jun 2019 15:46:12 +0200 (CEST)
Date:   Thu, 13 Jun 2019 15:46:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
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
Subject: Re: [PATCH v2 00/19] btrfs zoned block device support
Message-ID: <20190613134612.GU3563@suse.cz>
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
 <20190612175138.GT3563@twin.jikos.cz>
 <SN6PR04MB5231E2F482B8D794950058FF8CEF0@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB5231E2F482B8D794950058FF8CEF0@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:59:23AM +0000, Naohiro Aota wrote:
> On 2019/06/13 2:50, David Sterba wrote:
> > On Fri, Jun 07, 2019 at 10:10:06PM +0900, Naohiro Aota wrote:
> >> btrfs zoned block device support
> >>
> >> This series adds zoned block device support to btrfs.
> > 
> > The overall design sounds ok.
> > 
> > I skimmed through the patches and the biggest task I see is how to make
> > the hmzoned adjustments and branches less visible, ie. there are too
> > many if (hmzoned) { do something } standing out. But that's merely a
> > matter of wrappers and maybe an abstraction here and there.
> 
> Sure. I'll add some more abstractions in the next version.

Ok, I'll reply to the patches with specific things.

> > How can I test the zoned devices backed by files (or regular disks)? I
> > searched for some concrete example eg. for qemu or dm-zoned, but closest
> > match was a text description in libzbc README that it's possible to
> > implement. All other howtos expect a real zoned device.
> 
> You can use tcmu-runer [1] to create an emulated zoned device backed by 
> a regular file. Here is a setup how-to:
> http://zonedstorage.io/projects/tcmu-runner/#compilation-and-installation

That looks great, thanks. I wonder why there's no way to find that, all
I got were dead links to linux-iscsi.org or tutorials of targetcli that
were years old and not working.

Feeding the textual commands to targetcli is not exactly what I'd
expect for scripting, but at least it seems to work.

I tried to pass an emulated ZBC device on host to KVM guest (as a scsi
device) but lsscsi does not recognize that it as a zonde device (just a
QEMU harddisk). So this seems the emulation must be done inside the VM.
