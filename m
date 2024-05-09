Return-Path: <linux-fsdevel+bounces-19216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA28C1689
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 22:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FC028990F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCB13CAAC;
	Thu,  9 May 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNgFNOvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAB13C8F7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284946; cv=none; b=YYR/hnLgXN6ULGCHJMJ8PXe68xTxT1/Lu6rOBMYscd+P9n4ioc0YZI6VWZtey6cokX0Qt9P/M+MCughekIULKLGf8j7QAao8j7FPD2Z5OO5A1tYwnRLCsOTpF7YO/Q/ubSHb2bXpbOeFiilQwVtmsjuyFjWK3sgLhXiOhi4gVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284946; c=relaxed/simple;
	bh=XzM7bW4mUcL+MdWLSgy4pPFCyz7AUX0/rTFVbZz4Cks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q8xJ8k2Wsrm3tOxCiqKyNGyNpfNO0CufpzGLs2YkyCMFAZfqilTuWVbl1Tupe25kRWvDIC9cHoy0lAiAMulwlbU8Y08A/4NtgNvmyeRMO/HDa0BTE+ynWNKXZ/Ki2wYtOWh+oufveoILHaqChCI++6XpYC5ctfMLcqpfSI/5mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNgFNOvU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ed941c63b3so11426835ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284944; x=1715889744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibFWC41ZV4jKFs0EDjRGi9eb9rYUWbe9LL5jTVHUEjs=;
        b=TNgFNOvUDwSzSzaJ4tw+i7vOl78bZqwx798H7mD/omiE83Av15InytXJwanizgjzCC
         wSNIkuKBojsiBJJ7Y9S68oOPfkmfC3QTjdo91uUzXY8RFQdVfTpfAv0qxTBqCTtNQuko
         AwYJi5ORP7CeEXT6S53WXagQQElrKDNGlSg4L2Wh5oYtKIAbenVD1k8u6ga/9MYJpgcu
         zrGPLPVj+GNImrdIbQUCa5OFe0IXRUZaf/aX7dHnONufx2CXNfV0EJUWKQRslIVuOMPO
         zes7Aj6ZDCaP+3r6bVriUXvwfq0qQXqSPfO6WmhBwFUXgaqb5k/UXZJgptuflN9+y2me
         eklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284944; x=1715889744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibFWC41ZV4jKFs0EDjRGi9eb9rYUWbe9LL5jTVHUEjs=;
        b=YqjMyC4n1n4Tbx+jlokA0rWy7W/4z+/GK2owuvxyukI8o7Yz1rg3gzWsKGOeoNXIpZ
         aINSVC8pZ9Katyg/ZlwXWw/NgNUExDe7GXa9hBtigHXbrATI3bP3KZ0lsKAB1FpvRSI3
         a9J4OhAskd3qfhkAGG1cHVSkmfQQhjRWmkTtbHldbSuCCisyPUiSeXbEgNYg/8YlVOn5
         z2sB3xeCo+VNeFpb0zCaadwHWrC7O0RCI6Xlo+XZGkGKzmZF4beXOXhJgKCpibHXvEx8
         bn+Zbg/LZve/J8V6FKDoPcP27EDkkpMJIQwxR01JPluaw83cerhmlmkKPWHIgiA/IrGf
         mP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQFgC83UIp07BytHzYy0HqwkUytn9WpC+YbYAflbaE7oPm2UMUhtevFgIeRijJ0pXOwNhRZPwlA/QHIbzaxqF5xJQKzyPtMMzX93L4Jg==
X-Gm-Message-State: AOJu0YzOTtLDL4HE0G7r+Ze6DlM7X+lJvN4P48LtyqQpAai8wz5tqNgk
	2/sswIODm3HvQoe9OSd9j9Fi9LKc8o4F7l8D/SS0KEnW8ImjU4jsjD/1sBVSNAT7Dx/VKz2aWf4
	crw==
X-Google-Smtp-Source: AGHT+IEPkGuNPe4HIZuj85oVFOfPMLkPB6Cm4SK3VLdEwwtMiQwP0MRi57NnzjjqYrYIB2JiEx+9LJND0hk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e549:b0:1e5:e676:4b0d with SMTP id
 d9443c01a7336-1ef43f4b57cmr17425ad.9.1715284944391; Thu, 09 May 2024 13:02:24
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:26 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-35-edliaw@google.com>
Subject: [PATCH v3 34/68] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


