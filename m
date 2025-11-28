Return-Path: <linux-fsdevel+bounces-70089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3AC90632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B101D3A9652
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 00:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3BA937;
	Fri, 28 Nov 2025 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKY8WmcH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBD191
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288512; cv=none; b=bLPbc8ke+VQyHjDmIPUhXZ3EcQzM2fO/o41O6LKPxbRlzIF6EMsz5rGGzOq/was1iCfs349CyoDFYdffzCP0cvIEgXjmVm9OuqFZElkhbO6ST/UM0QoJZyYb9nOPIqaMw25hQwjWWwkCj39o0ZvZrGNexyoOJin3w470SlZJ6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288512; c=relaxed/simple;
	bh=xRHkLL23BIyz6Zqf2D2YJUkON/oSf/omHD5jcyjrZQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6DAB6O4CgYOBcEJpGpbbY/GcP1lNgv/RtRVnOqphTLjgpDKK8BRVrUWB+HL7y3qhstQ9E6mXNKKQPVkzXlqvwrDZ6Tx/7rqqny3cEBvm3YSpv+27Vw6wpO1J++m4+UcIAhY0u7BxErlJREQVoeGd3dN6zJu3lcXlXWq4KalI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKY8WmcH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TKAhL9+XJimsYDFdfqhDeTexdoWJe+uHZuM8GE2rOTQ=; b=BKY8WmcHH3XJsZe9Ve/6VSZ+B0
	xdsszozgUyDssD0TMqpkTzmiZKqq73K9pwm4keJ1s6zWi2lZr60oQ8J73r/oJF9xMdTyliImXX/L+
	v2/bU0lHaLzAGhSwGAyEUyhVNuuCb4tGuk4egUTh/ovJPP78d50FL3fHSYTGRTGIQljsKsl+IUjId
	WxOgEQJa8hjbTK81dmOX6mgcZSRtHJEKXbhl7QeawVb/ZLZko8f/mfEy6hR9o3CIYTiIWXkeFm/YP
	MaE0by9HX8rdvdy43HEWyrkDuWMVIUaJLlxU7ICZvXSZGXswpnDPors7rv2yxw+ITMbSFj3KeQQkb
	d71H3JJQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOm2F-0000000HKVp-1RoG;
	Fri, 28 Nov 2025 00:08:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] filelock: __fcntl_getlease: fix kernel-doc warnings
Date: Thu, 27 Nov 2025 16:08:26 -0800
Message-ID: <20251128000826.457120-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name and add description for the @flavor
parameter to avoid these kernel-doc warnings:

Warning: fs/locks.c:1706 function parameter 'flavor' not described in
 '__fcntl_getlease'
WARNING: fs/locks.c:1706 expecting prototype for fcntl_getlease().
 Prototype was for __fcntl_getlease() instead

Fixes: 1602bad16d7d ("vfs: expose delegation support to userland")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Feel free to correct (or tell me) a better description for @flavor.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/locks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20251127.orig/fs/locks.c
+++ linux-next-20251127/fs/locks.c
@@ -1681,8 +1681,9 @@ void lease_get_mtime(struct inode *inode
 EXPORT_SYMBOL(lease_get_mtime);
 
 /**
- *	fcntl_getlease - Enquire what lease is currently active
+ *	__fcntl_getlease - Enquire what lease is currently active
  *	@filp: the file
+ *	@flavor: type of lease flags to check
  *
  *	The value returned by this function will be one of
  *	(if no lease break is pending):

