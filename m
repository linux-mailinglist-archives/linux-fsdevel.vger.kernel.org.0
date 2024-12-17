Return-Path: <linux-fsdevel+bounces-37632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B39F4C77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A363B17428D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDD1F4E38;
	Tue, 17 Dec 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="CkAEg4in"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17641F4734;
	Tue, 17 Dec 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442273; cv=none; b=olJeCJY/8pyIPjfUfluLls1IXWBUCXhK1tYlzYNk8pvYhFYUAFJOtQduGrAnRACyYbOWlWPjoxjBAiDB3fmOr8Lt3LyDezO7PnHwxnqWi0j7zpf+mmoMEanBKaYeRqCZHojJqZLqB2S1wPQEJOhQ6VV6H01801xBo98Yl+XqIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442273; c=relaxed/simple;
	bh=Y1cpj11DsAb1u83h2drZNa4ZJSTouUH0rHR750qW+98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByVz3zcRrNdpBJUGWsJjU2XkuU2wUFcOzulDV7+AG8CF4x6jPSboZqLe3e+kuAUXtq+nKGK6djWEkNg4JN78qbeJr6IdBEGJFdc8gEK3KOnm+2f/7Hgwe3Kf8+9GplAYc9o3aPzvRtDyiCwQXjlGNwB8ddQ+1XN4mZmzW9q6d2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=CkAEg4in; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3A5AC0006;
	Tue, 17 Dec 2024 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1734442270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIuLqH8rMsMHoCnSRb3wBLspzx/H/nMJsGAsARGV+jw=;
	b=CkAEg4in2GlxQxqzv0Kj6mc9VNtskouF0R82e/Jye4WllK8+L57dr7Ni2qyI5uVFIbxcqb
	2f3pM+0Okd97GanJiatDeoHqsm3g5lalSXMqKqS6HC9b0wL5uiy/oQaM+sZiQ12U7auNMo
	DuAOPiXxrTSVctU9cyAc5vUsy7KjC7QLaCtNXI5QUq9CcRKrRSYlTylLNoOUunfPqk9AjD
	NIly0SXwYurEFRkiOZvFKblv+gBe9cw/yrucayjakx606vkOeOjPs4fTVGB9taBTCaQRMK
	MblhqHl2sED71SSWGoo1Ahc5yRhqluX9RRBjQHDdqrsnjeLeJM3xEIaOw9KPKQ==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
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
Subject: [PATCH v3 2/2] sysctl: Fix underflow value setting risk in vm_table
Date: Tue, 17 Dec 2024 14:29:07 +0100
Message-ID: <20241217132908.38096-3-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
References: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
fixes underflow value setting risk in vm_table but misses vdso_enabled
sysctl.

vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
avoid negative value writes but the proc_handler is proc_dointvec and
not proc_dointvec_minmax and thus do not uses .extra1 and .extra2.

The following command thus works :

`# echo -1 > /proc/sys/vm/vdso_enabled`

This patch properly sets the proc_handler to proc_dointvec_minmax.

Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 kernel/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48f..6d8a4fceb79aa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2194,8 +2194,9 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vdso_enabled),
 #endif
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra1		= SYSCTL_ONE,
 	},
 #endif
 	{
-- 
2.47.1


