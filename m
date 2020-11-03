Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082BB2A449C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 12:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgKCLzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 06:55:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:60592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgKCLzs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:55:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5787AB8F;
        Tue,  3 Nov 2020 11:55:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F4AFDA7D2; Tue,  3 Nov 2020 12:54:08 +0100 (CET)
Date:   Tue, 3 Nov 2020 12:54:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 00/41] btrfs: zoned block device support
Message-ID: <20201103115408.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604065156.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:07PM +0900, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs.

> Changes from v8:
>  - Direct-IO path now follow several hardware restrictions (other than
>    max_zone_append_size) by using ZONE_APPEND support of iomap
>  - introduces union of fs_info->zone_size and fs_info->zoned [Johannes]
>    - and use btrfs_is_zoned(fs_info) in place of btrfs_fs_incompat(fs_info,
>      ZONED)
>  - print if zoned is enabled or not when printing module info [Johannes]
>  - drop patch of disabling inode_cache on ZONED
>  - moved for_teelog flag to a proper location [Johannes]
>  - Code style fixes [Johannes]
>  - Add comment about adding physical layer things to ordered extent
>    structure
>  - Pass file_offset explicitly to extract_ordered_extent() instead of
>    determining it from bio
>  - Bug fixes
>    - write out fsync region so that the logical address of ordered extents
>      and checksums are properly finalized
>    - free zone_info at umount time
>    - fix superblock log handling when entering zones[1] in the first time
>    - fixes double free of log-tree roots [Johannes] 
>    - Drop erroneous ASSERT in do_allocation_zoned()

As discussed, patches 1-10 are preparatory and can be added to misc-next
but there are still issues regarding coding style and messages. I'll
reply to individual patches as well, list below. They're not the most
useful comments regarding functionality but we won't have much chance to
fix them later and we want to focus on the hard parts.

* all comments start with uppercase, unless it's an identifier
* error messages
  * don't start with uppercase (because there's a prefix already)
  * wording and style needs to be unified
* new locks that are nested in existing locks need to documented
* somewhere (treelog_bg_lock)
* missing { } in if/else if/else blocks
* newlines between function definitions
