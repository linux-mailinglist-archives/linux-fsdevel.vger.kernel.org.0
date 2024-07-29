Return-Path: <linux-fsdevel+bounces-24516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7D93FFBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124301C222E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915018F2E5;
	Mon, 29 Jul 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J3oxi84t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41B18E762;
	Mon, 29 Jul 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285834; cv=none; b=fZ1dNDq8VOkuUfTzp4WRisQVV5r648VFegh8A2NgRGoSOIIQd12q3Zs7m8xeQBDap4FWHHfBWThSsdv2Uew/hqnmo6OnzsyJYNWnAWuyUCXguW2PLXUEWOJgt6SK+Fokik9aWXoT0QoEhaAl7jf4jN5fBhV12NDbEkftQcEyawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285834; c=relaxed/simple;
	bh=BKEQT8+KYO2Lx+4PYMNXeCjW8FDuqJOIi+Cq4x3uRkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvNN0KDyDDCCktdrL5GMCnLRy7w+c9ysT2AgxEuQDW+pKk4LvAZ/1zkPkpcItJmpXmSFqyNEZwokuVo6wZnZhAx9n52xhKn1S5N903ie2BXDbvdp2eJj6q2vIyQwZCijwkm59o52zrrs4Tqfq45XoibEH4gRO6aJ30po1fd9S9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J3oxi84t; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722285818;
	bh=BKEQT8+KYO2Lx+4PYMNXeCjW8FDuqJOIi+Cq4x3uRkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J3oxi84tTAvzqz4jmYEfFLCbaxJaRJSr6/V/xRBnLQFh4ZgSRJKXK+oTkGTn5+FaJ
	 oYkQUPdyB5rnwPOcahsiSoxIRX8C8I3LdDo83wRTzVMWnPtY8f86QrKptpyUb2D3q7
	 84I4Fp8F+ymJiXdVanMZ6iT5HcDcvQuF1zVQF5pw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 29 Jul 2024 22:43:30 +0200
Subject: [PATCH 1/5] bpf: Constify ctl_table argument of filter function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-sysctl-const-api-v1-1-ca628c7a942c@weissschuh.net>
References: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
In-Reply-To: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285818; l=1677;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BKEQT8+KYO2Lx+4PYMNXeCjW8FDuqJOIi+Cq4x3uRkQ=;
 b=V0Qa4gSui+7cgZ5N4mQ0QnvGulTtQsNALhcaFCC5bM57lCvZZFFvU2qkRds6yqjax9Apm9nqT
 9dZvvmZ7vO/A0NE1xZy8d96zTMTvfuDlDYQMsaK8wNk+USsANsZc6uc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl core is moving to allow "struct ctl_table" in read-only memory.
As a preparation for that all functions handling "struct ctl_table" need
to be able to work with "const struct ctl_table".
As __cgroup_bpf_run_filter_sysctl() does not modify its table, it can be
adapted trivially.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/bpf-cgroup.h | 2 +-
 kernel/bpf/cgroup.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index fb3c3e7181e6..814a9d1c4a84 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -138,7 +138,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum cgroup_bpf_attach_type atype);
 
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
-				   struct ctl_table *table, int write,
+				   const struct ctl_table *table, int write,
 				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum cgroup_bpf_attach_type atype);
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..429a43746886 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1691,7 +1691,7 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  * returned value != 1 during execution. In all other cases 0 is returned.
  */
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
-				   struct ctl_table *table, int write,
+				   const struct ctl_table *table, int write,
 				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum cgroup_bpf_attach_type atype)
 {

-- 
2.45.2


