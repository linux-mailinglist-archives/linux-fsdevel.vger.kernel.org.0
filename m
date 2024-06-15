Return-Path: <linux-fsdevel+bounces-21765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF479099E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E901C215DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32918E25;
	Sat, 15 Jun 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/HIHWAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6061FCF;
	Sat, 15 Jun 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718484307; cv=none; b=qMmeVzleFIyrNe+1RhAgU5+w1ZKDS5bQYiEQU251pAVl6MtjSvCCVx4/mGojtCkl0+MYJ6lQGHHekKsJbr3T2vK/QQUhuutj8lICqtQoL5j9sHATYMGTGwEXMIfBxOFwXC8/9ysCnHg2pqvWWZYpo0jjjLeNT5LkPWsa8nEYu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718484307; c=relaxed/simple;
	bh=DEVpenWNdYzHyjqnsFXgj6XBhbqkz9f5UZJs7nNICsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3P2zF59xJFzPwWuZlxdvyt7EQlNPUTmQUpEfNPzUT6SzNhYEnIMJjSaU0DG0KTRB/5tAkZ1W89eTigJWs1aaKK8DNSOQ21DocUSxaQ/t8tcvts6FFry8UPvzPIa5lzQzPTsZK8g2tjcH2ZrJ4d80cg4jRnyaZKk1hny1ced9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/HIHWAW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WaPuINruPrEbczAsN4nNbVt86EXEyxm4Imad5SheDtA=; b=U/HIHWAWyhIiTs2klJKtzK3mcU
	Vx8EvFuExFMnFf7f4N5hLI0y3aIjVEK8U8aDBzzhkRL3SvYTCBaAx0/NiOWzk5jOGjKLPIv133Y0B
	mwOrFyCUc0KL006bY7/gVHwDSjkD9yuSs5b4f6aUOOeNXwiE89QqUaNlethzFilH3thV6Ll6vDcQe
	pSLCEwEHUdIDa3dVsBxZ9bOC5nDHkhHvQeCuwyEQ/8bwvWRxcZizRC8/So9KImywubLBQP6jyDWDj
	KbDiUXJiEBcAkhJX99Ptich0GeGk85jNJIDlKgZZWuwkXwhkC8hn97MEV4mMEhMiFuSX2fraCUW1h
	/lGV/dzg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIaGc-00000000Yfr-28Gl;
	Sat, 15 Jun 2024 20:44:54 +0000
Date: Sat, 15 Jun 2024 21:44:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-mm@kvack.org, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
Message-ID: <Zm39RkZMjHdui8nh@casper.infradead.org>
References: <ZmxIvIJ3YSZDwbPW@casper.infradead.org>
 <20240614235953.809-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614235953.809-1-hdanton@sina.com>

On Sat, Jun 15, 2024 at 07:59:53AM +0800, Hillf Danton wrote:
> On Fri, 14 Jun 2024 14:42:20 +0100 Matthew Wilcox wrote:
> > On Fri, Jun 14, 2024 at 09:18:56PM +0800, Hillf Danton wrote:
> > > Flush lru cache to avoid folio->mapping uaf in case of inode teardown.
> > 
> > What?  inodes are supposed to have all their folios removed before
> > being freed.  Part of removing a folio sets the folio->mapping to NULL.
> > Where is the report?
> >
> Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
> https://lore.kernel.org/lkml/000000000000cae276061aa12d5e@google.com/

Thanks.  This fix is wrong.  Of course syzbot says it fixes the problem,
but you're just avoiding putting the folios into the situation where we
have debug that would detect the problem.

I suspect this would trigger:

+++ b/fs/inode.c
@@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 void __destroy_inode(struct inode *inode)
 {
        BUG_ON(inode_has_buffers(inode));
+       BUG_ON(inode->i_data.nrpages);
        inode_detach_wb(inode);
        security_inode_free(inode);
        fsnotify_inode_delete(inode);

and what a real fix would look like would be calling clear_inode()
before calling iput() in nilfs_put_root().  But I'm not an expert
in this layer of the VFS, so I might well be wrong.

