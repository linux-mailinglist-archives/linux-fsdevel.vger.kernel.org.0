Return-Path: <linux-fsdevel+bounces-34827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7539C8FBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B742828A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592B18CC11;
	Thu, 14 Nov 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="BqKJmiv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9D18CBEE;
	Thu, 14 Nov 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601655; cv=none; b=AZJVo464bLBbDG0o99kZHsz4aLOtoq/D9fhM+4u0Sea/dg/gFW7WuTpw0XFjmXpFH8N9aXp7pXhG8m66sLIAiAHZD6x0dL2lS9V6DiMPnTypQCY7jTogehXCSBO/SViaAs8yRmpGKd8wdYOpkPo8ynSxkc/X22HGDdaGXzJqRuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601655; c=relaxed/simple;
	bh=utsyRUv6zF6lfsiqmmdHqVJJDZtIGR3H0bFdUUXhblA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0F24h59gSsbNcTvUAhgDKWOCDzjTVpmverK/eHTlUuirrglYVbRlUbs3xxaAacmUkr3ydnvB2ctqiUxIlFdFQBEmdur/Tyztp79fstMTYdCE97eX9zOMKiKJtPIMhxZIiWUUBmKumkdO2ehTX5bwJWvzZhCtUNzNCO2RDpFYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=BqKJmiv0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C20151C0013;
	Thu, 14 Nov 2024 16:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731601651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAZBTJoDFDDpLWVPcLeTfyoC4pnu7r3w7YRXCDSoHus=;
	b=BqKJmiv0B11YBe3hQszhxsPByGGuHDD5MYESZEzFWfiG7qm14vePNGtYuGkZVZuNneZHSE
	SWBJLltnu5xYrjEiEhHj2RhA19P5TlpeprH5ACo1r3mlNUDAUO7yX4HVhtXPP3nmYEBh2o
	x2Z4xvcHNEl5TD2FlopQ8VV0McElTV62KUm9/5yHR0XEJDNXT5wWkEcasKUeO6UknXbha4
	GzOV+9feVIw2CQR3QKZ8GX7Az7xiCD6lSDeyOtx9KZLLXmw9qQUWk2P994PbiUk22QWf6i
	aaFmYiM2fiX/sMY9H2MjNeTWoMly6d6pc8oRAhSBJJlphAYrH5eyZw2edD01rw==
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
Subject: [PATCH v2 2/3] sysctl: Fix underflow value setting risk in vm_table
Date: Thu, 14 Nov 2024 17:25:51 +0100
Message-ID: <20241114162638.57392-3-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
References: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
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

`# echo -1 > /proc/sys/vm/vdso_enabled`

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


