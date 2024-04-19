Return-Path: <linux-fsdevel+bounces-17306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62088AB2FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BE31C20F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47313280A;
	Fri, 19 Apr 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="it2eWAU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39441327F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543113; cv=none; b=HXcc45joYXxQVUROxktKFmPfhEg/aDkW10gbrKd/VkNrA9Nzv7bKu16MIN2hV7HxXj4OQ0AXi+983/B4xYj7SkZwdAoJCooJxA3DEY6ugbpxv6r1t01xeA5UYDObnRvWocXNqDXtfEsn1kDJDkY2yMOXG/9FKUGSYc5pG+fZw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543113; c=relaxed/simple;
	bh=VpfImLVWmm6H6uefDPKxeiHs9uTKfbONj+QPB74xvBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDHPEKj8DzXP7OkMz4GBV4EopMuR6q3Rropul2gel5MQCnaJHV75qmS5cSiE1qycZLIRalNdgR7jC86ZQfqLrUsIJf13MRouxwvEmKePSrECJMf4SFwfS4IRotZWzgCRHIzFvVAtinhGXoHZ4ZyS44K10Ha9Xw0NA4hdo/UZJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=it2eWAU5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ae546adf3so36981577b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543110; x=1714147910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKW6w2RS2380Toaurtlz5H8ZXBYNt1ZDZxAwn64hjvU=;
        b=it2eWAU50k3dcXx1065yhX359jkzMLLBSFNg+1QxujPOz/TS7uxWi16G01PtUoUFK/
         fV8gEFn0OTZLjtQThYSDkjn3Jfx/l1NmrZWexGcIlW7myaB8LpUjQcwJItsBwTTtjj+B
         wQgRpjW8MIeavvgPSr8Qh+k+owT4fXaBB7SzGYAkoQgzMvqvmNr8UjfiGRr9thdQbi7x
         Q53xEdNTG266IhsJfmer4eF4ZNwEL02sM3zGx9VnaPfouUjFsUBPJtGamnl15XiprrYU
         EGAUTRI6QnKaeCgfu0inK8fvLKBkndZPoQzm6baJYnCo2CKn2v9ROoKxuDDKlCV3FLOZ
         SwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543110; x=1714147910;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VKW6w2RS2380Toaurtlz5H8ZXBYNt1ZDZxAwn64hjvU=;
        b=GDulni8WQpBj/+bjnJSuHEyIEuzNkUK+T0jE211P/mNaJQ893qsOXtwOJSyLs4U6sz
         Go0Cwy+EEZH1ns/rSLLAsxs2lVwfweBOh+FEl63LAu4FLuRt9Y5ftG9km1z1oTxiRamt
         EcDlQwx8kvxAL1pUJyYcpFbYwnok9Yy4zWOnc/N95Ga78J3pZcvbMD+U+vvJ7nas533D
         VIRiDRxzZp9tV4T71cy9u0u3WwzkmCkzfhqCffIWAdShCy0GeNGJ4a05pej8s510IHHx
         mRjV7PKPtg1KWk/UcUbqeLMhjsbXvjedKarc6dgVGthIo1Y+yuJaVjSPEGX4PMeHUjpp
         Nu1w==
X-Forwarded-Encrypted: i=1; AJvYcCXziGj1llbX0/A+QJxHvxczovuM8zmUgOlsPPON8uv7qKsAiORGtE7DV5Q4aYOYIYvqCFz8FElXjm2SzaZmmFFuawS4vWVC4mticy56/w==
X-Gm-Message-State: AOJu0YwlEusCNd6hXIY3ni2VUBYd677M7q4Jp7EId3fFBg6WbFDpeQDo
	SlUb1NciXEKDh3m9iTmRA3pSw83QL4HC9vxAggDvVxGwWpy1JAjf7EWfrb2qaeCEX9S1OonHDUO
	Mtw==
X-Google-Smtp-Source: AGHT+IHUL4crRYZX6UP0KLDeyilKG8DboRSHVFY7n+VLdoKGJDafu9fh8eWSGzVE+Wn2lWOMbCBk3hjzUJE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2b05:b0:dc7:3189:4e75 with SMTP id
 fi5-20020a0569022b0500b00dc731894e75mr177661ybb.3.1713543109776; Fri, 19 Apr
 2024 09:11:49 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:19 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-9-gnoack@google.com>
Subject: [PATCH v15 08/11] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
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

Add IOCTL support to the Landlock sample tool.

The IOCTL right is grouped with the read-write rights in the sample
tool, as some IOCTL requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 8b8ecd65c28c..e8223c3e781a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
@@ -202,11 +203,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -320,6 +322,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.44.0.769.g3c40516874-goog


