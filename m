Return-Path: <linux-fsdevel+bounces-34189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF0B9C3856
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15831C20E53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1075155335;
	Mon, 11 Nov 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeRkOeV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FCA933
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306461; cv=none; b=n0WSnhXj/WuH6aqNrLxIYN49cJwHTH1ivPqwQa+huMisv5hdPzwyTas9Ii1Z42/B1FVkEiJ7iTB1z4tMl4mKTbe57/gxDPv8h+Joo5HeNtDCSSid1a18gCN/cMeKcYY+l1AVNY8FoH/LrZHViY9+56pYoLVuUftFFJ196c1KXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306461; c=relaxed/simple;
	bh=HqbW5bV/sY3+LicbeQRJWIlOnWPC9iWwyogiu93iFOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO79KqflAoP6uMAW9Uvmy81Nl0bNV2ybjaF7W1pVo+ne/gIHbSex+XUU6MWj0kzi0T2C7SS/WzNnvttTrbhTKXn8m8cKn/FHCGfGRd7ey/KmPbX+HC4peR5t6g345aNIMZDicTkDeZ7fl/VIhrqg5jKiInXJaHlF60AG0Us3udI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeRkOeV+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so42567995ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 22:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306459; x=1731911259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=WeRkOeV+n0Ba1k9dL6BXf7jYNIz/8zShbSVZurBr8SiWKwuwX9eSa7GwMV/3urfKEC
         JaOVHSxqunX2vJHbJyoGV469bJewxF1TmuvGe3CxIeP4wsnHjvYQnwtxGzJwSHelC0iX
         QgUER+KapVbA8lY94A5PWZ+NKZqoLVXr14/uxFlnTSA70o5w1AhyP7Dag1dpESL5OI8L
         PPX8PHXeKbaBxg6YsklRjagv/Dn0s7cuEPEmpS5Qojfnr1KUTD9Zq8dg6+4Rl1vqmZZ3
         QJz1dOb8uP/8IjAk0JQg7N7a592ZoamP2F2G3DaCp6uMKpBiGWE9bcimFsFC3l3IB2ek
         lrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306459; x=1731911259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=GEGDH0gD6nsHWUM+c5EXsle7m7jkFVcOi0N3bdEs+hwQ71TylP8dE4hpW11utFMgoz
         CC7KiISAs53IE+zbPE7QllDmCogCMTCE4oVcvsQsBCEW98qqiHxti54SNa26dGX2z0Q3
         ZsgFNRn+X6cgh/TDGxIPgraNS1EBQf55xzcvAwxT8HKS/kleBINRxs6c1Xqin79zHEU0
         S5UeDGFKLiDdFYUgS080yBhA9f2luMoak1gePP5CYK18RGldtdKrL8/5C/zsziEA7P2k
         phZATxADUl5jlp9qaTcWsDg49sqGoZwRqT5hR3BtZg3tdJoYFmBjWwR6chR7OXOHFEYX
         xVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8wwx66vRIFdQ8qx1u6i4LAyE/U559CY1ohQzmtT6wxWDyVh7lB65ripy6VTz3LDPGQq0atCMWAVH7S8In@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4b96L7SvTUJg4J+GM+ga+1smJ7zHHnwKpdwEy6Xin03M1BYv
	D+UlV3LemvDX9EZEK0m/jprFfPCI3d3HBaPS8YA+XRkFABwhXbJa
X-Google-Smtp-Source: AGHT+IHwpmnY7dnXQcsSzHRDD73tGXzcdssS5VVzqSGyOahZ7QhXBU0+7Fxo/FbpiQKc5P/v4ljTRA==
X-Received: by 2002:a17:903:245:b0:20b:5645:d860 with SMTP id d9443c01a7336-211835bf105mr168324925ad.36.1731306458982;
        Sun, 10 Nov 2024 22:27:38 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc836bsm68741545ad.13.2024.11.10.22.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:27:38 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E5712DBA914; Mon, 11 Nov 2024 15:27:36 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/13] fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
Date: Mon, 11 Nov 2024 15:27:01 +0900
Message-ID: <e611dd2e38703af858e22ef877a9135ca861270f.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FDPIC ELF loader adds an architecture hook at the end of loading
binaries to finalize the mapped memory before moving toward exec
function.  The hook is used by UML under !MMU when translating
syscall/sysenter instructions before calling execve.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 fs/binfmt_elf_fdpic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 4fe5bb9f1b1f..ab16fdf475b0 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -175,6 +175,12 @@ static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
 	return 0;
 }
 
+int __weak elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+				  struct elf_fdpic_params *interp_params)
+{
+	return 0;
+}
+
 /*****************************************************************************/
 /*
  * load an fdpic binary into various bits of memory
@@ -457,6 +463,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			    dynaddr);
 #endif
 
+	retval = elf_arch_finalize_exec(&exec_params, &interp_params);
+	if (retval)
+		goto error;
+
 	finalize_exec(bprm);
 	/* everything is now ready... get the userspace context ready to roll */
 	entryaddr = interp_params.entry_addr ?: exec_params.entry_addr;
-- 
2.43.0


