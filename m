Return-Path: <linux-fsdevel+bounces-15100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F2886F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07681F22C02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE655C0A;
	Fri, 22 Mar 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1dcz2Iyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F614DA0F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120242; cv=none; b=BK3s4mgt7k2qoO60JnS2uK0NQFzCaO+nlFGlKPeUvJKb6kQs9Cund2BW/DTEPrwU8o2RUs+X+MTf+EpgsqUpBxfwI3I99I71VlKyAwujrBH7cbBCnzeE5PbLnCLBFozokHPAmjWS/xj5x1CmzK3usWMl9K06JiV+X5i/DcF4bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120242; c=relaxed/simple;
	bh=I4ujxSWG1rQZvUOG3aGaAfaG34o0FSxd2yK2pMFboO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7qRu40hyrkJbtJtCyetJB3NrbkTZ1jUcqoHaVvnoey1TQfvrX6QzYyEKE23wxiDK86E7m7gxsQmKXXnNr5eYdm0qAR2XRf+qtuqCSdItyORp7WItOIDZdDJlsd2vC8cFeaQOnnhUVN6uf+vi3+AOmwEDr8RAqWK9UGpyMqpsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1dcz2Iyo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0815e3f9so34348847b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120240; x=1711725040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=1dcz2IyosX9KKA/3KNSmY5XarlU3xLIluGbKMtygfwNnoyMFBRfWeywZPxHnxy+aG1
         pUGJL17Cyln8hlvNSwB7LCp+jb50RmjMZ1Flhg2s+9pVn2+y/oJ8QC+5kDL/6pwbwXSI
         Iui/JGOf0GZSoVblLDKAMZhRT7OcyH3CrYFSwabzXMUQru3SgVxg4IZcix/y04H3wSQQ
         SqBat4OlSo+MHoxMLQQjwqkP6XEBOkaD2Xdn077IxfRrT8LC25K9gFd/jyfAi7O87cUu
         9qpjOuDlWA698J9z7v90G+f6XEAoFRoYqldeda4P7znZ2JPSfmObE1kPhfy9UtfXCgga
         +GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120240; x=1711725040;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zqw6HHB8TTWWZzHXrC+t6B4vKHkVHyluYvVzQQIi1bo=;
        b=ZNQkpA9uY65CxLSMZl9iu5cJAcMxMGf7ZMh1KvdNbsDYRiEeHa7TlhnIVjeTXosNzC
         sJdu53T6/xhQWtQZaiFneD8NvkCpMKESHEZpxYEGhmio4OnZIDy9NrcUx0OCRfJQhoHN
         ch3wts3eSDf76Ov2uDAWVyU7pew+e67+AzLVbg4XCNsqG+8fhljGAVatZ7r33wX9shOT
         hjtxcofEEFwG6SCeT786L/2JgiMQojvQFraJd3UNuusH4XtUvXUxcZfZVrwNxHoyNJwX
         8yGbxjC07X3NSNMc26XDdNbMK6ys5QoWTGg9z4NYKLQztGLOVIZxxMm6EcdC27xtn5C2
         Wypg==
X-Forwarded-Encrypted: i=1; AJvYcCU8sE1OnAVu8euK27ii+54Mxfg23KXD6hHj+NuCtOZdIFXByvBMm7VH2HGI28KvR+iLewezyxM23cBIM/qQJ0JtdmdixlTPm7w3S02Lug==
X-Gm-Message-State: AOJu0YztpVnJe+fwaKFNi1h4pxIYwb1s/m1NsTHDifkF7P/AqHLfIfxL
	zqgJc14+UBdKBrvnJl+StYTTXZIISsfC1xhu3FotVGBk/SFU/k9OSpXPeITJw7Kc3jJ0cIKajov
	2XA==
X-Google-Smtp-Source: AGHT+IEXCHg6NIh+6BQFmtU5UD6PB7Ny9+kH183mfOWzk4uupBXeY0DzvqGg9OiO4ZZ5PXxcNwqEBQGE664=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2686:b0:dc6:d1d7:d03e with SMTP id
 dx6-20020a056902268600b00dc6d1d7d03emr60950ybb.8.1711120239831; Fri, 22 Mar
 2024 08:10:39 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:10:01 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-9-gnoack@google.com>
Subject: [PATCH v11 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
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


