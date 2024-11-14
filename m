Return-Path: <linux-fsdevel+bounces-34828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1149C8FC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094421F21AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7518DF91;
	Thu, 14 Nov 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="WDyLFrSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389C18CBEE;
	Thu, 14 Nov 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601666; cv=none; b=IGr+36MRloHodSixqIDg4NZoqX2ZCc+r8fry+v5tBEIx9A4l7U6lgBckBIVwSLTAHMZJCx2U0BC40BbN8Hohebf9zy2IhhPWJFCQyUKG7ZEzrsTgt1L/w+1Fim9UIJAq7NQxNUY4BJaA/OB98OdwpOBsmcDvdnarxexF0gSFs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601666; c=relaxed/simple;
	bh=n5hyX6yMomOaBzphPxzWAbVrcJaUdxbAmwSzohj0OEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcnIh3qphGqvqtrp+1w0Dojw4CcK9HkO47yfqxxHYTtXd4Y28oEWgIVGyyr8cVBOasEPa4/+iFQSWs2NAiIK5khzLt6Z56f43/b83sws+gmwMEKGxDWCFET3MfHpDR+0a5TzOUdfhLsHSEIL+mN6OKxUpce/J22j7csLV7mRI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=WDyLFrSq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDFCB1C0007;
	Thu, 14 Nov 2024 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731601662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TPoafWSqHQ3L6VZWGol10eaPnstQLMyyt96RSAYCQ0=;
	b=WDyLFrSqJmEjmOtTCzCChcWaYROO0VuqcA411o2X0wx2J9FXRoFGB7goiSmWzBFiVEA1g0
	oXXIU+c1WAgAY9JM43ch9OzSyVFH3u8oH8rI+otcf1WdbdGyN0ZBGxWkHolgpKHlFjcdQ6
	MwHXRKJxFWh53bD6JZ6y40K6jT/XAKFDVu25rr+OB0BhGLwmRAAd2hanWh4NdoT/IKGqvd
	qo/6xGkCGP40377itTRTYuLR8xNRFtLlggO3o2InkA8t0QEurKPd6DWOAyyuysA0xiDT92
	X9gGRoCg4oJ/QMKFdNx9g83FJ5ey4SxtFyY7+3wULcImuQ2OUiKbVIXdjzBwrg==
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
Subject: [PATCH v2 3/3] tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler
Date: Thu, 14 Nov 2024 17:25:52 +0100
Message-ID: <20241114162638.57392-4-nicolas.bouchinet@clip-os.org>
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


