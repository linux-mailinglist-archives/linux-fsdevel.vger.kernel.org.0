Return-Path: <linux-fsdevel+bounces-15187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3473F889735
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58F729CEF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096236088B;
	Mon, 25 Mar 2024 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl1UvfUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0F21731A;
	Sun, 24 Mar 2024 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321770; cv=none; b=XoXRT7BKATQGOFkLnKz19ftiJcbDrHIiPsiI5E28asxF5XmT2oVBWc5GBnOrZ5okUpXQHTVEY5SSHdESX5mfXbiFbTWYtP0qMxhQ+RqsrqyrEM2Oz/hdwcHC1rpGw82f9QrFH4pWcwfTOp7ocwVxaddYG+xORll5R6XJZsfDzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321770; c=relaxed/simple;
	bh=XAPFzGb1sl2VWk/bnvkz1Ec81SxdjoxCg3bMh16LBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr5DDx869Mfx41liT/i+q45aFOJuHabc35ruj3WOCaKA8nhoXocHLCU50GWEZWnofDwDh1bzCRuWbAq9qjaEsT2Lm7uYnPXmqPmwr1UBO/O1ilqv+jyMQ/AFsxWk+ABwVC83F9A5m8CFz/LmYzntjRfsMFyBEES/ay/3VBvGbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl1UvfUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F415C43394;
	Sun, 24 Mar 2024 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321768;
	bh=XAPFzGb1sl2VWk/bnvkz1Ec81SxdjoxCg3bMh16LBlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dl1UvfUY39RRYBowjIQMDWxgDQF9PoLcA7HojiqaIRV94iG3/A8d5CuK5kTYAFWw/
	 oXQ++64WkQP85FsXjWB86ck0l8rr5GThWcP5V2pq+doKKXZOy2zmiKVVXziKgrmS+D
	 yriSHQeC6xVsqs+CpGtb54nnh77Zi1yaL+e56bXpJdLKXC+bt9tHtpWORTz/df1jDe
	 FaHYylc/ovWrQjmhQWxz/chd68FKCzPyJBQYNfs+L4QtIBnY45YPJokfTrr3f47pB4
	 7w8bi5gtLnekjqjfmtFtBjL/vpKor5MBkF5t88jIohsW2GxS1cPWFl55YGkq8P/1SC
	 n/71NXXBKQ+3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 496/638] cifs: Don't use certain unnecessary folio_*() functions
Date: Sun, 24 Mar 2024 18:58:53 -0400
Message-ID: <20240324230116.1348576-497-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit c40497d82387188f14d9adc4caa58ee1cb1999e1 ]

Filesystems should use folio->index and folio->mapping, instead of
folio_index(folio), folio_mapping() and folio_file_mapping() since
they know that it's in the pagecache.

Change this automagically with:

perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/smb/client/*.c
perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/smb/client/*.c
perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/smb/client/*.c

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Ronnie Sahlberg <lsahlber@redhat.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Stable-dep-of: f3dc1bdb6b0b ("cifs: Fix writeback data corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 043bee4020a91..7320272ef0074 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -87,7 +87,7 @@ void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len
 			continue;
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
-				  len, start, folio_index(folio), end);
+				  len, start, folio->index, end);
 			continue;
 		}
 
@@ -120,7 +120,7 @@ void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len
 			continue;
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
-				  len, start, folio_index(folio), end);
+				  len, start, folio->index, end);
 			continue;
 		}
 
@@ -151,7 +151,7 @@ void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int le
 	xas_for_each(&xas, folio, end) {
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
-				  len, start, folio_index(folio), end);
+				  len, start, folio->index, end);
 			continue;
 		}
 
@@ -2652,7 +2652,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 				continue;
 			if (xa_is_value(folio))
 				break;
-			if (folio_index(folio) != index)
+			if (folio->index != index)
 				break;
 			if (!folio_try_get_rcu(folio)) {
 				xas_reset(&xas);
@@ -2900,7 +2900,7 @@ static int cifs_writepages_region(struct address_space *mapping,
 					goto skip_write;
 			}
 
-			if (folio_mapping(folio) != mapping ||
+			if (folio->mapping != mapping ||
 			    !folio_test_dirty(folio)) {
 				start += folio_size(folio);
 				folio_unlock(folio);
-- 
2.43.0


