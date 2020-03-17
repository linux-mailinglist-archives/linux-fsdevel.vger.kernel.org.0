Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C131881AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 12:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgCQLR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 07:17:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbgCQLRz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:17:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5669BACAE;
        Tue, 17 Mar 2020 11:17:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E26B1E121E; Tue, 17 Mar 2020 12:17:52 +0100 (CET)
Date:   Tue, 17 Mar 2020 12:17:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        Harish Sriram <harish@linux.ibm.com>
Subject: Re: [PATCH] ext4: Check for non-zero journal inum in
 ext4_calculate_overhead
Message-ID: <20200317111752.GF22684@quack2.suse.cz>
References: <20200316093038.25485-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316093038.25485-1-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 16-03-20 15:00:38, Ritesh Harjani wrote:
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

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index de5398c07161..5dc65b7583cb 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3609,7 +3609,8 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	 */
>  	if (sbi->s_journal && !sbi->journal_bdev)
>  		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
> -	else if (ext4_has_feature_journal(sb) && !sbi->s_journal) {
> +	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
> +		/* j_inum for internal journal is non-zero */
>  		j_inode = ext4_get_journal_inode(sb, j_inum);
>  		if (j_inode) {
>  			j_blocks = j_inode->i_size >> sb->s_blocksize_bits;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
