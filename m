Return-Path: <linux-fsdevel+bounces-34449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB79C58C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8F328123A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290415444E;
	Tue, 12 Nov 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="pfAJ88hZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB53148FED;
	Tue, 12 Nov 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417385; cv=none; b=I5b5B7r/77qTL0IGY/Y0JBFPjzyuoNbSPZ1Y7iBslzOYkgY8bQ62y8Pie0QQlwwSiG2Z/m4rJlbwQfo58phZO6qQg1jeCcoysB64HjLQgWQ7XWJCJbXokzCMNGNBwQ7lY3kfF4Jh9c8m5B1eoBKBXGUzFlcMmEbtoMyrGprAZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417385; c=relaxed/simple;
	bh=1qYHnPK7Lu9MSgPF+yE9faOY4S3yQJDE3d472tmpRes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAdYfksyn+dcD23Nxjevxx5w0jGWpfDaZd0Rjroauc7KWe8Y5VtSvwywbAcEjDliI2FEpF32+NXXkiZy+CIvc0Hp1Pr9yBxoryyOFU/8mFCCnSXSCSPEKXKt6LrMWtHNHuHwVvLW+gEfgyFVT4/j4g/zNMjWXqQRXRdlADBMQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=pfAJ88hZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B169940004;
	Tue, 12 Nov 2024 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731417381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqFoQ2NQiDizEKUuuseSusLp3DfCTNz+Jgo3JgjKVl8=;
	b=pfAJ88hZLRRkjjkMFkgtrVa6N9NPC/nEyhFwH23Vd5ltu+UyeW3RLCiAqIUFHya2f/xAkO
	DpXNp4vA8HXvUZJyu9mo9bK1/Y9unpoViRPG5/vNGczA6+l77Hcce7frLfanXl4c6qFYBV
	2yj8aSWN96BYxDz+r1Y5RbxdCkidNI91f6/Sld42j7drGw8pYJ8cy/913ur3BOmkY/GNnm
	l+XB9grkabJDvDfbe7hFpemnPXbhFmTmTECQiEsBl539GNnwwD0QlBkBFGWyunln9hmzVb
	LaJu1NZ56XqzaSzVjYXlWnLsSfKu7XRU3SUXu7AE9UF3u25FWKQaVsW0ssxpRg==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: nicolas.bouchinet@clip-os.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Lin Feng <linf@wangsu.com>,
	"Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] sysctl: Fix underflow value setting risk in vm_table
Date: Tue, 12 Nov 2024 14:13:30 +0100
Message-ID: <20241112131357.49582-3-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
References: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
vm_table") fixes underflow value setting risk in vm_table but misses
vdso_enabled sysctl.

vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
avoid negative value writes but the proc_handler is proc_dointvec and not
proc_dointvec_minmax and thus do not uses .extra1 and .extra2.

The following command thus works :

# echo -1 > /proc/sys/vm/vdso_enabled

This patch properly sets the proc_handler to proc_dointvec_minmax.

Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48f..37b1c1a760985 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2194,7 +2194,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vdso_enabled),
 #endif
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-- 
2.47.0


