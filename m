Return-Path: <linux-fsdevel+bounces-15841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D48944EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B331C2157B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DD042056;
	Mon,  1 Apr 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="youQA+fI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED72576B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996800; cv=none; b=jNUNgCX2MgpzT0PBYONjpH49OGb2HySS4Im87GhsDFZlg4qx8ScbNoNueukEGfOgSwFsJde2clx1ay+2Tvg7VAdCPPYof5Ot3ohZn4dae9NoivfOuXfbWgLbA1+Fj6a0gpOCxuAKIfJQl+hnv6GM/3O71Yj401B5kdAoCdqujAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996800; c=relaxed/simple;
	bh=2MbhgQj8cVkDP038ndgOY503dVX+Ax4mZCM7tpCQcQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W2IEAkuO+mICDbwNKqYwWcWatnNe2I8G4+Th1vUGXOebXGI+LXRuyrOUeclBbTivJewhiGgNbkGjP1mViGCNIieaWhR1i4oJltALspB5Dk54HD4GDbssZjxe4S8B8qsylQ1JsjGKfAidUGjOtH4cxKJ4frqVsBApYS8QeNbZQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=youQA+fI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so7110350276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711996797; x=1712601597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgMheuDZ9q8sO5WzCyu4uSNRV4Oc3mqdwzajDlVhWIU=;
        b=youQA+fIeC+hyV6lUUv/206egygjVkPcYGWVXG4m10SlukXEvQFM6C2A5hFBXSTSBy
         IxZ+bLgQIa81ZR4kGbolVbBmoMEcuNoVZ/PEcsXecYc4YSFw9/4dJzbEYKglP3PjIr8M
         CSQkbrOx5jnRpXJbQrf7xGItkOWMWrvxcEquj4+Ib3OzKN0ozldmsidB3Sntftj20WHH
         AVHfo8VKmRUIutBh7TZXa4JZWL9loGV2pXxv1Iikb8WzzTN2dRSZZhn+CJeX7MLndXhk
         9nPnQ0m898l/TmLGJCFsrCbaJf+Req5LaAAHdFWzLh2uH2ULWlHJ5sDGM4SNjVQooa9q
         l3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711996797; x=1712601597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgMheuDZ9q8sO5WzCyu4uSNRV4Oc3mqdwzajDlVhWIU=;
        b=rD/ywsFtQArvv/l5twxTawvDrRjePZnj+3ribbiKdg+KqEsiz1gjWnbpJtwuWepk0R
         YbvZG8fKOSdXRLyymAPCnShP4i51JrAx61QQvxNvi4tVAmPIiLEtyMXP/53Icu41k9S8
         pvkBZiKmkEE3B8m8fywy4rV5JccAhPfaWZkvKRcxTh0tc/V5xmIJvoJQoEqHX29YI4On
         ogKUib4Sx7a4bZGheXBReTlwcpmmsm/0A2OzbajcN4R69CfNs96BZLgwiAlJYwJy+B3I
         TVzEzd4vVKyZZaFenFFllvTgbkdPYnARqmT9WipJfcibcNV0lLDtUxE7VXqv02SPJUk8
         SH0A==
X-Forwarded-Encrypted: i=1; AJvYcCVeAy/3NR8irPCaii7vk9Z3YVWZTFWIfAw7WVlJLKAluCbV70nMqmT9znJniT+X9K6O5qOO+02DYRE9JU4P0olTd45KL6r9jYrPeNiZdw==
X-Gm-Message-State: AOJu0YzRvLI25i5PruMq4New2srCpPzRBEdDiyKnK7Cz0Cr5qGC5+fiz
	8StfYj118eNC3CXcuVou3X3DhAOil59a50PJOZk3hkYQL/F0SMbCWI+zEyY5PxdRtATy7FTtphE
	gy93Lxs1eI1LYAJahXPuqVA==
X-Google-Smtp-Source: AGHT+IHSmFegPY5LrkmIhHmV2aW8Fujix6RmCEZ5xbkPgSlx7/Qdn60CtjV4+JrWRC8OnVdY8bMiErkNetC/FspRww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1893:b0:dc6:fec4:1c26 with
 SMTP id cj19-20020a056902189300b00dc6fec41c26mr3327875ybb.1.1711996797754;
 Mon, 01 Apr 2024 11:39:57 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:39:55 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHr/CmYC/42NTQqDMBBGryKz7pQk/VG66j2KCxMnMVAdmUioi
 Hdv6gm6fA++922QSCIleFQbCOWYIk8FzKkCN3RTIIx9YTDKXNXF1JgWmdy8ok84CzvMo2MhdGh
 109d37akjD2U+C/n4OdKvtvAQ08KyHk9Z/+wf0axRIylzo141Vlv1DMzhTWfHI7T7vn8BS8M/5 cEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711996796; l=2314;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2MbhgQj8cVkDP038ndgOY503dVX+Ax4mZCM7tpCQcQA=; b=QK8nLukocBQU9jplQm8cs3ucevtjDWazF2fw9lAMxYf+e9BuLtUEVXrqzKXK3RvJsRteZolGw
 XJfs74WA4giCbUveTWR8xEsOJ1EhMVcg46SafcYUkIELkNIvOLYJBFW
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
Subject: [PATCH v2] vmcore: replace strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is in the process of being replaced as it is deprecated [1].
We should move towards safer and less ambiguous string interfaces.

Looking at vmcoredd_header's definition:
|	struct vmcoredd_header {
|		__u32 n_namesz; /* Name size */
|		__u32 n_descsz; /* Content size */
|		__u32 n_type;   /* NT_VMCOREDD */
|		__u8 name[8];   /* LINUX\0\0\0 */
|		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
|	};
... we see that @name wants to be NUL-padded.

We're copying data->dump_name which is defined as:
|	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
... which shares the same size as vdd_hdr->dump_name. Let's make sure we
NUL-pad this as well.

Use strscpy_pad() which NUL-terminates and NUL-pads its destination
buffers. Specifically, use the new 2-argument version of strscpy_pad
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- don't mark buffers as __nonstring, instead use a string API (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/proc/vmcore.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..5d08d4d159d3 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
 	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
 	vdd_hdr->n_type = NT_VMCOREDD;
 
-	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
-		sizeof(vdd_hdr->name));
-	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
+	strscpy_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME);
+	strscpy_pad(vdd_hdr->dump_name, data->dump_name);
 }
 
 /**

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240327-strncpy-fs-proc-vmcore-c-b18d761feaef

Best regards,
--
Justin Stitt <justinstitt@google.com>


