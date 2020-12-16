Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF52DC823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 22:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgLPVH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 16:07:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:58028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgLPVH7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:07:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 334A8AD07;
        Wed, 16 Dec 2020 21:07:17 +0000 (UTC)
Date:   Wed, 16 Dec 2020 15:07:18 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@infradead.org, nborisov@suse.com
Subject: Re: [PATCH 2/2] btrfs: Make btrfs_direct_write atomic with respect
 to inode_lock
Message-ID: <20201216210718.u2rklayhl5hir5sg@fiona>
References: <cover.1608053602.git.rgoldwyn@suse.com>
 <49ff9bfb8ef20e7a9c6e26fd54bc9f4508c9ccb4.1608053602.git.rgoldwyn@suse.com>
 <20201215221359.GA6911@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215221359.GA6911@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14:13 15/12, Darrick J. Wong wrote:
> On Tue, Dec 15, 2020 at 12:06:36PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > btrfs_direct_write() fallsback to buffered write in case btrfs is not
> > able to perform or complete a direct I/O. During the fallback
> > inode lock is unlocked and relocked. This does not guarantee the
> > atomicity of the entire write since the lock can be acquired by another
> > write between unlock and relock.
> > 
> > __btrfs_buffered_write() is used to perform the direct fallback write,
> > which performs the write without acquiring the lock or checks.
> 
> Er... can you grab the inode lock before deciding which of the IO
> path(s) you're going to take?  Then you'd always have an atomic write
> even if fallback happens.

No, since this is a fallback option which also works if the I/O is
incomplete.

> 
> (Also vaguely wondering why this needs even more slicing and dicing of
> the iomap directio functions...)

I would most likely go with Dave's method of storing the flag in the
function and calling iomap dio functions without IOCB_DSYNC flag. This
way we don't have to change iomap.

-- 
Goldwyn
