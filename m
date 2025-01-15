Return-Path: <linux-fsdevel+bounces-39269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4AA12061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863511688D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE4248BC6;
	Wed, 15 Jan 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VPCk4Fpy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DC248BAC;
	Wed, 15 Jan 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937860; cv=none; b=H4jVGmcMtebwAbhgEBspRBJgZM9pfI69GZ9x8cA/KahE9vZkKPw4lURaOt56vRYIYNVDvPsMuOfG9wsCCsWq81t772u/eUz03EiDVjYUAnPcve27pN2a1XXbJWsvR73qDvKpaVUi7bj48oNmpKObly4f1Z3IA2P5VBy/gFl1AQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937860; c=relaxed/simple;
	bh=4lZsvhy5OevP60JRvEHP5t+uOh7DrOOMg9mCuTzncHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLsRZq5nHfBs71oIFrdCv631PBB6eFgmhX31GL0op/L+imFyOqkE39GJml/A8PsBPBgmmT6xG3QVSC9Na/EQnJOpAM3LECTjn5WjIfiaIFwG2Y5lfxaljc23ysTdqDdtBIJtitvE4I2HNgL7ElZt5aoQtIqrsVNha/6RPjsQ1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VPCk4Fpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48242C4CEDF;
	Wed, 15 Jan 2025 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937859;
	bh=4lZsvhy5OevP60JRvEHP5t+uOh7DrOOMg9mCuTzncHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPCk4Fpyui+BkD98BHlK+m2BwROUwErHhfUbogUZUeQ+yUxn8zvyV34r7Lqmrjfi5
	 LLxgSrDtJNzLJLYgF4ry15bqwEH95T6s3Z1jAag8hDl3/VV+3UnjdS40eLwRgjcLxk
	 MCYd9YQRzsF29gQ53QOieqbagsMHxnM4J1jMNsv4=
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
Subject: [PATCH 6.12 013/189] netfs: Fix the (non-)cancellation of copy when cache is temporarily disabled
Date: Wed, 15 Jan 2025 11:35:09 +0100
Message-ID: <20250115103606.891121830@linuxfoundation.org>
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

[ Upstream commit d0327c824338cdccad058723a31d038ecd553409 ]

When the caching for a cookie is temporarily disabled (e.g. due to a DIO
write on that file), future copying to the cache for that file is disabled
until all fds open on that file are closed.  However, if netfslib is using
the deprecated PG_private_2 method (such as is currently used by ceph), and
decides it wants to copy to the cache, netfs_advance_write() will just bail
at the first check seeing that the cache stream is unavailable, and
indicate that it dealt with all the content.

This means that we have no subrequests to provide notifications to drive
the state machine or even to pin the request and the request just gets
discarded, leaving the folios with PG_private_2 set.

Fix this by jumping directly to cancel the request if the cache is not
available.  That way, we don't remove mark3 from the folio_queue list and
netfs_pgpriv2_cancel() will clean up the folios.

This was found by running the generic/013 xfstest against ceph with an
active cache and the "-o fsc" option passed to ceph.  That would usually
hang

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241213135013.2964079-11-dhowells@redhat.com
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_pgpriv2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index ba5af89d37fa..54d5004fec18 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -170,6 +170,10 @@ void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
 
 	trace_netfs_write(wreq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
+	if (!wreq->io_streams[1].avail) {
+		netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+		goto couldnt_start;
+	}
 
 	for (;;) {
 		error = netfs_pgpriv2_copy_folio(wreq, folio);
-- 
2.39.5




