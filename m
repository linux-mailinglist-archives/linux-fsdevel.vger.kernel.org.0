Return-Path: <linux-fsdevel+bounces-60078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A50B413E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD49178DD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211D2D8DDB;
	Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Not3mTKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC992D7DE2
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875348; cv=none; b=r1izj7MGisLta4w0cMyNGZc7IsuazfFVKDBMQ8bGHiAt/czk0b6S5Ab3tuzD6H6ZZIXlTjr4VpQabuj4hYDdOdZJUgGEPtbyiCQQopYHtjn4M3oX/8YHn0fW0Z+FMn6341+587UJvUZtDJGbfO2noLmHsbjXnRZJXA6uCQkvLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875348; c=relaxed/simple;
	bh=wJa+KlHzwELIGYlHKOAtVqs4LqB3/pk3/hQxRZaqj0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmU/nWgxVLN1uKVyJuMDMXEPW2HvH7Yh+z67zn2hOqVJ34xfFhFYAzietGkF89qTIfSTGoEgZvRMUgawCPchN+mM4zTFnlQYOjE+O3ou2rq8ocefw5YPqGObenSRG8h+iPNyJGBXARDX5ZCzvqS75erjVGmbPbSrYoe/EdE4Cx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Not3mTKj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mGuKeVuB1GF2vuY2MbrLvaggfw0F1KjVh6KVbjMThKQ=; b=Not3mTKjZdFbzxXEj+whipNQNl
	BpujuyM9HLsLp4rTz6HuQe83vEAtmZo5JJk+VFHKNjNdpR0Qpf7g+QGx6FgjmvEYUx8gMkO484DLW
	0vfkzOoF7wyU1nfTZm02hMS4fu/BHvCfg0smqi5VC6F91roZ2ldvhfmnjiXNMe/5CgjhsQY37XqoT
	AvlLQPOU/ZeZ6Ikbv7vk9L8Lfw0djMcCh16oQY7RZ8e6FyJFH6rtAeyx6+L0v3x3gsKlDxTIJz1aq
	TPLAZiSI9HBvL0MgPuaottMfIiu4jElel8dsJSOEGBEZBTC49zA+IUG8aSup4t2nqatpBx1wlnZVG
	Yy30qf6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX6-0000000ApCA-3dF9;
	Wed, 03 Sep 2025 04:55:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 37/65] do_mount_setattr(): constify path argument
Date: Wed,  3 Sep 2025 05:54:59 +0100
Message-ID: <20250903045537.2579614-38-viro@zeniv.linux.org.uk>
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
index 511e49fd7c27..f74a0523194a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4865,7 +4865,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 	touch_mnt_namespace(mnt->mnt_ns);
 }
 
-static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
+static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	int err = 0;
-- 
2.47.2


