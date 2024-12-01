Return-Path: <linux-fsdevel+bounces-36202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325229DF5BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9323F162E41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA61CB505;
	Sun,  1 Dec 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgNnuDNh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3F1CB51C;
	Sun,  1 Dec 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058788; cv=none; b=FBDMX3sI4vp4MOKNEZq8W3jxm5cO9WjdYefcVuep6jFyhBouMiIXlakazY7ILGHMpYjq173Ody2veaUDbaobCisQxA9hGMqph8Zk0vezcoKTlQyC/hu4CPPUv5QI3lHFu/rP62CGOS3tezmueZYG/esLx85Cv6qoQq0zcgeWobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058788; c=relaxed/simple;
	bh=5orgtBoTxXpJkz8BkoZsQy5RLFKoiEsCdBaXTMOGW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8l+UgvPLMFaR4Pze1Gl1lrEu7RhnsMJZNXWD3UlHPRi1d2HTHmVWgO1bxgySYtfgW81t5uTr9Fjzxp4s4TNSaqK+KCHgGvw3DDGL5rLm3opGITiatClMrX2rtA7MOW4W2Q8F1Bp5aHyFm1NZBQg7LVQHXgDCIFZqAN9JR1aPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgNnuDNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2031AC4CEE2;
	Sun,  1 Dec 2024 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058787;
	bh=5orgtBoTxXpJkz8BkoZsQy5RLFKoiEsCdBaXTMOGW3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgNnuDNhGp4eusO4adtDhr/sJHwKp797fU/JnsFMqLDfOXEdGkT99T8ZSeXRqw0vP
	 ad6gInwqc9mr8yWHLWLm6iKTs9ed0KVM43rukrio8MYNAqmbpt5XkgVp5e+wVp4bZ9
	 mfj2ChoLWNtqWhFlxqzpCnx6xk/ArB3a4RUFFgevmS+fzwAXN24E+mMc63XFLg6dcE
	 bhDrSfC7swo0Fu0+joBNDomBj//1flncMigX7lHPB4KzbOOsb+wbjcSP+xGdcrd8f+
	 sIWhF8engmZNHdkJEUGdHDlLsYpwAMPUzVTlmMGcKmR8Yu2YA25wrdTmOHp5Am1Ryw
	 o2mpKYMOkevYw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] ovl: restrict to exportable file handles
Date: Sun,  1 Dec 2024 14:12:27 +0100
Message-ID: <20241201-work-exportfs-v1-3-b850dda4502a@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=brauner@kernel.org; h=from:subject:message-id; bh=5orgtBoTxXpJkz8BkoZsQy5RLFKoiEsCdBaXTMOGW3w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7JOx/1KMZsrbr08q/m2Y8s3jx0DpTMTyV5Wdj16Kfp iu3PBLQ7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIVRQjwzeOuLUzKmyWVpxc +fQWX9V/S8sL0br9Nq8/WembTRCYJsPwP1xZTv/szz7Zja+rn1Z16h9dWaNiWL70Y/C/f3HGOab 27AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Ensure that overlayfs only allows decoding exportable file handles.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 9aa7493b1e10365cbcc97fceab26d614a319727f..b498c74084f3950d8e4d9f63a804d1abe08258fc 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -83,10 +83,15 @@ void ovl_revert_creds(const struct cred *old_cred)
  */
 int ovl_can_decode_fh(struct super_block *sb)
 {
+	const struct export_operations *nop = sb->s_export_op;
+
 	if (!capable(CAP_DAC_READ_SEARCH))
 		return 0;
 
-	if (!exportfs_can_decode_fh(sb->s_export_op))
+	if (!exportfs_can_decode_fh(nop))
+		return 0;
+
+	if (nop && nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE)
 		return 0;
 
 	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;

-- 
2.45.2


