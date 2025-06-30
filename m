Return-Path: <linux-fsdevel+bounces-53255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64E7AED295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400E216463D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F931E0DCB;
	Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lgOEFyIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516117BED0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=ueb11BIpcqRw6qlnCOA6RnOvZxBf+r5CRo/tTxTVQS2PPlonvnWaqp2gvzv3sdVllFxGSBFkMx+n1sLKYhHxtEZCJ1xojnuAb4Nf8fTczzmko2ntkimOmSxwxbguYl91KTlIr9RXMFJ+FqmOgXiPvsTPaAvfF1sOnGUnAsVbOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=pwpjO0ricdUZa6Zzu0H7c1KfMk0kdItipczz4MVOdHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJEgMbusuKzPkdWV/sABYTSaJBH1pO0rjXIS5RARxuzXcagbldvlVw+PBQp5PIq8VF+dAVOacH2ZoPo29BbEQqZe3TQmK5DYqbhUQrNzV+E44nhdgviC0GFfACK3s/M+liw6MfuefwfzRLBr53SYJay4jNqjM4FwkAsM719QGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lgOEFyIw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gW31xWMjyo2BHFHEjFqfTM22eOyUjxbqVPvZ7AeJZL0=; b=lgOEFyIwIgoNtGKnLAcPU+zCsn
	b9sP8ZNy3VlzvCUYU4d8cMfwQiZOYORPY/ghpmL5R1BAQCfoDMRgVfvI9jeE/7jpumKYkp2A6pE7Z
	fkp5vDivpEA4CZK6+ePFpNccOB3UQsYk6XHJbOB7kaElMszFpM88Pvt27w8rKGrLbmjuiaOuZgFj6
	ucNYrkl3TgtJtFn0GSr0UB4/uPI11OJTUP3dScYBqyJgbvwUVkgKywn5gVFulm+gpXGPPtKAmLvsr
	TKxlafRLawxegzAp7YAucu0VPsU4vLTD7+iEABLQP8456tfZhfW0oCBkV+2zqySJ6btVXnh2mDDlc
	KtVTmWIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005owI-03n5;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 06/48] pnode: lift peers() into pnode.h
Date: Mon, 30 Jun 2025 03:52:13 +0100
Message-ID: <20250630025255.1387419-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
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


