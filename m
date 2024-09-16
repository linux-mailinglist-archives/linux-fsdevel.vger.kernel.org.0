Return-Path: <linux-fsdevel+bounces-29463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60A97A1F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02681C22E6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6280415574C;
	Mon, 16 Sep 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IF3fya69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE0149C57;
	Mon, 16 Sep 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488712; cv=none; b=geyvb3ez1bbYHLGaO7H2f0fLOkeexPHMr9SA8E3naTpEuLBiYCofLes+vqT7SbCpZ2YwlibiLPXcaVv6w0uji3MzIxpWr2SJx9Tqcz2TqZyFAi9wcNOox0J3GFaO+rTB0b6WlLGK+9icnG9W87G+2RX05XLS0xsTJ+2rU30KjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488712; c=relaxed/simple;
	bh=cpEi2GEdyl06om67qiYwRsfSu1/YmuuYKBRSmmZppdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTOxlEs/EvHMTltre7AuCEl98Dw7ifL0xU6lEMYe858PUMgtmIwKJF/emB/flX/p61oCxLKKJGuHfeV1dr7syFd1RMAPWxpniTQS5h/1ug0hBrhCWZ7rC9smsqXSPV1eGPK8Yx0q2bXVWnYDZO3H3g7SyNJYHkXr7quenhQS9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IF3fya69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1179FC4CEC4;
	Mon, 16 Sep 2024 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488712;
	bh=cpEi2GEdyl06om67qiYwRsfSu1/YmuuYKBRSmmZppdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IF3fya69qV91mmcgsXqcp4IrbFBHO6msSDc33C2KTwILNHnq4pfJK1F7DYv5iDp1t
	 eCGBhyDZbVQkSpH1fI13GjMwrwVloehb68Uavp7iBdJDOp/OslCF4cw1hB/QOe7+ZJ
	 wR4JAThOqfP/QqbA7jId+24tZ0Hdu4oa6ZTI7BnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 88/91] cifs: Fix signature miscalculation
Date: Mon, 16 Sep 2024 13:45:04 +0200
Message-ID: <20240916114227.350749688@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
References: <20240916114224.509743970@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 5a20b7cb0d8d3ee490a8e088dc2584aa782e3355 ]

Fix the calculation of packet signatures by adding the offset into a page
in the read or write data payload when hashing the pages from it.

Fixes: 39bc58203f04 ("cifs: Add a function to Hash the contents of an iterator")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsencrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 6322f0f68a17..b0473c2567fe 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -129,7 +129,7 @@ static ssize_t cifs_shash_xarray(const struct iov_iter *iter, ssize_t maxsize,
 			for (j = foffset / PAGE_SIZE; j < npages; j++) {
 				len = min_t(size_t, maxsize, PAGE_SIZE - offset);
 				p = kmap_local_page(folio_page(folio, j));
-				ret = crypto_shash_update(shash, p, len);
+				ret = crypto_shash_update(shash, p + offset, len);
 				kunmap_local(p);
 				if (ret < 0)
 					return ret;
-- 
2.43.0




