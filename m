Return-Path: <linux-fsdevel+bounces-63883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758AEBD1448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDC118943CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1AD2EFD88;
	Mon, 13 Oct 2025 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yvdjWMe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B031F5423;
	Mon, 13 Oct 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324307; cv=none; b=ZlUPECp3HPcT6WK1nGZJRkhb9cB37NstCiYEH2et3FiSDN8vj6FTqS+A7oar3kZgo+NGz+Zvt7Snb5eTp+dtAuCSzk1gv7lP0FZYM7iq+MVpfZa2t6rVvVimURZi8KyyQsMZKfdSpHfUfyRqLVXcqJbOZqkYr5T04/J1RxNXYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324307; c=relaxed/simple;
	bh=nKxfCO4ksQH4ZpyEpbXvS197w/tkWVyYr9fszANMZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7fP+6gbQEyOUrcuNXX6XPo62x+3r+g6reDzjK2IszDC3vOEhg0Vo96om2XwumLtvXY8f/f0nSyAMSCeL0S50bsbvHB3YOu+e/vJsW6CwKyvsMsThYVMOOOxaSGsl8yzjhROdCCkyqof9cN8t2g70MKnWx7ioxnLRCTyp5QK/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yvdjWMe1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IHawD8fXUsjzdqrBUJCMerdnKe9dIKJrBNuL1oU4Go8=; b=yvdjWMe1dksG8iFjNpFAfj1aEe
	A4MWib46wBHcELj51vFEJO1FLURpC0ChP3zWMAbP1jVF8ZtIJeMFGaZBYOfyIb3JZv9EPNHcHyllA
	eYIMXJljTYaRflblHSUsTsymqH6ITRsIA/qMfc+J4kwlkTl+8MWSWMuqKQF/uNtPh3pLBGTwqZSok
	iRlxAmYhIXlHBc01mgkwf4erW9kt2zjKSasJn4hFaFiEOON7+nvcIDjaSpR6Y3/O6qKbpANIlYJA1
	0qjIoWDwM9gAzWid8AygMqkE3HXcdV4HfOjr1wWfM1JqnEXNDAb0WBnodQObMz4C9QP0qa6KSqWd6
	x8Pmt9ew==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88lL-0000000C862-27OS;
	Mon, 13 Oct 2025 02:58:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: filemap_* writeback interface cleanups
Date: Mon, 13 Oct 2025 11:57:55 +0900
Message-ID: <20251013025808.4111128-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

while looking at the filemap writeback code, I think adding
filemap_fdatawrite_wbc ended up being a mistake, as all but the original
btrfs caller should be using better high level interfaces instead.  This
series removes all these, switches btrfs to a more specific interfaces
and also cleans up another too low-level interface.  With this the
writeback_control that is passed to the writeback code is only
initialized in three places, although there are a lot more places in
file system code that never reach the common writeback code.

Diffstat:
 block/bdev.c            |    2 
 fs/9p/vfs_file.c        |   17 +------
 fs/btrfs/defrag.c       |    4 -
 fs/btrfs/extent_io.c    |    3 -
 fs/btrfs/file.c         |    2 
 fs/btrfs/inode.c        |   52 +++++++---------------
 fs/btrfs/reflink.c      |    2 
 fs/btrfs/super.c        |    2 
 fs/ext4/inline.c        |    2 
 fs/ext4/inode.c         |    6 +-
 fs/fat/inode.c          |    2 
 fs/fs-writeback.c       |    6 +-
 fs/jfs/jfs_logmgr.c     |    2 
 fs/ocfs2/journal.c      |   11 ----
 fs/sync.c               |   11 ++--
 fs/xfs/xfs_file.c       |    2 
 include/linux/pagemap.h |    8 +--
 mm/fadvise.c            |    3 -
 mm/filemap.c            |  109 +++++++++++++++++++-----------------------------
 mm/khugepaged.c         |    2 
 20 files changed, 95 insertions(+), 153 deletions(-)

