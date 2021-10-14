Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DEB42D0A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 04:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJNCqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 22:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhJNCqr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94F2A610E7;
        Thu, 14 Oct 2021 02:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634179482;
        bh=It2mkzx6TjfzrxKa1z+glKX99V3LF5sLjb+XStt8Wuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mzz6lXM/GRSQKnipiuaTPceCHZUCG+Zwebj9V2e3D3u8BDYOSVlhmPweg8g6YiI8d
         r+FzG9sPVr+Hk4H2lOIBtjdINIDEutvPeEs53/z+5bq+4EPnsRZGELeTPAvwoMl5bY
         D5WR/vTtqwKDBMa4OMVf2PvJL0TBX8SE4EyM+00T66l6gCQbaCkFBvjZHr4BqEXJ5u
         yuO9zeVQIl48uQmyOc9Be0MLM+3GoQiZYDItlKL+q86y0ZlJKAGDhfO7K6kMaufy3f
         D7Hd7Q0saLd9aej/pORbgOIvPmwFjh+idyJi5NYgYOFIwSmTP7R1qlYbeAyhEajjn0
         kkbqUUfNjdm3A==
Date:   Wed, 13 Oct 2021 19:44:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 11/29] btrfs: use bdev_nr_sectors instead of open coding
 it
Message-ID: <20211014024438.GG1594461@dhcp-10-100-145-180.wdc.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:24AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.

Just IMO, this patch looks like it wants a new bdev_nr_bytes() helper
instead of using the double shifting sectors back to bytes.
