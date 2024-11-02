Return-Path: <linux-fsdevel+bounces-33531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1D59B9D26
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D508B23131
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A761AB6C4;
	Sat,  2 Nov 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ff1q850F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8033158DD8;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524116; cv=none; b=Akm+GC49SMlTYrs3XENsIctqVw5jKNRXosA+W6m01wI2qzSZ7kJc9GKw9JnyAq32oVmS+vl9TOqFZdm5GuBikKtH0vJQxsUQf9JHlqlnE14zaLPwxpbzR+CSn8qDvncua+gVwMrHQt10HJXku9OzHw7YOvUFBxdVNhJPusMu6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524116; c=relaxed/simple;
	bh=uyhGV8/aa7J8vd55zSJKXW39SXIpy1CmxRllgr4PuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+x5iLZmqRvXPw5/HL4Y7D79pBs//fXgtRvjYt5YKqy53xeMmS9AMgNE8JZ+6qdT2MeMWhJtqyf9Dww1jTWfiXlQ9LZ61zXgp9TfIzfbum5biNZrhyjmyLzvuP6VJlDd2hpax6o5Sdeo42keVkhUAgpVrjyK7RbubxLLxNnnFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ff1q850F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x2pCegbzwUsoMGPlduT/TiBDVwZvvFx02OPb7eHG2Yw=; b=Ff1q850FzDU9qU49eX+l6YkzOr
	naF33BEh1Dit8X8hviiyTfEe/vqlmXduyvq52RqCHPhKYJnjKXLi8hRYoCya7XsIN/LjLmwNdkuWa
	ogCOOcrUKetzweSjxOhfJoQ0ZtGheo8dAQAgMzgFwSPjDfQt8eHMc2qDHAbOr5WsTKDqEeMGj40Et
	HPRkpFU7l7Fcg7yBg6LJfyeGbgPqPvUdsw56F4iAi8vc3hJGqiVFhbyF/+QvmBQD4YpKY3nMlmF3D
	5tJ8Q164npUGNzxaoKuegX4r6uOYW495th98Hyzw4B0ILhAS+C6zYZZB/8bmTv1pQgd7BGl8FLHeF
	7P85xzRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76ND-0000000AHoc-0pLo;
	Sat, 02 Nov 2024 05:08:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 28/28] deal with the last remaing boolean uses of fd_file()
Date: Sat,  2 Nov 2024 05:08:26 +0000
Message-ID: <20241102050827.2451599-28-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
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
 drivers/infiniband/core/uverbs_cmd.c | 8 +++-----
 include/linux/cleanup.h              | 2 +-
 sound/core/pcm_native.c              | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a4cce360df21..66b02fbf077a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -584,7 +584,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	if (cmd.fd != -1) {
 		/* search for file descriptor */
 		f = fdget(cmd.fd);
-		if (!fd_file(f)) {
+		if (fd_empty(f)) {
 			ret = -EBADF;
 			goto err_tree_mutex_unlock;
 		}
@@ -632,8 +632,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 		atomic_inc(&xrcd->usecnt);
 	}
 
-	if (fd_file(f))
-		fdput(f);
+	fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
 	uobj_finalize_uobj_create(&obj->uobject, attrs);
@@ -648,8 +647,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	uobj_alloc_abort(&obj->uobject, attrs);
 
 err_tree_mutex_unlock:
-	if (fd_file(f))
-		fdput(f);
+	fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
 
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 038b2d523bf8..875c998275c0 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -234,7 +234,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
  *
  *	CLASS(fdget, f)(fd);
- *	if (!fd_file(f))
+ *	if (fd_empty(f))
  *		return -EBADF;
  *
  *	// use 'f' without concern
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b465fb6e1f5f..3320cce35a03 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2250,7 +2250,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	bool nonatomic = substream->pcm->nonatomic;
 	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADFD;
 	if (!is_pcm_file(fd_file(f)))
 		return -EBADFD;
-- 
2.39.5


