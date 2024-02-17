Return-Path: <linux-fsdevel+bounces-11905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A9858D7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 07:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F00B21D30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 06:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD23B1CD2F;
	Sat, 17 Feb 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRlgUqNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85231CAAC
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151150; cv=none; b=iGOgOaetyPQVofUDQlR/e2Apf89SJjv9n9MGUnphfV3b6f2flyX90/nQaqiUM+PifRF0TLMhFN4oYx77avjJo6y909HBRtvc2U89mPEXWOa0bg5jhsiAOQOJDxEB2LEGcHe/+ZzrYvTBIdawne/FpWp13c6zCOyiJrCsktM3ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151150; c=relaxed/simple;
	bh=0rdN5Ywql8YEUys9LVJTJWHqvzfAzwrX+79MyzxBI4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CRAVjrRsHKGaloxDvyNzK/SrBm156yZ/zveQRfrkQulNO/ynyxWp3QQBgf0rCLazlMVcG2M1F6j/PJ8Yk4WpUupYSwcjP/L9ch6kOqzazYyqU8SuYdzSXXEnr8s2Ax/46D+lxMzKsnOpLBL4Mem0euuC90FL2j651tOeu+Y/yuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SRlgUqNN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8aadc624dso23832905ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 22:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708151148; x=1708755948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWt8teqLAwEcY7rEsFaKXXpAOKx8kXlOD34XjezwzT8=;
        b=SRlgUqNNNRYHNWvpJpxkk38Ht2XtcaahmZT0sYkwFA9C58kkDYYZrF+Wz7FxWL73EW
         79+TcdO0SVg8LW2XT926h/Vt1khlXnIdrz312YLCHCj5SH/9C3kwCGerc3BzBdFcxCYZ
         1S9/XFg1MoU5ZWXb6EaykJmymk8Krq2mecU5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708151148; x=1708755948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWt8teqLAwEcY7rEsFaKXXpAOKx8kXlOD34XjezwzT8=;
        b=nMzV8m/AAsLXYj4hGEiKKT/CKb0Ejr5fiihkNaIIQO4AQD7OEyW0ZltRkqxjhR+iiN
         SFR4oBhxIES59gYoUHHJ2jnbD44EEDtzY+xnGfe90MuObS5FFXwGinXgborB0QqjUa1t
         7mmXpJes2z9YzRBcS5bq4AF3+e3uF1+fxQiC0uBX+SYYOCT4+Ba90//N2wFMnePEocsW
         0wtyt/e6pynTa7t1ZAn5QicnRcw87V6ND6qn0Bg1vpzrgzcalhOwba3WMdrmUjDgq5HQ
         6ip2bQ1vlWeb85YKrbO3ZQJq55qRpnpGt+ETEwNu9Wxavqxh6EgDXtq004/M/Ke9nqD9
         XT3A==
X-Forwarded-Encrypted: i=1; AJvYcCX0B6GcnNJwdb+2shq1VvhW/6JICUGHkIz3TvPe12yt77GAhTbogsjd4ZHkb/2pbDWGYMAnkF2RnaDgthEuU264cMpMo53tbMx3ig/0gw==
X-Gm-Message-State: AOJu0YzAJunyAItt4bRM1QwHwKnHOVc6N4mRPua31RpqnCXuRF9pf5Hw
	8iC9uA3dH93Jhu8kZzjdqeIE0yw8gGk+gQCVeOQgAdVHqLhOOmFYQ/mXRWwSjg==
X-Google-Smtp-Source: AGHT+IGOco9kGEkPlMYnz+xDhiK21QtcC3JoFPrjYqWqfD55D6hFKMHNyr0snN/tw6RCI6JofemA9A==
X-Received: by 2002:a17:902:bd84:b0:1d8:cc30:bb18 with SMTP id q4-20020a170902bd8400b001d8cc30bb18mr6427467pls.52.1708151147993;
        Fri, 16 Feb 2024 22:25:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kv5-20020a17090328c500b001db5fc51d71sm784311plb.160.2024.02.16.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 22:25:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	linux-kernel@vger.kernel.org,
	y0un9n132@gmail.com,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] Adjust brk randomness
Date: Fri, 16 Feb 2024 22:25:42 -0800
Message-Id: <20240217062035.work.493-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=656; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0rdN5Ywql8YEUys9LVJTJWHqvzfAzwrX+79MyzxBI4I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0FFo0XJ9PWurSkP5cp5jRezJ7UeZ+6fL+o1Sb
 VdG6+/Tu2yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdBRaAAKCRCJcvTf3G3A
 Jj2JEACkIrsCN/yzegtBO6Y04l+D7EWAUVXo9GIO/a66vCghjrqM320G2Rf3cSgbANwx9VKnkwK
 KBj4N8PVQVj3GJ05FrqXoxkez9znAutsnPUfw7kQXGgcL6xYIjeKz7r62SSSaxKDLh5cgVNWcZo
 +Ep3MbA3WO6RrC92yZD84DC347/oOWWo/xA99yrJX5NCB6XwoclZbdIG2340YJASly+ktJr1W3C
 NL7NImsV7wc13qqwwVd2Z4zOSLwLipvZriRFOxLicz5e4DSAEI7H2hz8DNq7XdgPVAMpYNwPEHH
 wpssXTFJaqzq/DpH/mPRMmE3099smsh7qmxWil1VovFC4dOpd2z2S13vXbDCjCIYRDmfDsKX+Q+
 3GPKJNPuyI5Jg7bMh/T7Tr3VqFCXVN9ekjXpq7Csdckcaq2xEto9jVoUFVu0Zlp2l88LQZrWL8e
 +xIRxU+bYIltyH9cQ8rZbIcrwp3biDynk471VrN+PAo0ct8Lr2f7PbpIy4qFsJsVwAKzitf/owv
 8Jux/+A4BtuL7WqTwI15JobtzRnwiKX6CvnGLD7jQ2ohTK8yem2G9HL1Gj8o3bAdsNe/FMJIBWg
 sIzUHxU2yjSewmhJMcV4PwI/Y+z3nUS02eQ1w/OlDvEpU2XfaqsD+NEPKKhcVbkrhZSHRO571dp
 8sfZ11TG 1uahJAA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

It was recently pointed out[1] that x86_64 brk entropy was not great,
and that on all architectures the brk can (when the random offset is 0)
be immediately adjacent to .bss, leaving no gap that could stop linear
overflows from the .bss. Address both issues.

-Kees

Link: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com [1]

Kees Cook (2):
  x86: Increase brk randomness entropy on x86_64
  binfmt_elf: Leave a gap between .bss and brk

 arch/x86/kernel/process.c | 5 ++++-
 fs/binfmt_elf.c           | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1


