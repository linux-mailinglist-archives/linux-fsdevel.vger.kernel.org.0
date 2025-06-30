Return-Path: <linux-fsdevel+bounces-53287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B6AED2B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096B116A824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733621E0B2;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ki9TcBRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E6199947
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251985; cv=none; b=Sa4DdJhwEGYUMgPXJr02K4tNX7LPTP+BwN6Zm3QZLH3K3Mvr409RiVQGS6wfF2+p1lo1cZ1KvcuBfZdRtQp5kmcU09GeM23dZlSjsfVwLq+ImHupy1+G8JQTP2qVRfhWDcHBrJFVQ5v3YUndPAA0YkF0qAspgq9At8VN8tn2mWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251985; c=relaxed/simple;
	bh=sfh7DkwmTPCPAaxAIJg+lc6BHZFPDlmP9C10tJX2EBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urg+KwNA8i9yiHDDh07k2da68OFC/2wwTO4XiMRXk4FbCK226dEhQyegl4uh1ePeQgpttlAaFwpnWKkAqPtycJ1UA04Opbvovn1CK+kpQxWsY0pMlk/w8/v1PMykNGaC6bedU8B7T+nhx9lrkt5IU5TE8EbE/r+OgBR9zeemexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ki9TcBRd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZfvOgTZiVseAGucA/3J2fRpSIOnjykXkfRHIbB8/Kr8=; b=Ki9TcBRdXLX1tDnENZz/nT1VCp
	O9ARJEJ0q8FIO3hAH/V15uBXuzaTkDJDmIpHmtpdQN/NM30krU3LP+pW9DLiBLOq7azACA8UeJEm6
	/8xTkgAH7QFdnFhSXXo5YsNFmTN0I3tCKfkQloMlbSbyCxLkR/xk8+ymXPg2ichMwT+AQ1VVC9fj3
	4jPaer6oHJbvnwG83+emArfO0XtruoWYQWeVW0FB7ZyEWfvqqP5uTThK2LPfVo7kPr2Rx5jXHt2fu
	4qAiV8XPU0IxWNiH7wuS8E2gteaMMRiM7fvYEuAUr7O65X1mFXmEZHyT4UP1uKT+QTtvZqF4v0LU3
	y7k9B4lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dh-00000005p5I-10Ze;
	Mon, 30 Jun 2025 02:53:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 47/48] invent_group_ids(): zero ->mnt_group_id always implies !IS_MNT_SHARED()
Date: Mon, 30 Jun 2025 03:52:54 +0100
Message-ID: <20250630025255.1387419-47-viro@zeniv.linux.org.uk>
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

All places where we call set_mnt_shared() are guaranteed to have
non-zero ->mnt_group_id - either by explicit test, or by having
done successful invent_group_ids() covering the same mount since
we'd grabbed namespace_sem.

The opposite combination (non-zero ->mnt_group_id and !IS_MNT_SHARED())
*is* possible - it means that we have allocated group id, but didn't
get around to set_mnt_shared() yet; such state is transient -
by the time we do namespace_unlock(), we must either do set_mnt_shared()
or unroll the group id allocations by cleanup_group_ids().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ca36c4a6a143..a75438121417 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2516,7 +2516,7 @@ static int invent_group_ids(struct mount *mnt, bool recurse)
 	struct mount *p;
 
 	for (p = mnt; p; p = recurse ? next_mnt(p, mnt) : NULL) {
-		if (!p->mnt_group_id && !IS_MNT_SHARED(p)) {
+		if (!p->mnt_group_id) {
 			int err = mnt_alloc_group_id(p);
 			if (err) {
 				cleanup_group_ids(mnt, p);
-- 
2.39.5


