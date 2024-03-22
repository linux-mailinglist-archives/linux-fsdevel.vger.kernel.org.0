Return-Path: <linux-fsdevel+bounces-15115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FE887197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A64F1F235FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F9D5FDAE;
	Fri, 22 Mar 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TZ/tkMVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757B5D752;
	Fri, 22 Mar 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127167; cv=none; b=Pr9CpeixvMMXmh3Q+fmdYzwGXdlMBi9u3RKSOMMig/PTlZr6ak9mQGgSOXKGf6eaI2hlamvFO54A9iSVlzaa+5GOLThzblBS81aQZ6Nl7bChNI4HeJ6cws9uKGPd7m3+1XkTObR9/eJwVn2aVuS8OWp1vewNjvF4l4nuHlql6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127167; c=relaxed/simple;
	bh=xfu3y4QYAgn5H7+B8mfCPDTjeXUxu85jQuuNI/0GZag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CoIY1kFNNlCArdz4L/TpmBPIsqyqEUO+jvvtCw9IOdL4UZdk+G+1ASGKj56L59fdT/myFkOuYyhO+dOMtoaVWjP7V2BczDXZmhXz2p9yV5WN5GgSGXcesNbQ1jZuK+LrQ3S+QnBxYKXgMBMgSu693P2XpYF7QyPV4Q8Zx1b7WMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TZ/tkMVc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711127160;
	bh=xfu3y4QYAgn5H7+B8mfCPDTjeXUxu85jQuuNI/0GZag=;
	h=From:Subject:Date:To:Cc:From;
	b=TZ/tkMVcIsrPODIhl7kLOqJPmZDhdRfN8YqM75QXBEaRswNXWWx1Z2pAKgxEJeWll
	 v2vgp1ZNmUIDKzFSb606LiFPaYA8PV5Nsx/WDDYeiZCnraW27aXtUB9tCq4xgpmd6d
	 GI6UfAw+dJCrUCG1q9Rgxcx9A7f+eK/dYRfXIFes=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] sysctl: move sysctl type to ctl_table_header
Date: Fri, 22 Mar 2024 18:05:55 +0100
Message-Id: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHO6/WUC/2WNSw6CQBAFr0J6bRum+Skr72FY8GmcThTI9IgSw
 t0d2LqsSl69FZSdsEIZreB4FpVxCECnCFpbDw9G6QIDxZQYMjnqoq1/Ir8mv2AnDgvTFXli+qL
 pGcJsctzL90jeq8BW1I9uOR5ms9s9lsZE9B+bDcaYZk19rfMkI77cPiyq2tq3PQ/sodq27QfpV
 +F8tQAAAA==
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711127159; l=1342;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xfu3y4QYAgn5H7+B8mfCPDTjeXUxu85jQuuNI/0GZag=;
 b=KuaG1JDkxSMsUgB3vh72Zf9SMWssHzNMLmc6o3LiNi04YbgX97I5qIPWeAwFaZNVutwWnTFOW
 AoAawNQWPXnCldm0bnTkTwD74upFB3J3j0GLWOewBPTqV7OY3mjTeau
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
Changes in v2:
- Rebase onto next-20240322 without changes
- Squash patch 4 into patch 3 (Joel)
- Rework commit messages as per Joels requests
- Link to v1: https://lore.kernel.org/r/20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net

---
Thomas Weißschuh (3):
      sysctl: drop sysctl_is_perm_empty_ctl_table
      sysctl: move sysctl type to ctl_table_header
      sysctl: drop now unnecessary out-of-bounds check

 fs/proc/proc_sysctl.c  | 19 ++++++++-----------
 include/linux/sysctl.h | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 22 deletions(-)
---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20231216-sysctl-empty-dir-71d7631f7bfe

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


