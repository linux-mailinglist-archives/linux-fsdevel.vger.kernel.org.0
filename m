Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF2114E44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLFJlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 04:41:19 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34427 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfLFJlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:41:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chge@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tk6q40t_1575625273;
Received: from IT-C02YD3Q7JG5H.local(mailfrom:chge@linux.alibaba.com fp:SMTPD_---0Tk6q40t_1575625273)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Dec 2019 17:41:14 +0800
Subject: Re: [PATCH]ocfs2: flush journal to update log tail info after journal
 recovery when mount
To:     Likai <li.kai4@h3c.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Cc:     "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <2014829f41f7447caa1701aa1efd09ce@h3c.com>
From:   Changwei Ge <chge@linux.alibaba.com>
Message-ID: <3d2f12b5-7378-e5a4-125d-33d9d9428b0f@linux.alibaba.com>
Date:   Fri, 6 Dec 2019 17:41:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2014829f41f7447caa1701aa1efd09ce@h3c.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,


I am trying to understand the problem.
Just a few quick questions inline.



On 2019/12/5 11:18 AM, Likai wrote:
> Hi,  I meet a new problem that file may be lost althougth it is recorded 
> in the jbd2 journal
> 
> with ocfs2 file system in one node scene. Can you give some suggestions 
> for this problem
> 
> and modification patch?
> 
> Test method:
> 
> 1. touch some files after mount
> 
> 2. emergency restart
> 
> 3. mount again, then log tail will not be updated
> 
> 4. touch a new file and confirm that it is recorded in the journal area
> 
> 5.emergency restart again
> 
> 6. the new log will not be replayed becasuse its seq and blknum are not 
> consistent with journal super block although it is an unbroken commit.

What do you mean by the consistency between jbd2 blocks and jbd2 super 
block?

Did you ever call fsync(2) to test target file? If not, posix doesn't 
guarantee the newly created file should be present after a crash. In 
other words, it's a normal case.

Perhaps, I miss something, better you can give a further elaboration.
If we can ensure this patch helps, we can make this progress :-)

> 
> After analizing the codes, its cause is as follow:
> 
> Journal->j_flags will be set JBD2_ABORT in journal_init_common first.
> 
> if this flag is not cleared before journal_reset in journal recovery
> 
> scene, super log tail cannot be updated, then the new commit trans in
> 
> the journal may not be replayed because new commits recover old trans
> 
> area.
> 
> This exception happens when this lun is used by only one node. If it
> 
> is used by multi-nodes, other node will replay its journal and its
> 
> log tail info will be updated after recovery.
> 
> To fix this problem, use jbd2_journal_flush to update log tail as
> 
> ocfs2_replay_journal has done.
> 
> logdump:
> 
> Block 0: Journal Superblock
> 
> Seq: 0   Type: 4 (JBD2_SUPERBLOCK_V2)
> 
> Blocksize: 4096   Total Blocks: 32768   First Block: 1
> 
> First Commit ID: 13   Start Log Blknum: 1
> 
> Error: 0
> 
> Feature Compat: 0
> 
> Feature Incompat: 2 block64
> 
> Feature RO compat: 0
> 
> Journal UUID: 4ED3822C54294467A4F8E87D2BA4BC36
> 
> FS Share Cnt: 1   Dynamic Superblk Blknum: 0
> 
> Per Txn Block Limit    Journal: 0    Data: 0
> 
> Block 1: Journal Commit Block
> 
> Seq: 14   Type: 2 (JBD2_COMMIT_BLOCK)
> 
> Block 2: Journal Descriptor
> 
> Seq: 15   Type: 1 (JBD2_DESCRIPTOR_BLOCK)
> 
> No. Blocknum        Flags
> 
> 0. 587             none
> 
> UUID: 00000000000000000000000000000000
> 
> 1. 8257792         JBD2_FLAG_SAME_UUID
> 
> 2. 619             JBD2_FLAG_SAME_UUID
> 
> 3. 24772864        JBD2_FLAG_SAME_UUID
> 
> 4. 8257802         JBD2_FLAG_SAME_UUID
> 
> 5. 513             JBD2_FLAG_SAME_UUID JBD2_FLAG_LAST_TAG
> 
> ...
> 
> Block 7: Inode
> 
> Inode: 8257802   Mode: 0640   Generation: 57157641 (0x3682809)
> 
> FS Generation: 2839773110 (0xa9437fb6)
> 
> CRC32: 00000000   ECC: 0000
> 
> Type: Regular   Attr: 0x0   Flags: Valid
> 
> Dynamic Features: (0x1) InlineData
> 
> User: 0 (root)   Group: 0 (root)   Size: 7
> 
> Links: 1   Clusters: 0
> 
> ctime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
> 
> atime: 0x5de5d870 0x113181a1 -- Tue Dec  3 11:37:20.288457121 2019
> 
> mtime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
> 
> dtime: 0x0 -- Thu Jan  1 08:00:00 1970
> 
> ...
> 
> Block 9: Journal Commit Block
> 
> Seq: 15   Type: 2 (JBD2_COMMIT_BLOCK)
> 
> syslog:
> 
> Dec  3 11:41:05 cvknode02 kernel: [ 2265.648622] ocfs2: File system on 
> device (252,1) was not unmounted cleanly, recovering it.
> 
> Dec  3 11:41:05 cvknode02 kernel: [ 2265.649695] 
> fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 0
> 
> Dec  3 11:41:05 cvknode02 kernel: [ 2265.650407] 
> fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 1
> 
> Dec  3 11:41:05 cvknode02 kernel: [ 2265.650409] 
> fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 2
> 
> Dec  3 11:41:05 cvknode02 kernel: [ 2265.650410] 
> fs/jbd2/recovery.c:(jbd2_journal_recover, 278): JBD2: recovery, exit 
> status 0, recovered transactions 13 to 13
> 
> Seq 15 is an unbroken commit, but it cannot be replayed, inode 8257802


I think all the ever committed transactions are kept in the journal area 
until it's overwritten.

> 
> is a new file and it will be lost. After test, it is ok now.
> 
> Signed-off-by: Kai Li <li.kai4@h3c.com>
> 
> ---
> 
> fs/ocfs2/journal.c | 8 ++++++++
> 
> 1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> 
> index 1afe57f425a0..b8b9d26fa731 100644
> 
> --- a/fs/ocfs2/journal.c
> 
> +++ b/fs/ocfs2/journal.c
> 
> @@ -1066,6 +1066,14 @@ int ocfs2_journal_load(struct ocfs2_journal 
> *journal, int local, int replayed)
> 
>          ocfs2_clear_journal_error(osb->sb, journal->j_journal, 
> osb->slot_num);
> 
> +       if (replayed) {
> 
> +                /* wipe the journal */
> 
> +                jbd2_journal_lock_updates(journal->j_journal);
> 
> +                status = jbd2_journal_flush(journal->j_journal);
> 
> +                jbd2_journal_unlock_updates(journal->j_journal);

As now it's under mounting progress, I don't figure out how can we get 
running jbd2 transactions? If no *running* transactions around, does 
jbd2_journal_flush() really have effect to jbd2?

	-Changwei

> 
> +                mlog(ML_NOTICE, "journal recovery complete, status=%d", 
> status);
> 
> +       }
> 
> +
> 
>         status = ocfs2_journal_toggle_dirty(osb, 1, replayed);
> 
>         if (status < 0) {
> 
>                  mlog_errno(status);
> 
