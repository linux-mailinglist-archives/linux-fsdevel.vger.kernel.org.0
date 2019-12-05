Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF6114383
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfLEP2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:28:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:45020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfLEP2M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:28:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 212C9ADC8;
        Thu,  5 Dec 2019 15:28:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 982D3DA733; Thu,  5 Dec 2019 16:28:05 +0100 (CET)
Date:   Thu, 5 Dec 2019 16:28:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 03/28] btrfs: Check and enable HMZONED mode
Message-ID: <20191205152805.GT2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-4-naohiro.aota@wdc.com>
 <20191204160734.GA3950@Johanness-MacBook-Pro.local>
 <20191205051704.pyelplxjuje6jl6v@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205051704.pyelplxjuje6jl6v@naota.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:17:04PM +0900, Naohiro Aota wrote:
> >I have a question, you wrote you check for a file system consisting of zoned
> >devices with equal zone size. What happens if you create a multi device file
> >system combining zoned and regular devices? Is this even supported and if no
> >where are the checks for it?
> 
> We don't allow creaing a file system mixed with zoned and regular device.
> This is checked by btrfs_check_hmzoned_mode() (called from open_ctree()) at
> the mount time. "if (hmzoned_devices != nr_devices) { ... }" is doing the
> actual check.

It's ok for first implementation to have more restrictions, like not
allowing mixing hmzoned and regular devices or hmzoned devices with
different zone sizes. Adding that later should be possible and not
complicating the review for now.
