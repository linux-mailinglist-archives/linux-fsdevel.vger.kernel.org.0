Return-Path: <linux-fsdevel+bounces-14022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C84876AF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182191C21483
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D197D54672;
	Fri,  8 Mar 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Fr3jdjo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93902DF92;
	Fri,  8 Mar 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924205; cv=none; b=jSsetAd1grzvmSqS3KBs8/mmKNJkwUlHzfWdOhfr1mbGf4lG+ko3zv6nrEa+f1XKbdcFyTiPVZrLrql0r5tM38c43r+cVmO0BUNTtDyMt1tXesqUb47dSxd/pUY0qXh7Cof4sc1nbzYsYk+SAMr6X6RzZeltthMtfUx7PGW8glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924205; c=relaxed/simple;
	bh=m1gSWDGhOAmMvJJN4zC6tWoZplCX09QlxH0eeqoof+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SsWNxymoXxY/MdICNEUNmji79NJrwW98ogupHh9yKgyHrIg2c25bqRIiY2+urO/hJM2KHqHRqRMSqCx5Ibw+YskMAoLJGioMZJrM2CknZ6WzNFLTjvnKTtTrNYxJvcZ89NA2DvtjrsFlxCLnU6OI+j7E9wIRTBjHvjeO1d1ER3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Fr3jdjo8; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wpcBiUaBaPQQIxzHAFN2Kj+yFFh9wih3axC8gZA47FQ=; b=Fr3jdjo8JbgHm2Ys+D8EYSwPP8
	yJgTFQ2fvP8c6RuOAaUJJXVwZnz0dGlIkTstiryvFT+N2+tnEVZbtf4hIUvxSCLHGVJE1cLiBfg0r
	dBFzsMYUn513pPb42XJlonxxVgWKNMjxCB6jLDrOSPcG/dTMPGOHsjwAMGuR+c9+Jo0Eno00eFuRO
	R44Zn17SKZ2/4vwLVdnGdAW6KUV0yHCmVrKSZaXhoKcMNgHXMhDoqZZ5qhsyiZR/HHFp1Oz8tyyJf
	2BaSZN7T0unvBoLobhjpOUu8yQDAMv8lw93sgkbc7OzdbFeGGJj279ytu8dmwpOhsvqA76tutU0DT
	Ui1vRU/g==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rif10-00COsw-Vd; Fri, 08 Mar 2024 18:32:19 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1rif10-000000084bp-2CXU;
	Fri, 08 Mar 2024 18:32:18 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-fsdevel@vger.kernel.org
Cc: krisman@kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] unicode: make utf8 test count static
Date: Fri,  8 Mar 2024 18:32:15 +0000
Message-Id: <20240308183215.1924331-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The variables failed_tests and total_tests are not used outside of the
utf8-selftest.c file so make them static to avoid the following warnings:

fs/unicode/utf8-selftest.c:17:14: warning: symbol 'failed_tests' was not declared. Should it be static?
fs/unicode/utf8-selftest.c:18:14: warning: symbol 'total_tests' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 fs/unicode/utf8-selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index eb2bbdd688d7..c928e6007356 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -14,8 +14,8 @@
 
 #include "utf8n.h"
 
-unsigned int failed_tests;
-unsigned int total_tests;
+static unsigned int failed_tests;
+static unsigned int total_tests;
 
 /* Tests will be based on this version. */
 #define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
-- 
2.37.2.352.g3c44437643


