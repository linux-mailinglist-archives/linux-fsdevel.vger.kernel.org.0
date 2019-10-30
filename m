Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE2E9BE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfJ3M5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 08:57:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfJ3M5H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A676B49A;
        Wed, 30 Oct 2019 12:57:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 265741E485C; Wed, 30 Oct 2019 13:57:03 +0100 (CET)
Date:   Wed, 30 Oct 2019 13:57:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JzQvtC90LDRhdC+0LI=?= 
        <dmtrmonakhov@yandex-team.ru>
Cc:     Jan Kara <jack@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.com>, Li Xi <lixi@ddn.com>
Subject: Re: [PATCH] fs/ext4: get project quota from inode for mangling
 statfs results
Message-ID: <20191030125703.GM28525@quack2.suse.cz>
References: <157225912326.3929.8539227851002947260.stgit@buzz>
 <20191030105953.GC28525@quack2.suse.cz>
 <2625831572437163@vla1-6bb9290e4d68.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2625831572437163@vla1-6bb9290e4d68.qloud-c.yandex.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-10-19 15:06:13, Дмитрий Монахов wrote:
>  
>  
> 30.10.2019, 13:59, "Jan Kara" <jack@suse.cz>:
> 
> 
>     On Mon 28-10-19 13:38:43, Konstantin Khlebnikov wrote:
> 
>          Right now ext4_statfs_project() does quota lookup by id every time.
>          This is costly operation, especially if there is no inode who hold
>          reference to this quota and dqget() reads it from disk each time.
> 
>          Function ext4_statfs_project() could be moved into generic quota code,
>          it is required for every filesystem which uses generic project quota.
> 
>          Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>          Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>          ---
>           fs/ext4/super.c | 25 ++++++++++++++++---------
>           1 file changed, 16 insertions(+), 9 deletions(-)
> 
>          diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>          index dd654e53ba3d..f841c66aa499 100644
>          --- a/fs/ext4/super.c
>          +++ b/fs/ext4/super.c
>          @@ -5532,18 +5532,23 @@ static int ext4_remount(struct super_block
>         *sb, int *flags, char *data)
>           }
> 
>           #ifdef CONFIG_QUOTA
>          -static int ext4_statfs_project(struct super_block *sb,
>          - kprojid_t projid, struct kstatfs *buf)
>          +static int ext4_statfs_project(struct inode *inode, struct kstatfs
>         *buf)
>           {
>          - struct kqid qid;
>          + struct super_block *sb = inode->i_sb;
>                   struct dquot *dquot;
>                   u64 limit;
>                   u64 curblock;
>          + int err;
>          +
>          + err = dquot_initialize(inode);
> 
> 
>     Hum, I'm kind of puzzled here: Your patch seems to be concerned with
>     performance but how is this any faster than what we do now?
>     dquot_initialize() will look up three dquots instead of one in the current
>     code? Oh, I guess you are concerned about *repeated* calls to statfs() and
>     thus repeated lookups of dquot structure? And this patch effectively caches
>     looked up dquots in the inode?
> 
>     That starts to make some sense but still, even if dquot isn't cached in any
>     inode, we still hold on to it (it's in the free_list) until shrinker evicts
>     it. So lookup of such dquot should be just a hash table lookup which should
>     be very fast. Then there's the cost of dquot_acquire() / dquot_release()
>     that get always called on first / last get of a dquot. So are you concerned
>     about that cost? Or do you really see IO happening to fetch quota structure
>     on each statfs call again and again?
> 
> Hi,
> No IO, only useless synchronization on journal
> Repeaded statfs result in dquot_acquire()/ dquot_release() which result in two
> ext4_journal_starts
> perf record -e 'ext4:*' -e 'jbd2:*'  stat -f  volume
> perf script
>            stat 520596 [002] 589927.123955:                      
> ext4:ext4_journal_start: dev 252,2 blocks, 73 rsv_blocks, 0 caller
> ext4_acquire_dquot
>             stat 520596 [002] 589927.123958:                      
>  jbd2:jbd2_handle_start: dev 252,2 tid 187859 type 6 line_no 5550
> requested_blocks 73
>             stat 520596 [002] 589927.123959:                      
>  jbd2:jbd2_handle_stats: dev 252,2 tid 187859 type 6 line_no 5550 interval 0
> sync 0 requested_blocks 73 dirtied_blocks 0
>             stat 520596 [002] 589927.123960:                      
> ext4:ext4_journal_start: dev 252,2 blocks, 9 rsv_blocks, 0 caller
> ext4_release_dquot
>             stat 520596 [002] 589927.123961:                      
>  jbd2:jbd2_handle_start: dev 252,2 tid 187859 type 6 line_no 5566
> requested_blocks 9
>             stat 520596 [002] 589927.123962:                      
>  jbd2:jbd2_handle_stats: dev 252,2 tid 187859 type 6 line_no 5566 interval 0
> sync 0 requested_blocks 9 dirtied_blocks 0
> On host under io load this will be blocked on __jbd2_log_wait_for_space() which
> is no what people expects from statfs()

OK, makes sense.

>     The only situation where I could seethat happening is when the quota
>     structure would be actually completely
>     empty (i.e., not originally present in the quota file). But then this
>     cannot be a case when there's actually an inode belonging to this
>     project...
> 
>     So I'm really curious about the details of what you are seeing as the
>     changelog / patch doesn't quite make sense to me yet.
> 
>  
> This indeed happens if project quota goes out of sync, which is quite simple
> for non journaled  quota case.
> And this provoke huge IO penalty on each statfs

Yes, but then I wonder how it can happen that project quota is out of sync
because ext4 does not support non-journalled project quotas (project quotas
must be stored in hidden system inodes). So it is a fs bug if project quota
goes out of sync.

Anyway, case 1 you mentioned above still makes sense so please just update
the changelog explaining more details about the problem and why your
patch helps that. Thanks!

								Honza

>  
> $perf record -e 'ext4:*' -e 'jbd2:*'  stat -f  volume-with-staled-quota
> $perf script
>             stat 528212 [002] 591269.007915:                      
> ext4:ext4_journal_start: dev 252,2 blocks, 73 rsv_blocks, 0 caller
> ext4_acquire_dquot
>             stat 528212 [002] 591269.007919:                      
>  jbd2:jbd2_handle_start: dev 252,2 tid 188107 type 6 line_no 5550
> requested_blocks 73
>             stat 528212 [002] 591269.007922:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 0
>             stat 528212 [002] 591269.007923:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [0/1) 190361090 W
>             stat 528212 [002] 591269.007926:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007926:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007928:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007928:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007929:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007930:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007931:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 1
>             stat 528212 [002] 591269.007931:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [1/1) 138484739 W
>             stat 528212 [002] 591269.007933:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 1
>             stat 528212 [002] 591269.007933:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [1/1) 138484739 W
>             stat 528212 [002] 591269.007936:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007936:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007938:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 1
>             stat 528212 [002] 591269.007938:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [1/1) 138484739 W
>             stat 528212 [002] 591269.007940:                      
>  jbd2:jbd2_handle_stats: dev 252,2 tid 188107 type 6 line_no 5550 interval 0
> sync 0 requested_blocks 73 dirtied_blocks 2
>             stat 528212 [002] 591269.007941:                      
> ext4:ext4_journal_start: dev 252,2 blocks, 9 rsv_blocks, 0 caller
> ext4_release_dquot
>             stat 528212 [002] 591269.007941:                      
>  jbd2:jbd2_handle_start: dev 252,2 tid 188107 type 6 line_no 5566
> requested_blocks 9
>             stat 528212 [002] 591269.007942:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 0
>             stat 528212 [002] 591269.007943:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [0/1) 190361090 W
>             stat 528212 [002] 591269.007944:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007944:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007945:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007954:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007954:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007955:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007956:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 1
>             stat 528212 [002] 591269.007956:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [1/1) 138484739 W
>             stat 528212 [002] 591269.007957:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 1
>             stat 528212 [002] 591269.007957:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [1/1) 138484739 W
>             stat 528212 [002] 591269.007958:            
>  ext4:ext4_es_lookup_extent_enter: dev 252,2 ino 13 lblk 3
>             stat 528212 [002] 591269.007958:              
> ext4:ext4_es_lookup_extent_exit: dev 252,2 ino 13 found 1 [3/1) 188785674 W
>             stat 528212 [002] 591269.007959:                      
>  jbd2:jbd2_handle_stats: dev 252,2 tid 188107 type 6 line_no 5566 interval 0
> sync 0 requested_blocks 9 dirtied_blocks 0
> 
> 
> 
>      
> 
>          + if (err)
>          + return err;
>          +
>          + spin_lock(&inode->i_lock);
>          + dquot = ext4_get_dquots(inode)[PRJQUOTA];
>          + if (!dquot)
>          + goto out_unlock;
> 
>          - qid = make_kqid_projid(projid);
>          - dquot = dqget(sb, qid);
>          - if (IS_ERR(dquot))
>          - return PTR_ERR(dquot);
>                   spin_lock(&dquot->dq_dqb_lock);
> 
>                   limit = (dquot->dq_dqb.dqb_bsoftlimit ?
>          @@ -5569,7 +5574,9 @@ static int ext4_statfs_project(struct
>         super_block *sb,
>                   }
> 
>                   spin_unlock(&dquot->dq_dqb_lock);
>          - dqput(dquot);
>          +out_unlock:
>          + spin_unlock(&inode->i_lock);
>          +
>                   return 0;
>           }
>           #endif
>          @@ -5609,7 +5616,7 @@ static int ext4_statfs(struct dentry *dentry,
>         struct kstatfs *buf)
>           #ifdef CONFIG_QUOTA
>                   if (ext4_test_inode_flag(dentry->d_inode,
>         EXT4_INODE_PROJINHERIT) &&
>                       sb_has_quota_limits_enabled(sb, PRJQUOTA))
>          - ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
>          + ext4_statfs_project(dentry->d_inode, buf);
>           #endif
>                   return 0;
>           }
>          
> 
>     --
>     Jan Kara <jack@suse.com>
>     SUSE Labs, CR
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
