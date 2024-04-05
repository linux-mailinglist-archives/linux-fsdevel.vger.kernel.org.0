Return-Path: <linux-fsdevel+bounces-16241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EA89A63E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91581F21A42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950BF176FC3;
	Fri,  5 Apr 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWQ8Ep7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED817556E
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353299; cv=none; b=WNUu+/oEi03fcRa628Yvhmwgy0FcT0TR7zU/rskZReOg48PFxz/mWVMzn+44iwCcIv9rbnBzb4B77JyweWeVTMQa6OeidwJIaijmoVDohmqbByRB9I6f0KzJdfyoD5s2+DQt5KXowm+gjxrfrQ1fP+a9kxyb0xfKvFEgVvqgEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353299; c=relaxed/simple;
	bh=6+gvohWDkjUJJGA4Zsd7JtJUdl3sLC5pZJEhJQPekgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HEa4rSkVOeeigFu82tccoGF9XJ/s3NF9wQQsyQJSb4U9zcQvaIhvCXSrtDEsRu/JBBPpOagEo3TqDspNr3/CegC/xgv94PaXjABOF2SHCYXv/PEyqxGn03Igte4cXY+F/7pO6eP8WklGmThO9E4dSap4S3yIFy+K7AQqqtZH620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWQ8Ep7m; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343cd240b2dso876036f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353296; x=1712958096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBsW1fdSkwIBXUs1pxIrhy09C1hIfpBAjgqErgaWIuU=;
        b=gWQ8Ep7medbhwKCUsx0QtXBxI8ZrydArz7RLbi3HX2LuEkjBMMyABcG0FsxyvKv0qP
         G1dDjol+bS7GD3MPrRCnthn1LR3CNA42etlVqO5yEKjgnxnkUexAL/3nuoQegDzUTydE
         ONx0cNEPEgSFsRyfIXfU9grJfvmoeTvmtk0w2eWeIa9qACO2MA8jJMcbkIVFIyxcGOoC
         BCqPPUdDZ1ZViWzE0LuCtxRpZ1Tf77eNtM3ttVs2hWMLd9rEH8npKDf/qBT9OJ4rbRta
         aBsM9MnnJDH9/O23WFRH8QPTXKj51SzJ7/rV/rEgv7C8BXi93EJqcjz5JroG+Z3rYIrc
         bqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353296; x=1712958096;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBsW1fdSkwIBXUs1pxIrhy09C1hIfpBAjgqErgaWIuU=;
        b=OxNzX5N+cndMGY4NUv0QV9w1YA5PQeRdMxL39hj0YV9K8uwPn7H4zvMVURxUg1ctF8
         DyMrYzPM1zGrvkYDenF28C6yGfV2ZWJjf/AhpYd9/os0sGxn0ClwtdTtCypB/yheovke
         5oLl1gUMXUuCYPMAVG8Ql+jpEIpDbqjsziQLmBTOUNEYJN/7qb0aDJ703oYxcK5orDTN
         B/a5/JWaTa8HSD0q1bl/wMKRzC13G9xaSw/Ct2fXp3lFMAL9puWphz4T6LQanIOfgbcv
         tdLpXa3RkPhNCCNu+1CIZl5wEVQJTXeCyud+Z0PjTpgmv+lkSuprmzG3o+TJX/YQ+wj8
         vPjw==
X-Forwarded-Encrypted: i=1; AJvYcCVY6l3zFthH9BbhsVkISVEY0llKU2mSvAhm2eamFWsusf0sc55rVB11dbC3l956cVuYFODZIac2IFz7jZ0iIqXyT5QvaOCh7prngUwopg==
X-Gm-Message-State: AOJu0YyYL7MwyzfAvpXHXLH8q/4+hP2LDJ0q5O5RmkLp8jqifknBL0TZ
	JwjSH3+ifqks/aetBzLFJFXLZCUDemVuSaYkDHX2UZfpsfPoEGgIsTKsEwe+qGwNa8nL2buKTWG
	kow==
X-Google-Smtp-Source: AGHT+IGX1eIbjjNMVba43aYVOq2ZT3mTAE8MH+z1SrggGLXN4E3yEJqi6XGhpoOSLqZO9NPCc5beK5SS57M=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6000:815:b0:343:c54d:28e8 with SMTP id
 bt21-20020a056000081500b00343c54d28e8mr5040wrb.10.1712353295759; Fri, 05 Apr
 2024 14:41:35 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:40 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-13-gnoack@google.com>
Subject: [PATCH v14 12/12] fs/ioctl: Add a comment to keep the logic in sync
 with LSM policies
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Landlock's IOCTL support needs to partially replicate the list of
IOCTLs from do_vfs_ioctl().  The list of commands implemented in
do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.

Suggested-by: Paul Moore <paul@paul-moore.com>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index fb0628e680c4..64776891120c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, v=
oid __user *argp)
  *
  * When you add any new common ioctls to the switches above and below,
  * please ensure they have compatible arguments in compat mode.
+ *
+ * The LSM mailing list should also be notified of any command additions o=
r
+ * changes, as specific LSMs may be affected.
  */
 static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 			unsigned int cmd, unsigned long arg)
--=20
2.44.0.478.gd926399ef9-goog


