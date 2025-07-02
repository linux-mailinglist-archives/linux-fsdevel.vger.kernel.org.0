Return-Path: <linux-fsdevel+bounces-53725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728AAF63D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AACC7AE4D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925B2367AE;
	Wed,  2 Jul 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OwP6OAQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9A2DE714
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490965; cv=none; b=B+NQab1edTPTZEyPlzl5masVX7lHuGTZ0iJUHI3LL5uMqYmFd+dhwlMKwoe0iXTzAQA003hn861kdqGMWmt8TpY75aBTyacMllhOqIeundE4BBQNKhhi6TctPmaYSuwrJugs0i0rKLHonPEoN97MeVUD8zNoptT7nIyDdmdNdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490965; c=relaxed/simple;
	bh=IIdKejTOzGYsQiCFOIP4u+ymPdfRQpBSHSR3m5tdZ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMhNVV1AgD3OmhG0CRN6fEc5V8bkrHvtbtP/inAzv+xMnQPO19OxP6OH6v+5vqKuJMG/mYzAzu60+qIH4yjjGzum3R33+DEPp/L+dCE8ZzFXW72wLLAY19duIEfMbJG4sBUOSh0F7zkHtUk2ClkxS4Y/IUUjHoMtQWpuF5fjgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OwP6OAQX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/y3PZ06UdQHHiBnR1knszJ5aZ8OoUSRze6j5Gwso4kc=; b=OwP6OAQXkms4vLHZX6cuwatCcq
	5/ZbQrFEovHyCNV0xd8Npc9b9G42USWnATE89pmgXSj7GxBIhKg+uWK/P4O8ARC0IjD90s2+ZbnqJ
	bDYzqSrer16+agIarlitNltkvcBE5R9P8ivWXz1qpPRdtbI/g6QLUMfXLE9lQD8Akat/ZfzdkdMhY
	vU9wNGFA/CZgVGK4CyTZun7LDtj7jYfGEMzvqnVuvm2fWwUWYGWzZPJuguyq23Yo4aS/g0FTmA4PR
	K6n6xBM0TsayqW1IIey0+mTPjbPisKcFYLdawB5N5pB7vdOcAzQ8YS47tRN6mfLuy5HVP8cLpFfGG
	g6V+2MTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4oE-0000000EJkn-1YvQ;
	Wed, 02 Jul 2025 21:16:02 +0000
Date: Wed, 2 Jul 2025 22:16:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 03/11] regmap: get rid of redundant debugfs_file_{get,put}()
Message-ID: <20250702211602.GC3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

pointless in ->read()/->write() of file_operations used only via
debugfs_create_file()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/base/regmap/regmap-debugfs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a75..c9b4c04b1cf6 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -470,10 +470,6 @@ static ssize_t regmap_cache_only_write_file(struct file *file,
 	if (err)
 		return count;
 
-	err = debugfs_file_get(file->f_path.dentry);
-	if (err)
-		return err;
-
 	map->lock(map->lock_arg);
 
 	if (new_val && !map->cache_only) {
@@ -486,7 +482,6 @@ static ssize_t regmap_cache_only_write_file(struct file *file,
 	map->cache_only = new_val;
 
 	map->unlock(map->lock_arg);
-	debugfs_file_put(file->f_path.dentry);
 
 	if (require_sync) {
 		err = regcache_sync(map);
@@ -517,10 +512,6 @@ static ssize_t regmap_cache_bypass_write_file(struct file *file,
 	if (err)
 		return count;
 
-	err = debugfs_file_get(file->f_path.dentry);
-	if (err)
-		return err;
-
 	map->lock(map->lock_arg);
 
 	if (new_val && !map->cache_bypass) {
@@ -532,7 +523,6 @@ static ssize_t regmap_cache_bypass_write_file(struct file *file,
 	map->cache_bypass = new_val;
 
 	map->unlock(map->lock_arg);
-	debugfs_file_put(file->f_path.dentry);
 
 	return count;
 }
-- 
2.39.5


