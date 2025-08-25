Return-Path: <linux-fsdevel+bounces-58935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D4B33584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A6217BDA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD6277C94;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eKdz4i5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180C27F171
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097044; cv=none; b=SUKZ0H+NcLNZUbYmrTMia+IqMAmHrocX8191u5zD8rItbebFc1tNCftvft6zasI7LCyMx4Tc5yKR8fpxL53qkUIVpg1OVTE1m6GeXWuBsk9eiT2IlhLloE6igtQuNO+HCmPsHCzvYlmJlBjenHQfmS1nv+CMFQINH5YgMcpvUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097044; c=relaxed/simple;
	bh=k4cBV32fLDFba+z0IHHl+dxtgdcwdIiJA9g/YMT3350=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlxZVVnfoLOIVCD6GifHi9TFt87/QzsViUjvxe4ofSZTqfjNHxQH+PTzRIZvFEUG4sITtVcFC91mUhB/DAH4dZflMZoqJY/3FOMQSm5JMrNTGb41QuXFCyHjMA8N9pmmiVaG7HT4ej/qImzgFNPMjBIK9LxAmxaB+p1AQ0mG0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eKdz4i5t; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TwF3Iala784ikxR7+k5GyXa8vep6ftr3fY/5/llqlw0=; b=eKdz4i5t95LG+GpXHOIIFMcxM8
	npGLIsZze086dTTXDTY8hdevTcvBb5iDG9MeDoUn/sX5Gwkk/f/Y1Vmzeyfc+/lW2GcpHUJgb1wSv
	jjVxNVU4JJ2RVLhZjqnXydUDhxcflzCtJR6QulOgStAFTwtIC9ElIJYnH7IO0IfH2PxnveUnZwekv
	16Ib53Qrrku8iCGwCLTCQN8KLL4sHOpdPLKX0xjIqYsnIsP7+9h/kF/PIm1L+/ek94Zs9aKnT70o3
	L1NHJuxxB5x5qOjMKLneTFhwGAYtcwSlN7kh6A6H026/32qjgsq8sZLgAh8mpx6q6JnxjnYP7l5ab
	gxS1M46A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TDl-1asS;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 36/52] do_mount_setattr(): constify path argument
Date: Mon, 25 Aug 2025 05:43:39 +0100
Message-ID: <20250825044355.1541941-36-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 458bef569816..2db9b006e37e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4872,7 +4872,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 	touch_mnt_namespace(mnt->mnt_ns);
 }
 
-static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
+static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	int err = 0;
-- 
2.47.2


