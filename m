Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58CEDF633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 21:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfJUTni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 15:43:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728543AbfJUTni (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36404AD72;
        Mon, 21 Oct 2019 19:43:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A2AF1E4AA2; Mon, 21 Oct 2019 21:43:30 +0200 (CEST)
Date:   Mon, 21 Oct 2019 21:43:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191021194330.GJ25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021133111.GA4675@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 09:31:12, Theodore Y. Ts'o wrote:
> Hi Matthew, thanks for your work on this patch series!
> 
> I applied it against 4c3, and ran a quick test run on it, and found
> the following locking problem.  To reproduce:
> 
> kvm-xfstests -c nojournal generic/113
> 
> generic/113		[09:27:19][    5.841937] run fstests generic/113 at 2019-10-21 09:27:19
> [    7.959477] 
> [    7.959798] ============================================
> [    7.960518] WARNING: possible recursive locking detected
> [    7.961225] 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238 Not tainted
> [    7.961991] --------------------------------------------
> [    7.962569] aio-stress/1516 is trying to acquire lock:
> [    7.963129] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: __generic_file_fsync+0x3e/0xb0
> [    7.964109] 
> [    7.964109] but task is already holding lock:
> [    7.964740] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430

This is going to be a tricky one. With iomap, the inode locking is handled
by the filesystem while calling generic_write_sync() is done by
iomap_dio_rw(). I would really prefer to avoid tweaking iomap_dio_rw() not
to call generic_write_sync(). So we need to remove inode_lock from
__generic_file_fsync() (used from ext4_sync_file()). This locking is mostly
for legacy purposes and we don't need this in ext4 AFAICT - but removing
the lock from __generic_file_fsync() would mean auditing all legacy
filesystems that use this to make sure flushing inode & its metadata buffer
list while it is possibly changing cannot result in something unexpected. I
don't want to clutter this series with it so we are left with
reimplementing __generic_file_fsync() inside ext4 without inode_lock. Not
too bad but not great either. Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
