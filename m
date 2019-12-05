Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF6113D66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 09:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfLEI4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 03:56:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:50868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfLEI43 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:56:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07A7BAC24;
        Thu,  5 Dec 2019 08:56:28 +0000 (UTC)
Date:   Thu, 5 Dec 2019 09:56:25 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 09/28] btrfs: align device extent allocation to zone
 boundary
Message-ID: <20191205085625.GD6051@Johanness-MacBook-Pro.local>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-10-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204081735.852438-10-naohiro.aota@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:17:16PM +0900, Naohiro Aota wrote:
[...]

Only commenting on the code, not the design, sorry. I'll leave that to someone
with more experience in BTRFS.

>  	 * at an offset of at least 1MB.
>  	 */
>  	search_start = max_t(u64, search_start, SZ_1M);
> +	/*
> +	 * For a zoned block device, skip the first zone of the device
> +	 * entirely.
> +	 */
> +	if (device->zone_info)
> +		zone_size = device->zone_info->zone_size;
> +	search_start = max_t(u64, search_start, zone_size);
> +	search_start = btrfs_zone_align(device, search_start);

	if (device->zone_info) {
		zone_size = device->zone_info->zone_size;
		search_start = max_t(u64, search_start, zone_size);
		search_start = btrfs_zone_align(device, search_start);
	}

That's the equivalent code, but should make it a bit more clear what's
happening int the HMZONED and !HMZOED cases.

And I /guess/ we're saving some cycles in the !HMZONED case as we don't have
to adjust search start there.

[...]

> @@ -4778,6 +4805,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  	int i;
>  	int j;
>  	int index;
> +	int hmzoned = btrfs_fs_incompat(info, HMZONED);

	bool hmzoned = btrfs_fs_incompat(info, HMZONED);

