Return-Path: <linux-fsdevel+bounces-41880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D11A38B86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC337A4F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF50236A9C;
	Mon, 17 Feb 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvlvJAP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CA22A1E6;
	Mon, 17 Feb 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818284; cv=none; b=L5RnUaEBEKB6ZYXDTjRjayyIo5WoTmVGG8eTAiVtIkp85pFz33ZUxNWMVxZxcWGEgZZkNbQ+0tieOiyj7aM10tAr5kpFpLLf8Xmq/dLHts5sdFJc67RG7jojWoh7JPc8/9+/gFow6yr0oSNeZocKBpQOJLZuilwSAegYqooWcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818284; c=relaxed/simple;
	bh=2eQc7nvh42nEffNI7qjDvuXRyDqLqHSynT+xP9Plq5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYC0W+bumVj4vlz9koCeCh5X9pjcstaqlCmhZOBVQ88W5xBMURW3ZbPcUUbnVnfX1aIUQtQGEeXliePE2MtuTP7rCq+dWuK9qBEWP1PvYgypste/Er59AHV/Ndb1VQOIImNWRqTvz2JQFK5nnaC+XK9Cx6fGqvrMUANzuL/TU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvlvJAP8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5iiwKG65PVOjsfmb6e1Nu6WPlqtL78lpUf8uESALYso=; b=qvlvJAP83DyfnNoLfVrp3RwAA0
	74uObTitBr7G3Sax60qYIjxMV13+xgHYwakUpGfRHRmEQ9GRGUHNsZuld9KwiQmrObqsutgK00A4B
	4Gs6rZ53zIwDSiDMN7SVuhF4L9oo9WfXBskK8k/VC9XlRKVHLeVYFMT77OQqPuPMdwanl0scfh/9T
	Z9Lmbgppfnrsz0mXq4NcoJmxbu8nz2+YJlav1POAxw7OVI6YB/s0EqbnjlWW0keL5WnQ1TP0EqZ+9
	UZj5aLQpp4Yz48HUJ+CLMZLjETCiB9ceAYZkPYtHsdMJN3iYGPVTsaTsPxMOvMfqn8gd8JlWAojMW
	e1pUd08g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nva-0N4L;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 0/9] Remove accesses to page->index from ceph
Date: Mon, 17 Feb 2025 18:51:08 +0000
Message-ID: <20250217185119.430193-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rebase of Friday's patchset onto
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
as requested by Dave.

The original patch 1/7 is gone as it is no longer necessary.
Patches 2-6 are retained intact as patches 1-5 in this patchset.
Patch 7 is hopefully patches 6-9 in this patchset.

Matthew Wilcox (Oracle) (9):
  ceph: Remove ceph_writepage()
  ceph: Use a folio in ceph_page_mkwrite()
  ceph: Convert ceph_find_incompatible() to take a folio
  ceph: Convert ceph_readdir_cache_control to store a folio
  ceph: Convert writepage_nounlock() to write_folio_nounlock()
  ceph: Convert ceph_check_page_before_write() to use a folio
  ceph: Remove uses of page from ceph_process_folio_batch()
  ceph: Convert ceph_move_dirty_page_in_page_array() to
    move_dirty_folio_in_page_array()
  ceph: Pass a folio to ceph_allocate_page_array()

 fs/ceph/addr.c  | 239 +++++++++++++++++++++---------------------------
 fs/ceph/dir.c   |  15 +--
 fs/ceph/inode.c |  26 +++---
 fs/ceph/super.h |   2 +-
 4 files changed, 127 insertions(+), 155 deletions(-)

-- 
2.47.2


