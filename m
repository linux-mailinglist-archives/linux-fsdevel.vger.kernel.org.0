Return-Path: <linux-fsdevel+bounces-65422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA535C04ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDD704E1EFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BB02FF171;
	Fri, 24 Oct 2025 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFyFm+F2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE22F7AD3;
	Fri, 24 Oct 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293091; cv=none; b=N9jLgn6NmsGc/V2RkJzhAcHJ3DYAMFA3clRzu49eafNzN3EgQs/aETR63hDFiy05uAz0CctIcI7LgaGQWNmbULQTHYoOjQsvZbaY9ri2cbZotuXFyPYDHKY4l4vfsNkJH25eNwjEg+KFlnGhVIozfEy4+M45OyNm7nL6Y7fqe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293091; c=relaxed/simple;
	bh=cbp0PyNjc/FnWzdjpq1IiESkpBBpZqik92hgHtcyUlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR0mRNjDiCV66cEYf8Mdx0QH6J0QKmHgiLm+GcKIn/w2uGfIyr97hILLmLBixc9aYcSQIrocTuu9Bx0KFutIhtBtJrMsn5MOhhQVnoHnhdRcuUED0SGZIr8BccpGY6entHpUlMAWtIR7eGDoyIEdBUb3bksaUDKR7muYGa/DO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EFyFm+F2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NA1EuLVhaXagkNkbEp2XlJIvkVm/6B2UHwg0o62JmEg=; b=EFyFm+F20P3IJnCg0fyoCLJwx/
	iUjafVa3MnQpYacpmfc4FhY83ukGNrsi+RejEgHj/fS1IEVKt+ePz8CTV35hZRQCamiNAgvqGDamH
	G/bB0vfKuOOTJboHNrKU8b2hjoo58Z8uBGyWcaRUUcJPc6WmWp8CKv+P1pfXUE9fZi1StqiPTEl1q
	HIslYqKlVG2K5+5Q8OZdMGqwzwFPLr09kDx/GxHA5L8tPfeHjHs4BUFM+7cn6uFZmPAfxxCXlQRJS
	784JSAnaI4lZd+Lz3VWOA9xf4bhqJXX+qM2lSiyLuhgSCRV3wEGvfowG3PsaZ5zzdMVd0nrjtN4P0
	U8Bfua3w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCmu-00000008c2I-1Fku;
	Fri, 24 Oct 2025 08:04:40 +0000
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
Subject: filemap_* writeback interface cleanups v2
Date: Fri, 24 Oct 2025 10:04:11 +0200
Message-ID: <20251024080431.324236-1-hch@lst.de>
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

Changes since v1:
 - use LLONG_MAX instead of LONG_MAX in one place
 - two commit message typo fixes
 - keep the filemap_flush* naming

Diffstat:
 fs/9p/vfs_file.c        |   17 +------
 fs/btrfs/inode.c        |   46 ++++++--------------
 fs/fs-writeback.c       |    6 +-
 fs/ocfs2/journal.c      |   11 ----
 fs/sync.c               |   10 +---
 include/linux/fs.h      |    6 +-
 include/linux/pagemap.h |    5 --
 mm/fadvise.c            |    3 -
 mm/filemap.c            |  109 +++++++++++++++++++-----------------------------
 9 files changed, 76 insertions(+), 137 deletions(-)

