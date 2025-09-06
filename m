Return-Path: <linux-fsdevel+bounces-60427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3BB46A9C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B2F7BCEA7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE212C3276;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZPSin5JM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D5283FF7
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=jOXX+NVi4X+Lgx3xX29uX3J1Zueh747cQ6uxbdakBcDSx//XIlSUbQ3EnxSStPFEcpeEZ1SC8EZ9zvuciMmMBtxhLjJMFEVRnIvGWx/UFf0nsxj6v+ByAveyYqBdBjHHGWEFc8Psg7eTlVBPEcCm0MmVEU+BTQTLd3DApeIsoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=UygDzoGVgatbDlOxYmexdRB41P1uWF083tpZO/7eAOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq/PgQ4mZSjYt99kbWQ6oV02DqUzRBfcdLA4i7lrMJdmzCltZ6+7LOLR/1odTgdk13l0OpoQfge7Nsj5r5grXPUSryX/YDxbW0I2jLj4W+fwnS2CIjvMu+qDTkcYYLIvPgESevJgnv7r1u1JPT68AH/48dWR1bWgHtjZyQmZoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZPSin5JM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l+cuNSxTAzqJIMhMBbLxDYsGyTAkZznaw9gd65vHQdk=; b=ZPSin5JMDPBNpsE41jIUjjypr5
	duBYRuTnFSLTM6zkqSTdrox/VjO1Y0i+b4uofizXwTkw7u3W9qhW+Z7Ymra8Ir+O29DJrelheWvsw
	Ze77lZcTPifSgDv17KwVAasGli5YznpQDmsd4A6ZNtZZhGc+CW6WchQmpBHBQubLZGYbe2W7bfVOB
	WUqnHotiWqKzPw55kaoz2eHlBaj1xcF03mVYKzw3TenrQ520/RTuYquFTNMnyB/D55sODiDmwb7fD
	SfskRazm9lifd2yr7kfui65yWsCdH1/pV6W0FWSNopu3RVM4POo+OgcU64ZT9vEtzVaxtlmrC31gQ
	QxqIKHdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxO-00000000Oro-2n81;
	Sat, 06 Sep 2025 09:11:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 05/21] bpf...d_path(): constify path argument
Date: Sat,  6 Sep 2025 10:11:21 +0100
Message-ID: <20250906091137.95554-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/bpf_fs_kfuncs.c                             | 2 +-
 kernel/trace/bpf_trace.c                       | 2 +-
 tools/testing/selftests/bpf/bpf_experimental.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 1e36a12b88f7..5ace2511fec5 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -79,7 +79,7 @@ __bpf_kfunc void bpf_put_file(struct file *file)
  * pathname in *buf*, including the NUL termination character. On error, a
  * negative integer is returned.
  */
-__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
+__bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__sz)
 {
 	int len;
 	char *ret;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae6..a8bd6a7351a3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -900,7 +900,7 @@ const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
+BPF_CALL_3(bpf_d_path, const struct path *, path, char *, buf, u32, sz)
 {
 	struct path copy;
 	long len;
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index da7e230f2781..c15797660cdf 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -219,7 +219,7 @@ extern void bpf_put_file(struct file *file) __ksym;
  *	including the NULL termination character, stored in the supplied
  *	buffer. On error, a negative integer is returned.
  */
-extern int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz) __ksym;
+extern int bpf_path_d_path(const struct path *path, char *buf, size_t buf__sz) __ksym;
 
 /* This macro must be used to mark the exception callback corresponding to the
  * main program. For example:
-- 
2.47.2


