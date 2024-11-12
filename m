Return-Path: <linux-fsdevel+bounces-34450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA49C5AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F7EB43DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5215572C;
	Tue, 12 Nov 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="Akh/a14E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF621EF01;
	Tue, 12 Nov 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417397; cv=none; b=j77czF0WpGM93xNSpsqSl6pv9UTgxrEUUBuO3q9Tn/S70KxqMIfmbcNMMPmQIqtUFdD1NrOqM2ukVnS14WMnx0mmq0x5X6FezdxvzYSUPUv2xK/j4N3XZNHdct9wj6Kcms1b5ie5zjQBwKPgn75OGty9RmI/CzWMMEsvQdb0FAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417397; c=relaxed/simple;
	bh=n5hyX6yMomOaBzphPxzWAbVrcJaUdxbAmwSzohj0OEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2Nq8lm4g9RhoCyytVwcXIL9F0FHJDMVzqik04Sm9Rr61kW2+vQhCpBecg9KXjkF6QtF9lZRQrQsvmh4ySZHIYA9HT0p20mwR4Auc0hbzqrPGE68IWjGbvmGrGMbFUY2Hh7XFH/GNEM4wFR6WZdsEa1XLWVan+vJinQEaAuHOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=Akh/a14E; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7648B4000E;
	Tue, 12 Nov 2024 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731417393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TPoafWSqHQ3L6VZWGol10eaPnstQLMyyt96RSAYCQ0=;
	b=Akh/a14Ejlp4XkaT55YUdmjE5dKDBiMCz2IvoiGUEY5n1OWSUFsY9NR36Bq+gVodhMJdGM
	jzM5PDG/iI3S4gW6Vr52RbrJYidFuhjevrLG4DDl9nfx3k5IfM8e1G2bnhZe2YnVHLzEFI
	8pI6Od0E1LQmlJUdgBHug9Efw8WxTgwqBT+skKex9e0q+RSvi+OzjXhve1Ws6dyCUDchCy
	6utgU7hr2vXZ1CLJ87RosyvG7fWcI17A0u3wgq8IFW58kEyUNlCTrk2M7xLDlAz5T9WMur
	qhHgeyEAtDmpLz6Ry9cqZLb3Zi09KBD73DbrdUosHTXXXUS0AglaxxxdDXAR2Q==
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
	Neil Horman <nhorman@tuxdriver.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lin Feng <linf@wangsu.com>,
	"Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler
Date: Tue, 12 Nov 2024 14:13:31 +0100
Message-ID: <20241112131357.49582-4-nicolas.bouchinet@clip-os.org>
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

Commit 7c0cca7c847e ("tty: ldisc: add sysctl to prevent autoloading of
ldiscs") introduces the tty_ldisc_autoload sysctl with the wrong
proc_handler. .extra1 and .extra2 parameters are set to avoid other values
thant SYSCTL_ZERO or SYSCTL_ONE to be set but proc_dointvec do not uses
them.

This commit fixes this by using proc_dointvec_minmax instead of
proc_dointvec.

Fixes: 7c0cca7c847e ("tty: ldisc: add sysctl to prevent autoloading of ldiscs")
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c10..f211154367420 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3631,7 +3631,7 @@ static struct ctl_table tty_table[] = {
 		.data		= &tty_ldisc_autoload,
 		.maxlen		= sizeof(tty_ldisc_autoload),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-- 
2.47.0


