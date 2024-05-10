Return-Path: <linux-fsdevel+bounces-19228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2658C1B31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 02:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB991C2039E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D964A28;
	Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCJYiUWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33213B293
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299881; cv=none; b=Pm5TYNhBrBLcl/H21wg4xJiQEy0M1ZcdlhxZR60CoYqvUZXPUjtQgdBkRBgfsPPrtghrxsSH4luSMRbQn0H7oGfQNNP/S6YURLXLBZGUPr2gTfUMLFQpWRUsMUL+TMaxoPEU68hw6k5B9fvIcIHX13O4EaQe6YEvY3MfHma9ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299881; c=relaxed/simple;
	bh=9SdZLXa8bOO8qqRm4M0qIy9O0gsnXY10oXqx9sqJBYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzO1/OCSXhm406eB7ABYCQJ00MSLMNm8F7vkaXEwQCdS5RWPjDxTDOoOxotW/32BLEQdUUq8ioK5UkTLnC1N5pH8PYbwwIu3gvFvha/MQ2w+HYfk+Ll8OaAyo4Hga/uWGwgWXIZBrgrBsFzle60jqplcJgicjAyxdIHiuXSPOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCJYiUWS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2009011276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299879; x=1715904679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiI/uc5MiF5hVrzWysDwKaH6OKN5b01GtVR6T+4Ou8=;
        b=PCJYiUWSDKcZ7b5ZTRYxoRuPu/wGXUWBBoDIoAQEhfLfpWGNfAL5JmkKv+ETj7xx7F
         eLkIMY/AKbqCiSngQU8h4CHQZFFaJx9dcTVvoMN6zWTmX6VjHYsTHGpG3hIgVgJv2Y3H
         Z815kk50HeJORYz0zX64evgkNwNF8iMunDDC+H5zdlONOj3vnKVEL+nkj5BCIsTtnEZU
         W5DRXsgZAiIP6iXmYV4z9dcwRHvlnvnXHq570loyl2/ydNnX4w5UpyrnHhKGbVl1PwLP
         vacZMjN+tRWZ6ddnm/hO92Yn5oja6EixJtkE4xbFL0G9xn3RNqgMYrbUo1KI7g4kTZPf
         UpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299879; x=1715904679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiI/uc5MiF5hVrzWysDwKaH6OKN5b01GtVR6T+4Ou8=;
        b=lgquDshcmpAkSoWmg0C2wmL7JAuIuFOFVTwGFsQkV9mpiWCHowBBWNdgVeNBvtWEYS
         jmYZp1zqggnQJlGjrAfVtiMWit8ppzoWYKvsEZ7kKfnnRa8+21SJCXrXhjc0n1gdcCyu
         2I+enm/6Isxh6Ruelu7e2g+EB1uKkV2m3UANTKE0NJftfpeSg/xxqrG3ESEmHHE3d8Sr
         pBePQHcwu6Fo10WJxka1wUgPtaMghi6sOkHsEd7vhwU7HgwdulKPw2W7z5+tE5BhH0jl
         OitrE9oPTjiVwnZ+hyOqeRjM9ceZ525FUiGoeDT7p7/+f2MVkQ3NJFTfpU7U5l1bugA+
         w31Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+0Bl1i4ZV1XcVSdRaiL2uwo5vE40RzDX9HjHrxnI8BoHwR01lUDxfCENti7pWUkuz4nKIX+Kms/7OB0pBIsd8QXC0HQ3aHJ56vAh/Ng==
X-Gm-Message-State: AOJu0Yy8/0ez76SjF/cQYimR4ESOYyODHPLg/ZnnASTEwrc1/9xfj0eC
	Bv8wu4qthOqLLBi7R4hjEFWNsBzmQ2gM8TJu+x95oYqvlBdNdBfbWNkx6ArHBMm9vx9quUvK5Iq
	mmA==
X-Google-Smtp-Source: AGHT+IE5lK4O5tKmIABh+/0fZfzUGpesvK3r0yQsigzHVYkbLRrBgnWaOZUctD25gmyF5UaK8CUOK4LhdqQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:a1e3:0:b0:dda:d7cf:5c2c with SMTP id
 3f1490d57ef6-dee4f365eb8mr105581276.13.1715299878998; Thu, 09 May 2024
 17:11:18 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:02 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-46-edliaw@google.com>
Subject: [PATCH v4 45/66] selftests/proc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..f92a8dce58cf 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,9 +23,6 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
-
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


