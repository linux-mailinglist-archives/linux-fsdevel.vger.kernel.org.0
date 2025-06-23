Return-Path: <linux-fsdevel+bounces-52438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F061AE346D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE502188F144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B7B1DB346;
	Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jwoTwXHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8811C84A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654472; cv=none; b=FZ9r+1D0d1cq81ru2Lo82BHb/McFB2zhJ2o03StpFQTmY5p9dmWvF5JjclR52P1XST1VHwcvAeLOBhKADKPrLNhdASVOWF5y7meVU2lr31xIvWkBRHS0vmr5a1J/0yHv6cGgHECZHf1gfVj6J7f+YcNEKYkrTHYQ1LaRfo1oO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654472; c=relaxed/simple;
	bh=pwpjO0ricdUZa6Zzu0H7c1KfMk0kdItipczz4MVOdHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmSarOxtmSkqVPhoC968DS1pNUY0SkrVtFoGzMjbr8EO+WRbcg1+CVFJKZ8oX2A5QOebZMNWccUpdh+5NymPflSq7Cz9E4Rchn1DvKfzlNchQo9vFgvE29Ic2VLhzt8ytZCuDeTGLgWB8/H1xwvabSKxp++ictvpqDFheCc03nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jwoTwXHT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gW31xWMjyo2BHFHEjFqfTM22eOyUjxbqVPvZ7AeJZL0=; b=jwoTwXHT3YLvnwA7RlcjHABi0O
	l/IV2+lO/szwisuP8c/+FhC3G1EX6gxFnaZd3N4r+mR6v4jRTyzvbZh27O19QisyZR5VZLN3t2jRF
	8fenyQijSkdleNVIZE16h2Z1Zj+a9HWfbI4i5rhbUNXJ9ZOMvf+TcdXHlB/wlllon67efmPsLuW+J
	7q6Dbk/6IUOWgJ9AcPnnYPjTWTWyuercjG3OPaP3GVFjHiKiXMy3VgCR/J3t9s9TzluEkDsqVsEU/
	RQDI0Kte741xQzvBPEnqc/+7ut5KHTP/qwscCdSDp97LamadLvFcoBTyMOPK1En3RbwT4qztBTJv/
	oanITdnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005Kp4-0nzw;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 08/35] pnode: lift peers() into pnode.h
Date: Mon, 23 Jun 2025 05:54:01 +0100
Message-ID: <20250623045428.1271612-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

it's going to be useful both in pnode.c and namespace.c

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 5 -----
 fs/pnode.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index ffd429b760d5..aa187144e389 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -216,11 +216,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 static struct mount *last_dest, *first_source, *last_source, *dest_master;
 static struct hlist_head *list;
 
-static inline bool peers(const struct mount *m1, const struct mount *m2)
-{
-	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
-}
-
 static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 {
 	struct mount *child;
diff --git a/fs/pnode.h b/fs/pnode.h
index 2d026fb98b18..93fa9311bd07 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -34,6 +34,11 @@ static inline void set_mnt_shared(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_SHARED;
 }
 
+static inline bool peers(const struct mount *m1, const struct mount *m2)
+{
+	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
+}
+
 void change_mnt_propagation(struct mount *, int);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
-- 
2.39.5


