Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997F2F1145
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 09:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfKFIjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 03:39:42 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:34886 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbfKFIjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:39:41 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 03:39:41 EST
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 401F015CBF5;
        Wed,  6 Nov 2019 17:31:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-15) with ESMTPS id xA68VErR024850
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Nov 2019 17:31:15 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-15) with ESMTPS id xA68VEqa006768
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Nov 2019 17:31:14 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id xA68V8ZC006766;
        Wed, 6 Nov 2019 17:31:08 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: KCSAN: data-race in fat16_ent_put / fat_search_long
References: <00000000000016a19d0596980568@google.com>
        <20191105143923.GA87727@google.com>
        <20191105152528.GD11823@bombadil.infradead.org>
Date:   Wed, 06 Nov 2019 17:31:08 +0900
In-Reply-To: <20191105152528.GD11823@bombadil.infradead.org> (Matthew Wilcox's
        message of "Tue, 5 Nov 2019 07:25:28 -0800")
Message-ID: <87k18d8kz7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Nov 05, 2019 at 03:39:23PM +0100, Marco Elver wrote:
>> On Tue, 05 Nov 2019, syzbot wrote:
>> > ==================================================================
>> > BUG: KCSAN: data-race in fat16_ent_put / fat_search_long
>> > 
>> > write to 0xffff8880a209c96a of 2 bytes by task 11985 on cpu 0:
>> >  fat16_ent_put+0x5b/0x90 fs/fat/fatent.c:181
>> >  fat_ent_write+0x6d/0xf0 fs/fat/fatent.c:415
>> >  fat_chain_add+0x34e/0x400 fs/fat/misc.c:130
>> >  fat_add_cluster+0x92/0xd0 fs/fat/inode.c:112
>> >  __fat_get_block fs/fat/inode.c:154 [inline]
>> >  fat_get_block+0x3ae/0x4e0 fs/fat/inode.c:189
>> >  __block_write_begin_int+0x2ea/0xf20 fs/buffer.c:1968
>> >  __block_write_begin fs/buffer.c:2018 [inline]
>> >  block_write_begin+0x77/0x160 fs/buffer.c:2077
>> >  cont_write_begin+0x3d6/0x670 fs/buffer.c:2426
>> >  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
>> >  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
>> >  cont_expand_zero fs/buffer.c:2353 [inline]
>> >  cont_write_begin+0x17a/0x670 fs/buffer.c:2416
>> >  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
>> >  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
>> >  generic_cont_expand_simple+0xb0/0x120 fs/buffer.c:2317
>> > 
>> > read to 0xffff8880a209c96b of 1 bytes by task 11990 on cpu 1:
>> >  fat_search_long+0x20a/0xc60 fs/fat/dir.c:484
>> >  vfat_find+0xc1/0xd0 fs/fat/namei_vfat.c:698
>> >  vfat_lookup+0x75/0x350 fs/fat/namei_vfat.c:712
>> >  lookup_open fs/namei.c:3203 [inline]
>> >  do_last fs/namei.c:3314 [inline]
>> >  path_openat+0x15b6/0x36e0 fs/namei.c:3525
>> >  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
>> >  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
>> >  __do_sys_open fs/open.c:1115 [inline]
>> >  __se_sys_open fs/open.c:1110 [inline]
>> >  __x64_sys_open+0x55/0x70 fs/open.c:1110
>> >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> > 
>> > Reported by Kernel Concurrency Sanitizer on:
>> > CPU: 1 PID: 11990 Comm: syz-executor.2 Not tainted 5.4.0-rc3+ #0
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > ==================================================================
>> 
>> I was trying to understand what is happening here, but fail to see how
>> this can happen. So it'd be good if somebody who knows this code can
>> explain. We are quite positive this is not a false positive, given the
>> addresses accessed match.
>
> Both of these accesses are into a buffer head; ie the data being accessed
> is stored in the page cache.  Is it possible the page was reused for
> different data between these two accesses?

No and yes. Reader side is directory buffer, writer side is FAT buffer.
So FAT buffer never be reused as directory buffer.  But the page cache
itself can be freed and reused as different index. So if KCSAN can't
detect the page cache recycle, it would be possible.

Is there anyway to know "why KCSAN thought this as data race"?

>> The two bits of code in question here are:
>> 
>> static void fat16_ent_put(struct fat_entry *fatent, int new)
>> {
>> 	if (new == FAT_ENT_EOF)
>> 		new = EOF_FAT16;
>> 
>> 	*fatent->u.ent16_p = cpu_to_le16(new);   <<== data race here
>> 	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
>> }

This is updating FAT entry (index for data cluster placement) on FAT buffer.

>> int fat_search_long(struct inode *inode, const unsigned char *name,
>> 		    int name_len, struct fat_slot_info *sinfo)
>> {
>> 	struct super_block *sb = inode->i_sb;
>> 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>> 	struct buffer_head *bh = NULL;
>> 	struct msdos_dir_entry *de;
>> 	unsigned char nr_slots;
>> 	wchar_t *unicode = NULL;
>> 	unsigned char bufname[FAT_MAX_SHORT_SIZE];
>> 	loff_t cpos = 0;
>> 	int err, len;
>> 
>> 	err = -ENOENT;
>> 	while (1) {
>> 		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
>> 			goto end_of_dir;
>> parse_record:
>> 		nr_slots = 0;
>> 		if (de->name[0] == DELETED_FLAG)
>> 			continue;
>> 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))  <<== data race here

Checking attribute on directory buffer.

>> 			continue;
>> 		if (de->attr != ATTR_EXT && IS_FREE(de->name))
>> 			continue;
>> 		<snip>
>> }
>> 
>> Thanks,
>> -- Marco

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
