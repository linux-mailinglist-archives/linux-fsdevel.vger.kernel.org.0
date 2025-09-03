Return-Path: <linux-fsdevel+bounces-60081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBFB413E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9AE1BA1296
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3F2D9484;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uxuhhCK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808522D7DEE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875348; cv=none; b=i2+APXckXj2VqYHc7o0xffmjic12xpadHN+u9D5dZPrJj5Vpx8MlAuhh+sZhxD2i4Ikq0cXXGOULvs5CQDvIZezV0nTkdSXMik84F8f4ggQWOWXsc27l/BDskzYw4CltjatRdlkeFnr3Fv5ZvirqudtsoNzVzQL5KxsDFJim2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875348; c=relaxed/simple;
	bh=iAub7YD+5UUSbUI9UtRa+3ECI0BdjbTeqUTeueOf5HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdP4eGb1kd0S+wx2QqZXAxBwWJc4hzUGBP4AvqzfFq6Z1xdwFGUOe73rGmB8nwaezMpI+0hrrwqBgqsDgawHuxKh7VbI+YiHuajq77PjnsSrKr1ljd/sgQBkDklOaeOQP4pBloXUG+UKpIGwLAsGzfc7rX1RlHxM6NkA3YUK+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uxuhhCK8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tmPEWJAbAGXe7sOJHHkXW/VjQefe+DceGuj9y2n/EDE=; b=uxuhhCK8eSnWCJ3WM48Os2EsAn
	Vr5m0/r+QNLFKB11x3VJTist5r+qPv2Z34pycvqHTb17heK0/tuRjCjTUt1d9NciyoA9zfBEE7Qhn
	yeMqTaL7b8h6yr/ThYE+Vv3WEwtRr2jQScnvfEDWC+liWcpuvg3RqCFRwGMjJ4oKSLB5ntZldszw7
	LT43SgTPsq2cDI3ers8H3k2kc+YK37hYud8Ik39NUhYv56sd4YCxqrbSMWSPJRB8kKqcWxHlEQ/Mv
	Tey5QCdrYRmQIBthY9UMEutmq7GOfJGbW/vJjRk1nWBqZJ+91gOiqLQpIb33KUoBG0Zg0dkNjH+Qn
	MEDIvbHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX7-0000000ApCK-0EQp;
	Wed, 03 Sep 2025 04:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 38/65] do_set_group(): constify path arguments
Date: Wed,  3 Sep 2025 05:55:00 +0100
Message-ID: <20250903045537.2579614-39-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f74a0523194a..7da3a589c775 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3359,7 +3359,7 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 	return 0;
 }
 
-static int do_set_group(struct path *from_path, struct path *to_path)
+static int do_set_group(const struct path *from_path, const struct path *to_path)
 {
 	struct mount *from = real_mount(from_path->mnt);
 	struct mount *to = real_mount(to_path->mnt);
-- 
2.47.2


