Return-Path: <linux-fsdevel+bounces-67043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5BC338F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3621A465C1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919523D7F3;
	Wed,  5 Nov 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt1aLowJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D23BCFD;
	Wed,  5 Nov 2025 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304019; cv=none; b=M9q+s2Vx3F8OAgWlzIijr3R06rZ879p52Qu2R5mPLuFEBur95SltroSXWe4K4RauBV6gmbBZMZE0SOiX3xQ4MvWari4D+qFTOF1MWQqZm4R523Zda+HJGMZdejlaaAJrfwAc0FxRF/+aPJ1kXihp4N9A2+vQoTLa0BjrfV0Vr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304019; c=relaxed/simple;
	bh=yuPf1GRvbePvWROZdHUDkRtswa57g94DPqiuL9w/plw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpuWOmvdegxZhjHxq4dVoUkZowWIYCneD40r+CRZ/Lv2hI8pqKo1g/ZalvGUpSdJkWQyQ2+SZTD4ntmNolLCXMN4Q4BIxARWWgrleCea/72nAGORqHLu6yxsofhrDPVl09tPIeM1VeEAM3KMkqnDU3dEvBzrAPXIIFrctUOhk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt1aLowJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7832DC4CEF7;
	Wed,  5 Nov 2025 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304018;
	bh=yuPf1GRvbePvWROZdHUDkRtswa57g94DPqiuL9w/plw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Yt1aLowJMDwJfAM4C/QOOgb0CATm5BQhCTLLIKuN+0uKVjiwG/3q9u1x+3W6IdgAC
	 Z713wpltX1em4I7WOrCaUoJNuyMUUFsxDI9sqDdvwaWe0Hlu3TFfXnv8bGmbWY28fT
	 /D1cnaSTOHaINvJ0L/m1PwN9RK3VyIIC0E0U7OEAkZ6byfw3KMoslPWkM5LNZWe2NP
	 eolfV2KrC/D2S3PBFbfLqmiDL9yqmKTBhfhPcwa+HUqXERg1g8jtuVFV/I3mmCvyOO
	 b6BEvOBu9RhMfhwTL1q6P7pfDvGSD5U+O1heb28+Wx72HKBTpcUoNmHocINOKOEM07
	 pCRCF0fWpVp+g==
Date: Tue, 04 Nov 2025 16:53:38 -0800
Subject: [PATCH 20/22] xfs: merge health monitoring events when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366128.1647136.4178585393135821433.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Reduce memory consumption and event traffic by merging healthmon events
whenever we actually add an event to the queue.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_trace.h     |    1 
 fs/xfs/xfs_healthmon.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)


diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e5d95add53d347..520526ef9cd11c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6143,6 +6143,7 @@ DEFINE_EVENT(xfs_healthmon_event_class, name, \
 	TP_PROTO(const struct xfs_mount *mp, const struct xfs_healthmon_event *event), \
 	TP_ARGS(mp, event))
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_insert);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_merge);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_push);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_pop);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format);
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index e5715f52f4b218..b46b63e62d5143 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -143,12 +143,112 @@ xfs_healthmon_free_head(
 	return 0;
 }
 
+static bool
+xfs_healthmon_merge_events(
+	struct xfs_healthmon_event		*existing,
+	const struct xfs_healthmon_event	*new)
+{
+	if (!existing)
+		return false;
+
+	/* type and domain must match to merge events */
+	if (existing->type != new->type ||
+	    existing->domain != new->domain)
+		return false;
+
+	switch (existing->type) {
+	case XFS_HEALTHMON_RUNNING:
+	case XFS_HEALTHMON_UNMOUNT:
+		/* should only ever be one of these events anyway */
+		return false;
+
+	case XFS_HEALTHMON_LOST:
+		existing->lostcount += new->lostcount;
+		return true;
+
+	case XFS_HEALTHMON_SHUTDOWN:
+		/* yes, we can race to shutdown */
+		existing->flags |= new->flags;
+		return true;
+
+	case XFS_HEALTHMON_SICK:
+	case XFS_HEALTHMON_CORRUPT:
+	case XFS_HEALTHMON_HEALTHY:
+		switch (existing->domain) {
+		case XFS_HEALTHMON_FS:
+			existing->fsmask |= new->fsmask;
+			return true;
+		case XFS_HEALTHMON_AG:
+		case XFS_HEALTHMON_RTGROUP:
+			if (existing->group == new->group){
+				existing->grpmask |= new->grpmask;
+				return true;
+			}
+			return false;
+		case XFS_HEALTHMON_INODE:
+			if (existing->ino == new->ino &&
+			    existing->gen == new->gen) {
+				existing->imask |= new->imask;
+				return true;
+			}
+			return false;
+		default:
+			ASSERT(0);
+			return false;
+		}
+		return false;
+
+	case XFS_HEALTHMON_MEDIA_ERROR:
+		/* physically adjacent errors can merge */
+		if (existing->daddr + existing->bbcount == new->daddr) {
+			existing->bbcount += new->bbcount;
+			return true;
+		}
+		if (new->daddr + new->bbcount == existing->daddr) {
+			existing->daddr = new->daddr;
+			existing->bbcount += new->bbcount;
+			return true;
+		}
+		return false;
+
+	case XFS_HEALTHMON_BUFREAD:
+	case XFS_HEALTHMON_BUFWRITE:
+	case XFS_HEALTHMON_DIOREAD:
+	case XFS_HEALTHMON_DIOWRITE:
+	case XFS_HEALTHMON_DATALOST:
+		/* logically adjacent file ranges can merge */
+		if (existing->fino != new->fino || existing->fgen != new->fgen)
+			return false;
+
+		if (existing->fpos + existing->flen == new->fpos) {
+			existing->flen += new->flen;
+			return true;
+		}
+
+		if (new->fpos + new->flen == existing->fpos) {
+			existing->fpos = new->fpos;
+			existing->flen += new->flen;
+			return true;
+		}
+		return false;
+	}
+
+	return false;
+}
+
 /* Insert an event onto the start of the list. */
 static inline void
 __xfs_healthmon_insert(
 	struct xfs_healthmon		*hm,
 	struct xfs_healthmon_event	*event)
 {
+	if (xfs_healthmon_merge_events(hm->first_event, event)) {
+		trace_xfs_healthmon_merge(hm->mp, hm->first_event);
+		kfree(event);
+		wake_up(&hm->wait);
+		return;
+	}
+
 	event->next = hm->first_event;
 	if (!hm->first_event)
 		hm->first_event = event;
@@ -166,6 +266,13 @@ __xfs_healthmon_push(
 	struct xfs_healthmon		*hm,
 	struct xfs_healthmon_event	*event)
 {
+	if (xfs_healthmon_merge_events(hm->last_event, event)) {
+		trace_xfs_healthmon_merge(hm->mp, hm->last_event);
+		kfree(event);
+		wake_up(&hm->wait);
+		return;
+	}
+
 	if (!hm->first_event)
 		hm->first_event = event;
 	if (hm->last_event)


