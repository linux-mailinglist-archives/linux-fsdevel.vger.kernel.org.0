Return-Path: <linux-fsdevel+bounces-54280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A7AFD334
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B51C3B8223
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73BC2E5B09;
	Tue,  8 Jul 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mW7biP2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAE2E54C3;
	Tue,  8 Jul 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993510; cv=none; b=E3j5tQ6MsiWp+kzBTabA4ZHJSiLFNE+yz50CuT0ZAN8eWmp4eirtayw4EiE9J6M2+CBXllk4RaIZRUoLYgXBh1sIMIktZt67nYnDJDpbqA8cmOXBqxA1NIp2GMywQAJZHbsyXtLJCCC3/I7ETzV4taXFC6ZunP5H0wtgg8wLklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993510; c=relaxed/simple;
	bh=bhIAbamWKyn9yledia7qxwF7JvPYu8BScFWI4uzWh/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7LNcbpGbfQrpnRA+mjEvYSENtUwllSnHQjrVHnMe7qqCTu0bSMlKDhooXUJhIceJxvxbP30Y7j2gvCT/Q/CRz+Sz5+i55sDKEhgo3aLIdfxuqeslC5R0SJRkz4bQkTffPWkM+bXrTG8l2n11IjuDLvrr5DaqBx1NIqtWR/U0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mW7biP2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D0FC4CEF0;
	Tue,  8 Jul 2025 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993510;
	bh=bhIAbamWKyn9yledia7qxwF7JvPYu8BScFWI4uzWh/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mW7biP2gtUp5ElZoGpWSbMXStSwDpz8dmldUlvcgAds1adkV7JckohVaqqVbafznx
	 CxOZdquld9RM04PqRVW0keOZICia6ePLpkOPOile6oCzrNM9kFBlD3JRnYtFs46dZA
	 DnKlEtK43qFhuoLQsSlZVFPH3qx7pZwlnKTVBfng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 098/178] netfs: Fix looping in wait functions
Date: Tue,  8 Jul 2025 18:22:15 +0200
Message-ID: <20250708162239.211969217@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 09623e3a14c1c5465124350cd227457c2b0fb017 ]

netfs_wait_for_request() and netfs_wait_for_pause() can loop forever if
netfs_collect_in_app() returns 2, indicating that it wants to repeat
because the ALL_QUEUED flag isn't yet set and there are no subreqs left
that haven't been collected.

The problem is that, unless collection is offloaded (OFFLOAD_COLLECTION),
we have to return to the application thread to continue and eventually set
ALL_QUEUED after pausing to deal with a retry - but we never get there.

Fix this by inserting checks for the IN_PROGRESS and PAUSE flags as
appropriate before cycling round - and add cond_resched() for good measure.

Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the waitqueue used")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250701163852.2171681-5-dhowells@redhat.com
Tested-by: Steve French <sfrench@samba.org>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/misc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0a54b12034868..d8b1a279dbda9 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -425,8 +425,8 @@ static int netfs_collect_in_app(struct netfs_io_request *rreq,
 /*
  * Wait for a request to complete, successfully or otherwise.
  */
-static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
-				      bool (*collector)(struct netfs_io_request *rreq))
+static ssize_t netfs_wait_for_in_progress(struct netfs_io_request *rreq,
+					  bool (*collector)(struct netfs_io_request *rreq))
 {
 	DEFINE_WAIT(myself);
 	ssize_t ret;
@@ -442,6 +442,9 @@ static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
 			case 1:
 				goto all_collected;
 			case 2:
+				if (!netfs_check_rreq_in_progress(rreq))
+					break;
+				cond_resched();
 				continue;
 			}
 		}
@@ -480,12 +483,12 @@ static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
 
 ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
 {
-	return netfs_wait_for_request(rreq, netfs_read_collection);
+	return netfs_wait_for_in_progress(rreq, netfs_read_collection);
 }
 
 ssize_t netfs_wait_for_write(struct netfs_io_request *rreq)
 {
-	return netfs_wait_for_request(rreq, netfs_write_collection);
+	return netfs_wait_for_in_progress(rreq, netfs_write_collection);
 }
 
 /*
@@ -509,6 +512,10 @@ static void netfs_wait_for_pause(struct netfs_io_request *rreq,
 			case 1:
 				goto all_collected;
 			case 2:
+				if (!netfs_check_rreq_in_progress(rreq) ||
+				    !test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+					break;
+				cond_resched();
 				continue;
 			}
 		}
-- 
2.39.5




