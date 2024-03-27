Return-Path: <linux-fsdevel+bounces-15430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61688E68C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C69E1C2DFAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C361156F58;
	Wed, 27 Mar 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfvMX277"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D8156F50
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545065; cv=none; b=oGtk5DXpfpNYnT3wKXY+8EKS2TH7wMSBIFn22eKYePnIehRTAkURbExzOZnQyHzAi/Qccx6TwGLgJna+ZPkyrbjZJNEA0hwynZdwuhWvmGTMsToj+b2zzl/MwmfEoQILoMwUfnRuh0VcEyizYOiP5NxtDfeymRduaoSg/BCcbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545065; c=relaxed/simple;
	bh=EeRGwHz6swnOIRlMBlv7zlJ6FdE1ePei2mcknRU4yVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8C77Mb0atCcQp0hz+CmUrRP0uDF/ohsRoM5SC3o/TYAQXGGQR6ImeDVnnUUZ3qiyYvj3RQ+3O/J6IkcfSeiPEurFNkcYguqKqB1Ym6+7OuJm51tryP1CaH13wPAAgBJjsrak+tSmMSk6LoHP7FRIeUxxij5GraVzBRsbZbf+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfvMX277; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a45acc7f191so401784666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545062; x=1712149862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6KNBzHqVxdWQfnLG5JEHxEU2zjee9ejfwPGlk43wY8=;
        b=HfvMX277j7strc8zKLr+qO61RSMurni1HkSH7C5Mf97NRUDUmtBu5ePPMx/09duV99
         KRVkZNmwYIclfgbISTeWdsEG+F1ZmEzgQ8yn5w3vOfNb9YD8StkndnYKerbmpo5ybvPZ
         IuRMNySoMl4wpK/dnJHOY13DtwDxNL2SUOYwfSUUW5irxqL1M9McvyoRxdTUVqZAS232
         3plg+HdYzl5vh6/A7b1CQcpqbGGVJxVQL2dD6aUkg8wsicfj956+d83ksqiz4kv+tpRD
         toYELv1YquSr6k1KZJDc542W53dNBDdkbqopHzHesutK9m3F5ucIHVNGiw6LuwqRQH51
         2L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545062; x=1712149862;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6KNBzHqVxdWQfnLG5JEHxEU2zjee9ejfwPGlk43wY8=;
        b=wg8DY9V90BB34iiu+kjxlDGKYA+D4DBk2znQEpZVj4zd0rv7uj6ZsKOQguPi1hWDh6
         CK+78cjT08ZjHHUp26qPkhE8UsG783dvyj8FyAZQ8TpLusHM3/cfFPCyjEGzVAKZeLpA
         Zg4MP3h8UZftGSB6V/H3RcE0ThJxdf5cxrYyY20o95gafmX/9LknXqNREBFP+xkiXvza
         pF52gXlSbbbgHXCbMZ+ZdOun+gCkVEPlISGnZSJWByqF+9Anu7M2MmQZIUYtN95N+rHH
         5M0QlhrbLME1WxniSF9lOAJx30FK/aVCZlHAvzQBANx54cgFHbaMh2+wWjRlVXClmmxx
         xU7w==
X-Forwarded-Encrypted: i=1; AJvYcCUpMn211la7V1gQpHqB2OP3eb62kM/57axSBEo+ETY9yBVtbN6YjC/OINDYvTier7vWG09OKHVrDjy76YiPBi6xH4OzD4HBlMwIyBbZiw==
X-Gm-Message-State: AOJu0YyTFJvOnQ5Q+bCpyQlz5xtFPi24dZ0pm5kfZqN/qZgG7MAexre9
	CY2z72/Vx4xEAFrsFkPO4xmik+7gAjVlNuYa0+QmKA4Vq9F3f2ksTTydJxGdvkaMWRCjezSUNux
	PGQ==
X-Google-Smtp-Source: AGHT+IHf/kpoa1SkRRq/ZtW1kKi5A0jzz2n9FfDcQSnZ2kISo2yo523exP1bue4OGrTF4QBG1JfkixOa41Y=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:b5a1:b0:a47:36ac:ecbd with SMTP id
 qx33-20020a170907b5a100b00a4736acecbdmr55729ejc.2.1711545061763; Wed, 27 Mar
 2024 06:11:01 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:37 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-8-gnoack@google.com>
Subject: [PATCH v13 07/10] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
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
2.44.0.396.g6e790dbe36-goog


