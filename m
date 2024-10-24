Return-Path: <linux-fsdevel+bounces-32723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636319AE46A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194661F22995
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 12:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D161D1E72;
	Thu, 24 Oct 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEpo8HAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FE1C9B87
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771790; cv=none; b=NGiZ+ZyhN2Ohr8jhItqqyyw+5gy2lwG0dLrJqXlba36O9JLjcbUO+rU110bdtjkTYo1adi+VghScwNW4ysiWQAwHYkAYPbZKc3PRLjJgDIxhRv0Aa2A6j9++NzM0AR8C6Q/PBnmcGtbADcSbGZm+08X2cEG/+DXl467NHLaKraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771790; c=relaxed/simple;
	bh=HqbW5bV/sY3+LicbeQRJWIlOnWPC9iWwyogiu93iFOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip+6lKesP2BJJhO6Y6GSxiOZOJ+eZKs1os2dPzP8h2uU4OjRF7oKXynIsb/W+ruZDCaXRDSVN6S/IU4BF9sNHJwYHm7HJpzRbrRCXGcqEh455ezfI6vu9MTNRriqw2eGkznNa0+MLXHdMK0NWnEbU6SMZUrQ8vK+hCQPorZoj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEpo8HAm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db908c9c83so441279a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771788; x=1730376588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=TEpo8HAm9+xx4faO0iMTFnzEUbJVL2msTWJvVlUaAsngOtVwqMq7UH7OGJmePZZkr5
         WqFspXHp04AxvIV6/1FA03o9HL0AE/iKkE9QpaRalKQ0tGTQQabA6ce0wBBCTOjKxQAQ
         aGxMPytWlyygdcgREz/8LZHAHOV4vaymKFt5JJn3XSJA7yasdhlUDec91G1D4ULe6e7v
         Qr41SDSIfYvhrXpTorzCNDhcXxWMM2SS2UsHgMPd0qtmBzP8iCWQOjDOg94IhbUKbi+I
         ISfktXZflZAatlwBDuyiDRGDZlxK/0M3LL7BiZTkd76MFtSpgnA68ywBlKErE+1r2JOH
         3r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771788; x=1730376588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=Y8ScRn7mUocSQxP2gGcC5hluyJ4dVQTPgZrytWgoJi8D8umKZNhpod2Wt5iLjSgng/
         4TmSa9UCpTX/8Hk85PBvNreIly36+4OV2eUyWoGhaU8B74whwxKYMZlB2IgEb7KDpOvl
         alufo4C5v3PIepZiPH6r8qfwrR0jI5VxSp4fBOkk/xPD5SB01nXlKPpqn8C1GfRVSDpG
         2otgxLKfj+YqXfE5SdyL50Y6if3uMPZAHVdVtDyWpl2S9TFgVMpeZ6U0kf5omg0NSPwi
         mV0F7wHuv7x2Q+0vNasvktUVHHYdeFWthG4bvpmdQUHRtmW3Sw3uc4oqdBikvhRfLqQp
         ww7A==
X-Forwarded-Encrypted: i=1; AJvYcCXw/UMUdMX6A5/XHvzEwSJtWPSP0GxY/ZjpYZ4ZRNTZsSXycGAte+4zzfOlR4gT3ziZBGNN0sNam1NrdEnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8OjvxjNYrnVB6PhaX/0TnCACTN1FfWiX1e2uztOPnNQvCoc3
	M1I6ckPwnxejCTl0ImxXJqutUeV+K/ngMhqEaRufhaAvt+vVkRt3
X-Google-Smtp-Source: AGHT+IEDeGgbLE/zgvIx9Neo7X/Tvc/kwVBKGo3SVswnkbyJjKLA71wygrf5Z7lZwgpXfxWF3CU2mQ==
X-Received: by 2002:a17:90a:f0d2:b0:2e2:973b:f8e7 with SMTP id 98e67ed59e1d1-2e76b70c381mr5909794a91.38.1729771788065;
        Thu, 24 Oct 2024 05:09:48 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df50eb7sm3335163a91.16.2024.10.24.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:09:47 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0CDB1D51249; Thu, 24 Oct 2024 21:09:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/13] fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
Date: Thu, 24 Oct 2024 21:09:09 +0900
Message-ID: <c327f6bfe8db1ceb5d45a8e0aeba4c46c6c8e064.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
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


