Return-Path: <linux-fsdevel+bounces-22776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266AB91C11A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF75B2305A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0011C2336;
	Fri, 28 Jun 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPlgJA2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8D1C2329;
	Fri, 28 Jun 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585348; cv=none; b=a/hKt00L4W4C4Hm5wKnb+MOYKMNAbgeDBWmYi1Jxv0/ngxmoqdostdpxEVegnZEDaNa42b9F2nNG5OaTD4kmVJA1cxRYJ7B3+NgK6UqU/hArg90sg2UNzdTnh+5HNWSCFO+YQLf/x383ThiSj6shEgqdfpgwYcCLtxAba13wj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585348; c=relaxed/simple;
	bh=Gagml2vWKb4HTLerZRwBKq3Is+4TMHNPAjmAwDGGOrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRHreFnuGGPYAKfBy5toDMOj/PhGwbDgauj3Sh0Y0AtBOWruzbdgdPt/Qzwbo1F10ebxXvDYghgcZFlK5zkzehtxDZNp2sgx3z0ZY23/tw+/JJYZ8PiKsMsMfy2Ls9mWwzXyS1dSj4URRSUSvFIU7+j6K5qMnBpAybuqZO6JG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPlgJA2H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so4807345e9.1;
        Fri, 28 Jun 2024 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585345; x=1720190145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VCM3WkcoPjwO3U6PrjTKLd51325lQXJKBmY5RFuANs=;
        b=BPlgJA2HPk/CAE7n0ogEQTtxcf4DDNmw73ANJhdbsrXk83tC6okf80v9FYZCck2tfJ
         S0YeLQ0NwxqjIJFRfQa0opj1KsNUCi0JTccbuOWvO9vSX5cpSGAAAawiAAi8UPhqMfwC
         1kJGP8hv9gDPJXJMECg+OW/aw1todyYeyikscm9o+t0QET0ys8UlqccHn9TkvRt1zv61
         WuY4CkxKxRNPmOW1H1x8D6h/5u5cO8CHU4K9zw1kjqOp13QynoJMteuOcIRJBaHTMNES
         JVC5rR2luTwFu7kxR6FmEO97PgIEZGAb16tFsFV22pbRPfzUH3jyk99lZEp5IogclFuY
         11yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585345; x=1720190145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VCM3WkcoPjwO3U6PrjTKLd51325lQXJKBmY5RFuANs=;
        b=aPMYPWnG0JrNGL9g3kD64NjyTyxIQ6xok0gzxitAas29xYfBdzi4r9O/Ja3Z1GyTcK
         9kkKq9kyGtf7m6ua/nx+D0GEiJsfizhY27qCDhT+PrV4UIvQzn56CK5vxM0fjCaAHsoQ
         QGbPIPfwrmCWs+KhsIX4Wixj/ZhtP2aCDKZ7+DOdwnRtQohrnZDz07twyDUpZWJE06kg
         ijvEoSjTV0AH9P9Xiw+Zt2O0RKwSaDz/e0TSBGq2Tl6GI/gHS4LmZ9Yj/pmBBPty8Bt4
         7yoOPxQ0xrNvkWHW9IN8olSkliISqkYsAy1eB4MWRUlaoNJTa8RY/LVBq/2rCwnb+mCE
         IvOw==
X-Forwarded-Encrypted: i=1; AJvYcCWhUhKIWITkkLja6Mwiol/ixZMSUm3XHuX74J0TK9Awg447wNKHHvZCqlU68SAD/sddl8gj2WBVZRzFx7LIq6otjFSIH8+KqMpl2M+x
X-Gm-Message-State: AOJu0YwWRrOImZ8vBBubsSSKC+YZtuqqiXdm69C+0DFY20zHSLT1yLuK
	4qfc2pTB4BykAxW99TzBi/eWtp4haDFV7S9wPYv7f9FgfSBP0LUt
X-Google-Smtp-Source: AGHT+IG+GT7vM/vuCP4Ik73lva+ehQFqIN8obARO7xTMmlpMIbkWtm6BmGJCs2S1YQbgjFGCpfZfTw==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id 5b1f17b1804b1-4248cc18101mr133385125e9.2.1719585345445;
        Fri, 28 Jun 2024 07:35:45 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm38985485e9.9.2024.06.28.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:35:44 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH v2 5/7] MAINTAINERS: Add entry for new VMA files
Date: Fri, 28 Jun 2024 15:35:26 +0100
Message-ID: <0319419d965adc03bf22fee66e39244fc3d65528.1719584707.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719584707.git.lstoakes@gmail.com>
References: <cover.1719584707.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vma files contain logic split from mmap.c for the most part and are all
relevant to VMA logic, so maintain the same reviewers for both.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 098d214f78d9..0847cb5903ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/
 
+VMA
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lstoakes@gmail.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.45.1


