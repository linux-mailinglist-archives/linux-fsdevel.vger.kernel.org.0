Return-Path: <linux-fsdevel+bounces-16929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FE8A5008
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A0EB22DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3642D12A163;
	Mon, 15 Apr 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHrVFIEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DB129A7A;
	Mon, 15 Apr 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185417; cv=none; b=Uy8+ESwfntE/w4lXm9Qr8WBwzjWL/GmWHpkXeNslJ9qClANj8HDycSwZa/Q+R0zJE8/xrdYMaJbWlLZOpfDqkw00tRyje8xeG4TvE4PmnJIzTw1/z+DpcnoZ2hY5nEq2Hp3romfO8u01FW2/pzmdcc6Qaoa9KjdXXVrrAOUuYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185417; c=relaxed/simple;
	bh=ez+9pHNThV4Qwno6XjpGOuiqDEvbUby8kRZAvhEvGOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+F+mRUbx6pDcvvTr/6kkjBCwsCGIxg+OfWxfA1O+MRG4gV97fne9XUNgZC+fLBXAiBOdjql3yfdSKoNR6aKykm4fvbGD0gUpMJ1K3JC7cMZw8CnNsj/OeEwlgYM/Ur5Pi9zMOxLazGH1a6l021+L9PlXwVUSoh43az14KGh8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHrVFIEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A456EC2BD11;
	Mon, 15 Apr 2024 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185417;
	bh=ez+9pHNThV4Qwno6XjpGOuiqDEvbUby8kRZAvhEvGOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHrVFIEi/Jop+gegrcvYz97xOR/jaQtd7CT/nitgVyqoAz2SMLqtFnPPewD3DRPb0
	 UzZLakYAMwGVDaleSQH3OcelS6l+JW/eiPM8wB0pO6PC2xlMEk3ZbmNAsqc5dMA7gh
	 FmzVZJurTw1hYmloXLhpz2kPWx2gsHioK9XpMVWuLo96GATaZGXL+4aVTM9a7uHHMW
	 bYnJXsZRnchc9wpVR5GccFU+AW/7mI3fmAWKeAVweDAdPBmKoW42hZdUaCDs67E/uu
	 oBgb6VehAf7OGy0xrSp7mG+LUDtWMJ9l3zwtGQjkxPVDHWIL51aTfmatPJq0insgDu
	 DTitlvC8e6jZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/12] vboxsf: explicitly deny setlease attempts
Date: Mon, 15 Apr 2024 06:03:45 -0400
Message-ID: <20240415100358.3127162-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1ece2c43b88660ddbdf8ecb772e9c41ed9cda3dd ]

vboxsf does not break leases on its own, so it can't properly handle the
case where the hypervisor changes the data. Don't allow file leases on
vboxsf.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20240319-setlease-v1-1-5997d67e04b3@kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/vboxsf/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 2307f8037efc3..118dedef8ebe8 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -218,6 +218,7 @@ const struct file_operations vboxsf_reg_fops = {
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
 	.splice_read = filemap_splice_read,
+	.setlease = simple_nosetlease,
 };
 
 const struct inode_operations vboxsf_reg_iops = {
-- 
2.43.0


