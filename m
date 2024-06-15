Return-Path: <linux-fsdevel+bounces-21767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA741909A9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 01:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F011C2107C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F874655D;
	Sat, 15 Jun 2024 23:53:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D12561D
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jun 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718495581; cv=none; b=aoT9M6wM6wVa15N/FN5nmFA2vceaCGX7v72qB/HHziHRt7Z2CX5wIrYmTdltmZ1dJzTbDqMh6Ja3ROd/XDMGj1VG4Ed6H1KO+lfK0yOhDlsuNcd+vkSyB9K5LhT3AeNah4qHOXy8EvCN3taVV4BLGGeN39CgJU6nsbe7gN2K6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718495581; c=relaxed/simple;
	bh=vN6PP7hBwU0zBLnBaoXnkxipyRBOgrc17LMmBVxavN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXlu/SqxOLUnDo+Lstd1LXB6RyFA8+XAHBQTMlPIHWA/4BB5HQipnxR40b3e6IjU/PYyB7MleOghc8hsymUZexILho24QqIAd/fyV5gKLisDXgc4EQpo8jBVKp5+geLeVkQSzVSUHzaVt7G137AzYhTpgbdFOJLcMl4rCQAPQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.2])
	by sina.com (172.16.235.25) with ESMTP
	id 666E294D00005E62; Sat, 16 Jun 2024 07:52:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 89047434210117
X-SMAIL-UIID: B5F68BFFE1BC4398B8FF78159B84E9A2-20240616-075247-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
Date: Sun, 16 Jun 2024 07:52:38 +0800
Message-Id: <20240615235238.1079-1-hdanton@sina.com>
In-Reply-To: <Zm39RkZMjHdui8nh@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 15 Jun 2024 21:44:54 +0100 Matthew Wilcox wrote:
> On Sat, Jun 15, 2024 at 07:59:53AM +0800, Hillf Danton wrote:
> > On Fri, 14 Jun 2024 14:42:20 +0100 Matthew Wilcox wrote:
> > > On Fri, Jun 14, 2024 at 09:18:56PM +0800, Hillf Danton wrote:
> > > > Flush lru cache to avoid folio->mapping uaf in case of inode teardown.
> > > 
> > > What?  inodes are supposed to have all their folios removed before
> > > being freed.  Part of removing a folio sets the folio->mapping to NULL.
> > > Where is the report?
> > >
> > Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
> > https://lore.kernel.org/lkml/000000000000cae276061aa12d5e@google.com/
> 
> Thanks.  This fix is wrong.  Of course syzbot says it fixes the problem,
> but you're just avoiding putting the folios into the situation where we
> have debug that would detect the problem.
> 
> I suspect this would trigger:
> 
Happy to test your idea.

> +++ b/fs/inode.c
> @@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct super_block *sb)
>  void __destroy_inode(struct inode *inode)
>  {
>         BUG_ON(inode_has_buffers(inode));
> +       BUG_ON(inode->i_data.nrpages);
>         inode_detach_wb(inode);
>         security_inode_free(inode);
>         fsnotify_inode_delete(inode);
> 
> and what a real fix would look like would be calling clear_inode()
> before calling iput() in nilfs_put_root().  But I'm not an expert

Hm...given I_FREEING checked in clear_inode(), fix like this one could be
tried in midle 2026.

> in this layer of the VFS, so I might well be wrong.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

--- x/mm/truncate.c
+++ y/mm/truncate.c
@@ -419,6 +419,9 @@ void truncate_inode_pages_range(struct a
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		folio_batch_release(&fbatch);
 	}
+
+	if (mapping_exiting(mapping))
+		lru_add_drain_all();
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
--- x/fs/inode.c
+++ y/fs/inode.c
@@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct
 void __destroy_inode(struct inode *inode)
 {
 	BUG_ON(inode_has_buffers(inode));
+	BUG_ON(inode->i_data.nrpages);
 	inode_detach_wb(inode);
 	security_inode_free(inode);
 	fsnotify_inode_delete(inode);
--

