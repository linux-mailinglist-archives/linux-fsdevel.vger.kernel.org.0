Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8EF1153FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLFPM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 10:12:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:56368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfLFPM4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:12:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57547AC10;
        Fri,  6 Dec 2019 15:12:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 466E3DA783; Fri,  6 Dec 2019 16:12:48 +0100 (CET)
Date:   Fri, 6 Dec 2019 16:12:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 05/28] btrfs: disallow space_cache in HMZONED mode
Message-ID: <20191206151248.GD2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-6-naohiro.aota@wdc.com>
 <20191205153953.GV2734@twin.jikos.cz>
 <20191206053244.r2en7jydhyohd45k@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206053244.r2en7jydhyohd45k@naota.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:32:44PM +0900, Naohiro Aota wrote:
> >> +	 */
> >> +	if (btrfs_test_opt(info, SPACE_CACHE)) {
> >> +		btrfs_err(info,
> >> +		  "cannot enable disk space caching with HMZONED mode");
> >
> >"space cache v1 not supported in HMZONED mode, use v2 (free-space-tree)"
> >
> >> +		return -EINVAL;
> 
> Yes, we can technically use free-space-tree on HMZONED mode. But,
> since HMZONED mode now always allocate extents in a block group
> sequentially regardless of underlying device zone type, it's no use to
> enable and maintain the tree anymore.
> 
> So, just telling "space cache v1 not supported in HMZONED mode" is
> better?

Ok. That v2 is possible to use but not necessary is something to put to
documentation.

> >>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> >> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >> index 616f5abec267..d411574298f4 100644
> >> --- a/fs/btrfs/super.c
> >> +++ b/fs/btrfs/super.c
> >> @@ -442,8 +442,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
> >>  	cache_gen = btrfs_super_cache_generation(info->super_copy);
> >>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
> >>  		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> >> -	else if (cache_gen)
> >> -		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> >> +	else if (cache_gen) {
> >> +		if (btrfs_fs_incompat(info, HMZONED))
> >> +			WARN_ON(1);
> >
> >So this is supposed to catch invalid combination, hmzoned-compatible
> >options are verified at the beginning. 'cache_gen' can be potentially
> >non-zero (fuzzed image, accidental random overwrite from last time), so
> >I think a message should be printed. If it's possible to continue, eg.
> >completely ignoring the existing space cache that's more user friendly
> >than a plain unexplained WARN_ON.
> 
> We can just ignore the generation value and continue. I'll rewrite to
> use btrfs_info(info, "ignoring existing space cache in HMZONED mode.")
> instead of WARN_ON.

Sounds good.
