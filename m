Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5293170D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhBJUBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 15:01:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:59344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhBJUBK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:01:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C80FAE8A;
        Wed, 10 Feb 2021 20:00:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAC46DA6E9; Wed, 10 Feb 2021 20:58:29 +0100 (CET)
Date:   Wed, 10 Feb 2021 20:58:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Message-ID: <20210210195829.GW1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1612433345.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1612433345.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 07:21:39PM +0900, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs. Some of the patches
> in the previous series are already merged as preparation patches.

Moved from for-next to misc-next.

> * Log-structured superblock
> 
> Superblock (and its copies) is the only data structure in btrfs which
> has a fixed location on a device. Since we cannot overwrite in a
> sequential write required zone, we cannot place superblock in the
> zone.
> 
> This series implements superblock log writing. It uses two zones as a
> circular buffer to write updated superblocks. Once the first zone is filled
> up, start writing into the second zone. The first zone will be reset once
> both zones are filled. We can determine the postion of the latest
> superblock by reading the write pointer information from a device.

About that, in this patchset it's still leaving superblock at the fixed
zone number while we want it at a fixed location, spanning 2 zones
regardless of their size.
