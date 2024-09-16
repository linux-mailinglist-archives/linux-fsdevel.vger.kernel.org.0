Return-Path: <linux-fsdevel+bounces-29462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9C97A182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCA2287C45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0181155322;
	Mon, 16 Sep 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vEY/jwn9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC615689A;
	Mon, 16 Sep 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488453; cv=none; b=ARs9/p3KV2UqbhAZAjS3KHyAQHoDvCNRy12LpK3z/yJCxepU5Co3PZ9voOaBIEASUuM4S2X49G0MRvEc7wkNHG8dRub9qkGWU5LG2SNw+/YaxJaEe7CPqV1BuRRHTSt7AGiY06RyKnf7VBsVEHVjX8eDA86GM+xm6mb0V4qv8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488453; c=relaxed/simple;
	bh=2g2qgh/YrdTdc1RKgP8SZlonukH4nq0K664Z/dAXG9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqwejfMJbFIx+EtXKesamoEqnfSvqhvp6FkUql5JhaGnmius3zTZEB+yKh8uGCzsAFfLRU0WxfY/7LvX88LTVPPRHR/niuKo+EHF/PeCY+czYh6cqcc0cN6w93C+5QZYXY06t7eXGUFcDDiElxHbET3Sxo1d0x0aULphLTlvViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vEY/jwn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0FBC4CEC4;
	Mon, 16 Sep 2024 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488452;
	bh=2g2qgh/YrdTdc1RKgP8SZlonukH4nq0K664Z/dAXG9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEY/jwn9r/kdg5xtCb4iZixspunJAelQvP25wZhKyy1BMXBY21uabX3NLhko8qxVO
	 CivW3J5D1aE9vWhXoIkTA8lKLgbnQbhRBVZz487G3E19gwIqnLUTJ/c3XGtwBmujhN
	 o3CdV00B+z/pQuyEq7K/xKLO97ETUhnsx0OAFkVE=
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
Subject: [PATCH 6.10 118/121] cifs: Fix signature miscalculation
Date: Mon, 16 Sep 2024 13:44:52 +0200
Message-ID: <20240916114233.022973853@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
References: <20240916114228.914815055@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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




