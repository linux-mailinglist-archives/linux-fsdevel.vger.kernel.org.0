Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D233811541D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFPWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 10:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfLFPWr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CF91AD00;
        Fri,  6 Dec 2019 15:22:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 26D2CDA783; Fri,  6 Dec 2019 16:22:39 +0100 (CET)
Date:   Fri, 6 Dec 2019 16:22:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Vyacheslav Dubeyko <slava@dubeyko.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] libblkid: implement zone-aware probing for HMZONED btrfs
Message-ID: <20191206152238.GE2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
 <20191204083023.861495-1-naohiro.aota@wdc.com>
 <5eb099b6886358f3a478658e25a26a42ab674e7f.camel@dubeyko.com>
 <20191206070320.fzvqe4ketl3lx5q6@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206070320.fzvqe4ketl3lx5q6@naota.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:03:20PM +0900, Naohiro Aota wrote:
> >> +#define BTRFS_SUPER_INFO_SIZE 4096
> >
> >I believe that 4K is very widely used constant.
> >Are you sure that it needs to introduce some
> >additional constant? Especially, it looks slightly
> >strange to see the BTRFS specialized constant.
> >Maybe, it needs to generalize the constant?
> 
> I don't think so...
> 
> I think it is better to define BTRFS_SUPER_INFO_SIZE here. This is an
> already defined constant in btrfs-progs and this is key value to
> calculate the last superblock location. I think it's OK to define
> btrfs local constant in btrfs.c file...

I agree, the named constant makes the meaning more clear. In the code
where it's used:

> >> +	if (ret != -ENOENT) {
> >> +		if (wp == zones[0].start << SECTOR_SHIFT)
> >> +			wp = (zones[1].start + zones[1].len) <<
> >> SECTOR_SHIFT;
> >> +		wp -= BTRFS_SUPER_INFO_SIZE;
> >> +	}

If there's just

		wp -= 4096;

it's a magic constant out of nowhere. As pointed out, it's defined only
in btrfs.c so it does not pollute namespace in libblkid.
