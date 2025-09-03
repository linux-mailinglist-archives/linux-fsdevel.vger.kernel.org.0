Return-Path: <linux-fsdevel+bounces-60093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB098B413F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91AE543869
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A22DA771;
	Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="muMzslXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB62D8790
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875350; cv=none; b=ZpJG20mUI4051ZSmhArAdE9HYt/tQ11LhNVW05a6p4I/2EH1jcCfkCurdFXntNzZtAM7vQRucgTu8ZCalGpJ6UuNTcJT++qi9+KQ+SiI5gx//4JwBqegwf18v8gRaTuwu9c1IJk7nji4ZZ3anO47ttFF6DMAZD8z6BLsJa62TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875350; c=relaxed/simple;
	bh=Zu40cAwIUxacTnH9J6l9r7s52zQ4PiUBg2U5Tjt6mCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaF+ezADP5FFUq6L3ln0PeLo0iO9msgjY1JtPVGgqTu1/BrSgOFqZuBx9j0ixSPl65KJBDBF+EafJrIizNSpRgfoUBFVAPZElURjlN+ZfjfKxirIalBSfwXuGjQK28Tvo7K7Y3y6RK6sVLjae/C6UiUE3tVai4xiEfeDh+Sh80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=muMzslXa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O6lK8+iiNgppBzw2oVs8EcmuxAHbhSxDZrDwIQza53s=; b=muMzslXa/O5thggeJITqTRK2+q
	g18LsinpfAUh/pR6+/VlUO3UUvqv3hfC8jBi2vSc4hGMXTC0ybrh9I74jOmkDxaivOi9ZO6C8V9R0
	IXHv9vcMy5nfvA/rSZM8yXv0LyLdF4Ge2r1j0bnHzkbt2W3ai83FnK0zQt1/6UIhHJikx6yFyKzSG
	J00hLAyLyNTVCqCKSxMFPFm+syN2BugfNY8wtwAGO7eSvPPLYqBiE1bN5nNbTT48VIW3yDKtDCCXi
	a2qUw3JXb5QbMeGXC54bbM9yJkTeGze8HOV4nW1u5xlqBLsFp7DZJCQz3Gd3CG7lTg4tWgytBXJiM
	UXo2i2fQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX8-0000000ApEb-3jue;
	Wed, 03 Sep 2025 04:55:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 50/65] do_mount(): use __free(path_put)
Date: Wed,  3 Sep 2025 05:55:12 +0100
Message-ID: <20250903045537.2579614-51-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5372b71a8d7a..f977438b4d6e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4098,15 +4098,13 @@ int path_mount(const char *dev_name, const struct path *path,
 int do_mount(const char *dev_name, const char __user *dir_name,
 		const char *type_page, unsigned long flags, void *data_page)
 {
-	struct path path;
+	struct path path __free(path_put) = {};
 	int ret;
 
 	ret = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ret;
-	ret = path_mount(dev_name, &path, type_page, flags, data_page);
-	path_put(&path);
-	return ret;
+	return path_mount(dev_name, &path, type_page, flags, data_page);
 }
 
 static struct ucounts *inc_mnt_namespaces(struct user_namespace *ns)
-- 
2.47.2


