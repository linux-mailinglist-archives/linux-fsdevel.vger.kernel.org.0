Return-Path: <linux-fsdevel+bounces-24989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD3947898
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC081C21114
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADB154C0B;
	Mon,  5 Aug 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sEUkzoOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D8152E12;
	Mon,  5 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850831; cv=none; b=Iqb1aIuiKi5O59wptj9hiKmw/uKSodZmPL6jTKBA86QU4AJziVuSzL6Oh8YZSqGDvPMFs80abRr2ZvYAuTjU/LQu6/+xc97gLq863OJF7LC102ZWHjKwK8EmUL57OXorIBOnSj0pH09mCHVysXBd1Svl/Be1HbscXVcMiJZ/XjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850831; c=relaxed/simple;
	bh=Rw7lLyUzQtDQ37SOsZUqYsNsIk/yDuTOrlhTe9egzio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFb/2t/ZErkP7K0PG+xn+/3ZFq5M5ffiJsUkJhYvhWJyGfzuGraXq3lwdu8VYA4uPIfQxXyhofvnOZD5dTHA73HoOFgZ2t45H5lamS5Nd6xi7A/14Y3QQcMmmsUdgsGi3fZfBz1Qnhw37o0wlttoGq8G3q/fZTdgtffovw3fklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sEUkzoOq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722850825;
	bh=Rw7lLyUzQtDQ37SOsZUqYsNsIk/yDuTOrlhTe9egzio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sEUkzoOqfbySqJcN5K1mMVKJYXpLYE1IRUTo7bQpUvKepp60pD9UVd4taHe9bzo8i
	 tgccNMcis2n0B47aLtOw+gwiQhFv/C2pzsyrHftfzhvDIggsgHFrfXkpSTke+kDwO3
	 7gYU/uhBzj0p+yNKEYJj23E6+9SvzKVMFtcrxEuk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 05 Aug 2024 11:39:36 +0200
Subject: [PATCH v2 2/6] bpf: Constify ctl_table argument of filter function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-sysctl-const-api-v2-2-52c85f02ee5e@weissschuh.net>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
In-Reply-To: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722850824; l=1677;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Rw7lLyUzQtDQ37SOsZUqYsNsIk/yDuTOrlhTe9egzio=;
 b=Tnz2oU9PfiIZf89t1KnPtyCZ6GqcNmO1kGYDzyhnx0275zoYBfu/nuqPrypoDK++1DEFMwx3x
 751mlX196u8DVuPYVicR5AzL4h/HHq/d6kF2W8pj6o4m8RcO+73PFqG
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
2.46.0


