Return-Path: <linux-fsdevel+bounces-21155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E558FF9D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EC1284B84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2E39FFB;
	Fri,  7 Jun 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZIrDazY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25B17BAF
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725604; cv=none; b=BGdDmoGQPeIK9mtx8JS1JjXeWAd1/uOua89t4PD64Pt+NxxJNI93h/7aLPXU4K4kYxLlm9epUmyIERTSrdlJG93VDOZ6IZUYtCeiLn9dqy+nq36r/1O+WY6ziqYpFTtP+CPlEHPMBOLzaaycbfLEHWotlDX8Zj2awLOnPlS6G+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725604; c=relaxed/simple;
	bh=B8jj4X6GSJr4oh32exWYSro2VtuLyzyy+5pglJaloZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+UpldrV3R+zOTavF2Kafdm2MhMSlpxc2OPNXV2F88GPq1JIaaTWHebAP8iEFb6BxmFJzzdyfFSSZWrXWqHmA1xxCSXkvJ5+KL3Ec5d+T8W2TOZzFLObb2g7ZGpn/cZAxCPxgtM3vjo5/+hslCP6b9BO4oXdVIkPzQTlUkSUqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZIrDazY/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ux5W4RKMVkxHYoSIQfR1y1LIkABcx87HV0CScbR079g=; b=ZIrDazY/cVvJBuLSpp5IF+oIrL
	9xsQnGBZoSrYw/bKbBZ3ZpDFpwo8ixqu0H6v+D005ZKuDXDO2awx0riySEdJwoK+VgjDuQ6eoCDrk
	DBwme4O9KldWlCLLHuvW8S1K7S9CiX/BaFkyCVdFz4sMtr2GRLZVE0jSWecpRiCl9ct1ZGX7R3VMP
	e3XRdNAAY6TjPXKLwczqcaADNaukFhy/lHW18AyyqVRnbzG7P14SkhCKP/fCcCQWGgYT8k5L44A+t
	TEFsh3Oyrq0DMILF3OHQWHtPNUgmbE3WGwDbT05bKl65Fsv5ZqoKZD1RhljsNXp5mQIxJVivVH3qn
	6dX82E8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtc-009xD2-2x;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 19/19] deal with the last remaing boolean uses of fd_file()
Date: Fri,  7 Jun 2024 02:59:57 +0100
Message-Id: <20240607015957.2372428-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/core/uverbs_cmd.c | 8 +++-----
 include/linux/cleanup.h              | 2 +-
 sound/core/pcm_native.c              | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index efe3cc3debba..717880ebdd88 100644
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
index 22cda00cf6a8..d3f943ea1d60 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -95,7 +95,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
  *
  *	CLASS(fdget, f)(fd);
- *	if (!fd_file(f))
+ *	if (fd_empty(f))
  *		return -EBADF;
  *
  *	// use 'f' without concern
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 388fdc226c1a..af5f651c9cc6 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2242,7 +2242,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	bool nonatomic = substream->pcm->nonatomic;
 	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADFD;
 	if (!is_pcm_file(fd_file(f)))
 		return -EBADFD;
-- 
2.39.2


