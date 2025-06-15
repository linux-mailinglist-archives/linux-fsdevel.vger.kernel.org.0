Return-Path: <linux-fsdevel+bounces-51679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459FADA099
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 04:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B21893D66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992616F06B;
	Sun, 15 Jun 2025 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eGvtAOVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41211CBA;
	Sun, 15 Jun 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749952919; cv=none; b=PuAkPqcSAT4V636cUXOLOBYWv/PS6V7V170vR4yj+UQCc1lW9V+PTRiVRzJmE76KcIDYMz24vIy0do7DmgBwRV6n0FFlDJwTlLs6WY1GkAFi2RQUEiKa2rSKYCdoA4Ju2Xc8Q0gVPJHsJMzbuKt2KrdpqwoT42n+AJhKDU3Bmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749952919; c=relaxed/simple;
	bh=O/QTV3SgMSG8EsyUwUU7f5X/zMiUkNxW2xWZhHIz0dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG36Ul/nuVVgyeQxz7gUT+G1A8x8pX7J7pp5pwI8p7zopf/b/TgHsUETkoKn9ABX2MPysUimKjVIamNrbec/2Et0okAVNjsZSTLcZIrVrDBr60EOD6uVLvQtY6HytEaT7MhBZFUTb/TVzdEy70g+6aw3MqFoyyk03HtB/Xq9P1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eGvtAOVS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MFjBL1KWPaBD3zS+E/1euWh9toW9ZqwuJ3e+wNUifrw=; b=eGvtAOVSeFa9Dmlj56il76ZbKK
	mDQgodmqscZfpD9iE9OIsb25r6kHG8j84g+hVsO2SIwFufLZylurebaWWAMh/0Ztliogb0WFSz1+y
	496o7xabiy+G4frDbex2E6uIF7C/HXrBElNXyliKQXkoJ8gfz4P+LVb9BYovcHoaFAui2hAwaCAMr
	IRQidrV0zL7ddSYXBa0E1eZXrj9obZ5Seg7i7kviP5rhqDcUvgsFo06NW0+XZ5tX5pseQtRq+X1+O
	Zi4Zw56f6WkQK0DcAsflcQ0Z8jVBVgKjHLJXPAr69GLaWd555K5Sbt3G36/+/RcqwTYZW30JuJljr
	azXk3wgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQch0-0000000DWIv-3wnN;
	Sun, 15 Jun 2025 02:01:55 +0000
Date: Sun, 15 Jun 2025 03:01:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] selinuxfs_fill_super(): don't bother with
 selinuxfs_info_free() on failures
Message-ID: <20250615020154.GE1880847@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003110.GA3011112@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]

Failures in there will be followed by sel_kill_sb(), which will call
selinuxfs_info_free() anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/selinux/selinuxfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e67a8ce4b64c..b44b5919f4af 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2097,8 +2097,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	pr_err("SELinux: %s:  failed while creating inodes\n",
 		__func__);
 
-	selinux_fs_info_free(sb);
-
 	return ret;
 }
 
-- 
2.39.5


