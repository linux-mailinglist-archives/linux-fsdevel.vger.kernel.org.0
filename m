Return-Path: <linux-fsdevel+bounces-47121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442FBA9975E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ABD924FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B886288C97;
	Wed, 23 Apr 2025 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liNqck4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A521288C95
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431231; cv=none; b=pygacMY1+Mivx8fcIvlTHNppQ9Khg9YDuhgH/TR8kJdfmqhGxSpbk7DrZOHsFBl6i2+6tj5i0S9gtzIe+kMIxr4jZXLeOgOSilvdkdteNiXsJeMDb/nESDjWvXVGKkXSyDAOR3umu95uywWFoT5YgHD2k56M+wItvw/kGweawks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431231; c=relaxed/simple;
	bh=+AfY+0DnN3cknayUVzyft99P4jOmZpu3yiNDoJr8V7g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N+bSchspvQnfDWGSnZG09xiDmtXvHeWGsc9geBP2N7y/8iLZcIMY50HaXTY7LRc784qPau2dCwzHAjgfxjuknaShewzwmiUBViZzw0HynNwi7dbe3zHJ1Ncy/pKZ5KPJnSEDb83ulG7DupIKY/SW1BnLaSbuA0/ge4Go+cS5w/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liNqck4c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso140869a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745431229; x=1746036029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2XkzTc2PJn4A+a+JXQEXeGTLyFH8I/nd3+JwtUQBwE=;
        b=liNqck4cGDDoaggOjUmZ/sitXRq0vvwWuFBbBzYwnp1DhnEnQbMIGwJfXIbvUllCqb
         g0Ms9zfO0iy65jZ/5iP/1HoAGNsDTCWBU6nQsTaVoLoSa4tOoPax8WteRxtrh2aYP27x
         2qZoY/jnKZ3JY/Ab4ke7pfBeqPROKaHEP5atv2+eDM4B3SRUOV1j/DOvhnefY1CyIOJo
         4mo1uC+luLN+Xq2qtDrNM4cCaCq/V3pV9TQ6n7Ot5xsEo4BCBRHRAQmkvRjGPEinuJi+
         ZdZB5ytJwtwj9O8FgP8VXcczztUpChLI5Fhm8/QGnRpD+tO/jiNfTzRpbgpVTDOhq1f5
         4amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431229; x=1746036029;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2XkzTc2PJn4A+a+JXQEXeGTLyFH8I/nd3+JwtUQBwE=;
        b=jyTLPaiAJHFix/hJxWP05ZInEwtiyHpXh2tp2AjyyJhPpxhUzbgAPZBB78TBGZooQB
         EqT8I2LR3LprigmdPivBeCzYEpiZ6ufvXDnzP0+YFUvYxz7DdXs8IKZRXVH2rtDwHxoJ
         KnJqMGMBvZDWY0Zp1CHd5eFOJ5s2ZYv496rxLy47o0v35d6OKAhU2fqUbG5O7uAZyYqx
         P4DOi4phyGikTBayVADoKCQEvMoFjhsHiWhOAkBpli+R5g0sJtNE7v/adWGuSjrgH8er
         XPlK+3wmv2MrwwOaV+41qXQmlH4nIx6z4oPhaF6UOsEUm9lszig2EX31Ux4k7d73Tri9
         Tl5A==
X-Forwarded-Encrypted: i=1; AJvYcCWF5AfrX35RQ+l/xoOjCsmYE4WO3SHTvQg5QpBQzZaBFacMItoBU/P7H31y1e4lXJTZ2NYiRXn6aVbrXiaq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4zso4XJ5Hx0T+VPvNy5G4hnQYz1Yhca6HAPcYlXFX6kh9cE8
	fbIzCc702dIRt8y3tsDbf2e1QwuG0vu0E8xQLwUBIVjk8Dmlg34bRD3pEwXc17lx3kGcQkiRmcm
	y/3SZHkn1bueIQw==
X-Google-Smtp-Source: AGHT+IFqLpkFseBunG8fACc1+jNza00V5SiHoWz9+D+PYIihJbr2Oc/oxVvJXJdUbkhWRZP5M/gY1MykKMLBRrA=
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:2fc:3022:36b8])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5828:b0:308:2945:386d with SMTP id 98e67ed59e1d1-3087bbad74bmr31666512a91.24.1745431229546;
 Wed, 23 Apr 2025 11:00:29 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:00:23 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423180025.2627670-1-tjmercier@google.com>
Subject: [PATCH] splice: remove duplicate noinline from pipe_clear_nowait
From: "T.J. Mercier" <tjmercier@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>
Cc: "T.J. Mercier" <tjmercier@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pipe_clear_nowait has two noinline macros, but we only need one.

I checked the whole tree, and this is the only occurrence:

$ grep -r "noinline .* noinline"
fs/splice.c:static noinline void noinline pipe_clear_nowait(struct file *file)
$

Fixes: 0f99fc513ddd ("splice: clear FMODE_NOWAIT on file if splice/vmsplice is used")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 90d464241f15..4d6df083e0c0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -45,7 +45,7 @@
  * here if set to avoid blocking other users of this pipe if splice is
  * being done on it.
  */
-static noinline void noinline pipe_clear_nowait(struct file *file)
+static noinline void pipe_clear_nowait(struct file *file)
 {
 	fmode_t fmode = READ_ONCE(file->f_mode);
 

base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.49.0.805.g082f7c87e0-goog


