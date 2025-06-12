Return-Path: <linux-fsdevel+bounces-51467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE6AD71D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94E117C975
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B4248F7E;
	Thu, 12 Jun 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdjX26rV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADE2566E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734743; cv=none; b=fkX2hdCLAYyIBhlDL2FhZ1Y0OgSh1ScIelUnkWj+bUq/4l7llucSpvmqDvUCtl0J3S72kCgVKQB4GdIzVV+wP4+wnZCoiB2OoQdtgwpKN6Uak/ubRRkdGI9WIxt/K8Vo1QDnyPdrLvPOJzxRSDJH17tURBJOQDRQnpUJ1XeGQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734743; c=relaxed/simple;
	bh=TmlqCTA6m/L57ld03hi2zkM4dX/gTJmuRDgipg4skVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJVIl9n/pyEvsxFhYtpQ0tGXNt/Fh6oy0gGFPLwcBNfEZ77792ZgRAzaY+rpIfCtAyEsB38583uHDqyPG8UMd+7yfqKxOezH0QQOKMbFsPIgmNFAdk5Kw5wMCQStkFH+tuU+zxPb2d8rAsyYFw3zEgHfaibqMEC1+4vW+iC9YvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdjX26rV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C47C4CEEB;
	Thu, 12 Jun 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734742;
	bh=TmlqCTA6m/L57ld03hi2zkM4dX/gTJmuRDgipg4skVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GdjX26rV5WNI6qJ/m/VN4sIk+hmDEmAe1xG0971W04zwhNelA74Fqy4ugA6UfDT4+
	 8XpGSrPCBhIM0/pmnmItACOAKOW00fD66zdI/cxdd28j5kL3yqqJdo6j8qqeDTNspY
	 MCrD7pauRdWZ4Kvu1lguVVFWPDZitR0SU3Y9U/AQra9j/rWcWDaW7tK2Z6+uhT/+nL
	 3jZL2WNA5Go/mMaX/8EqIYwuhkUNEX2XNfRDhbgtTlMcgUWQsTusfnHGPz2flu+jNy
	 sIU7qs7Ms1fKH5rzKcPT6nkM9KfTjpSNx/yqLk1I9EbCo504Tobsv6rzuz7oT1Yxl6
	 9pd6NE3g5zpdg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:20 +0200
Subject: [PATCH 06/24] coredump: don't allow ".." in coredump socket path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-6-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=744; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TmlqCTA6m/L57ld03hi2zkM4dX/gTJmuRDgipg4skVs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVr+RA6vXKz3On9DhcetiXKhl6LW3ZKWEjHVvrqT
 YbeOG2JjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIno7GT4X7I24sdWc8XFrFJX
 2X9Plz54zPuOnsLHpilPnvKfefTx31KGv7KSG7f5Oh3W/FsqJPVM+6EDY7/GlUmFb/R+3RfYdKO
 qkxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no point in allowing to walk upwards for the coredump socket.
We already force userspace to give use a sane path, no symlinks, no
magiclinks, and also block "..". Use an absolute path without any
shenanigans.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index a64b87878ab3..8437bdc26d08 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1418,6 +1418,10 @@ static inline bool check_coredump_socket(void)
 	if (strlen(p) >= UNIX_PATH_MAX)
 		return false;
 
+	/* Must not contain ".." in the path. */
+	if (name_contains_dotdot(core_pattern))
+		return false;
+
 	return true;
 }
 

-- 
2.47.2


