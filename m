Return-Path: <linux-fsdevel+bounces-22967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D992451C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521B2B21C03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CB1BE251;
	Tue,  2 Jul 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IvCiZ+TA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECB1BE22A;
	Tue,  2 Jul 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940682; cv=none; b=fjARMwY5/4JkZ2wDETp5e/OIB8um/zyPU2W8AgRJonendTcI/xjBez1PpqOcKlV2Ww5ZTQiue341u5A7X4oxS3DAFf4QX0n/hO/k8eBbZBP0QC4V/vSPlTxiuGFbJBnr+OTuB/51+InQCJPJ6L5C+t9Q2s0+4aeekeUDQq2m5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940682; c=relaxed/simple;
	bh=xYuhDM0qnN8IfxCRnGM/W7DHSuvjwI8r4s+KWI0SZ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMqxa02JXplGJNY0ImD6sb1yMm4TzWsgQUen15u1KcZ/EgrWx/4d0eLN1JUnryYngDOR5Dm3+mqhDGVCKT3LCG+Rh+V7x2DOAjxJHJhUs/6GSwT3hYyk/Ut5tCKnUUpr1w53nhzPiYP/FaM2jaTkTQ36aqBw5cnmJKd6CBry2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IvCiZ+TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A48FC116B1;
	Tue,  2 Jul 2024 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940682;
	bh=xYuhDM0qnN8IfxCRnGM/W7DHSuvjwI8r4s+KWI0SZ/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvCiZ+TAt9cpZRpRKauh2Acwidr+Q0221ErGsC2Z8KS9lCJshOPpD/BoEOWNnAzyy
	 eTI55EkDpzLOYEg1NJncYAIx71bJjqgZhmIYlb3S7eCU6iMy2PpAptGQQM+AxQTNtb
	 D5XGrJrhw/TDIE1zzM7ZOvZ6mpfD3fySyRkoPiAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 221/222] netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
Date: Tue,  2 Jul 2024 19:04:19 +0200
Message-ID: <20240702170252.435728996@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit a81c98bfa40c11f8ea79b5a9b3f5fda73bfbb4d2 ]

Fix netfs_page_mkwrite() to check that folio->mapping is valid once it has
taken the folio lock (as filemap_page_mkwrite() does).  Without this,
generic/247 occasionally oopses with something like the following:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page

    RIP: 0010:trace_event_raw_event_netfs_folio+0x61/0xc0
    ...
    Call Trace:
     <TASK>
     ? __die_body+0x1a/0x60
     ? page_fault_oops+0x6e/0xa0
     ? exc_page_fault+0xc2/0xe0
     ? asm_exc_page_fault+0x22/0x30
     ? trace_event_raw_event_netfs_folio+0x61/0xc0
     trace_netfs_folio+0x39/0x40
     netfs_page_mkwrite+0x14c/0x1d0
     do_page_mkwrite+0x50/0x90
     do_pte_missing+0x184/0x200
     __handle_mm_fault+0x42d/0x500
     handle_mm_fault+0x121/0x1f0
     do_user_addr_fault+0x23e/0x3c0
     exc_page_fault+0xc2/0xe0
     asm_exc_page_fault+0x22/0x30

This is due to the invalidate_inode_pages2_range() issued at the end of the
DIO write interfering with the mmap'd writes.

Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/780211.1719318546@warthog.procyon.org.uk
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 912ad0a1df021..72e4fa233c526 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -507,6 +507,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 {
 	struct folio *folio = page_folio(vmf->page);
 	struct file *file = vmf->vma->vm_file;
+	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
 	vm_fault_t ret = VM_FAULT_RETRY;
 	int err;
@@ -520,6 +521,11 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
+	if (folio->mapping != mapping) {
+		folio_unlock(folio);
+		ret = VM_FAULT_NOPAGE;
+		goto out;
+	}
 
 	/* Can we see a streaming write here? */
 	if (WARN_ON(!folio_test_uptodate(folio))) {
@@ -529,7 +535,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (netfs_folio_group(folio) != netfs_group) {
 		folio_unlock(folio);
-		err = filemap_fdatawait_range(inode->i_mapping,
+		err = filemap_fdatawait_range(mapping,
 					      folio_pos(folio),
 					      folio_pos(folio) + folio_size(folio));
 		switch (err) {
-- 
2.43.0




