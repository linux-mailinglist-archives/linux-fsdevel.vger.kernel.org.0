Return-Path: <linux-fsdevel+bounces-22231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F8914880
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 13:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15520B250AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829F13B59B;
	Mon, 24 Jun 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFFLhIpT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE213B2B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228194; cv=none; b=Uw4+CFqhebZig0wYDwDQ+9skRhyEA2nnZdu/OF/JeqUSsiEVGX3GCOliGa36O2Qyfk4NpbWSgSmKOVw9oEGx7xIX6WktSggLpYTJwgwipOzju0daJlVtJj8qS7bD+f0BsPqvovo295Vd7qmfGhTg6pBy9fYjzW9Lg12W3T4/LMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228194; c=relaxed/simple;
	bh=pz7sF+ZNbJ8Bz1RRTeSeApuW5zYwcOlxnuYNSLjnGG8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Xr7nnPGt0lP8Ma9bKml4awzyzayjnH76tPsE5qDCbaPSbDD24qtEO3uhhIed0Jf8SxQ27OzQF+T43Nhdhd95qpGi3lshoYytPhDALZjsYVr/MMAy94Yz560I6YQCpZC44Huv+zAbJMt94Ed8BGV4/FBZgi31KqipwAghgdbbx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFFLhIpT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LH3f+Un7sHJi2rr5Ob6HxSxGqRh20bSt/mtca6UvBrE=;
	b=VFFLhIpT3xUK5rd3QihAYZNjQsTD1wHyY928jeR+Vm+guPw7SSCIe3MuGCFeUWKdG8larm
	BRRajokKgBANo+/vOqhVgM+K88qSRUCEEKupW8OFDwTjYyIpEBJ+5mjgAh5BgVqrHhXoJz
	/tmOMLfzVqLYfFkcHattNy1qzfDaTv8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-sVUMWg9KOmO8r1WqE1-FXA-1; Mon,
 24 Jun 2024 07:23:08 -0400
X-MC-Unique: sVUMWg9KOmO8r1WqE1-FXA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97142195608A;
	Mon, 24 Jun 2024 11:23:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 240671955E75;
	Mon, 24 Jun 2024 11:23:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <614256.1719228181.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jun 2024 12:23:01 +0100
Message-ID: <614257.1719228181@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

This is due to the invalidate_inode_pages2_range() issued at the end of th=
e
DIO write interfering with the mmap'd writes.

Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through =
netfs_page_mkwrite()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index c36643c97cb5..6a6387b3aaff 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -497,6 +497,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, st=
ruct netfs_group *netfs_gr
 	struct netfs_group *group;
 	struct folio *folio =3D page_folio(vmf->page);
 	struct file *file =3D vmf->vma->vm_file;
+	struct address_space *mapping =3D file->f_mapping;
 	struct inode *inode =3D file_inode(file);
 	struct netfs_inode *ictx =3D netfs_inode(inode);
 	vm_fault_t ret =3D VM_FAULT_RETRY;
@@ -508,6 +509,10 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, s=
truct netfs_group *netfs_gr
 =

 	if (folio_lock_killable(folio) < 0)
 		goto out;
+	if (folio->mapping !=3D mapping) {
+		ret =3D VM_FAULT_NOPAGE | VM_FAULT_LOCKED;
+		goto out;
+	}
 =

 	if (folio_wait_writeback_killable(folio)) {
 		ret =3D VM_FAULT_LOCKED;
@@ -523,7 +528,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, st=
ruct netfs_group *netfs_gr
 	group =3D netfs_folio_group(folio);
 	if (group !=3D netfs_group && group !=3D NETFS_FOLIO_COPY_TO_CACHE) {
 		folio_unlock(folio);
-		err =3D filemap_fdatawait_range(inode->i_mapping,
+		err =3D filemap_fdatawait_range(mapping,
 					      folio_pos(folio),
 					      folio_pos(folio) + folio_size(folio));
 		switch (err) {


