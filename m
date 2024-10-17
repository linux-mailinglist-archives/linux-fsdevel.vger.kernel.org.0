Return-Path: <linux-fsdevel+bounces-32163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D09A189B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B341F245B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 02:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F340858;
	Thu, 17 Oct 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0oB4kbdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249126AF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131946; cv=none; b=HvhXvTe4r/on/+kIEJuspi5GEh1UfV7sPE5WJ/0AipjLKILEYy5ZNumDvP3BAQzBncefIgYYOWlImfJKhoolk86qLeX5iPSIyaAYTlpfLm2M6MUKL7PasqlKNMze6baV0iogQ5ie79VSeeNb+4u6oPBxpedyF9n1E7jLWE3M428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131946; c=relaxed/simple;
	bh=wCXbIJUe86ygDOAsxu1IOsgumVMsgNInaS8mLesw5fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPNzGN8n3hXjmc5iP4lxmqBN2algwJazBa5RHcOeewOnmUCQa0fvftW5R0tTvLRERCLJUW5VpBbNwd8L9dSF6H4Yq4VSwK6kyzkYX84SQoKOQkMA4vVXH9viBeM0H6FwvfKDh9nD+OHO3Kp3s/y9Y1s6WRqkjI/1lpMF5AmsHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0oB4kbdn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=hE1UxQBVQrdtqi+BJo7WZMEeyQP5GKEXivMsE3kADmk=; b=0oB4kbdn4bEbkLdlh8wr5oScnx
	2/HEm5rHCmksJkm6MkTjhIMAzBJPquwq6Vh/XmL7guBKks0FjBrCv1Hq4ZL4q1li+yguVFSLVDClD
	1s7HDsABpq5WB9Xty0vHzPfGNBpIWtNi1UD40dCaEwklrQxUUlpyLV9TU/n08LGkP2rNkVHMGo5NV
	ZUVHWx+7IjrU1id5ldNs50wq2AWlrFHYXEfXaNiCa5RnIndGai2mmg0RDzIYuddRAaHByuICwrcM2
	cxGSq5la4K2cpZzg/cvC2m/cDBPRZy39Kx3yr3SG4eI8Yy9j0ozJxBPMUDfMpoei2veM06yT9k0yu
	fH0Kl1Pg==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1GCr-0000000DYIe-0Sni;
	Thu, 17 Oct 2024 02:25:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] fs: fix f_ref kernel-doc struct member name
Date: Wed, 16 Oct 2024 19:25:36 -0700
Message-ID: <20241017022536.58966-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate 2 kernel-doc warnings by using the correct struct member name:

include/linux/fs.h:1071: warning: Function parameter or struct member 'f_ref' not described in 'file'
include/linux/fs.h:1071: warning: Excess struct member 'f_count' description in 'file'

Fixes: c0390d541128 ("fs: pack struct file")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
---
L: linux-fsdevel@vger.kernel.org
L: patches@lists.linux.dev

 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20241016.orig/include/linux/fs.h
+++ linux-next-20241016/include/linux/fs.h
@@ -1006,7 +1006,7 @@ static inline int ra_has_index(struct fi
 
 /**
  * struct file - Represents a file
- * @f_count: reference count
+ * @f_ref: reference count
  * @f_lock: Protects f_ep, f_flags. Must not be taken from IRQ context.
  * @f_mode: FMODE_* flags often used in hotpaths
  * @f_op: file operations

