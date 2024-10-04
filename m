Return-Path: <linux-fsdevel+bounces-31012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FF990D51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5681C20404
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F020896D;
	Fri,  4 Oct 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ1iO1b+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB868207A2E;
	Fri,  4 Oct 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066373; cv=none; b=m6225xRO8qVPLJPCDY4x+fKRnE8jvQdsoIT3l8FC7lgjaoZdSBGbo49Z5WWmzX0g/ytBeh8UIVSd45sRXCTAvJZsm34UgsUm7/pbnJfV+xDrW6iLuRw5JZxFnPe7eZIcfnW8aj8XSZHOhHmeGHgMUlwR6ZjxFV13GTtGGo3UBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066373; c=relaxed/simple;
	bh=3DupCd0BK5nVMeJtrsvS8AMecK7ocigIZU05ubrKsxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6PgRCLV+zsNJTRJ1azM1DJmmTI7coR01CMvuDdPNdHgra2l/96Gcx6YCI7fW9Cn9Cmx1awqtJbBSw46KTqTZ5aK141//OOJ72KOzDMX881MO1EUr0PctyHVVGVPR1Mk7+YU0bUo00Ex6W1tPNH5W+3wXUrZw3bIEpomP0sjOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ1iO1b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F58C4CEC6;
	Fri,  4 Oct 2024 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066372;
	bh=3DupCd0BK5nVMeJtrsvS8AMecK7ocigIZU05ubrKsxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQ1iO1b+VR8pLvRU7HaRQQPtH6rhuYaAvAfn7cL0PbCR5uU0807MkZjLTBkkE0svW
	 UmddizpCO3Rny4E0miJWFEozSFv4gjbktOwG9rkkWbXK+XPJQDOJ2XUujF4uIyGA+Y
	 6Zl8Z0tcuwIqsv8iP8Uo4P4eeTR3SV1bSnjg3/VZz6O+4kUGxY9oYw9JxZpCNloSD9
	 6W+FZD0TIjHKg6rSxcaJfY8C/DWy62+Hi/v6TJAZ2vk/U6Bd0RFgPJr6cOXJm1MzED
	 wMcCEQn/1PMkCkkRtyO2ItBOslzew0dUWpMZn00Fn9kNgm50hjAEh/h6s9ZCDPafcn
	 KvDgM6XTMD+Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 39/58] fuse: handle idmappings properly in ->write_iter()
Date: Fri,  4 Oct 2024 14:24:12 -0400
Message-ID: <20241004182503.3672477-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

[ Upstream commit 5b8ca5a54cb89ab07b0389f50e038e533cdfdd86 ]

This is needed to properly clear suid/sgid.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ceb9f7d230388..eb2a3ffb1e816 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1301,6 +1301,7 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
@@ -1315,7 +1316,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    setattr_should_drop_suidgid(&nop_mnt_idmap,
+		    setattr_should_drop_suidgid(idmap,
 						file_inode(file))) {
 			goto writethrough;
 		}
-- 
2.43.0


