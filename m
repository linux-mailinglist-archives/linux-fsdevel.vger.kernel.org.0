Return-Path: <linux-fsdevel+bounces-66814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667BBC2C9BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D81881466
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2D334C16;
	Mon,  3 Nov 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfjNIE12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595E31B138;
	Mon,  3 Nov 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181900; cv=none; b=kuDZYD8vfo+0tw7EJLbarRGo44iJCfr7OJeZmdOcSucaqgc+Zsc4A5xiOrDfAaSU+kt2+CePZUddZufxuzo48Vb7fFSrdbEdMFw+f4Sxne8IQOamW7jmPRIEtgcur54evLNN16yyRs5ixkFyBmgg/A0yVnrhsQhNFbjA3ByDWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181900; c=relaxed/simple;
	bh=c3MjjxCah9rBlJv8gEbIO0Wdkh/B50Fpv0CEVpSv9OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kzdt1J8qMFiGlG1y/mgmmGokDm+fkHRD6QbbnYhjuERg3V+ancEjOtNX+8qLQ1TFFj965UZbyiJlRShQjoFMIzdwZV2kLvj9+GqKttm9pi6gwtUaZDOadlKpZoFURJEoXEa+lM86mFlr3bDjoSprBWPdtnQTfBugeM96i1LlfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfjNIE12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E440C113D0;
	Mon,  3 Nov 2025 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181899;
	bh=c3MjjxCah9rBlJv8gEbIO0Wdkh/B50Fpv0CEVpSv9OE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FfjNIE12fBDXyCnPG4LOVn61IOGzDAi39xv0r51APjfXkGOj6cWQuTRlUj604/ozo
	 Povw9myNuMm1ljtrRCkTqyVh4bFAPTCs5loqrX+7/37CHb+NUsq0s7uHoOpCs/m3ti
	 UMqw0xVtyhjapiaEcXLbqp2RqzD3u0CtRHDEDIvOkmpRwmmku8bQNDtEWl8XEbjf2T
	 uytPDnZZvyinUEWfIBgWUwOxEbJECZAr+mDAzOqt7nIz9SlJctuUzP8lcmv0ZygBRe
	 kouePD9U+wkCEQO5Ou2rYrGTTAZ8uDp3fShajHO2qMGWXF00JVj0vAHAIwmJPM3Bg+
	 yEwQK9iS9JPCQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:35 +0100
Subject: [PATCH 09/12] coredump: use prepare credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-9-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=c3MjjxCah9rBlJv8gEbIO0Wdkh/B50Fpv0CEVpSv9OE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHopwsuxvjlnd5bB3CqvS4ZW7CvfJnLHFto9bkkv1
 M8+UL+xo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIS6owMN9/rS7u0KCxf8ePA
 njVZXecXJj7JeVewWaYwJ7E4WXtFJcM/O6HUn0onP1l6aYpFnFo2/3lXNdNb1hCRqWYmcfwm2wu
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the prepare credential guard for allocating a new set of
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 79c681f1d647..5424a6c4e360 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1155,7 +1155,6 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
-	struct cred *cred __free(put_cred) = NULL;
 	size_t *argv __free(kfree) = NULL;
 	struct core_state core_state;
 	struct core_name cn;
@@ -1183,7 +1182,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_skip(&cprm, binfmt))
 		return;
 
-	cred = prepare_creds();
+	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return;
 	/*

-- 
2.47.3


