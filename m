Return-Path: <linux-fsdevel+bounces-15185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F43888FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 07:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6471EB32193
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 05:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73744153807;
	Sun, 24 Mar 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4UeH+zb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32321ED72F;
	Sun, 24 Mar 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320992; cv=none; b=NqsJM0NbJ8cd3NJ+zGAdowLs4pocNgLq9M5oNfB7UHNZouVil2UlGN8Y2wRokKHjg/yPMvKTnuesZKU1XHqZm3OWrnrUVzHCvMNjLo8sxob2RZRrassZ8HgtmLhT3TDAcz8BIaPaGBPb2xKXqjuNKAtfOJGnv64X+aEYefcdPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320992; c=relaxed/simple;
	bh=XAPFzGb1sl2VWk/bnvkz1Ec81SxdjoxCg3bMh16LBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ45agMWbTTsiJDYpYnvT1BEKGrhA6hO3RRYGSoqDAqiTJD/wPdlwHiOwIk5uhfLRJO7iflM7PmxDSUmtScxhtOMSo77XbHN4bsOQgJvmsATj0P7WiknXiAhxgMxlBxfta5ZeWZkgs/OyioIO2nLUIiBJ/iwyldUHTMsYnPWjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4UeH+zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D3EC43390;
	Sun, 24 Mar 2024 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320990;
	bh=XAPFzGb1sl2VWk/bnvkz1Ec81SxdjoxCg3bMh16LBlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4UeH+zbNj7vx7QdHsDjh+i57cerjAfq6lziykq7s5TkYoHUNgSvBHwYs/9XaJkB5
	 Mp18Zo7+bmJt3o9TWYoV0N1RK1HNPSbZXNJBgpUUQxmWLGQ8M8jm535zwifalL9xVR
	 mTmQoaRXcD44uyNPdHSFgiAuo6/fFoHXpMfxGUW0cWLYtJig3cFA34ZlSal3PVbzRV
	 4y0YQcqi3DzrbRRoCKCEBF0+ovaaJV7Cb3nGZmNpv47D+lstNTdUktBoyKaK+UpuFc
	 zEoqUby7SY1vfsadrfU0n2J2Mvz1WJYOM5aSAjX6eP1q2BvM1VHPpwBZtxu4g1VvGw
	 rSEul6zCzPqAw==
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
Subject: [PATCH 6.7 553/713] cifs: Don't use certain unnecessary folio_*() functions
Date: Sun, 24 Mar 2024 18:44:39 -0400
Message-ID: <20240324224720.1345309-554-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


