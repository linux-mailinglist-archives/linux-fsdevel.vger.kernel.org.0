Return-Path: <linux-fsdevel+bounces-16889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8D8A44CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A95628155E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 19:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19740136659;
	Sun, 14 Apr 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGG8E+fk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2329B0;
	Sun, 14 Apr 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713121511; cv=none; b=HOiekfWPuf0UkyrdldMnT1LgJOxcJNhO0IpQObkZrWtgU2zQDstgrvGBL5BWrX9c4uu1xX3Z93U6aPky5lMIB+5jtXH7UoESh9F7UCFDVoJFPdQi9xAIGSN8M4B2B9NjUxzB1tKVcPC1tA05TWD12YOHjl2jGESwxUk2FLj4E9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713121511; c=relaxed/simple;
	bh=ULpB5zEHNx8o7jTnYoFsTNKr7+A2ETV9S+C8xAA82pg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CJ+P7ZA7maQ4Dekc1lLkUN5d62+6SLGtSSqfk6TFyVz6xOpBxobhc7eL2zNDNgJCZ8HSQfPuE4k3k+1Z4T7AhOwEjNnyj9rLgfFnKkHhQCrD63WgXb6mQFxRMgYh4KHteR4mO+sJqqxyK37iYFYIDfAX+own4O19KC2y//hQd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGG8E+fk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41802e8daafso10829735e9.2;
        Sun, 14 Apr 2024 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713121508; x=1713726308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNevKWeuXPz/2Z60lvAdSM4dYp5t5puBfeqtuDVl1Vo=;
        b=GGG8E+fkPj69+UlS3rWtZ2qrzhLkxm4GuYhieUx0g38u3YTk94FmdVMN2/Sm8wo+hq
         NA2nzNaFcCGrwp4IGEOP9q7aeWkk7ex9UFK5O13GWEh8Ng9SvDF21J7J3AD/Uz3kPwAf
         JeXX8Uunm5JotAYsCYqzYtbQM8k5jHlH3blo0PJLGxmgiU785WXG2C98ieuEvz5SaEN/
         d2DMOe1LBxZGfKpErM8LwjEQu1bn0J8sTu8uwPuomm3kIyvrlMcIB6GmV50uxa12G8xJ
         t1lKD/F6cGqxYK0km1h5A8I2bxC6O5CZ9Lsl6XMuLCdEjeL7HylrJYUM44HBeNicWFys
         gLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713121508; x=1713726308;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNevKWeuXPz/2Z60lvAdSM4dYp5t5puBfeqtuDVl1Vo=;
        b=KgYF3aJpf/6OS3K1gzG40y6Dz0KZq9ZWYQzX+UFhvqX+4HzQG3QrjJvX8ZVvaXqXgQ
         fJTu5tOhZQ6wLLeNWDyiKRdq91K4GV7nh3Ejmzd3/xEHCh8KMwRdH8r++GaYvfkW9MXN
         vC5nuXKvs6lPjlH6n/VbUYnvyf0UZgDhxkiGrpltqZvPNYRRnw9bdj1/7eqazDBafWXk
         riSO9jOfhvI0KFF3TDGyZPtyxCe40TnUn1BN39ioXxtDQaNkLqxTGVUnTpHrKSiXexOp
         uYa6NsfQNmHHx2/MJBgDLNtRUXqj5w9zOVBRfkbhOwUy/+OCK8ojbWMb9wYd2yNvzBdm
         v0JA==
X-Forwarded-Encrypted: i=1; AJvYcCXqsi19Rs1EPuI3zj7JTA+ttsKqS7z8d3gl+bOtJTfTvTV8aDfrcx0udYyldM0l1QfjCmwRBZuPMtHmTtA6zFUliGv9ojzMZwvO+1IBInZ+cfwzAq8h8cxw2JaoRGP4EEPCPabkyrziqfEk4A==
X-Gm-Message-State: AOJu0YxU1GcSyU0orbWOyaGiIDiZC6aTubzezzSbJxKE7QVlANY2lOQN
	aFVfXEFH7mNqDetAjIHzNm3SkpO6ijkDVqUWssNcBNRpdNG8NfE=
X-Google-Smtp-Source: AGHT+IEdBy80nafV0EePYDuu0fA31EPuzHzjJZrFenycT5jMGoty8MD06p6WZ84kUbfQGE4d16garA==
X-Received: by 2002:a05:600c:314c:b0:414:1325:e8a8 with SMTP id h12-20020a05600c314c00b004141325e8a8mr6081608wmo.39.1713121508092;
        Sun, 14 Apr 2024 12:05:08 -0700 (PDT)
Received: from p183 ([46.53.253.158])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0041627ab1554sm16378399wmq.22.2024.04.14.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 12:05:07 -0700 (PDT)
Date: Sun, 14 Apr 2024 22:05:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As the title says, ban

	.
	..

and any name containing '/' as they show in sysfs as directory names:

	/sys/module/${mod.name}

sysfs tries to mangle the name and make '/' into '!' which kind of work
but not really.

Corrupting simple module to have name '/est' and loading it works:

	# insmod xxx.ko

	$ cat /proc/modules
	/est 12288 0 - Live 0x0000000000000000 (P)

/proc has no problems with it as it ends in data not pathname.

sysfs mangles it to '/sys/module/!test'.

lsmod is confused:

	$ lsmod
	Module                  Size  Used by
	libkmod: ERROR ../libkmod/libkmod-module.c:1998 kmod_module_get_holders: could not open '/sys/module//est/holders': No such file or directory
	/est                      -2  -2

Size and refcount are bogus entirely.

Apparently lsmod doesn't know about sysfs mangling scheme.

Worse, rmmod doesn't work too:

	$ sudo rmmod '/est'
	rmmod: ERROR: Module /est is not currently loaded

I don't even want to know what it is doing.

Practically there is no nice way for the admin to get rid of the module,
so we should just ban such names. Writing small program to just delete
module by name could possibly work maybe.

Any other subsystem should use nice helper function aptly named

	string_is_vfs_ready()

and apply additional restrictions if necessary.

/proc/modules hints that newlines should be banned too,
and \x1f, and whitespace, and similar looking characters 
from different languages and emojis (except 🐧obviously).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/fs.h   |    8 ++++++++
 kernel/module/main.c |    5 +++++
 2 files changed, 13 insertions(+)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3616,4 +3616,12 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
+/*
+ * Use this if data from userspace end up as directory/filename on
+ * some virtual filesystem.
+ */
+static inline bool string_is_vfs_ready(const char *s)
+{
+	return strcmp(s, ".") != 0 && strcmp(s, "..") != 0 && !strchr(s, '/');
+}
 #endif /* _LINUX_FS_H */
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2893,6 +2893,11 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	audit_log_kern_module(mod->name);
 
+	if (!string_is_vfs_ready(mod->name)) {
+		err = -EINVAL;
+		goto free_module;
+	}
+
 	/* Reserve our place in the list. */
 	err = add_unformed_module(mod);
 	if (err)

