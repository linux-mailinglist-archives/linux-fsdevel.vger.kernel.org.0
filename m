Return-Path: <linux-fsdevel+bounces-14518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EF87D35B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB111C21C48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975784E1C1;
	Fri, 15 Mar 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BZpOY7Gf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E71B810;
	Fri, 15 Mar 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526245; cv=none; b=M6nxZ0FF/+/5ZgYTQBRxgUBt5ClyGglOLub2lsp0c2QH1ku4jLG494bCS77TnI5gyn7fs+yHxjEHC8gv1V7IT2nBpiNkGNK28ueK/946pMM27vL1hV7cuERX40Ldf5/3VZBGPfdG6QzDF5mNKwEBsRubDZWOT/M+lTbX/rsaBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526245; c=relaxed/simple;
	bh=qP8nHFMJofHjWsKPWlJWonj+i8kGEwps7Wxqod3/LYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nblBjGYFC9GrASyImke+ymuJOYd3P2VVNVrAsng9wqahATFW2M4E5rObPzxwZXejzuo5u0HrLTxPQp8AqvtpFm2XlpNNUXeFjpexAaizze/UMPSwU5lHJBGIO4d5hu4/yg0jIipsfiBaBcvYIDpAwBJfb3wsob/UEX2fankOkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BZpOY7Gf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513dbb5a1f9so996466e87.2;
        Fri, 15 Mar 2024 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710526240; x=1711131040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ0fcTtTD0fe4SyWRrePksxxOrhm45+SyvujsTCShkE=;
        b=BZpOY7Gfxc0fq5sCCAMJNife7+wlXKE5RxnxURWpuSrqQd8HGMwmnzcpiGwRw6grru
         f0D+x1HDGuuGtrYNd/Mb3eAYoGtxcJSizrH9By5B39nWAr6a32RHrKDoGORoWSlezNeL
         SN0Ha4YCHPFucob969rsICHJSbdPfnFIb+RAsXoxeR5bcBNqEh9BqvHww1S3puBhB4Hi
         1JY5jrGdytjM8LPsOK7qMLuW0sE9wEncLeE4KVihFmZllU0C0284Z9/xXmtb/MJSwdXT
         nk/VrMVp3aG5QogGiFhUWvWR8hZE8Bgu8LUViBw9caS0AIp2vw/dnGEZ9yGoWP0wRaJd
         p8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526240; x=1711131040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZ0fcTtTD0fe4SyWRrePksxxOrhm45+SyvujsTCShkE=;
        b=Ij8FE/aUNhpCXw9QZqL7hOkRtwusZzIlIhau0qqLwtHJUPog7oNUggPwtcC4SsdnKY
         Vay0jPaaFDkKcl4sXdLYDrHy+xETHNhg6tsAJRRIgHgfLEFm/Wa4+xN3GHjtsl9iVnnu
         x3XTDfHgDbyVbfOs5JF80vVXTd3lqwrs1na53odaHs10MVOyF0vu1Tqvdg6DLztL7/L3
         V03gqOHwsc1BMWVTF4zZl+4r/wDWJAQnvQTSwn54MPvsvRgJZdaCCtNc4b/NejM843Hf
         oIg/gneAyhJdDPbkYj3YiQXVvp7MA0/dOiopi27NOLdVu8oMlMHBgTzCd2KOfIGHnhNI
         BhOg==
X-Forwarded-Encrypted: i=1; AJvYcCVGmhyByAx3lDcMhrvuRWGCTdxKEhR/vsEh5bHHJUk28T7s21BNaOFX49Hr1YL79cfGYvrcmxxt2bTj3IRHmSBjbTgkWO2S72DGScNJ2/oLlI8FXmzW3WDX2vi5tstlj2oCPn1Do6y+xJUe3aeh948J8brw/TD6NM78e8I/KjeVJmOr6Z0=
X-Gm-Message-State: AOJu0YwRMDMfrqO5YYZ84PVCDSJjCEtu8lUMY2kqJ6NJyKKf/HO7QtAo
	FY1ygImY3AyCTAVVtrXU719xBjluCaPOZ4FSMTrP28uJTShFF9Ij6qb8vP/cT3WHAQ==
X-Google-Smtp-Source: AGHT+IEmiwrd4RrzijlKpRPRn/2mZElzaqpXLjQrJS1Vo5fvprxZg222wGzTFeFiS5qSlSXAJenLSA==
X-Received: by 2002:a19:3850:0:b0:513:c757:33d9 with SMTP id d16-20020a193850000000b00513c75733d9mr3931656lfj.53.1710526239712;
        Fri, 15 Mar 2024 11:10:39 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id jx11-20020a170906ca4b00b00a46937bc44esm510480ejb.135.2024.03.15.11.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:10:39 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Guillaume Nault <gnault@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Alfred Piccioni <alpic@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 2/2] selinux: wire up new execstack LSM hook
Date: Fri, 15 Mar 2024 19:08:47 +0100
Message-ID: <20240315181032.645161-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Perform a process { execstack } check unless virtual memory is marked
executable by default.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a0fde0641f77..daf901916836 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -113,6 +113,8 @@ struct selinux_state selinux_state;
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
+static int default_noexec __ro_after_init;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static int selinux_enforcing_boot __initdata;
 
@@ -2221,6 +2223,18 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 	return cap_sys_admin;
 }
 
+static int selinux_vm_execstack(void)
+{
+	u32 sid;
+
+	if (!default_noexec)
+		return 0;
+
+	sid = current_sid();
+	return avc_has_perm(sid, sid, SECCLASS_PROCESS,
+			    PROCESS__EXECSTACK, NULL);
+}
+
 /* binprm security operations */
 
 static u32 ptrace_parent_sid(void)
@@ -3767,8 +3781,6 @@ static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
 	return selinux_file_ioctl(file, cmd, arg);
 }
 
-static int default_noexec __ro_after_init;
-
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
@@ -7120,6 +7132,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(quota_on, selinux_quota_on),
 	LSM_HOOK_INIT(syslog, selinux_syslog),
 	LSM_HOOK_INIT(vm_enough_memory, selinux_vm_enough_memory),
+	LSM_HOOK_INIT(vm_execstack, selinux_vm_execstack),
 
 	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
 
-- 
2.43.0


