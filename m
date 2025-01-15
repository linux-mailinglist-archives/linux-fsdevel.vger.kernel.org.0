Return-Path: <linux-fsdevel+bounces-39267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48DA12056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B42B1883C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4489248BC5;
	Wed, 15 Jan 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VtRc5lJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD0248BBC;
	Wed, 15 Jan 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937854; cv=none; b=ClABhwFuPK1rtJ4AENUuMCuXJU59Rwg2WCgsOt44mZjQvgkTthTn62Ny7ri4tAeCuMA/BNKBnyIepehzjHfNAcDpllJun/MJC05GrgU611qdEunU0xQI7nctOei2IWXRrMzSMm4YEWt72WM5SJglPSaT2VybI9UO2hutrLv4teA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937854; c=relaxed/simple;
	bh=SokORilNrdtX0azQHZD2AlkmgpyP55TQ9cV9EkwBSyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxTjMuVRQFIUC3cpnbAx3dp2+LA0EhcaiWV2Fs4yswQhA9ZbaVpt8HqRxQq/r2BAFf7+1IThk3i+4Kd6kf7p+CY4gelc46DSLOAhMKoI5vCrNZbAlLIMZbiVr1jWNWfXal3urj/fGO1IeUUTyI7rSu1PJBK8PvqBkC+adyaTJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VtRc5lJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF3AC4CEE4;
	Wed, 15 Jan 2025 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937853;
	bh=SokORilNrdtX0azQHZD2AlkmgpyP55TQ9cV9EkwBSyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtRc5lJ+Ya7+yxyhMWVrKntoy/WFGf/EEcpYZzV/gM8YQMuvW594CQJs2VB6iaKJ+
	 Mq89MKI7yGpgZf8Ht2L2nrfxpOeKKJhMIfnBKKAiwij8MliHiLpc/tdTbr9crNHiHO
	 Ac+B3njjQNkKrdhkeF+rZkZYLvZVCJGrH+0yWbuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Akira Yokosawa <akiyks@gmail.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/189] netfs: Fix missing barriers by using clear_and_wake_up_bit()
Date: Wed, 15 Jan 2025 11:35:07 +0100
Message-ID: <20250115103606.813324642@linuxfoundation.org>
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

[ Upstream commit aa3956418985bda1f68313eadde3267921847978 ]

Use clear_and_wake_up_bit() rather than something like:

	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);

as there needs to be a barrier inserted between which is present in
clear_and_wake_up_bit().

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241213135013.2964079-8-dhowells@redhat.com
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
cc: Zilin Guan <zilin@seu.edu.cn>
cc: Akira Yokosawa <akiyks@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_collect.c  | 3 +--
 fs/netfs/write_collect.c | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3cbb289535a8..d86fa02f68fb 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -378,8 +378,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq)
 	task_io_account_read(rreq->transferred);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq, false);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1d438be2e1b4..82290c92ba7a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -501,8 +501,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		goto need_retry;
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
-		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
-		wake_up_bit(&wreq->flags, NETFS_RREQ_PAUSE);
+		clear_and_wake_up_bit(NETFS_RREQ_PAUSE, &wreq->flags);
 	}
 
 	if (notes & NEED_REASSESS) {
@@ -605,8 +604,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 
 	_debug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
-	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 
 	if (wreq->iocb) {
 		size_t written = min(wreq->transferred, wreq->len);
@@ -714,8 +712,7 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	clear_bit_unlock(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	wake_up_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* If we are at the head of the queue, wake up the collector,
 	 * transferring a ref to it if we were the ones to do so.
-- 
2.39.5




