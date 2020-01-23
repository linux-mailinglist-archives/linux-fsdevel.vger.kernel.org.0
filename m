Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74079146FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAWRiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 12:38:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:40452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWRiC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:38:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F80CAE46;
        Thu, 23 Jan 2020 17:38:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0910DA730; Thu, 23 Jan 2020 18:37:43 +0100 (CET)
Date:   Thu, 23 Jan 2020 18:37:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, darrick.wong@oracle.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] Allow deduplication of the eof block when it is safe
 to do so
Message-ID: <20200123173742.GF3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, darrick.wong@oracle.com,
        Filipe Manana <fdmanana@suse.com>
References: <20191216182656.15624-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216182656.15624-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:26:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Hi,
> 
> This short series allows deduplication of the last block of a file when
> the eof is not aligned to the sector size, as long as the range's end
> offset matches the eof of the destination file.
> 
> This is a safe case unlike the case where we attempt to clone the block in
> the middle of a file (which results in a corruption I found last year and
> affected both btrfs and xfs).
> 
> This is motivated by btrfs users reporting lower deduplication scores
> starting with kernel 5.0, which was the kernel release where btrfs was
> changed to use the generic VFS helper generic_remap_file_range_prep().
> Users observed that the last block was no longer deduplicated when a
> file's size is not block size aligned.  For btrfs this is specially
> important because references are kept per extent and not per block, so
> not having the last block deduplicated means the entire extent is kept
> allocated, making the deduplication not effective and often pointless in
> many cases.
> 
> Thanks.
> 
> Filipe Manana (2):
>   fs: allow deduplication of eof block into the end of the destination
>     file
>   Btrfs: make deduplication with range including the last block work

I'm going to send pull request with these two patches once the merge
window opens.

git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git fs-dedupe-last-block
