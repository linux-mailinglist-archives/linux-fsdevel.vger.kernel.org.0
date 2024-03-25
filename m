Return-Path: <linux-fsdevel+bounces-15217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE388A80A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEA31FA0015
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987D12C80A;
	Mon, 25 Mar 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynwRLXR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839C12C7F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374030; cv=none; b=hqI4cOknX+1Cx/OOhCwMyowl30DuZu1IOMXIoBQPojQEMDnd++ZjNGpd/hau2n9eIiWRdJt4hpMZLuLseJrsRLYJrFERY/+4EJfC7K4gYCFZ76kSfI709Y4JGc/DV5/FT4Veqf4P3Q6BTTvl8IZ6wkZ4UfjotPbOhTqIKNBmYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374030; c=relaxed/simple;
	bh=I4ujxSWG1rQZvUOG3aGaAfaG34o0FSxd2yK2pMFboO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=geeKOo1wZbuNpSPSw9b9pmt/ZgA47IWB66ust60wRkGhCEp7ffWXNcwVDvfDk/Yv9xTD950QOWWYdrHFIBCuclczR6m89eQyGsN8tlQ99bPlZu5gm6d0WlYodZCB54X98UqW1cOTqsvXi1OG3kzGmFgWJI/eLk79xejX3dqkYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynwRLXR4; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a46cc88be5fso300092266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374028; x=1711978828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=ynwRLXR4/N2fgwLq67Xq65v4rvA0LrBZNozy+29d9g2A7iuAemsHMJ9GE3zwGI0YaT
         NvYVCu3ZUFgjvWTCk49Ubc86XUxIsP3+Ir7v6RyO+OusC3WW+sItUYYQLk0dIeRBa+RG
         x06lU3xkZucnxLZjcJTlsns2dnufVF8TwGhytdT+QfWMCIk0kwBZUa7+J6A+RIT5r2WV
         e+QG72xqv6OnHBlCC9tK3WPZS5oqEZbVM2+84uTgu2zAMOHhzHDFT8nVdRLR6GpSV5An
         wmAuXh4Q3YTcQ8srBgitxX84dCArC2D0pA4Q4ye7jKxCtF0qKYHyRo+GFEl/255UL3jH
         TdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374028; x=1711978828;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=Q9DjwAbJp5TgcqAFmo9OIioKtTJKkU0UWqVkjcgszIkx5my3naKjl8x+gXRh4Xnr5s
         mcLeMOqwAEbY8VAbWSU5FixieMEh1v8IHgf4edC18pZ5BEu8I8UkHpCIN8ZdgwxSrqD3
         xaUUDqvYUFcKlD7dAKZ4EaUVhO86NGMe0t8qsMwKX7/Ncr/CQcN1x96gdY5Umk9e0IhX
         NP2M6DmE4CmKWpIhOkG6Lgcuf7xPiV67ZV2QvWLNPMSax+/97XXMYQjgH4XOZzlfAg9R
         5nRWuKGrKy9n/o+bWpNFnT7tnOhBEtmrWnT5q1LhnPzbsm5idGxQdqzsR3Wubm73LZpx
         PB/A==
X-Forwarded-Encrypted: i=1; AJvYcCUsY7f8f1fbK+eSWAnFUNJZUdYx85FrRymLD1jywtOV7nmBnwcQhljI0Bya/QuZXvZI7z4bn53ssnZEuBtNVKQ/xhFzflcNmcoLfqEpuA==
X-Gm-Message-State: AOJu0YzlIFFhyNSOFX4xxSI3PqMqRMUjzHiy5Ahl3anipBoem+OBCRG8
	HdvmAjYQr1WiqF+2/6ZDV0CPMXKEUdGa9fSfQnhq6hMrGtxsQM9cjCFWv5rDzx5PZwF7GMY7c6Y
	2zg==
X-Google-Smtp-Source: AGHT+IEook1Vy3rWJYUAL71ECA3zPQwVSnll+1PCbdZbB6UG9EJ/1AV9JwkMpaOLemUblQM8SJ6KZHRqJvY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:af06:b0:a47:3b6a:36bf with SMTP id
 lx6-20020a170906af0600b00a473b6a36bfmr24943ejb.2.1711374027753; Mon, 25 Mar
 2024 06:40:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:40:03 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-9-gnoack@google.com>
Subject: [PATCH v12 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
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
index 32e930c853bb..997f774e88ae 100644
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
@@ -201,11 +202,12 @@ static int populate_ruleset_net(const char *const env=
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
@@ -319,6 +321,11 @@ int main(const int argc, char *const argv[], char *con=
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
2.44.0.396.g6e790dbe36-goog


