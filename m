Return-Path: <linux-fsdevel+bounces-26312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCD5957326
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AE31F22AA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84F3FBA7;
	Mon, 19 Aug 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzr05njY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991B16A934
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091950; cv=none; b=hEJ4ANLcUGAUg5bi6BsQNcgy3pbL06EYtfrjxRio/7ZNJKrWAMElN4+ByPdxfaO+PYQH2mAhQ9z0CiqOsJhGz1YoPW3GCeDglNJeCFZjcDG/iwSQAEWOcFeOeVJ3drS6R7TgmqLArSCu6qX0m3Kk2tif+xNOQeeEknvBtn6r32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091950; c=relaxed/simple;
	bh=3/ehxZFrs3h0ti64UOz7XCm9CjTDl8Se7Uil8ORcz6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEShOE8si0f8IXIvI9iL0KsQNJa50MVm3TLXBGVr/YplrfiM38+VUvgtAfjr2hgM8EnPkI/WZRRLQc+7I6piSKIwBfNn3WFsVukuS4YeXE2tmJAn+wfXhVnOKzQQGmNFLz3+NOBHW2YS2OWJYon8RuB78u0VnUtWK9+jo0CY4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzr05njY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b4432b541aso22291487b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724091948; x=1724696748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr2iQkOey24QchtLiI4W769lUd/hyn418evGeJUJo5E=;
        b=gzr05njYispPgspTsTUFjO7NHAVNBcLTkM5brprrRFctnhKg8JBXvRzdzH4rsgZ2Bk
         7iqFKQnaqjCO/EpL8uq4F+6EQQN8KXwK2pWauvEdTjK3TbBttkYxz+/Z4gqiI75xdi7f
         nofphAXnHE74gKm4uFRo+S758x2zP+iWSEOhd/T0oztZ50AyOWOr3S9JfI0EiDWPvzX0
         vBl13RAYF03vyoldYq1cW7ruKx+0x8GcQnCwCj6HJ8IQLsD+xM3sMX8I492A+6Fm1Qa8
         43xTrwLiGjMo7X9Cca6Q76KslIbOvv0mEZl2pcbecfxX8P86IpQeleJLCY+TsYoLNq/l
         gFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091948; x=1724696748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr2iQkOey24QchtLiI4W769lUd/hyn418evGeJUJo5E=;
        b=iNiMWZTeOTWRjq7FiIqlHiiBm5NDRhpNIUijeS8xzQo+KWX1GBHsJwKz1BSuwkZ/uU
         X1ze0exRnRHJwHJmups2gplLPmuyu3q3Rz0A0pfyEenwiWNfH2x7he4vUiBAT3GnqHvP
         Pz3t89xlCZSeg5Mj6PlUkzQiYKGrN00P1RAJEMjYFPyMsyH0mFNJh3id7aBK1mBxueiS
         LRmln4sZihemoBeYuHWgqHSEcc2ITpZchdIJTB+xfiijkBdb4U58PLEIa0ARg+4FzS/Z
         B7O0bRiR9kB/3CXMHHysFm17GY2+7FqnYTESf83RtDZazDuCIMwMkUcwzvOYlhNWbUUD
         lljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq5VBCkeQa7vMDYoLr/5962UJn4BR5j+Ip991RAw/iFwSf8tOHP7XOWQ14eAJZ9WQDgLl53XcWd3S/UJHz4K+rDtuNiHewBe+/FgQxGg==
X-Gm-Message-State: AOJu0YwQzhfSTyj4TfqjoKojUgrCmydSriOTiX/rbx4g5n+Nm64GnrnC
	XhJVrcfavRS642AEE0U3ntcFYdSQka3DgcvSXvBOkzrEfKCfMjxK
X-Google-Smtp-Source: AGHT+IFnIErRjBjq9G64I0RKKWzPjQ/XaAcXHLqmfm+MtX1JNaJISPO1WJKb6QxZz9qs8bOgkDyF+g==
X-Received: by 2002:a05:690c:f92:b0:63b:f919:2e89 with SMTP id 00721157ae682-6b44e9df250mr101243757b3.2.1724091947863;
        Mon, 19 Aug 2024 11:25:47 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a48esm16701317b3.102.2024.08.19.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:25:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback list
Date: Mon, 19 Aug 2024 11:24:17 -0700
Message-ID: <20240819182417.504672-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819182417.504672-1-joannelkoong@gmail.com>
References: <20240819182417.504672-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case where the aux writeback list is dropped (eg the pages
have been truncated or the connection is broken), the stats for
its pages and backing device info need to be updated as well.

Fixes: e2653bd53a98 ("fuse: fix leaked aux requests")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 63fd5fc6872e..7ac56be5fee6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1831,10 +1831,11 @@ __acquires(fi->lock)
 	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 
-	/* After fuse_writepage_finish() aux request list is private */
+	/* After rb_erase() aux request list is private */
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
+		fuse_writepage_finish(aux);
 		fuse_writepage_free(aux);
 	}
 
-- 
2.43.5


