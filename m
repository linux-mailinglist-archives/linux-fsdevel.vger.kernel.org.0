Return-Path: <linux-fsdevel+bounces-14050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074F876F9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9896C1F218B2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80186208A8;
	Sat,  9 Mar 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NXrNHKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C6374F1
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970827; cv=none; b=skyGnjGIMOTbnsXbLGKmVApKyTvUJljSZgNwitqc5Yqe2+QeILvJulFBcACD/LJTaiPFjbsht+KeGY/ZYevBegYlmdqcdvm5xT9XHddJlcR2LJOIZOBQv75Sc9NTgMdMtig6bzx9AobTpL1PBxrlB4PA5gDu1JsgHnADU3s+uso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970827; c=relaxed/simple;
	bh=XpHNaMw51kfwTcxWhMkN0GRYGhulnMClD0SZLPpObEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q32rI+ww4jLPVwWOnh/sJstoosYH7YNVe7SW4pUzNOEBOMizuLpIRSMG6jEnqq09Gpbluo6Ok9XgIxIQIFwdxS2x0h7abRv8GOmgyvkZd88In4g8qLpOtuhE6CWShgDUJ876Na4C3mh36VmI/anJHVeNH9dY5/HzytSvA9hdfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NXrNHKA; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a450c660cdeso169188466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970823; x=1710575623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Jm3POEMybiMvQ/3vdCRUI71c8LtW1JmAsyXMz3gRfE=;
        b=1NXrNHKAXCeut2dUORqdrMdveRBb63LxdXTQDhZw0XFnKAKfDAeZnI7MgDZcCFomJF
         X6PQ1hA44TinSm4cwCCS9ScEaLoQAbGtWPqlJyZTZC4VXX3cwJm0DgcLOP9XuYVrBDex
         YnAt6JKU8I/g/h9WxwxAEpCcdrPYqBP0wKBP98NvUPn2W0IT7c3eBTHnr2n2aotFDqzS
         zrrUdHE78n3B2PPl0yGoI4VXZ4ahYJS1lP6eHHFD8e15GbsZiRLy8TT1vO1VQl6jJXCa
         CdohGA/brXlG6Nt1Cj2wmiXeN9jvQudLHuvJ9ZTNqEA4lLwG/NPoDc6zbWRZcLUkjgXJ
         wKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970823; x=1710575623;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Jm3POEMybiMvQ/3vdCRUI71c8LtW1JmAsyXMz3gRfE=;
        b=P9tFlewVeN9MMPtq2HEioN4pGVIAbqXifiwiISHoSAXZy971IJTAjPOjftsPXCiyJr
         1iP6a8Bu3ye0aCAhTjvSY8dQFeAfV4EhY9PhZDQ0OtisNjDIL2dcWma0tUzzuwvi0duM
         Ds3VLVTA1t0jKHFoR2nDhUoPqrv5TZOXmQM3T4Xa/dZqTXBnX8lSyUTjMBcsUS3Ogaxc
         DPqqxY9c3VmyfN0/vz231Ku7BmJfyXZH8GFGcam0tsMSxWULtFga3hNtFGRyCiLcaBMZ
         vg7SmYA7k2hlCNiOIsBWAQSFhDfP5ETaRZxo+E0mlYACpP1TVIRo74QxP3uf5D6gvJ8W
         p50g==
X-Forwarded-Encrypted: i=1; AJvYcCWnMEIIh2tbw0w8skrdybmOcK94dEWXmiHIQPkhHHrP16yGOs2P1a+bQAzDdgZZ+140W8jXjP9NkMNqz31kkIssxv7XOZ3dTAqRezNcHg==
X-Gm-Message-State: AOJu0YwhMV0yvV0mDYFJdJnSsmYvaBRXsCA6VRPkVM0fqaDtP6tbw5DR
	ZneIXLu8R7laU0/gQD+iFi8S+gkr63EGdkPNs+RNC33MJQRl327fyLgVnfPN6Tf2GhAt/k+tGSY
	8jA==
X-Google-Smtp-Source: AGHT+IGLpXM+yuVfUWprHCPTtG+qTgEOtYUZ/27FY+xZlbXBgCi2PYlMNVjPDgR1F3OhtL1jvLlFQ/U3n2k=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:e8a:b0:568:13a1:2c2 with SMTP id
 h10-20020a0564020e8a00b0056813a102c2mr4921eda.5.1709970823517; Fri, 08 Mar
 2024 23:53:43 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:19 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-9-gnoack@google.com>
Subject: [PATCH v10 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
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
index 08596c0ef070..c5228e8c4817 100644
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
@@ -199,11 +200,12 @@ static int populate_ruleset_net(const char *const env=
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
@@ -317,6 +319,11 @@ int main(const int argc, char *const argv[], char *con=
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
2.44.0.278.ge034bb2e1d-goog


