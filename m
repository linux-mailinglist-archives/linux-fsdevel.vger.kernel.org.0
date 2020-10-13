Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8628D288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgJMQqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 12:46:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbgJMQqf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87C4FAB0E;
        Tue, 13 Oct 2020 16:46:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CC39CDA7C3; Tue, 13 Oct 2020 18:45:06 +0200 (CEST)
Date:   Tue, 13 Oct 2020 18:45:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 25/41] btrfs: use ZONE_APPEND write for ZONED btrfs
Message-ID: <20201013164506.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <1727a2fbaa17db7c5d3447d2f547b98cb5f9bf32.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727a2fbaa17db7c5d3447d2f547b98cb5f9bf32.1601574234.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:36:32AM +0900, Naohiro Aota wrote:
> This commit enables zone append writing for zoned btrfs. Three parts are
> necessary to enable it. First, it modifies bio to use REQ_OP_ZONE_APPEND in
> btrfs_submit_bio_hook() and adjust the bi_sector to point the beginning of
> the zone.
> 
> Second, it records returned physical address (and disk/partno) to
> the ordered extent in end_bio_extent_writepage().

That sounds fishy ...

> Finally, it rewrites logical addresses of the extent mapping and checksum
> data according to the physical address (using __btrfs_rmap_block). If the
> returned address match to the originaly allocated address, we can skip the
> rewriting process.
> 
> [Johannes] fixed bvec handling
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -127,6 +127,10 @@ struct btrfs_ordered_extent {
>  	struct completion completion;
>  	struct btrfs_work flush_work;
>  	struct list_head work_list;
> +
> +	u64 physical;
> +	struct gendisk *disk;
> +	u8 partno;

btrfs_ordered_extent is on the logical layer, disk/partno is physical.

This needs proper explanation why it has to be done that way and that
there's not really anything better than layering violation.  Why
__btrfs_rmap_block takes bdev is unexplained.
