Return-Path: <linux-fsdevel+bounces-56339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF37B1617B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD42564D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D272BD00C;
	Wed, 30 Jul 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUsB0HL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C32BCF51;
	Wed, 30 Jul 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881909; cv=none; b=TsxL9s0E7BQfOfpzs4QIo5RxwV23skCmCarVIypDrtBW3grgt3Bm1DicsE9JuynuupsUgSJ1YyG6nYGD+wv6jyaoSiuLP3DT9pNfkpgikYC/HPRlM9oKCVxowJ7qIYWhVamzsAPjWzdwQgc8kzlMd5SfT2XyR/HyEF29fFCz4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881909; c=relaxed/simple;
	bh=+rAzc5qvjz0FCD5vq5bKYPfZ4fICvaRMvsO7vDhd3jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NH4PtYa3BSHaq4ZRRBLQJIxx1/BCmc3c6/eeOe65w0LCHalQ6ZA1+sJXTiQhpeL49aYEEaQe9Gi5cMyXqYJfQFmcL2tLsM9afLhFPNJF/MEU0zq8drf/+e/PmXZaZaAQOFjrwKRgQx9qG0EKBVg91bx0BRyxS4dzI7B42IDufsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUsB0HL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D396DC4CEF6;
	Wed, 30 Jul 2025 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881909;
	bh=+rAzc5qvjz0FCD5vq5bKYPfZ4fICvaRMvsO7vDhd3jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lUsB0HL+ryaxgWhnK0hehy8FZ29dYok29L2frmn3NJsK1x2Selj8WMtgcRBjiQOwy
	 2O7C7JwOmZgNa25ti6YJB4N9VW4ZjmP+gEM1lQ51mMOMyfGsdynQD9D7X6+9GVX/k0
	 iQaaxT8UYW4y6bcne5pM/aNSgVoruYewjfUTFP9OxWbpu/wPO2om65bebfOl2YcPh3
	 grs5w81VGPFl6wSckTUjtfxhOVkPupCnZwYZpn31HtLnRrXLV/toMQE1ohKJkzEkj7
	 I2C95wbDX/GAOOOs0JUoCRheIzCbCVY5ukzRctl0QdtbNlwptgaVgJNfvpTiYUSZaR
	 XEmFllDYraVXQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:36 -0400
Subject: [PATCH v4 7/8] nfsd: fix timestamp updates in CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-7-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+rAzc5qvjz0FCD5vq5bKYPfZ4fICvaRMvsO7vDhd3jo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0ozCZMvsY/QigN4CpbOu48VpvIAL2kTVRDC
 jUPMEwLmzWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodKAAKCRAADmhBGVaC
 FUJgD/wNh7Hmn5bfpdWIRcoMZrV0ukGz4e9p3wBx5n4aWvICu+EKxxBUewz3fcfH2G1twF2oiuf
 g+W7A/8Y09vpc24XSAG6B6g1aWOJRBxZJDb43nurZOL4Z7fwsu+vcM4mWvxorXJE7fGbzCvx7CZ
 49VEgxbzFQSVJG7YCHVbLvYPN40qBi0g7xN4HWdV10asvwTldCxB2YDrSlHHj41r2c7U6lUL4Ls
 lh/z51e5J/TvQDp/EPS4HNG15lLTk1hAWN+Dl34OlKb2bqSdxKJxMlKKtPjrMm9l0QPuGEEMEYD
 h2yHsG7gMBW5T1524qSwgRqYa6tbjtgPflL1At5VHQsU5j7OwIa/FLPx5L4US8bTQ7CtMF4ricd
 6YsxSWc2gp8e8DeddKM0UWX7gIs/ZbKauPZGrm1/2K2FUHd1Wes3qpEqqvuaS/Bkkjc8hQ8XuJt
 zvQ21IRB5abeW8YiL49XR8dbMXTPEp0ZnuwsqeQ8gYILJV/JvHHGe4MfewfKzUSNnUXGtavJsa5
 /CpChHs0TA+Q8cwZctCqp0xhsMj+wDZzlAnuwNH9U71aYPlCnE+DyrSMQaRQF2N22HeVGHLpHgF
 2Bcr+7T2RBmisA8Z2qX9QBYIUfBc371vVPIKBQnfg32pR3o7KyloC4PlC+b9lLVb9I54NYIhL3b
 u1PQx198KX0oD7Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When updating the local timestamps from CB_GETATTR, the updated values
are not being properly vetted.

Compare the update times vs. the saved times in the delegation rather
than the current times in the inode. Also, ensure that the ctime is
properly vetted vs. its original value.

Fixes: 6ae30d6eb26b ("nfsd: add support for delegated timestamps")
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


