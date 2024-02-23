Return-Path: <linux-fsdevel+bounces-12574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B5861306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2072867F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA27FBBD;
	Fri, 23 Feb 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpzC9HiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34080033
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695708; cv=none; b=WGhpbtvrfgacDrKr0zUkQG8oNvE0Cmt1DXkh/mckA8jvGURotuJNVyNILtdCa6TChtbeYyGJbiU58BkqA8mn22mA3bA7WCRX82YHU3DOC282JJggZNCny176iOaNHOenuJ1EkzZC75lKmWzyS3OMYXuUmxQe6uhjq+6KwDbDC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695708; c=relaxed/simple;
	bh=ZeEgrHFNZ1UZPQ6r77BJ34V0W6ar1DD3XMO4AcqB124=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phruMY2dT6vldhX1iGnDwV0SDrkmLuhg5gA7SVrNhahnmpti65bcq4gSVcXDuU4nxdBAgKUlkQaS4h6PcYK5QLX/Wje7tqMBf82kupbwVTcAfXonLyMDgjY/KQEb8GOd8Rt6bwzpZWBGh2GyPeSgRN1tbU0rvXnXwpQfi8tog8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpzC9HiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FF6C433C7;
	Fri, 23 Feb 2024 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695708;
	bh=ZeEgrHFNZ1UZPQ6r77BJ34V0W6ar1DD3XMO4AcqB124=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpzC9HiLLtCn92/oI6tPlJHTj0eUMYX1f6cqpOhyfsDOgGy/Jf4+BSSahhLgaGwfg
	 ezdDgzB1lMaOsbAP603YLM1zKcP4EUbsjbGZWd4BGmJEyURM+FwNi5e5yr/yuxkjq8
	 1o6V3NxhbFW5VQykYh9XgIqfX1CIz0eK7o6kvwd6Fu1Q/Husne0x6KV6PqmXkajnva
	 rL5v6+SIidBU7Mg17ry8hu9pQiD10eLDBdb4xb/4iUioXi0gofwVHFqhXPBg/LDrAS
	 aoFtqRy70r13Sl2RHtKc8ASl/CZKUBfyrWs6ujTmhc8KUbve1W93wJDRyTZEdEx1zo
	 pf5Wm74W8dNcg==
Date: Fri, 23 Feb 2024 14:41:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223-ortseinfahrt-verkabeln-a69a70229ea0@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223-delfin-achtlos-e03fd4276a34@brauner>

> default to N for a while until everything's updated but I'd like to

Ok, updated vfs.pidfd with a patch to flip this to n as the default for
now until the LSM learns to deal with this. Should show up in -next
tomorrow.

---

From 57a220844820980f8e3de1c1cd9d112e6e73da83 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Feb 2024 14:17:21 +0100
Subject: [PATCH] pidfs: default to n for now

Moving pidfds from the anonymous inode infrastructure to a separate tiny
in-kernel filesystem similar to sockfs, pipefs, and anon_inodefs causes
Selinux denials and thus various userspace components that make heavy
use of pidfds to fail.

Feb 23 12:09:58 fed1 audit[353]: AVC avc:  denied  { read write open } for  pid=353 comm="systemd-userdbd" path="pidfd:[709]" dev="pidfs" ino=709 scontext=system_u:system_r:systemd_userdbd_t:>

So far pidfds weren't able to be mediated by selinux which was requested
multiple times. Now that pidfs exists it is actually possible to medite
pidfds because they go through the regular open path that calls the
security_file_open() hook. This is a huge advantage.

Until the Selinux policy is fixed we need to default to n to avoid
breaking people. That process is under way in [1] and [2].

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2265630 [1]
Link: https://github.com/fedora-selinux/selinux-policy/pull/2050 [2]
Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240222190334.GA412503@dev-arch.thelio-3990X
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index f3dbd84a0e40..eea2582fd4af 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -177,7 +177,7 @@ source "fs/sysfs/Kconfig"
 config FS_PID
 	bool "Pseudo filesystem for process file descriptors"
 	depends on 64BIT
-	default y
+	default n
 	help
 	  Pidfs implements advanced features for process file descriptors.
 
-- 
2.43.0


