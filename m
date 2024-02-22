Return-Path: <linux-fsdevel+bounces-12424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38785F1C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482221F23A8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B177417BCA;
	Thu, 22 Feb 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aGbX+ctM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D0F9F5;
	Thu, 22 Feb 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585706; cv=none; b=fjZTRvBB8LlcwDm66+9VdNLmApsWzQG0YEyNRUWOzWk8ggkq1NmSrIku/W+6oZEMYty/rOMP+e9dD0meAqdiKeaxPTuh9WtCTfj0Pcj5+3D8av3VG0wLKcVUCr4t2cq8JUCQNHPbVoAR30y1xsyvdI132kLX6fSqX/GqfKD5t7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585706; c=relaxed/simple;
	bh=2soR7KajXwzwQXCP9lWkLt0XwWeWSvqlG2ruurCjAJo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nGOoIq9muiBkijVdgstX125wHrdOk/uv9hjd9r6dY09qjAYdRf/ACB003yUW7VojJDrv0jmweCtkrvwm7pYsjR0i4YtG1S5X1ecgnTnuY8ARByYSQFoB0Oz/oWL3pm3XBpHMWd3fPCJKFS2ilQSJoChbDGPivJRbqlLF//OWgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aGbX+ctM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708585697;
	bh=2soR7KajXwzwQXCP9lWkLt0XwWeWSvqlG2ruurCjAJo=;
	h=From:Subject:Date:To:Cc:From;
	b=aGbX+ctM3SscFwnv50+cjuwS33sKTxPhZ88xRVQddaA0CGyfHDABEBpfR4yqRGf1K
	 R1O6oxDmHkYbCIL3naj6c0w248pQB1dFBICKe8r+oY8uxW66m4DcP9bjDx0W1vPnU+
	 /DS9izTjG9IhRc4M9HLWBw9w6sP60rAsUshWggRs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] sysctl: move sysctl type to ctl_table_header
Date: Thu, 22 Feb 2024 08:07:35 +0100
Message-Id: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALjy1mUC/x3MSwqAMAwA0atI1gZMBQteRVyoTTXgj0bEUry7x
 eVbzCRQDsIKbZEg8C0qx55BZQHTMuwzo7hsMJWpyVCDGnW6VuTtvCI6CWjJ2aYmb0fPkLMzsJf
 nX3b9+35pYEbOYgAAAA==
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708585698; l=1139;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2soR7KajXwzwQXCP9lWkLt0XwWeWSvqlG2ruurCjAJo=;
 b=2A7jBJ3P2WImICv/ZMsnClbTGNvpvDRm9MPeySlCwEKssa8drCitOYc9THSuSI6hKWAifDCSU
 N3mgsO2Q8rkCn+Awh74jLIZi0/ocv08/Cjbgpa2kEtFEgB1z6pCcD7U
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Praparation series to enable constification of struct ctl_table further
down the line.
No functional changes are intended.

These changes have been split out and reworked from my original
const sysctl patchset [0].
I'm resubmitting the patchset in smaller chunks for easier review.
Each split-out series is meant to be useful on its own.

Changes since the original series:
* Explicit initializartion of header->type in init_header()
* Some additional cleanups

[0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/

---
Thomas Weißschuh (4):
      sysctl: drop sysctl_is_perm_empty_ctl_table
      sysctl: move sysctl type to ctl_table_header
      sysctl: drop now unnecessary out-of-bounds check
      sysctl: remove unnecessary sentinel element

 fs/proc/proc_sysctl.c  | 19 ++++++++-----------
 include/linux/sysctl.h | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 22 deletions(-)
---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20231216-sysctl-empty-dir-71d7631f7bfe

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


