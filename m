Return-Path: <linux-fsdevel+bounces-22279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C953D915A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF8C1C20E88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74F1A38C0;
	Mon, 24 Jun 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFnZmnvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDE1A2FC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271743; cv=none; b=ri/HeUsaH4Kj2WIwrQ6R6HMMMe92TJ2FsrjvFAnjpnLdF7a+yY8qBHI/vtL4UNbBNt4DdiKkZXC6uaVWEIQu4TTWpOH9g/Xq9+/lQRRXdvMBOFO/H08GA5E6kfg0/0hN6MVh8bAsdSFqJApGzweTFqCAqEGDYeoB03P86R6g0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271743; c=relaxed/simple;
	bh=NqMqA7QWqr9/+mHOdPi0hG2A/sBfX5GGxqySZ84bEFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f45qU6+9zCWopIcTu6BNzFq2Hv2gMECBGg/5Mjv30eKySzA+xNTYs9PdIm071IRwNVLHzhvXhjYDoWkwN67YVg8vbWI2JjvnC6W8Jx8SLGB3EhwAzDurV/v927yMMy2VkqHT95WwdQG1HLVMLNup7BkXNYjxlEBNfAnnNia1SaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFnZmnvw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6e4381588c8so5568968a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271741; x=1719876541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=fFnZmnvwS7MKFZpI2jZMbCpkc1fBRNSkoC0KwtyJ//fyUSbZ5X7qFRT22trNVHNbwH
         7hKGXsTVw8DsxkPINXp4UyNONQ0xtStZnBMMB50Qz0DqWUW4UIMVG71me7g/KZzsf1p9
         iLgKVe7bNnsQVW3vMyqwwum4CvlzWjxiFZ1HfNScTjY/HG4RO1YDuK0/fIJgQI0er74i
         YQe5HcwABIwTtd60FVLPOwNe8zOvM6GlKnmAhSomrs0eDER+eGosM9jV0exbdhtsCTYg
         fP2AaGSFbYc4PQEvAIRaVPD/220sTNF2RIhdRVfy5cFWDBz0R9+HThNNdPmt1AzPkhBU
         1dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271741; x=1719876541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=MkWDgZ1dyzVvoHIRwksEYicbfBY7hbCEA0BXzIOAZQH3ykGdMDb54UoVHFDzNp1Ls0
         MC7fVkgMx2lQC97GOnH8EAMrEsP1BpKiJK1Jxw7FSOGD3uOAAlzQMP+UC+Jyc77xnDCe
         jQ/jexPWMfJaQZbGnWxwgs5t54jfcmS4wvOSPKFhc+BUkMpb7uJ6PNvgnhP+ELl6CgQQ
         Si7ebn3vz8Dk23jjwmhdO/MFGJGzF4iB241dMvafydrQDfedhM4A2G28U+pKvhMsDsSU
         x6QArjRVJ1NP+QmGzbiI/HgoAM46HCJyqLcXizXuAo/aFtC03KzQpLkxg/yk5mNDBV2g
         HO2w==
X-Forwarded-Encrypted: i=1; AJvYcCWeABx2d+x3oIR9MWEY8DzNOnaITQumxKyjBp5hm+97kbeSny3QvBf0zoLYMyv24OmtEoOuxR6a70lN9+r46GC2yzodDESFAq+DKNyK5g==
X-Gm-Message-State: AOJu0YwIYZ6g/eYkkbF4myGPxQ9oxrgvPdMOF3FXETscO+vX4zzqRClP
	f/hC2lP6DQFpOiLyBoiS5X9qjlLpWVHGnN3O5ULGgXhPE0Y0GLIO3ndawT58/Tu41LVIqpGYjVS
	ugg==
X-Google-Smtp-Source: AGHT+IEk+3lC5zdyxifyt4ii+6a16n1y8uZeO7DOAPkbXtiVBPE0qfgp7g0LpuESyv8BZuXBXF4M/RvaOF4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:4a7:b0:655:199c:eb1b with SMTP id
 41be03b00d2f7-71b5fe10537mr20071a12.10.1719271741168; Mon, 24 Jun 2024
 16:29:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:10 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-2-edliaw@google.com>
Subject: [PATCH v6 01/13] selftests/mm: Define _GNU_SOURCE to an empty string
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the more common "#define _GNU_SOURCE" instead of defining it to 1.
This will prevent redefinition warnings when -D_GNU_SOURCE= is set.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index d50dc71cac32..e4370b79b62f 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -13,7 +13,7 @@
    sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
    (warning this will remove all if someone else uses them) */
 
-#define _GNU_SOURCE 1
+#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <stdlib.h>
-- 
2.45.2.741.gdbec12cfda-goog


