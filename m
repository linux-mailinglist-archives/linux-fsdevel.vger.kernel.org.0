Return-Path: <linux-fsdevel+bounces-15027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9D88616C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 21:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4E9286B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2E13443F;
	Thu, 21 Mar 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9UBmgHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486313442C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051451; cv=none; b=JAm5OhloIPEbaXxxP1bf2wBUg0coIYKAENWxx3CRE6scYB+7lslRfZLcRpZrMpikgOuNOAa2HlvIAL6v7T+3TekrzCRsOMswXGyXtNmMVQrBoMkFMb5nXqM/Wy22tpQzdW4/kA9vL9YunfqZWU7Oq3irP+LJQle6yJ1r3unkPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051451; c=relaxed/simple;
	bh=S6RP6uWmLdlEXkKQny/wqkGVsqJcl1gAUGPqZ6bCYiM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jmkkvguXBnLdWKydN3+/6VkVbUsNZpTWtnxilrV2FVFmNZmj59ILyvXzdcK2AkMTGVRCoV62OYVJmxVqRlcO04elr4o8MKh8G192wjYTubbnBmXSO+ebo0E4R09BdeSsPv6Z/HEr4fCOHnXTcUWxdR8Jve8UxNfpx20Z9pQSZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9UBmgHd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so2575663276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711051449; x=1711656249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TCBKqThFKtYqhjiY4RMqU+IuZ1w6cv8EE0k+cJlDNnk=;
        b=t9UBmgHd/q5utv6qWZdP7eKjHmnVZeNPsHJMDwPYc4VzSykPCFSN7CTgGuWTVhHh+a
         aKYy3oo4FCmLVj+XEkYF67gVoWr+EGVpoDy9KDhU+KV1z8h0vybFigUzJVjuqcBcQVDi
         9UmqlsMy2iJRkUHNR8I9EdPTQxdvTqqtsFqsliQ7cuFrF7hYiNguxgHqbnR4oDDOHWj+
         FPJxBjH6zXp5rlwhy0fpxHw6jCbrbESsqvo5Ky7MZSvoDJz7FjZyvxMnyPP53mO65s3h
         AWBYcWP74+R9YGP7LJSclVyEpCt5zYHP+H8lumtOK1/34k4CFGACNJ5Ja89dzoaPxFV4
         U8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051449; x=1711656249;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCBKqThFKtYqhjiY4RMqU+IuZ1w6cv8EE0k+cJlDNnk=;
        b=rK9y7JU+jSC3J6eA2KuGleBeMqaBUHf5mWw85fCtocygDnWWaiCpDTAJM+U4pBcjmI
         sRfEdMCxOExmxySq46h0aXTp24AN1sOaBK6qqN+ZyPh0Yuhd1CNLjcol6qYUcIQkY+kk
         MdHgU5WEIf/giDILV29OgX9TshO31jyH7AabmaQ01KiIbr84N4UBqzIxXetOwbzMS31z
         x3iSo2+JMhlgie5L6RX08tD18IAvx8IZJrrrMKXcYJEkH0IoW2XPEDCBJXed7cKfdZhi
         JVw5wPBU5rVP+9X8LNE/ogJmQ1WiizACiG0uY28Mg8f6wJWHmZyGlqNdvB5SX7BJWCwA
         +lwQ==
X-Gm-Message-State: AOJu0YzfnR5MqDjeABV14lmuGrYlhR/j3hBx1VYiCmRGBm2XstMTzbuI
	gPuRkJYNl1nK5OtTfQRLmWPtOWSHKjDtQQ4MgghiqsTRGiM8H3x3yMovdwUNn+uY2vIeVTQ/NsB
	diL71Xl8KauRXUc7OO5MKtA==
X-Google-Smtp-Source: AGHT+IE5VBN/+0LV/WPi06J13PSBodS0OdOu9MsbtLw0uhdLxrW4h4oP0M2VfdY/eM1a/8qsQNDCacEmRg4kGkc2ng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2484:b0:dbd:b165:441 with
 SMTP id ds4-20020a056902248400b00dbdb1650441mr74857ybb.0.1711051449209; Thu,
 21 Mar 2024 13:04:09 -0700 (PDT)
Date: Thu, 21 Mar 2024 20:04:08 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALeS/GUC/4XNQQqDMBCF4avIrDslicVqV71HEWmTiQ5oEhKRi
 nj3pkLXZVb/LL63QaLIlOBWbBBp4cTe5VCnAvTwdD0hm9yghLqIUglMc3Q6rGgTvtjZae5otJ0
 1gTVqrFW+ylyrUgrIRohk+X34jzb3wGn2cT3mFvn9/mT5R14kSrTGkKp03dQN3Xvv+5HO2k/Q7 vv+AbD0yg3LAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711051448; l=1634;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=S6RP6uWmLdlEXkKQny/wqkGVsqJcl1gAUGPqZ6bCYiM=; b=ltUxZ2cpj94pnvyIBEzmfBEHQXiRRLeDTlLyWbffUabFpLWPDEAtsiKsRij39k9phe/VyFBxJ
 50r/4jHF4KlATUMzXLzQG9U+LPWH6633/Y5LV4uwnne1EeG7KX+npD1
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
Subject: [PATCH v2] binfmt: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

There is a _nearly_ identical implementation of fill_psinfo present in
binfmt_elf.c -- except that one uses get_task_comm over strncpy(). Let's
mirror that in binfmt_elf_fdpic.c

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use get_task_comm (thanks Eric)
- Link to v1: https://lore.kernel.org/r/20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1920ed69279b..3314249e8674 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	get_task_comm(psinfo->pr_fname, p);
 
 	return 0;
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-fs-binfmt_elf_fdpic-c-828286d76310

Best regards,
--
Justin Stitt <justinstitt@google.com>


