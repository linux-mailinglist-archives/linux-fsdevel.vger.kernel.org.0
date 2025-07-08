Return-Path: <linux-fsdevel+bounces-54283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98229AFD35A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94881188D361
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC552E54BA;
	Tue,  8 Jul 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wfx05wIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B636225414;
	Tue,  8 Jul 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993567; cv=none; b=DguCt4aRrNbQT/WesVa/MkPQb7Btxkb7Q5DBdnZhvxi4L17UiZdVEFlS+7HH/ZlM2Y1jVx7/BZA5n+GxaX4wZkwGoPHyYpraKc4FkScaB85rSK5rq/JwEL6JOQ93mr1c8N4rd8H2ENiCuN++E1ZsSZe9bTyMl+4Y9jrcPyR2OCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993567; c=relaxed/simple;
	bh=LmsVsq75sclLyI+ct6JiksOp5LbW3JLhM7RsiP0+GaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7x1vOzqm+1xa+3/lBH3JQZ7C19r4Dhma6DoDx5A5dLjMhI02xQBbru8wcNPMEUFojuO7bEGajtNkv5OXVDw+jNwRNi5vHOLBilSoepAoTiAYTU79pDDNnLcyB9SraTmkp3gT/UjVJM8knIoaP3CslmCNW1uwjV879MZ+FyLiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wfx05wIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD24C4CEED;
	Tue,  8 Jul 2025 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993567;
	bh=LmsVsq75sclLyI+ct6JiksOp5LbW3JLhM7RsiP0+GaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wfx05wIr41ENhyQX/Myk3Eo+7nIyLcyTzQhBUkOPiC9ngdZtD81XSexGLWse/+XnR
	 GHprA+pJA5FxL7O1zhc4tejE3dAxLwBItfKUR3X88ElTjUD4hdx73QAGzXLil7s/W6
	 ZJD9XETwGkk87ITBz3ehS2AqMjsJLxvziyCqdio8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 119/178] netfs: Fix double put of request
Date: Tue,  8 Jul 2025 18:22:36 +0200
Message-ID: <20250708162239.713614529@linuxfoundation.org>
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

[ Upstream commit 9df7b5ebead649b00bf9a53a798e4bf83a1318fd ]

If a netfs request finishes during the pause loop, it will have the ref
that belongs to the IN_PROGRESS flag removed at that point - however, if it
then goes to the final wait loop, that will *also* put the ref because it
sees that the IN_PROGRESS flag is clear and incorrectly assumes that this
happened when it called the collector.

In fact, since IN_PROGRESS is clear, we shouldn't call the collector again
since it's done all the cleanup, such as calling ->ki_complete().

Fix this by making netfs_collect_in_app() just return, indicating that
we're done if IN_PROGRESS is removed.

Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the waitqueue used")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250701163852.2171681-3-dhowells@redhat.com
Tested-by: Steve French <sfrench@samba.org>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/misc.c              | 9 +++++++--
 include/trace/events/netfs.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index d8b1a279dbda9..8b1c11ef32aa5 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -383,6 +383,11 @@ static int netfs_collect_in_app(struct netfs_io_request *rreq,
 {
 	bool need_collect = false, inactive = true, done = true;
 
+	if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_recollect);
+		return 1; /* Done */
+	}
+
 	for (int i = 0; i < NR_IO_STREAMS; i++) {
 		struct netfs_io_subrequest *subreq;
 		struct netfs_io_stream *stream = &rreq->io_streams[i];
@@ -442,7 +447,7 @@ static ssize_t netfs_wait_for_in_progress(struct netfs_io_request *rreq,
 			case 1:
 				goto all_collected;
 			case 2:
-				if (!netfs_check_rreq_in_progress(rreq))
+				if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 					break;
 				cond_resched();
 				continue;
@@ -512,7 +517,7 @@ static void netfs_wait_for_pause(struct netfs_io_request *rreq,
 			case 1:
 				goto all_collected;
 			case 2:
-				if (!netfs_check_rreq_in_progress(rreq) ||
+				if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||
 				    !test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
 					break;
 				cond_resched();
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 4175eec40048a..ecc1b852661e3 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -56,6 +56,7 @@
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
+	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
 	EM(netfs_rreq_trace_set_abandon,	"S-ABNDN")	\
-- 
2.39.5




