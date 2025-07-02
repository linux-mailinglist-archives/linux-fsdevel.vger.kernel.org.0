Return-Path: <linux-fsdevel+bounces-53723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF292AF63CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3D7A661C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89F239E63;
	Wed,  2 Jul 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QcK29Qvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FD1E9B3D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490853; cv=none; b=XhAdQ58v00Lcn9c10zgh5L9JkvBXrlAsx2GEJlrfPIgcgIAwl7d8JFTSb+bA6Ya+CgF+MQhvVcgG1mF3WDJunTD8jdTJZ+nezawJxvSF6H9UAdbR2cIqxOPRV6jPNrXKQnID3i2i9O84V7MIvVoKFHg/KbmbCQ2vtvQMZtrHZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490853; c=relaxed/simple;
	bh=7lMBh5zKwPgWwFJFPiRUVHEnX2zuR2mfhFN3lYyaVyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAQ92UK19v05rTr3/BFzN4Sl3YqZXOQh+H+eqIz1JGyTu8ZKXolwdR5fjUaQTR5AqIOCl+MKIeqsEGbo2eXJ+utyN2u7FhFo6d3JMUH+Eyunbp1fftMPatZuCnU3r94YnJyjgOcdgmsUhv6ihnAoVTRhRJEq5CmsMx5M+q+ADok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QcK29Qvs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0lnNT7VXFrd5hFSMTB8A5PSAxW/oCHup8N9yaRGth44=; b=QcK29QvsYVGRGkdCtd/fjh8LFU
	OUvu58zeu0jFID8JeERStNKf+LjLUxo1VxxdSo+xJq4c+Z1e4dP6Td8akMwn1K4iNffENyJBRh+55
	U3ddwQjPDeUbyPmEaLNjca+pq7QdU8eXdISrZ5GmM8goDfLsxj14glmkH2iDMjlPkQqnCC3uAVBsO
	f8o4a9QPYaLA6LoWjzxagmyg1xj/Dr6oSJG0dvq62lWMmB0ab1w+C9PnAEhAjzC4Vpe/Z53Pl2YJe
	itm8IOsGuPsdyJFPYSWB2842A0LRRaV6EW1vQihPRcXwgNgaYTG+PA8D/wSUJslXAdv+ZuW74fUgA
	3YRMgXBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4mO-0000000EImB-3Cny;
	Wed, 02 Jul 2025 21:14:08 +0000
Date: Wed, 2 Jul 2025 22:14:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/11] zynqmp: don't bother with debugfs_file_{get,put}() in
 proxied fops
Message-ID: <20250702211408.GA3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211305.GE1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

When debugfs file has been created by debugfs_create_file_unsafe(),
we do need the file_operations methods to use debugfs_file_{get,put}()
to prevent concurrent removal; for files created by debugfs_create_file()
that is done in the wrappers that call underlying methods, so there's
no point whatsoever duplicating that in the underlying methods themselves.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 38 ++++----------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 238cbb49963e..197defe4f928 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1869,20 +1869,14 @@ static int zynqmp_dp_test_setup(struct zynqmp_dp *dp)
 static ssize_t zynqmp_dp_pattern_read(struct file *file, char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
-	struct dentry *dentry = file->f_path.dentry;
 	struct zynqmp_dp *dp = file->private_data;
 	char buf[16];
 	ssize_t ret;
 
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
-
 	scoped_guard(mutex, &dp->lock)
 		ret = snprintf(buf, sizeof(buf), "%s\n",
 			       test_pattern_str[dp->test.pattern]);
 
-	debugfs_file_put(dentry);
 	return simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 }
 
@@ -1890,27 +1884,20 @@ static ssize_t zynqmp_dp_pattern_write(struct file *file,
 				       const char __user *user_buf,
 				       size_t count, loff_t *ppos)
 {
-	struct dentry *dentry = file->f_path.dentry;
 	struct zynqmp_dp *dp = file->private_data;
 	char buf[16];
 	ssize_t ret;
 	int pattern;
 
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
-
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf,
 				     count);
 	if (ret < 0)
-		goto out;
+		return ret;
 	buf[ret] = '\0';
 
 	pattern = sysfs_match_string(test_pattern_str, buf);
-	if (pattern < 0) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (pattern < 0)
+		return -EINVAL;
 
 	mutex_lock(&dp->lock);
 	dp->test.pattern = pattern;
@@ -1919,8 +1906,6 @@ static ssize_t zynqmp_dp_pattern_write(struct file *file,
 						 dp->test.custom) ?: ret;
 	mutex_unlock(&dp->lock);
 
-out:
-	debugfs_file_put(dentry);
 	return ret;
 }
 
@@ -2026,20 +2011,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_zynqmp_dp_active, zynqmp_dp_active_get,
 static ssize_t zynqmp_dp_custom_read(struct file *file, char __user *user_buf,
 				     size_t count, loff_t *ppos)
 {
-	struct dentry *dentry = file->f_path.dentry;
 	struct zynqmp_dp *dp = file->private_data;
 	ssize_t ret;
 
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
-
 	mutex_lock(&dp->lock);
 	ret = simple_read_from_buffer(user_buf, count, ppos, &dp->test.custom,
 				      sizeof(dp->test.custom));
 	mutex_unlock(&dp->lock);
-
-	debugfs_file_put(dentry);
 	return ret;
 }
 
@@ -2047,18 +2025,13 @@ static ssize_t zynqmp_dp_custom_write(struct file *file,
 				      const char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
-	struct dentry *dentry = file->f_path.dentry;
 	struct zynqmp_dp *dp = file->private_data;
 	ssize_t ret;
 	char buf[sizeof(dp->test.custom)];
 
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
-
 	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	mutex_lock(&dp->lock);
 	memcpy(dp->test.custom, buf, ret);
@@ -2066,9 +2039,6 @@ static ssize_t zynqmp_dp_custom_write(struct file *file,
 		ret = zynqmp_dp_set_test_pattern(dp, dp->test.pattern,
 						 dp->test.custom) ?: ret;
 	mutex_unlock(&dp->lock);
-
-out:
-	debugfs_file_put(dentry);
 	return ret;
 }
 
-- 
2.39.5


