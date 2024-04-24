Return-Path: <linux-fsdevel+bounces-17668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C298B1379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E36728442C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10378C89;
	Wed, 24 Apr 2024 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Roi+baR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D9745D9
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986500; cv=none; b=HDOR/k7xsHEonVWHpxR3YbQD7nDfHSlaGGxiR3kjB6sTXx471wusdKV9qcQ/9cWRc2RTgJArP9zadLdVl6L/6MSphDCZNArFqpcyLUmB/Bxd6taS1g7eaUdxyqIFZ9Q2IzJlx7RSiqNLuzHzH0aQbHwzKYm840sqzTJ0QZBYdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986500; c=relaxed/simple;
	bh=tTJKTCZK+7MUJMSSp7o23DoKoVGNAUDPQk8v0lL9B64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjDBBGhOyNl+WxvrtgZZnft2Nxpc7rq8rsZFEbdOTlk6npxO6drcLR6JTJUjzTsUNCn8ZF6zat/iQhF51C3XJcrZOXUs5LXvAbicsSlAojIIt+7dNsAsElvYboH+TgYhB20QkyfxKkmT0mByN3EWV2XMrWM72ynITL/zFM9Gl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Roi+baR/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea26393116so178308a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713986497; x=1714591297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNHLJopld4jqnJrZ1oiAAgxTAlpul98lFx9bY2o4kLg=;
        b=Roi+baR/9NehB/DEa7wTeBDHVdkwYBUdQYGWKE5QRbrth+AMF2nWrsHrwAOPUtMjN6
         dEV4o6+6Z08gitDVs6x8SErCBK0EEn7JB7nS296WtxFqv7bnukDlnUAbMCzG0P2YHNTt
         tj92DpS9LgbMAGdRbsioaSu2w9rlMenjpHbjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986497; x=1714591297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNHLJopld4jqnJrZ1oiAAgxTAlpul98lFx9bY2o4kLg=;
        b=sNWYR5ri86Stn4938/RsxgAsJCec5AKKL9zbi3NQrOX2Q1ElNIeHmo+RAD53h0Yymz
         eAL40XPQgvGN/3mQsUjEw2qXhwBXzVrh53JUCCYcBMLYB6C41A1s+YfWGlTZp65Qy5py
         0jxFD+07AXI0L1rIZbv1Lqd57EyH0m6uikOZEdAKY4Sb2FgV7U/JHVxPxIBbvjPvyUHB
         xPO6FPBZR9VTrCzFOM5ifRIFXTsZfd95IVsLwPms6MSkWyeGAopA4rRQbwwTCNapN3Ez
         igujOhu1a9rz8URXNcRkEN+t/EdAmkwB/mGEomK0sFd5R/c9G5qipUEstWzGXqOQQdO5
         gszQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1A2voK0aq7kavfB+IZ6bDw/1DUuiw14IB+aVZPiM5DyQ5bd2UNgvDBBKAJf2P5OQUU3gwLWhVe1cOqkG8arMbwQp/oqRKZ89tPQiug==
X-Gm-Message-State: AOJu0Yy8cAook/cOF1ooW12ujsvTQ+YCe4DNUJ7k31gfCisB+HpljUBJ
	wilbbEqRUuIstSjalMpWU4gcARsQwRoGyBExMgQI5mHLv/tP0NdVGOZKe7LihQ==
X-Google-Smtp-Source: AGHT+IFuqgGNw1ep4y54aPm4dQmLi99sxiEQ9YbOo91SW07Q3tBMI8FSl2WHIOI7cdyQhNEZyiSynw==
X-Received: by 2002:a05:6830:1d6f:b0:6eb:7685:b00 with SMTP id l15-20020a0568301d6f00b006eb76850b00mr4093982oti.28.1713986497681;
        Wed, 24 Apr 2024 12:21:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l26-20020a65681a000000b00606506a95bbsm1425110pgt.13.2024.04.24.12.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:21:37 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: y0un9n132@gmail.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] binfmt_elf: Leave a gap between .bss and brk
Date: Wed, 24 Apr 2024 12:20:58 -0700
Message-Id: <171398645483.3089364.2691527690120638755.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217062545.1631668-2-keescook@chromium.org>
References: <20240217062035.work.493-kees@kernel.org> <20240217062545.1631668-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 22:25:44 -0800, Kees Cook wrote:
> Currently the brk starts its randomization immediately after .bss,
> which means there is a chance that when the random offset is 0, linear
> overflows from .bss can reach into the brk area. Leave at least a single
> page gap between .bss and brk (when it has not already been explicitly
> relocated into the mmap range).
> 
> 
> [...]

Patch 1/2 was already applied via x86 tip, so I'll grab this one for the execve/binfmt tree.

Applied to for-next/execve.

[2/2] binfmt_elf: Leave a gap between .bss and brk
      https://git.kernel.org/kees/c/2a5eb9995528

Take care,

-- 
Kees Cook


