Return-Path: <linux-fsdevel+bounces-56083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC3FB12B03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507E716C458
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C8289353;
	Sat, 26 Jul 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJathtJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EE288CB2;
	Sat, 26 Jul 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540331; cv=none; b=tIdRE+KPHRQrKqURp5tiBbnA0IIjKyDkI9dvupcuSIcLt4k4kLmofXOC+YV5hIztaRgIji2iXpQpzTHSQBqnF/IhOc7UjfM7OjkvLLQt+efvj06jr+y1ISGdzAbxUQzh3S9V7NuDtnoMaRXfUWAtGKRlic3gtCC3UGQKT8oWVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540331; c=relaxed/simple;
	bh=zb0KcsT4OeKcJsPoBb2cTusxxjt+L0Sv4EowLlwUSBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nc0FPevBiYg1PXI5NlHJ+kEXh5BBmF1darVSW/Qe+dUzmsnSyH5aoIe8WwF1Fb79iZeXHPtlNqTIVVxOytRi+bFqBmvQssTSvt9/9G9fkVdff+xeeNcL69DrHivU/JXIrM6sUnY3aGx6u5sCOchfgzVDf6pLg0iJ0bj7ycNh4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJathtJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEB7C4CEEF;
	Sat, 26 Jul 2025 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540331;
	bh=zb0KcsT4OeKcJsPoBb2cTusxxjt+L0Sv4EowLlwUSBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZJathtJl6Qc5AIywrU6xkq4iz2DDXWXGA195ArJA3O3vG/KutzcYts1q0bkATYoAn
	 /l5YI/HOG4z2plsC3kXfQvim/bAp6w0YfC0SHrJkz8LgcaAet+QOwfvARPP+P8+7pV
	 gibkv0LgPUEQU6Ky3V1EoSVZKYhpIUSM/LqI3LaLudkztQWuWLYQINwE+ono0TtuQs
	 mgXNa6BZ6TYYG3J/KwF0Ja1EhN8QtEJ2xAqMRvTHb6eaxPXRXCF4BdaMy9ioK/w8nk
	 dEBKjfw0lF8fEnJmGQr5Ow9nUbhqjxav6Byv/4jpsZypxH47nCjR6zPOnXnYQ61td0
	 ClpUycEIG+TJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:32:00 -0400
Subject: [PATCH v2 6/7] nfsd: fix timestamp updates in CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-6-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zb0KcsT4OeKcJsPoBb2cTusxxjt+L0Sv4EowLlwUSBg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObf1TPeq9m7xz8YWWL9mSQu3CXambxR1PxaD
 CJU0tQ0iVyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 FXeSEACQIQ9O8jm73/8xMlQuOaKCOIHfiN0E9/v5AZJyrG30CYYwrBqtvWGV9iD9/xCLKsT8Tmw
 UZeh1zLzYZXH9mEDMp1Majg4PnKXsnyd7NG9QFbOda41nkNn1agtjG4ScGs8UjJFYdtqLBLc24C
 bNnSzNtr/Ht2DEb8Xi5MR/GJruq0eV2TopEcACJyjTajeJIMQ32xfhfjlqimnVDDESWta+Y+2aZ
 0xDOz/nBVDDFLnErgN9sIuqVj9IzJpc6XxTVmCfEnbetHLKt5spdUxVArew1l6OGdFIbpp3VsLk
 biy1wcM07hRh/3jxb1uZUGlNf+I6LGDwfrLXxa+ELHKz9HSBWLS/4d1b3Ic7SI/Jo3mR2Ky5RRc
 iHQnqkL3nD5FMKU69ptuqscC0ZcZrRYAS5i1ChlTuB2WtJ22QyJz5D1EwuE9HpG7oZmRGZ5N+Vb
 Tc85r/Np8V7zFPaPx+Khiwl9tzqgsF8W7LxDxM2jIgkBYa+wRRwIEDVXD3CEK+lhH3eRb2vo9JW
 9K7iPtZrBhM7tBKTo3N8Be+0SCwmkIIUXL6K3W926wf6m/ksHRjFk4lrU84JQYVWfQuaw52UtUO
 C2DhV+FawVTZOn8kb8NFt9Ugk9pmlXvQoKMMWZrHZdIU6Y3rdb05evlBP/fNVl5MXEG60XwPVZk
 aGwrEjvQrSE1bPQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When updating the local timestamps from CB_GETATTR, the updated values
are not being properly vetted.

Compare the update times vs. the saved times in the delegation rather
than the current times in the inode. Also, ensure that the ctime is
properly vetted vs. its original value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f2fd0cbe256b9519eaa5cb0cc18872e08020edd3..205ee8cc6fa2b9f74d08f7938b323d03bdf8286c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9175,20 +9175,19 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 	int ret;
 
 	if (deleg_attrs_deleg(dp->dl_type)) {
-		struct timespec64 atime = inode_get_atime(inode);
-		struct timespec64 mtime = inode_get_mtime(inode);
 		struct timespec64 now = current_time(inode);
 
 		attrs.ia_atime = ncf->ncf_cb_atime;
 		attrs.ia_mtime = ncf->ncf_cb_mtime;
 
-		if (nfsd4_vet_deleg_time(&attrs.ia_atime, &atime, &now))
+		if (nfsd4_vet_deleg_time(&attrs.ia_atime, &dp->dl_atime, &now))
 			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 
-		if (nfsd4_vet_deleg_time(&attrs.ia_mtime, &mtime, &now)) {
-			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
-					  ATTR_MTIME | ATTR_MTIME_SET;
+		if (nfsd4_vet_deleg_time(&attrs.ia_mtime, &dp->dl_mtime, &now)) {
+			attrs.ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 			attrs.ia_ctime = attrs.ia_mtime;
+			if (nfsd4_vet_deleg_time(&attrs.ia_ctime, &dp->dl_ctime, &now))
+				attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET;
 		}
 	} else {
 		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;

-- 
2.50.1


