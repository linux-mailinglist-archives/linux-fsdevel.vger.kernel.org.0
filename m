Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6B19036E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 02:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCXBxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 21:53:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56818 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727102AbgCXBxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:53:01 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02O1qrU9018924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 21:52:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B5817420EBA; Mon, 23 Mar 2020 21:52:53 -0400 (EDT)
Date:   Mon, 23 Mar 2020 21:52:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, Harish Sriram <harish@linux.ibm.com>
Subject: Re: [PATCH] ext4: Check for non-zero journal inum in
 ext4_calculate_overhead
Message-ID: <20200324015253.GC53396@mit.edu>
References: <20200316093038.25485-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316093038.25485-1-riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:00:38PM +0530, Ritesh Harjani wrote:
> While calculating overhead for internal journal, also check
> that j_inum shouldn't be 0. Otherwise we get below error with
> xfstests generic/050 with external journal (XXX_LOGDEV config) enabled.
> 
> It could be simply reproduced with loop device with an external journal
> and marking blockdev as RO before mounting.
> 
> [ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
> ------------[ cut here ]------------
> generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
> WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 generic_make_request_checks+0x6b4/0x7d0
> CPU: 107 PID: 115347 Comm: mount Tainted: G             L   --------- -t - 4.18.0-167.el8.ppc64le #1
> NIP:  c0000000006f6d44 LR: c0000000006f6d40 CTR: 0000000030041dd4
> <...>
> NIP [c0000000006f6d44] generic_make_request_checks+0x6b4/0x7d0
> LR [c0000000006f6d40] generic_make_request_checks+0x6b0/0x7d0
> <...>
> Call Trace:
> generic_make_request_checks+0x6b0/0x7d0 (unreliable)
> generic_make_request+0x3c/0x420
> submit_bio+0xd8/0x200
> submit_bh_wbc+0x1e8/0x250
> __sync_dirty_buffer+0xd0/0x210
> ext4_commit_super+0x310/0x420 [ext4]
> __ext4_error+0xa4/0x1e0 [ext4]
> __ext4_iget+0x388/0xe10 [ext4]
> ext4_get_journal_inode+0x40/0x150 [ext4]
> ext4_calculate_overhead+0x5a8/0x610 [ext4]
> ext4_fill_super+0x3188/0x3260 [ext4]
> mount_bdev+0x778/0x8f0
> ext4_mount+0x28/0x50 [ext4]
> mount_fs+0x74/0x230
> vfs_kern_mount.part.6+0x6c/0x250
> do_mount+0x2fc/0x1280
> sys_mount+0x158/0x180
> system_call+0x5c/0x70
> EXT4-fs (pmem1p2): no journal found
> EXT4-fs (pmem1p2): can't get journal size
> EXT4-fs (pmem1p2): mounted filesystem without journal. Opts: dax,norecovery
> 
> Reported-by: Harish Sriram <harish@linux.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Applied, thanks.

					- Ted
