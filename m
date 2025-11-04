Return-Path: <linux-fsdevel+bounces-66938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3EC30ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BA3462012
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBF2F5468;
	Tue,  4 Nov 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1ICki7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5E2ED848;
	Tue,  4 Nov 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258368; cv=none; b=MavRarQ5f3CzPKT8M+YUKB7iUcZHPOvij9WTqDGNp61ZwotZ4gnkSzTO/jovnC++4gV0tNUHU1HB/AG7HMLdTJUAiXpvYtG0IZldpw9uyhHrF8di4vVv4EztzUS1WP5T4DnXKGBGMuM6lkLjYWm9vjNGabg1/u0N8SrL603LSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258368; c=relaxed/simple;
	bh=A+9Gi5oaDByYdwSalbpWdwyS0pZJtiHOYC0TEbxSuHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7Jdmw3VR/Ckgr0VIHWMsqfEHPVPBR2KgAHXblCbYsS7uW7Qyz0XSGAii3WjhRAUdk/KduH49aN7CD04uflVgds4MAPknRZquRS5XoxAA0ceOpPbDN70Y/UHPmZRNbnQtAU8rMHHBhbJ1rsymhwUBoIPIbdRWVbeH+Amy2xcKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1ICki7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B5AC116C6;
	Tue,  4 Nov 2025 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258367;
	bh=A+9Gi5oaDByYdwSalbpWdwyS0pZJtiHOYC0TEbxSuHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t1ICki7gPPLcAPvJOYvq2lnw0N2LJQX42cgOE342VcvT/uUpOf8Bh7PcGVaW9i3p9
	 9GdU//jAoMAUyWw/wZ0pulQZngSxgt5KzWyOnmJ1iFhxfmTN7wYXVqmGvnAcNMVwQu
	 M4+/35RkwarTAGXEh1RTuYk0y6wZcaK/O/guGD6j+l+e5W472z0klOoSo6h3+M0Kq2
	 0E3jz4+xJm5DVj2B9yQsVhXwA0Ok9m/XFXknhC35zB2g9z7yi+Hd/tSrGwQVej3QQE
	 RolKBkmjHJaNO0/0B1xo+k2KZnDa6hhSR/saPmdAfxWwVEpbql8ycraKP6ZzqXL653
	 Izp3EXd+jLong==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:33 +0100
Subject: [PATCH RFC 4/8] btrfs: use super write guard in sb_start_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-4-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=626; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A+9Gi5oaDByYdwSalbpWdwyS0pZJtiHOYC0TEbxSuHg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt1il5m2Z0Z3QUr8/Qt2zovFWA/JsPSnhVwpKQl5w
 yFutkW+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIlRxkZfqwr//HBiKH+C8s1
 x+unjVezxy+bvTXRo+VcrPXKh6mT5jMynDh2TM3iLUfghydZp9Y/E47is3SIaDnf/Ogay7WFnxR
 52AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bec544d8ba3..4152b0a5537a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4660,7 +4660,8 @@ static int balance_kthread(void *data)
 	struct btrfs_fs_info *fs_info = data;
 	int ret = 0;
 
-	sb_start_write(fs_info->sb);
+	guard(super_write)(fs_info->sb);
+
 	mutex_lock(&fs_info->balance_mutex);
 	if (fs_info->balance_ctl)
 		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);

-- 
2.47.3


