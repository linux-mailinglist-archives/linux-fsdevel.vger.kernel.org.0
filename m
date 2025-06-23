Return-Path: <linux-fsdevel+bounces-52439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB6AE346C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D553A666E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF421DB546;
	Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K+FHRAS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754081C6FF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654472; cv=none; b=MPSCeE0TBBCZnxuSynW6HH2BLaaGNP0WlJH2OmsfRFT2sS+6O71h/HGVQ/la2rAeJ0oXHO4qIajk2A5snklfks+uLly7MvYBDoP6tK1un9esqbGmQUvK0+0ChbtFvX8K9HBMEN1CWVRbXViOXG4Yxtfbg7Yn8lu1C0RZN/T+7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654472; c=relaxed/simple;
	bh=fWzydlJQwIYP5NTUlOOKqIHRgF0/xazrcswlMlOv34E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI5RNrTGTesF3Qf09EnqktOTt1pc38SFS/5FpWMwU9kd5Y1yt2fT9QM7AYhsWfQ0HAt3qcgVKSnRS3EVpjDHkg3ZVTInqVkZxzMan6D9vFbcxmxKZr+ClJnhks5HtquvkFrRqelJKZOiWmJdiaZNkR8x8MX57wDgZf+BeMRHzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K+FHRAS8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fb34o0sKkaf+nETHAlYSCf5rYWqYBEsdEL/2U8pfKlc=; b=K+FHRAS8CoY5H437mLvbTQn+C+
	0c9xsBi5KTgyES3Uda8+54rjN+ajzpbMXZVxQs/Km8rdvRNTxnbTNuXy2ragqKVd/9PGfUoFVndNL
	00HkkjkWMyNuqIXavhG4oJ4/22U7RAxPvZ8TXtxNGpsXXT6aXtC2QlVzA1n6g82BRB2pIL7PEPi2L
	8jC33m6Hgm7fBhDYomEVjI1dc25yTZk1pPC+uZkmUkopGc6E2vK4f0x7GQa+1F7PISwYfyO2SRzJv
	Nlm+XyCj0ZEix/vMjHClVoVpBp2jSbsREfL+IHVcwfKH7Rt244DaDyHQ+2vq8FkljNb2FTJHRGUnp
	9ybbHN+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005Koy-0R6s;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 07/35] constify mnt_has_parent()
Date: Mon, 23 Jun 2025 05:54:00 +0100
Message-ID: <20250623045428.1271612-7-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mount.h b/fs/mount.h
index b8beafdd6d24..c4d417cd7953 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -102,7 +102,7 @@ static inline struct mount *real_mount(struct vfsmount *mnt)
 	return container_of(mnt, struct mount, mnt);
 }
 
-static inline int mnt_has_parent(struct mount *mnt)
+static inline int mnt_has_parent(const struct mount *mnt)
 {
 	return mnt != mnt->mnt_parent;
 }
-- 
2.39.5


