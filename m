Return-Path: <linux-fsdevel+bounces-18675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88D8BB4A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5DC1C230A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 20:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E020158D98;
	Fri,  3 May 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NzJCjyfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25076158D78
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767389; cv=none; b=TvZAUZX5nlAC2owbazUiUa1Z0598RHW78t+STm75bh+gN/uRE3LG8uib0CzvGMSc7sZulssTNXr55SSn7ZPEBoXCArgkQZHEiWowQsF9NqvouIfAA89BMu9++ave1rl2zHcmQjZh937vWd11ciDGf4IREobi4LEVr9FRd6Z6MDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767389; c=relaxed/simple;
	bh=pf+pNFxmMm1HFvn7js6D1XqSBUysWOw89rU+1scNx50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OFlaJdRSJsfgyN+3RwadavYfk5rgtIraQwQaQ21d1s0McTHeB5ZHkn2i/wK3pw0mwK/esUv+kxkG7Hc8lFJN2UFxMgTK+STDZoIL2VRdPLLZajORftHLWSZ/LXRYfDXKDtrKKnsfh8f7PTxjbfBBUHMYkGF3+1KXCTMK1RcePSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NzJCjyfO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b338460546so83343a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714767387; x=1715372187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjXuBsA7zZ0oIxrlLeiGnoyK8wpbBUktncdxO0iL2YE=;
        b=NzJCjyfOflwbz9Z3Hp6sa2Ei3LrQrl0eEOMtuvg5lOnbLtM4zte7OjQ/W33RCI3QwK
         vg9hzdHLWRPC6zIG2NIv26mUMUgWlaD9a1F4qtgBT6fbIZzt+c/fHYfGo4kxAsZHXFAB
         2K1hVBIZ4nRbifi6uRXe8ZIfC/rXalGCtyF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767387; x=1715372187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjXuBsA7zZ0oIxrlLeiGnoyK8wpbBUktncdxO0iL2YE=;
        b=uXtgcdSBoCQUGtNEv7zcOWQlh0XVL7x6FqCzLvQIcAoC9OIodrmeodwaXK52uF98Sg
         /dcQSy5hsv8K6QYRzX8x+XX8TqsTIhuf17rlI7AjgigkOl1yn8gXpSnc441roatykb1l
         A7TkiNu/rvfdu2kNLv/tebsKjDLZD1kDz2/cx5er6CSU74nJGF0mgDN/wIF8Of6o9DiK
         L71Xw/O0Fw73iSGU9OLkPXcy8cJBo/IW5IG0ZktUZyT+e/ZZMWyUTQAM+TFmQOHd9X8m
         YaKjih4tM3pAVSXMJh73uob4mySwvt/b/AauxKhHeWOUPPTozlcuUB5ZSbik4L1o10XY
         zI2g==
X-Forwarded-Encrypted: i=1; AJvYcCX+tcMivQMCHtBS2YbSDykv0JovkMF/QN8xV9qjAFol5/+ofHNo3B8MDEmaeZQnW1ekLVhR2hUQdOjRJJJt87dZZQCL9CC8WWhpotMoHA==
X-Gm-Message-State: AOJu0Yx4ZgW1t44JeWy2oIKJyN3HSub85mghEN4gABl3QagMG7UusGvN
	D2fYT+dnwQ0Hd/fyp4Xc/KGoR+QJ4kGFRhR50VSqp5qS2EzCKsRFKk/qBdk8wQ==
X-Google-Smtp-Source: AGHT+IEAqfDwqCSvcN8OuGiJ0swOLO/fi75RqAG5LMAhNjNj16WfYkFbQ5AiOphfNtiKx6xIeY4mqQ==
X-Received: by 2002:a17:90b:886:b0:2b1:3cc7:ae83 with SMTP id bj6-20020a17090b088600b002b13cc7ae83mr3668935pjb.32.1714767387520;
        Fri, 03 May 2024 13:16:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gc19-20020a17090b311300b002b05e390c59sm3545286pjb.27.2024.05.03.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:16:27 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs: WARN when f_count resurrection is attempted
Date: Fri,  3 May 2024 13:16:25 -0700
Message-Id: <20240503201620.work.651-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=keescook@chromium.org;
 h=from:subject:message-id; bh=pf+pNFxmMm1HFvn7js6D1XqSBUysWOw89rU+1scNx50=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNUYZ53nnbAADcogtkELI+D9ycJdn+pb9aefol
 66UgNHNLRaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjVGGQAKCRCJcvTf3G3A
 JszHD/9djHZkCfUTJG1NBb3v6t6W29SB91Q2iuAlm76cE5d6kGsEagP3JkHy5CVPK+fB+YXCFAj
 3aDVoCAdyYlyA115UlUtIiPsA8u6bXNHzFHhPTqcPg6FwlpDiXHQ9Z0UifMo60EwUbulmSwNe5c
 ZgUTI5sWBFE64w4Ypz/qXYH+Q78dMwMwDP5PmkO8dQAxRVJc2PYxJ+g9CEKdKuq4Bm1SH21Ea+U
 Zs2uWdofnwqQvLVsl82EVnl/RPoYX1AJX4mtPDpMgL/n49+BUT88pTa2w0GIalXNsY0os9rfBBJ
 i6qNMChvDdenE3QpeMxmWLNlAdCA4dFYwnuqfVlb2Je8/4u6mXalIZiaUDVCpHqFBXuXjvnfW7I
 F9Cz9Ah80rLXmRNijfTMsB0u93V0diOciv/914qmiaukoJiAzOCNqoMncV/9dfLpsURf08oOy26
 yneYGRMD9FgEGxGvUPPR6Vw79tTtwB3/d6oIv0b9RzffmukU5v6qUP2MiAjSjcNmECVVuXsEbQt
 MmNztwez3USCFAZS2SY3Msz2alKSzLAmMJDYKmd/L4EZWZEplt7xOKc6rDjOiCVUD0C2HtlfICe
 46Kb98XHn1ZjswhLT2hykrtD2eVBkS7UGoSMKDxwM5fkmgXlhvFC3RY0njUjpOSM9JQq+b2Uc1X
 Wx/OMIJ EUHtkgQA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

It should never happen that get_file() is called on a file with
f_count equal to zero. If this happens, a use-after-free condition
has happened[1], and we need to attempt a best-effort reporting of
the situation to help find the root cause more easily. Additionally,
this serves as a data corruption indicator that system owners using
warn_limit or panic_on_warn would like to have detected.

Link: https://lore.kernel.org/lkml/7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com/ [1]
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..fa9ea5390f33 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1038,7 +1038,8 @@ struct file_handle {
 
 static inline struct file *get_file(struct file *f)
 {
-	atomic_long_inc(&f->f_count);
+	long prior = atomic_long_fetch_inc_relaxed(&f->f_count);
+	WARN_ONCE(!prior, "struct file::f_count incremented from zero; use-after-free condition present!\n");
 	return f;
 }
 
-- 
2.34.1


