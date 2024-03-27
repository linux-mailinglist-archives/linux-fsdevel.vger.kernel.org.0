Return-Path: <linux-fsdevel+bounces-15432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53288E690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912D81C2DF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF715746E;
	Wed, 27 Mar 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAGVyGo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D582157463
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545068; cv=none; b=bxZUcdkW4Rrx2gtJgORA6qe9ysVHeFIoIdeCnEBVLVNy+PQ5LmPYOFkf9ChRs2WtGfA5ciLFnjiUyCjXzRfIHtRUZBZJBRJXAtQuuzbdMIZlhIV9Umhw6gWm+RxnwNFgW2SLMoVkq8jpg92Xis0j9BT81vKH2bSOjgR7I/iivs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545068; c=relaxed/simple;
	bh=y+r+QiYljJ8LyQPSz6ila4q3cE0VvWJjqVMPhAkSt5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cuNmWejNQNdnfBe7EQMCpnz7kPOefpASWnYbH2+RXz6wWOFtwkZ/bV2JJbI9uFOBvhlk182eNMj2cy1Il0884ouJ423bQAUEfrUNoa3Q5A79gEpj3hsVZMlekGMyVfiBLDYeUC42vcFGz8SH262puvj/XMwtExwE2uDZjWi7yKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAGVyGo1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6f571so121456357b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545066; x=1712149866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgH+A9pGo8bgeAYR/oROdEMFeGk4hRe3NHSXR6u/PQc=;
        b=zAGVyGo13mPvorWxeq/7hQXRjIB2xwIC0DsLN+8paYKG27bpNg7mJT6TiuNDGADvk8
         Vf93SKdC+uz4qGJojqYMHReo8FLpC1cipZEIM7Ll4UNLBPVymz/oYU4W2G1qzN9xwwLm
         +fHGKF75eTGqhSEA7QrBNWFOI69yjKPP/dXrQJHLUStDN1EgAhjZN+9haT32YrZw5kiJ
         cLPOsdpU7Sd1TXVQ8kfwwdK1jLqcSq3h5DBkty+YF57WaCA9I2H1JFVV/2WAkIBevtCT
         ZMwY020Yg6pvQ+OuFZL2yvhQj+DjNX0yh0b4MQf2AZtXeUR1Wu1aS2pxiQ31lyRStsi4
         WClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545066; x=1712149866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgH+A9pGo8bgeAYR/oROdEMFeGk4hRe3NHSXR6u/PQc=;
        b=Qw1nK+7XiKJjIzqO+HOthG1sM5Pjedw8LTonPu0ZS6cni7RxlQLa5hexULXUg5Wcai
         uc4DV7zVn2OMNdIlHWSuPwdWjSqpWxdgsRlIn1lEBUQjfg1MeqxIQZGpUN4fswC1Cj9r
         fsVE2hidHJeAwBF5N9qSvhh45+ST1koKYnDULepRZRDbht9RyBQMa445QTtqSn0afSbV
         hG54KmbCbh5g7tj1pP3RLhvv9gA5FCjEWaAFb3HO0KY9HDNICi8BV0vfSHozWom+ECuf
         NALXl7fth7HqE9ari9N8lE+z89u8SWbYVZ4DA6sTIbCB62hJ+vr34j+7fTHNKlaPYtEE
         AcYA==
X-Forwarded-Encrypted: i=1; AJvYcCXPyABKCgbqLkW52yTc4UzgQ3R8JkAB/0UehkAD1q0D6dGp0bqAtJtc7pD3jvP+TkEKO03qERruI1euKHVKwHp5rSFIkVWnXLn6xDUS9g==
X-Gm-Message-State: AOJu0YyqXDdCVG6vBWsNitd59BsVv8Flrq6Hf2uqXN1GOcSpDBzi0r5Y
	gJ33esQ6MfebgkFiOX+oNUMjHQrOsQFqv4jrAu0q7oVy7wtKPXoI34p1DJ8SeOAJJ66on89DeHb
	p9w==
X-Google-Smtp-Source: AGHT+IEGx+pRisBXIjqRw7WTmfJs7jTAXuVLd8tF0S97jUlViAzTO05AtGfmYNmzpOBX3iVy3fk2d4rEJuc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:220a:b0:dcc:f01f:65e1 with SMTP id
 dm10-20020a056902220a00b00dccf01f65e1mr4043330ybb.8.1711545066672; Wed, 27
 Mar 2024 06:11:06 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:39 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-10-gnoack@google.com>
Subject: [PATCH v13 09/10] MAINTAINERS: Notify Landlock maintainers about
 changes to fs/ioctl.c
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

Landlock needs to track changes to do_vfs_ioctl() when new IOCTL
implementations are added to it.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c95dabf4ecc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12222,6 +12222,7 @@ W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
+F:	fs/ioctl.c
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
--=20
2.44.0.396.g6e790dbe36-goog


