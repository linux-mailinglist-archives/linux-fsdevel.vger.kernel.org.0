Return-Path: <linux-fsdevel+bounces-44396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC968A681AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735037A8AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495834204E;
	Wed, 19 Mar 2025 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWTaeagE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DD10E0;
	Wed, 19 Mar 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345207; cv=none; b=WWNi7sJG52Xyhggjy+t8MlKPmG5fdh0Vqy4EMcAtS4NvUpyVu3QN86/Nhc6LYw4YjDawhiKI3inzjScX5ej+OUuOz+lUftkwDLxmfcrUG93xXkLpgC0Bus+oGy83QMwsY0wcW+quJz7IH4v7EvbsgqWz/NpTjhJL8BGowGajd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345207; c=relaxed/simple;
	bh=bfVbi7FbmHxygyK2S5xJEpqViTMnREmlZbT07aIGYAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyDw+c8zuWDJTb12/1EyI4uF/Xd1yt+avLibPLg/T6m/GXl9G6dXNA1mQtNV8n/pDqLQZhZg0GoLwE71pSwrCFPpG3yCsvLWaBn5kcH6t81zpG1wAkKWmJOiMcLATrDsYDz6e2P/WamrFL1t4Sh6VruJtd+cjYNYknH4yGRdCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWTaeagE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2171401f8f.3;
        Tue, 18 Mar 2025 17:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742345204; x=1742950004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0c6cJlYGaTcUhed4oIwzI8jYJwOovlRh9funGgxRcIc=;
        b=jWTaeagEHvvPUgBgtIee2UdNWbxZrgqL/5AuAPa6Gwc5vHzThwnD7wmcWje5WdPmk6
         Z2rEC2kUfKS8t2OSjL6AGSBR8qcHl/+hxi3BUrOH1T4C0wUyd+YCpJRlCCyJ8ZY/TIOL
         roUodUmJmWWb+9A+QNfLpm71LQ0a9+vmp7nmy0be2Vq799ta8amHPatxn+uoL+EptgIl
         hOFWyHgJgZg/1edP3JAGuimFk198YZE2+fuk8yfJNOBB9PyH0RS224YlHhM1M62uYrWO
         9BvM8t5SBHlez4mqo2BYuCZ8vjPpyksjcFKIoDxrC/QrnNBbW6lv2Wp3kaC/a+paLVn/
         eDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742345204; x=1742950004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0c6cJlYGaTcUhed4oIwzI8jYJwOovlRh9funGgxRcIc=;
        b=XUBUX3VP7y56MjqJ58r0DlrWIaTx264+Wglv4u26LZdFjn3VxBu3rSS6BXIPh+WVpX
         mibfz8CN5Z27CFUY6MBnO7ciOqgE/zchQoqK5q/QbAm6g9JYAdziCAujiC2isyuBq7+K
         nrfGc9GyXSlmbZep8UNk9aBplmR8khUicyZtNfrSPVeEZajikz55CHkstdpOg4ycpQdi
         +ZErHTEztgalgE+dmlSnmFUDRpDf5ChVwAyeeh0JTWyG7U2x4l3gcsKRRbFxaaWJ3MId
         2n/cmcwyOVgSK2IR9P9bsBfjoKqlaHQ/csAa2WjhdjG2HCIt0RvVsEwcTPTUExpaDzun
         EnZA==
X-Forwarded-Encrypted: i=1; AJvYcCWF74CTQ11bVf56ILy4qVM7zBil2mvZzWsplpbpuJw0dxhkcji348fgbyLQqAyVsnm0qos8umM4YGHJpI6S@vger.kernel.org, AJvYcCWYe10YFICTAyJS4f717yw3cCxCboGeW1eK13RmcFt+7TY3W4LTfUW/1ykFOo/Zg8qyxwQ0eYIvKwdJFiqZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyZaV4/f4PELYh4sbzm/YukfyrqEnrdlkeHWmwt7vrt0EE+jJaI
	dHqquaerZtH0q6Q83/HLvmBHM8aSggaoZCAr022AX4ZK9/qp2twl
X-Gm-Gg: ASbGnct9b/rk20hdqQ/hj7CPI/z2aLoW+FgCNufV8XMI/NtmAjXJji0vAIBgmJOoSeM
	X2AaglujuB7G+iKCKMk8ex4b0YMpxMg5ly3+emLlYcB1bApPdgLZUQ+Q1kPjnXh5WHdLAMRX6rR
	LJh9X5/XwlyS/iRPm1h/nb0gfd34QptQuJBqDkQIowyxZ+/OpHlxDsX5EBaJBUETOq7HnadOcND
	Ehtf8js/plzPh20O7vIn0FPiPUaTpQvksCdqv8TP6bm1iFFYoeZpMDjeNYcIKAJWpGDT4YyButO
	Cekje1ZQw3YKuE/A63cERthWFh/bPDuWQi/5eLI9UpcYV2L9XOsGHnE50CKrdPA=
X-Google-Smtp-Source: AGHT+IGZMnCajOo8WrsmM/9u8qNNj3NdNQoEM42Jx4melck1VCewfsF4/64CJ7xWCLOb6Sn73KyQog==
X-Received: by 2002:a5d:648d:0:b0:38f:2a53:1d78 with SMTP id ffacd0b85a97d-399739b45d3mr691598f8f.10.1742345203962;
        Tue, 18 Mar 2025 17:46:43 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm19560679f8f.77.2025.03.18.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:46:43 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: load the ->i_sb pointer once in inode_sb_list_{add,del}
Date: Wed, 19 Mar 2025 01:46:35 +0100
Message-ID: <20250319004635.1820589-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this may sound like a pedantic clean up, it does in fact impact
code generation -- the patched add routine is slightly smaller.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Below is disasm before/after. I did not want to pull this into the
commit message because of the total length vs long term usefulness ratio.

can be moved up into the commit message no problem if someone insists on
it:

(gdb) disassemble inode_sb_list_add
before:
 <+0>:     endbr64
 <+4>:     call   0xffffffff8130e9b0 <__fentry__>
 <+9>:     push   %rbx
 <+10>:    mov    0x28(%rdi),%rax
 <+14>:    mov    %rdi,%rbx
 <+17>:    lea    0x540(%rax),%rdi
 <+24>:    call   0xffffffff8225cf20 <_raw_spin_lock>
 <+29>:    mov    0x28(%rbx),%rax
 <+33>:    lea    0x110(%rbx),%rdx
 <+40>:    mov    0x548(%rax),%rcx
 <+47>:    mov    %rdx,0x8(%rcx)
 <+51>:    mov    %rcx,0x110(%rbx)
 <+58>:    lea    0x548(%rax),%rcx
 <+65>:    mov    %rcx,0x118(%rbx)
 <+72>:    mov    %rdx,0x548(%rax)
 <+79>:    mov    0x28(%rbx),%rdi
 <+83>:    pop    %rbx
 <+84>:    add    $0x540,%rdi
 <+91>:    jmp    0xffffffff8225d020 <_raw_spin_unlock>

after:
 <+0>:     endbr64
 <+4>:     call   0xffffffff8130e9b0 <__fentry__>
 <+9>:     push   %r12
 <+11>:    push   %rbp
 <+12>:    push   %rbx
 <+13>:    mov    0x28(%rdi),%rbp
 <+17>:    mov    %rdi,%rbx
 <+20>:    lea    0x540(%rbp),%r12
 <+27>:    mov    %r12,%rdi
 <+30>:    call   0xffffffff8225cf20 <_raw_spin_lock>
 <+35>:    mov    0x548(%rbp),%rdx
 <+42>:    lea    0x110(%rbx),%rax
 <+49>:    mov    %r12,%rdi
 <+52>:    mov    %rax,0x8(%rdx)
 <+56>:    mov    %rdx,0x110(%rbx)
 <+63>:    lea    0x548(%rbp),%rdx
 <+70>:    mov    %rdx,0x118(%rbx)
 <+77>:    mov    %rax,0x548(%rbp)
 <+84>:    pop    %rbx
 <+85>:    pop    %rbp
 <+86>:    pop    %r12
 <+88>:    jmp    0xffffffff8225d020 <_raw_spin_unlock>

 fs/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 10121fc7b87e..e188bb1eb07a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -623,18 +623,22 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
  */
 void inode_sb_list_add(struct inode *inode)
 {
-	spin_lock(&inode->i_sb->s_inode_list_lock);
-	list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
-	spin_unlock(&inode->i_sb->s_inode_list_lock);
+	struct super_block *sb = inode->i_sb;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_add(&inode->i_sb_list, &sb->s_inodes);
+	spin_unlock(&sb->s_inode_list_lock);
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
 static inline void inode_sb_list_del(struct inode *inode)
 {
+	struct super_block *sb = inode->i_sb;
+
 	if (!list_empty(&inode->i_sb_list)) {
-		spin_lock(&inode->i_sb->s_inode_list_lock);
+		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
-		spin_unlock(&inode->i_sb->s_inode_list_lock);
+		spin_unlock(&sb->s_inode_list_lock);
 	}
 }
 
-- 
2.43.0


