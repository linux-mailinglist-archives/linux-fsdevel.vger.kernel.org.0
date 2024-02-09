Return-Path: <linux-fsdevel+bounces-10998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4684FAA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B44281316
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852680BF8;
	Fri,  9 Feb 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvWr5Mdw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFB7E595
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498399; cv=none; b=IV5zahfHiDw6crv5TMAxuNMEdarvC9+32OZEdTulca1CFwyQqH8rR+aMl1D2Dhfeum+HHO2xQbHEDAoPEUvSjBqjaC+ywV3/XKgNg3GKIDiFR/lOFUIhp7t99cPVOQdpDOEaxRH30AZqR7c1Ira9L/fjA3Tz39mTywySj4M0zsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498399; c=relaxed/simple;
	bh=kIEptzQde7cesZNFjMOm2MmmN9Ek6A0D6Wd9L3b44iE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=IrEXeNP9QXHjgvF9vIsCm3hBpc/K8EB75Ztab+mLo4Uzi5LRUdN2KDmYMuEnTtwdv2W/67Tl8PeRfdWDacK617TpRlcI95AtiS5TPnu+8Zk7ITsHYmuxlAEctlK9ywKI5cGkE9FM2VeUkV9H91nLAXQKfmV+TxL5bKA8LmSRYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvWr5Mdw; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5611e1da4c6so822675a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498396; x=1708103196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es+e+wQNjnyIvSqYUyube9Brelr1LLu1DXJz4rbQGc8=;
        b=qvWr5MdwO1Ma+dQRtPBOw4tXF8RyyuWm+fH4CS0yD9gL3bZa6ehoeGQdy4J4NyBrDj
         +pYjHhRYyUrdcrO1uzRmJbWIp5jXYDGaxaJ6R/7yhYnaN670I23eeYNXYPsA7bTAmIwP
         AsRAWjSraIOismKjO1xA3aa2wlH5q/auXMtV+vJz6hr3FiX+dLbGAy7b16oW8e9xQXSf
         yK3/21imzWmy2MvS1hgp4YbRqd7PgRQeUeaE7zWlsQsKlfHSb/o6/CNShsQbjsoQu5/C
         qEJab4eIy1N+Igv9pMp4yPbEgJL5a712XmrWbUyJpRoO5TliV/Kx5N0mHokRkmRoyxDo
         N0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498396; x=1708103196;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=es+e+wQNjnyIvSqYUyube9Brelr1LLu1DXJz4rbQGc8=;
        b=L8olMqATnCajsF7x+6qxMzzhzaPV0L/2/Z6Kqw5AezB+hClSMouQzvswyqNmi6lWyN
         Q4KwQ8wKi8NILZwh/TvOYfSVY/l6I54Od146Gxfr4ucJd6l9l8ng7RNyTf2crJQCvPVJ
         GiFbnkz1sAL7VSSQcr5sRIESQQZdca3yp5YP3QZ9OikOfRbqOMpbC2h9loVd3OrRItl9
         C/0WWDA8ChQbeDlBAqJKofoYICZxSRnea5MGmVDedph1R7GYDIsHPzo9DKzr3iE6+5lG
         0qJ+NT8DmvRCKRMvunoT09MxHFNLFB6G7pO0F8tiag45PGrS+kvRO4YQ3qbMu7KlGpR/
         qCag==
X-Forwarded-Encrypted: i=1; AJvYcCW9SXdNMcBwYcti1HUgA/vQZMOAu/qtBziYk54I5/LiwzVhZQ6pyKd4Uq1C4C6wr3F5PMs1RPQkNYQ6gY+n6YQB50oVKMykk14NcsAVFw==
X-Gm-Message-State: AOJu0YxkoCvgBKZWxG2tRSQMnVjGh58avAsQW+Q2xSog6Pc9AmiS2yzE
	r3gMDkBBVJCDAs84aSGB8H1sPJbVTkQH6k3RJrpgU0vksmoSJqPxzA6jd5xBlJE4iuBQDA7IaaS
	tIQ==
X-Google-Smtp-Source: AGHT+IFB+/pCN9oyiGtqBzLpOTRwTMJGgBLKeYT+4cNG8iiYDpmKYYsqMea+WwU2IoCoNg5kd4GNsf+JBRY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:3718:b0:560:ab40:e6bd with SMTP id
 ek24-20020a056402371800b00560ab40e6bdmr9105edb.1.1707498396254; Fri, 09 Feb
 2024 09:06:36 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:11 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 7/8] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08596c0ef070..d7323e5526be 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
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
+	LANDLOCK_ACCESS_FS_IOCTL)
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
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.43.0.687.g38aa6559b0-goog


