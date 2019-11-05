Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CFF014B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 16:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfKEPZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 10:25:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388865AbfKEPZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NgATcCLTGpEPLwWdKi14PTpZ7rURfMGSbUwiELsU3Q4=; b=IuCRYE4FycS9P2WAfst2WI/cB
        OE99a3FeQZFP5k1rXzlUwGE+qZalTv8pYKIH96bd7jqKFmgourtzl34cq2RESZADqOTU4OG2KSuyG
        CrVwGCgx3IwlzNjMcripYiWeh0HfiXl+5kKPMINTpAWL+qwWPxji3qlifM+/RU9pclIYNa68BahSs
        GMABOMxeGHuHU0WdOO+sTtUkc14/hpk7LkXlPQqJyNgLpduRsgZB+XXpxaN4pPPPaE5j0qpQmZfeO
        OX2xxAHE7z+RDLVZ2GQaVHSn/eOQaLepgnJiVaZ22p2nq/eYAzRG+oFkmutkY5IdRqXNq3ipMytr8
        elO7VvF3A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iS0i0-0003Ji-JY; Tue, 05 Nov 2019 15:25:28 +0000
Date:   Tue, 5 Nov 2019 07:25:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com>,
        hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: KCSAN: data-race in fat16_ent_put / fat_search_long
Message-ID: <20191105152528.GD11823@bombadil.infradead.org>
References: <00000000000016a19d0596980568@google.com>
 <20191105143923.GA87727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105143923.GA87727@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:39:23PM +0100, Marco Elver wrote:
> On Tue, 05 Nov 2019, syzbot wrote:
> > ==================================================================
> > BUG: KCSAN: data-race in fat16_ent_put / fat_search_long
> > 
> > write to 0xffff8880a209c96a of 2 bytes by task 11985 on cpu 0:
> >  fat16_ent_put+0x5b/0x90 fs/fat/fatent.c:181
> >  fat_ent_write+0x6d/0xf0 fs/fat/fatent.c:415
> >  fat_chain_add+0x34e/0x400 fs/fat/misc.c:130
> >  fat_add_cluster+0x92/0xd0 fs/fat/inode.c:112
> >  __fat_get_block fs/fat/inode.c:154 [inline]
> >  fat_get_block+0x3ae/0x4e0 fs/fat/inode.c:189
> >  __block_write_begin_int+0x2ea/0xf20 fs/buffer.c:1968
> >  __block_write_begin fs/buffer.c:2018 [inline]
> >  block_write_begin+0x77/0x160 fs/buffer.c:2077
> >  cont_write_begin+0x3d6/0x670 fs/buffer.c:2426
> >  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
> >  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
> >  cont_expand_zero fs/buffer.c:2353 [inline]
> >  cont_write_begin+0x17a/0x670 fs/buffer.c:2416
> >  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
> >  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
> >  generic_cont_expand_simple+0xb0/0x120 fs/buffer.c:2317
> > 
> > read to 0xffff8880a209c96b of 1 bytes by task 11990 on cpu 1:
> >  fat_search_long+0x20a/0xc60 fs/fat/dir.c:484
> >  vfat_find+0xc1/0xd0 fs/fat/namei_vfat.c:698
> >  vfat_lookup+0x75/0x350 fs/fat/namei_vfat.c:712
> >  lookup_open fs/namei.c:3203 [inline]
> >  do_last fs/namei.c:3314 [inline]
> >  path_openat+0x15b6/0x36e0 fs/namei.c:3525
> >  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
> >  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
> >  __do_sys_open fs/open.c:1115 [inline]
> >  __se_sys_open fs/open.c:1110 [inline]
> >  __x64_sys_open+0x55/0x70 fs/open.c:1110
> >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 11990 Comm: syz-executor.2 Not tainted 5.4.0-rc3+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > ==================================================================
> 
> I was trying to understand what is happening here, but fail to see how
> this can happen. So it'd be good if somebody who knows this code can
> explain. We are quite positive this is not a false positive, given the
> addresses accessed match.

Both of these accesses are into a buffer head; ie the data being accessed
is stored in the page cache.  Is it possible the page was reused for
different data between these two accesses?

> The two bits of code in question here are:
> 
> static void fat16_ent_put(struct fat_entry *fatent, int new)
> {
> 	if (new == FAT_ENT_EOF)
> 		new = EOF_FAT16;
> 
> 	*fatent->u.ent16_p = cpu_to_le16(new);   <<== data race here
> 	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
> }
> 
> int fat_search_long(struct inode *inode, const unsigned char *name,
> 		    int name_len, struct fat_slot_info *sinfo)
> {
> 	struct super_block *sb = inode->i_sb;
> 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> 	struct buffer_head *bh = NULL;
> 	struct msdos_dir_entry *de;
> 	unsigned char nr_slots;
> 	wchar_t *unicode = NULL;
> 	unsigned char bufname[FAT_MAX_SHORT_SIZE];
> 	loff_t cpos = 0;
> 	int err, len;
> 
> 	err = -ENOENT;
> 	while (1) {
> 		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> 			goto end_of_dir;
> parse_record:
> 		nr_slots = 0;
> 		if (de->name[0] == DELETED_FLAG)
> 			continue;
> 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))  <<== data race here
> 			continue;
> 		if (de->attr != ATTR_EXT && IS_FREE(de->name))
> 			continue;
> 		<snip>
> }
> 
> Thanks,
> -- Marco
