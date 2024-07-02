Return-Path: <linux-fsdevel+bounces-22968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B692451F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62255282279
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECE1C6891;
	Tue,  2 Jul 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVfK0B4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD841C0057;
	Tue,  2 Jul 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940685; cv=none; b=knZVki69h1x+DYFDTCQC0+RrAfmwUKtrnw5Ua5q3Egjw1gPL7kIQATsqkfaXsKVEG3fEff5xeONDHIaM6hf0ZHXxNh9Fmo05gW774jyQvMxvZ3cmWDggaa8x3gwxX5jgf17dAJA6Fhaes3j8/GjLBQe1pmNuhWBmbPJfktvID7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940685; c=relaxed/simple;
	bh=EON+gqEufkTPjkcJvb2LKu94Uj13qfooeC/bdqwFgY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTIAPStTPctjJR/kKNJVp0eEeRqujLzoyYcXlsySxi/0eHkp1saDgylVXfFhQwn3PFv8LNOec/RVhvGa8qA/4WfoMBCQmQFFicvuPxImTHC+ocItcCtcSkC3Wv+b2egEGGGtLlUNPficYlRJYPWj61fmn6fmuHTzVC2QGo9NGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVfK0B4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F146AC116B1;
	Tue,  2 Jul 2024 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940685;
	bh=EON+gqEufkTPjkcJvb2LKu94Uj13qfooeC/bdqwFgY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVfK0B4/VLfszVK2GVrRYavPxtQL8FYWFuozactC36JVOt9Ah+d36yWpl99QIPfCd
	 cx0SWA0+iF2gSb8/PM4U5fg/ElEWxYF1uhcc/bi4iXMnnkeal8a6L1ZR4l7iZ79zFc
	 IfapPgM1qdYDbI7XXJoCGNY0+KEFCNj8umtgaqo0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 222/222] netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait
Date: Tue,  2 Jul 2024 19:04:20 +0200
Message-ID: <20240702170252.473065522@linuxfoundation.org>
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

[ Upstream commit 9d66154f73b7c7007c3be1113dfb50b99b791f8f ]

Fix netfs_page_mkwrite() to use filemap_fdatawrite_range(), not
filemap_fdatawait_range() to flush conflicting data.

Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/614300.1719228243@warthog.procyon.org.uk
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
 fs/netfs/buffered_write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 72e4fa233c526..d2ce0849bb53d 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -535,9 +535,9 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (netfs_folio_group(folio) != netfs_group) {
 		folio_unlock(folio);
-		err = filemap_fdatawait_range(mapping,
-					      folio_pos(folio),
-					      folio_pos(folio) + folio_size(folio));
+		err = filemap_fdatawrite_range(mapping,
+					       folio_pos(folio),
+					       folio_pos(folio) + folio_size(folio));
 		switch (err) {
 		case 0:
 			ret = VM_FAULT_RETRY;
-- 
2.43.0




