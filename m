Return-Path: <linux-fsdevel+bounces-39293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA347A124A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9EC3A67F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D3241A0F;
	Wed, 15 Jan 2025 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="FYsRitfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834542416AB;
	Wed, 15 Jan 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947349; cv=none; b=Q065JnQn4ZtMeuB7bHXZI92Yj3pczh3t1nplDFIEjC1I1dgg3MNR3xfxBjdY/yjcvUddBkZ9J9uwiG6UTjXLU0Gr/sDb5uG2/2y8EsFUpSswolzW+rtcT77kyOIW5aqnT9lJBl1EtVJnVfECcCgiDEQAJ5IA3eMFIroSYjYbPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947349; c=relaxed/simple;
	bh=BamQTXn7tOLezG5eGnx+CGW7UYC2q8u2Or22ixvwEH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAHauyA50d+wUfaSTkNaUb6Wov26IJwttvXRO5xfLQKM7jeIVIdVbqDN4H/6ephm41aAoST6Cq5SxLZsvjFJJ87nZogW43UzM7UYoaiqHTy9MrOr5rOt52+T9yoBF1GUiOw13AAWmJBPhz8FSH8NTeqICYncqxc+GMZam1zZRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=FYsRitfR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29AA31C000E;
	Wed, 15 Jan 2025 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1736947344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUquHLlUQqgvzmZlNIirYYls626vSbWc54eoHijhiZU=;
	b=FYsRitfRfvRgiIqG8xK9YVZ0P4FaDuZdlSGIOj8KTqk7gKtQRl3lbJo6G9FR1twhUWy7vB
	cBrO7Bi2qsWCaunu2gLSH1CFHFca8AfNGHEh2jrM4tonbrlyGMd219mPVOUpL6fVHMSbme
	Aeh8qAqDg65m181wtna/Ne6UvyHu1WtrvurOYD7z1Tc9i+05OdbjtxXFNmeEaoBcYfSKXh
	m2LdUDLLYbksKOHHqGmsY9NRgKLtryagpkFHyE3x6S0MZkZ9Oj7ZrzcnmC1AiQlCZjWFGq
	TvOAzSU7s2LSlyM1Hmc7nSWVW+7Hk8xKGqS5E7bKaiaZtfh0uLhC6KadPeYjhw==
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
Subject: [PATCH v4 2/2] sysctl: Fix underflow value setting risk in vm_table
Date: Wed, 15 Jan 2025 14:22:09 +0100
Message-ID: <20250115132211.25400-3-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
References: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
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
In addition to .extra1, .extra2 is set to SYSCTL_ONE. The sysctl is
thus bounded between 0 and 1.

Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 arch/sh/kernel/vsyscall/vsyscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index d80dd92a483af..1563dcc55fd32 100644
--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -37,8 +37,9 @@ static const struct ctl_table vdso_table[] = {
 		.data		= &vdso_enabled,
 		.maxlen		= sizeof(vdso_enabled),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 };
 
-- 
2.48.1


