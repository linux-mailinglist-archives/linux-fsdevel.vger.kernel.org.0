Return-Path: <linux-fsdevel+bounces-21771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30569909B4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 04:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D44282488
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE216C6AB;
	Sun, 16 Jun 2024 02:40:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BBA20
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718505617; cv=none; b=lIj63HAYCGK8esWd7nkpTgRZvAMUfdDCdXJg8eop8oNptiZy/pprMp/tWSgvX+neqe5NqKQmbqJQ5Nfo6aqotSTj+rAuOUquifrv6xjpFDhcqZl0bs9cCPHj4tr7o8xP1nYbfbyEcmiMwKrKBE/SmNyeODjo+x1zDPVozMyRByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718505617; c=relaxed/simple;
	bh=dETxmxxhwV6tBINnXqbtRGHmH6/LENJrYEaHiHk7z/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nh5IQhebTN5qyCAZAcQl6qQ8ggoUd9vgivLeaC/HV2HxLhhk7iaMka237CaeJk2LSI+3sjWAZfxzup24v3HQnMINM52vcMrLJmS8kNuNBDerUYrGwdiFHn8sxXYxJUW1nT2ZItfj5nTNHKhRMFI4corDbqaBz9nQ38r+YRaMjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.2])
	by sina.com (10.185.250.21) with ESMTP
	id 666E507E00004EF8; Sun, 16 Jun 2024 10:40:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7761573408381
X-SMAIL-UIID: D0200C16404743458945B9D848C2A235-20240616-104000-1
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
Date: Sun, 16 Jun 2024 10:39:51 +0800
Message-Id: <20240616023951.1250-1-hdanton@sina.com>
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
> 
> I suspect this would trigger:
> 
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
Yes, it was triggered [1]

[1] https://lore.kernel.org/lkml/00000000000084b401061af6ab80@google.com/

and given trigger after nrpages is checked in clear_inode(),

	iput(inode)
	evict(inode)
	truncate_inode_pages_final(&inode->i_data);
	clear_inode(inode);
	destroy_inode(inode);

why is folio added to exiting mapping?

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

--- x/mm/filemap.c
+++ y/mm/filemap.c
@@ -870,6 +870,7 @@ noinline int __filemap_add_folio(struct
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
+	BUG_ON(mapping_exiting(mapping));
 
 	for (;;) {
 		int order = -1, split_order = 0;
--

