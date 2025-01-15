Return-Path: <linux-fsdevel+bounces-39268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A35A1205C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859E67A0863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9C1E9904;
	Wed, 15 Jan 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMsN3DMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6C248BA6;
	Wed, 15 Jan 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937857; cv=none; b=Ouya1rOajiEw708xQGcotpMgEYD0Ztj7/go0fxeQCcOd5lfHUxsVYfRJpvHI5PEphQw6sSUyOXg8c3mg9DeTi2re0V+vWZWfBIN6FUA+7H6574xu6bp5uDhdhjx/E+01vqBfOuCgeT6voMikt0kR5sWYVrbQmEQTBboRepy10CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937857; c=relaxed/simple;
	bh=Xbt2Z2NNLw93h/+B1/cQ2K3Dh3qMokq8s8q+goERNFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIfywETU8smK6k07AUcU9JtAwJi8kDVmFb+930ogzcoJdVXu5O6WfVhlLn7wnXzkuq4ckHxyjlq/AbkyWIk/1tdqdtEsuz7rh1trJMiMouWCkyaZu1WGbYSyxiJ5ObKrPGebETPp/CfaON9DLmTVrmxtG5zv0l4hf3Jk0oxq83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMsN3DMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D9C4CEDF;
	Wed, 15 Jan 2025 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937856;
	bh=Xbt2Z2NNLw93h/+B1/cQ2K3Dh3qMokq8s8q+goERNFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMsN3DMp49bcutIS5v34DH68H5uM6kOqs9h7vn4iZimYd8hA9E7Ns2vzSVMPj4or6
	 7Z2J2I6lrr3yK0r/xqX4mzV79ZamPlT4H2IuGXZw8NpKF9diG3+Mfn7YTRiHmKA+ih
	 D9sf7IPtmX+R+UhIYes0MoXY5nwY17XAOchrMS8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 012/189] netfs: Fix ceph copy to cache on write-begin
Date: Wed, 15 Jan 2025 11:35:08 +0100
Message-ID: <20250115103606.852383000@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 38cf8e945721ffe708fa675507465da7f4f2a9f7 ]

At the end of netfs_unlock_read_folio() in which folios are marked
appropriately for copying to the cache (either with by being marked dirty
and having their private data set or by having PG_private_2 set) and then
unlocked, the folio_queue struct has the entry pointing to the folio
cleared.  This presents a problem for netfs_pgpriv2_write_to_the_cache(),
which is used to write folios marked with PG_private_2 to the cache as it
expects to be able to trawl the folio_queue list thereafter to find the
relevant folios, leading to a hang.

Fix this by not clearing the folio_queue entry if we're going to do the
deprecated copy-to-cache.  The clearance will be done instead as the folios
are written to the cache.

This can be reproduced by starting cachefiles, mounting a ceph filesystem
with "-o fsc" and writing to it.

Fixes: 796a4049640b ("netfs: In readahead, put the folio refs as soon extracted")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241213135013.2964079-10-dhowells@redhat.com
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_collect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index d86fa02f68fb..e70eb4ea21c0 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -62,10 +62,14 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 		} else {
 			trace_netfs_folio(folio, netfs_folio_trace_read_done);
 		}
+
+		folioq_clear(folioq, slot);
 	} else {
 		// TODO: Use of PG_private_2 is deprecated.
 		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
 			netfs_pgpriv2_mark_copy_to_cache(subreq, rreq, folioq, slot);
+		else
+			folioq_clear(folioq, slot);
 	}
 
 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
@@ -77,8 +81,6 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 			folio_unlock(folio);
 		}
 	}
-
-	folioq_clear(folioq, slot);
 }
 
 /*
-- 
2.39.5




