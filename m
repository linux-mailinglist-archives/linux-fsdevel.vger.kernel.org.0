Return-Path: <linux-fsdevel+bounces-68882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF9C679AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31C2235B70A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61502D7DFE;
	Tue, 18 Nov 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kRoO2gVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931A2D3EE4;
	Tue, 18 Nov 2025 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763444556; cv=none; b=SNQNT4J1yuu2NYKPUviCzkjfa+FbYeus6Z8lQMr3DVDpYyIuIJweYIR0RkTXNtqTWozpLMOFe0t91VNGSMs/D7QCTjxXJdiT/yTkeE3uVqXzuNKYKWoGUIEotpJ74LSF3KYem/DfPcms7II+aVCGnvieqeje5O8bgr1AkG+WFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763444556; c=relaxed/simple;
	bh=TAB6xfNcoq1MQ7hgBWl+/zjNA0lDZRNHIjvmsH/HXxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQFQxWXjOIdVYSarnlUiXvhHwW7WCco8aNwWIOP9S4FvOEyfl5CrD5QMOVw1YEZNgAnU5ENOdOToFttwipLKQVBP9JWvDI8kYF2u3DwCqZTshJPz2ZQrwI0Z9oFCYnANDK+LFcn0IWJ20tdsZhcfp/WYnagtiEsxMXaZKWrt7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kRoO2gVK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wj6NtuoUx6rorSoJrKwRjGX8DQ+3LbRm6UPbWp7kXpM=; b=kRoO2gVK7d/cWqBJ6oqBUlnxJH
	PhTjJHkTsQ83nuQ9+vhtRJ8QzehJ3LyLXh5vXFlKySjTDD2J39bDe/QAeQjkboxVZ3qqGUZIHXKnt
	t2CTLX+Q1auCj0k9O/9fdY+TiRGfykMKhF0OVCj2HS3tmT7w+g5QYzstUb/2rtQknF5pkF2vamB4H
	RYoIoGtUJrv8jQISXhpX1bgNQKTKn/LFLjd7/h5fo4kg7ypdg4GaP8sX0RyEPxEjIEOS/Dr+nz0GT
	JreJhFuS/cYBtc965Q+g0ADUymVs0TT+phfONbdrB9vnyxiJde8/FCIJ/+y7e3z23zj+RnwyTeLEq
	Ww3jTsBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4a-0000000GEhn-42P8;
	Tue, 18 Nov 2025 05:16:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 53/54] kill securityfs_recursive_remove()
Date: Tue, 18 Nov 2025 05:16:02 +0000
Message-ID: <20251118051604.3868588-54-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

it's an unused alias for securityfs_remove()

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/security.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..9e710cfee744 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2258,8 +2258,6 @@ static inline void securityfs_remove(struct dentry *dentry)
 
 #endif
 
-#define securityfs_recursive_remove securityfs_remove
-
 #ifdef CONFIG_BPF_SYSCALL
 union bpf_attr;
 struct bpf_map;
-- 
2.47.3


