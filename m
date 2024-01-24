Return-Path: <linux-fsdevel+bounces-8639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B1C839EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B80284180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E25441B;
	Wed, 24 Jan 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF4SNat/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C53D7A;
	Wed, 24 Jan 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062896; cv=none; b=b6z/lsq1lo9uBOiTef1Vd06oKhEIk5keqEWTZMp5rILCQ2ziLdlUI+Clg+0OYS2XwJcmQqsD9MWI+pJieo5NTheQHehgr60n50N93Obq2s76ZEA2sBuY4KF68tF8+RrvrrSLL+6ZSZ+oEU9tVWMfgvAr8R84CdALBQc0+LKy7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062896; c=relaxed/simple;
	bh=3HOh/p8xwMWGTeJIdxrkvqcCOzV2nnOPkxOxyLrtmZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iETGG5TbJFmxisVTFP6dKSkE1WPGBKRV4/O63TSqeUb8a/oda5hNDFyFlc8U05HHaPU6PZy1j2FL2qcXoL++3IZzhfy5VpHuOIm6jkLyBnMccCC2yeiQ+73aBJnpQ854oWiwZJp68SJmf98c+EwiaRnHuVVpfN509xBrWXTIs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF4SNat/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F72BC433F1;
	Wed, 24 Jan 2024 02:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062895;
	bh=3HOh/p8xwMWGTeJIdxrkvqcCOzV2nnOPkxOxyLrtmZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AF4SNat/+tN/zI5rPcuPA46GbaTO1/mw24XBaoxdwXmUBI64y7zIfG/eel+ySwjHP
	 ozk1xmS6PwS3z81PnKBSK8EY6z+ISogxvrI86H0BnxmPJQcS4azxUsw7T2IMVaJKDg
	 VpcGe7+1jb9VMMM2lu5SCVx/gA77lECDq20FUdBXvBfzBmoS5P2HcPCU5BTMafR9Ql
	 H98kCfmiZmwSFU+SWd3A0HQrXcpRUagXwB61ZePwk+hqQmNMOxLydxQjCwfzcYDFpu
	 AqOWaagN52USmJzWuHfMcdF+e9bRFCJDkzkcPP0A1m014osBMocmERrvp6uLJ4LIWw
	 NnGscNlewWVQQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 01/30] bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
Date: Tue, 23 Jan 2024 18:20:58 -0800
Message-Id: <20240124022127.2379740-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Within BPF syscall handling code CAP_NET_ADMIN checks stand out a bit
compared to CAP_BPF and CAP_PERFMON checks. For the latter, CAP_BPF or
CAP_PERFMON are checked first, but if they are not set, CAP_SYS_ADMIN
takes over and grants whatever part of BPF syscall is required.

Similar kind of checks that involve CAP_NET_ADMIN are not so consistent.
One out of four uses does follow CAP_BPF/CAP_PERFMON model: during
BPF_PROG_LOAD, if the type of BPF program is "network-related" either
CAP_NET_ADMIN or CAP_SYS_ADMIN is required to proceed.

But in three other cases CAP_NET_ADMIN is required even if CAP_SYS_ADMIN
is set:
  - when creating DEVMAP/XDKMAP/CPU_MAP maps;
  - when attaching CGROUP_SKB programs;
  - when handling BPF_PROG_QUERY command.

This patch is changing the latter three cases to follow BPF_PROG_LOAD
model, that is allowing to proceed under either CAP_NET_ADMIN or
CAP_SYS_ADMIN.

This also makes it cleaner in subsequent BPF token patches to switch
wholesomely to a generic bpf_token_capable(int cap) check, that always
falls back to CAP_SYS_ADMIN if requested capability is missing.

Cc: Jakub Kicinski <kuba@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 13193aaafb64..9072db5d17dc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1123,6 +1123,11 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
+static bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1226,7 +1231,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			return -EPERM;
 		break;
 	default:
@@ -2636,7 +2641,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
+	if (is_net_admin_prog_type(type) && !bpf_net_capable())
 		return -EPERM;
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
@@ -3822,7 +3827,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -4025,7 +4030,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
 {
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_net_capable())
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_QUERY))
 		return -EINVAL;
-- 
2.34.1


