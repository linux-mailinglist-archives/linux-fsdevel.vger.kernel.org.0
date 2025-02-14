Return-Path: <linux-fsdevel+bounces-41729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D29A36285
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C523AE21B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671726773C;
	Fri, 14 Feb 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ca8A/UHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187926770A;
	Fri, 14 Feb 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548640; cv=none; b=EPX2DlIiIFvRVFGJ+xKyECjcmhpyjD9bOPSC3k8mcQ8VKKT4E7vIPXzAx+fl2id73m5SdPpqRBzWTug5HOtsQ54I3BmXvpvxna3SZPnwqUN9ojKjmkVgPU71uLIX+i2kCVQwaHtRDgXfMKwY2qBzL6hP1mdkbpeqXUJPKRLUOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548640; c=relaxed/simple;
	bh=XNgbG1zMI7UoF0mxdU2YRvp3YIrcbdP5wEyJha0nWt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGTWILZ1nia4VLG/WuqVEl0DdTFUNQf65V5W6QSP6SQJKHn/VjFbH9K+B2B/Cf9u2k2GHB7Cil4NcZNCws+A2BKB1Xz1s6z6oCNxxGDVf0CVv5TkIk2y27Q94Q16gAOpZQRwgr5rR1F+a+zUorJnLqZn6mbpkYAEWXJqLJa2xZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ca8A/UHD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=azWlzhNcRk6YIClEheIyNJuukxKnhh7eEfcNy8j+HRk=; b=ca8A/UHDDTejE0G1C9fLbJgU0V
	f/JD4z8FigWAKvRSuJkBa8M7gk9ke1UEVX4nfGvj0eK3k4h/Q2YsWAULXbH622zeZ16joYlGPhMkF
	aFqca069wefFNe+3SHzchsleRNMUnfNwbpD8eAKhCceWloVMTa7bCqGdjRI0KZC0EtWAFnNLgfN3n
	KTpfqvVoJU5Ca1kdU2yBkIDpyqKMmKSuC6AnLnxCHX4AVuMEF0FtwKL4scm7n31kzp836a7jwI/gn
	sz/3JpsIKigN+e1aB7onhCf5gP3J6WnKqUhmrWHygQgEUUHtUUZtmyfclRGRzqxTRj54e8YdD8LEk
	qEGSA6kw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000BhxZ-1FRQ;
	Fri, 14 Feb 2025 15:57:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 0/7] Remove accesses to page->index from ceph
Date: Fri, 14 Feb 2025 15:57:02 +0000
Message-ID: <20250214155710.2790505-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a bugfix.  I'm not quite clear on the consequences
of looking at the wrong index; possibly some pages get written back
that shouldn't be, or some pages don't get written back that should be.
Anyway, I think it deserves to go in and get backported.

The other six patches I would like to see merged for v6.15.  Unless
Dave finishes his rewrite first.  I have only compile tested this,
but it's _mostly_ a one-to-one transformation.

v1: https://lore.kernel.org/linux-fsdevel/20241129055058.858940-1-willy@infradead.org/

Matthew Wilcox (Oracle) (7):
  ceph: Do not look at the index of an encrypted page
  ceph: Remove ceph_writepage()
  ceph: Use a folio in ceph_page_mkwrite()
  ceph: Convert ceph_find_incompatible() to take a folio
  ceph: Convert ceph_readdir_cache_control to store a folio
  ceph: Convert writepage_nounlock() to write_folio_nounlock()
  ceph: Use a folio in ceph_writepages_start()

 fs/ceph/addr.c   | 223 +++++++++++++++++++++--------------------------
 fs/ceph/crypto.h |   7 ++
 fs/ceph/dir.c    |  13 +--
 fs/ceph/inode.c  |  26 +++---
 fs/ceph/super.h  |   2 +-
 5 files changed, 129 insertions(+), 142 deletions(-)

-- 
2.47.2


