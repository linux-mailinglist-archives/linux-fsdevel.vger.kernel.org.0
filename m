Return-Path: <linux-fsdevel+bounces-53791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA27AF7334
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFD8562D44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055E2E54B7;
	Thu,  3 Jul 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M52IOnLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D942E4278;
	Thu,  3 Jul 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544229; cv=none; b=Pvzmxj4gz8Csihb6P0I+s8I8n30+TG9gwsGcaB26RebaEok8f6XpqIw/g1ejO0d/yGKTbh3DmCNmYMTwGY3iot0Itl1ktwXeHlTpPZVQkkJH9WUXOtqLKLmWUcyclAMG8rkB9DbaU0rm8CRdVGV/Cvh7Ul7bp3ngHj0fvYQpW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544229; c=relaxed/simple;
	bh=DPLlg8RFPNJdxWW/brCD2gDkRKgZCaF2rPsXV0R+7D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdMi+IuEiGfyEWFwhg+Ftf9KimYhOqPVHK77+yWUvRoNtjDRulIYRE0S6z63MxGHi+iLUF848XJy/gWc04P5Efa/W7SeIm1EMmbPHFf6EbxOGjdrwlCkwumm5ES1T76+a6hUvLcAoAMiFOF0yVQ62365oQ2FUiA06hcTNhsBrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M52IOnLP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so1741748a12.0;
        Thu, 03 Jul 2025 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751544225; x=1752149025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZiJRpaaJ7ruZirKbZeRPx4dN5q7YM53YMqzZaGHH3A=;
        b=M52IOnLPAEWznqfeDk/3jt0d4zM18enditDp/aziC52udAZrpsQVap7dPxTI8P/4/G
         KDeSKO0SF+Jz9wsMgMmD9pLrPtP2XiGUIFVfGhdI+AgnZQ5gA4tJW9NbvcAhB0JeCYYn
         J16qR5iuCP4moNBkDAZJ1CU7En2KTZ94Etuj1KvhCGdKr7v7lhvZNalZOtQyc2pgrWMg
         fJbq8HdfOyJJxxheKnvCDTvSMlfJNls+THel2Vr0mZmhhj1LZC6snemldmPQZRICgdTO
         NWS1uo5fj9LSYz1JzMlamDaMl1Uux6bPSgTIdKEOIqQidMio94PIyCz76VK5DlPLtcB2
         kh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751544225; x=1752149025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZiJRpaaJ7ruZirKbZeRPx4dN5q7YM53YMqzZaGHH3A=;
        b=JebDibWcZcNNXOMi5uJA2qo1yfnMcdDnX3HI+02EcJT9CoUYMDY4QHDey2v4iK3Q3G
         I1KTLIeT1/XtRq74uD95I1GGna0F908qWAs6hbZsBBg2V7MvELdIr7NSM3HXf6BikynY
         LAVYA/qwzBJGLsjrjh+re1zrLkSE3bylAh1MZk41jX1+BkNZXyy4xex8Ec70mQthyg6y
         m7KBqtL92UZeJrWLmyX6ixBClhzH1hkYIqMCByWwZNq8LHYV/9noV2R131LrhtfhgGUE
         UyWeOtjzJuxL0EcOqxdDPKsBpKxV5dpcfOhIbhA2AW7U1AFk2FqrOxk3G12mrC6zudDx
         Khjg==
X-Forwarded-Encrypted: i=1; AJvYcCU8nXkZSwtyU2AtQw1VPamekinXtkgpVLDUmZdi4790KiELzvpBKyeMRU9aJEOmGSzK8aISa3tm4acz1ue3@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSewitI5hxRh7Z4donKrZl9rLU1wvq7tIQv6rdNjDEJi8Ejeb
	shDuPLZMNmmyFmFQG8FNCw/w83vYO+EtY7ESK1c6DrvfKgitn898pQtq97RrenGK
X-Gm-Gg: ASbGncuKhDDE1diTFeXkCZefag0mY37Ylk+8Gw3kpkoK0D9GetlZBUoT8s+GoLCEanN
	L6k6RRAPxUFOa7dVWoAsCYNYsOhKwsAIaD2T279HTPWW7PwKw6RoPw+OaNAABh7kIbwdRiExhIV
	V7jFfIPrl2bf6Flvd74R2lXuO3xF07jsqcHAQOS1Pd+XrOhfXjblIqjiRbgat0us8IOkt5YkbnJ
	LAp2ZupaMiiG75VXHZ6mUQM4WymrH53IY1XgTBJzNvfTqEMvXgwFeMUlcF2eqZ+VypYwx4wKa6d
	yNcgCaGprFxIJPHyXWALusCmETbgdIrs4tUwe1CTXp+ciXXM4mDrM9qnCMDMJTFCqrKqZSol4oM
	iKbYii4ldJl+N4t1A+4xnj8sge0BTqRnQXfB+lPs=
X-Google-Smtp-Source: AGHT+IHYDAaPmrCCz58mtFkwj6fZMHuKWu8i2NQzgkDwQJlkkBjrcsE0qfhmirYRpHgfVTYpyPcTpw==
X-Received: by 2002:a05:6402:22d6:b0:607:2e08:f3e6 with SMTP id 4fb4d7f45d1cf-60e723fdf65mr1686967a12.17.1751544225203;
        Thu, 03 Jul 2025 05:03:45 -0700 (PDT)
Received: from Mac.lan (p5088513f.dip0.t-ipconnect.de. [80.136.81.63])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c83205eb0sm10563837a12.72.2025.07.03.05.03.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 05:03:44 -0700 (PDT)
From: Laura Brehm <laurajfbrehm@gmail.com>
X-Google-Original-From: Laura Brehm <laurabrehm@hey.com>
To: linux-kernel@vger.kernel.org
Cc: Laura Brehm <laurabrehm@hey.com>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] coredump: fix race condition between connect and putting pidfs dentry
Date: Thu,  3 Jul 2025 14:02:43 +0200
Message-Id: <20250703120244.96908-2-laurabrehm@hey.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703120244.96908-1-laurabrehm@hey.com>
References: <20250703120244.96908-1-laurabrehm@hey.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Commit 1d8db6fd698de1f73b1a7d72aea578fdd18d9a87 ("pidfs, coredump:
add PIDFD_INFO_COREDUMP"), the coredump handling logic puts the pidfs
entry right after `connect`, and states:

    Make sure to only put our reference after connect() took
    its own reference keeping the pidfs entry alive ...

However, `connect` does not seem to take a reference to the pidfs
entry, just the pid struct (please correct me if I'm wrong here).
Since the expectation is that the coredump server makes a
PIDFD_GET_INFO ioctl to get the coredump info - see Commit
a3b4ca60f93ff3e8b41fffbf63bb02ef3b169c5e ("coredump: add coredump
socket"):

    The pidfd for the crashing task will contain information how the
    task coredumps. The PIDFD_GET_INFO ioctl gained a new flag
    PIDFD_INFO_COREDUMP which can be used to retreive the coredump
    information.

    If the coredump gets a new coredump client connection the kernel
    guarantees that PIDFD_INFO_COREDUMP information is available.

This seems to result in the coredump server racing with the kernel to
get the pidfd before the kernel puts the pidfs entry, and if it loses
it won't be able to retrieve the coredump information.

This patch simply moves the `pidfs_put_pid` call to after the kernel is
done handing off the coredump to the coredump server.

Signed-off-by: Laura Brehm <laurabrehm@hey.com>
Cc: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/coredump.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f217ebf2b3b6..a379758d9ca9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -898,12 +898,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
 					addr_len, O_NONBLOCK | SOCK_COREDUMP);
 
-		/*
-		 * ... Make sure to only put our reference after connect() took
-		 * its own reference keeping the pidfs entry alive ...
-		 */
-		pidfs_put_pid(cprm.pid);
-
 		if (retval) {
 			if (retval == -EAGAIN)
 				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
@@ -1002,6 +996,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
+	if (cn.core_type == COREDUMP_SOCK)
+		pidfs_put_pid(cprm.pid);
 fail_dropcount:
 	if (cn.core_type == COREDUMP_PIPE)
 		atomic_dec(&core_dump_count);
-- 
2.39.5 (Apple Git-154)


