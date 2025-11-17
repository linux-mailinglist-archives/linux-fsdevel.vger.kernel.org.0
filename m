Return-Path: <linux-fsdevel+bounces-68803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CBC6679F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 29F2929E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C134EEF4;
	Mon, 17 Nov 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+3ItJq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274D33123E
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419643; cv=none; b=eglOeY19oq0X/+eiNFt59EoNbvvr5syFUouzrHpMjlWC/rRQ2nW7MkDXQgNWycuS1iMBz4DrprJJUsZgU9jkqVHxN2arV1c0eLwP3SbvhJQHGBMrHcdleA8zlrwgcsUhaDacxluOtC33WyE0RMEOBjRv0qx1H/tM5nmBW1bwL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419643; c=relaxed/simple;
	bh=KTa8/7CrfmjBWMkUG3DA+uVzaVnpuiI3UNQUMiml6/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfrmegyQIzSEguyUoVcS7KH76xtk/ZTgHeHEcAhUQNSJ05aWbWmCB6S2jP8gyhbCyNmlcZmzDVwO2czfeqTqcIffReVJVnwUR81CqLMlpc63twtYpWSQDpM6o+hgiCMs32G6cTPkvL9b+cdvvnHinU/dWEcvKHEECyX7m0lD7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+3ItJq9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dabf9fd0so62472715ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763419641; x=1764024441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFDZWRBWGeSJJ18PHJTmScz5mdF08U3XJWNOIdU9ii8=;
        b=0+3ItJq9FyJ60mFUfdaAHLFMZp4mUxXRmD9kDWZrsb50+QOry00z3s+siHs0Vt2hpj
         fgFRC3Q8+5Uxdj1zSk7cfr27JlZGGb63SDxJBNBv4UaQmzPAM/uXGT/Q5U0zUnvzWB81
         BD65zN5NjxszyEuPJAVpHlxP3+rMENcdnScTd5ogAnKourgi0EXFAYRpmvBUsmIR+oWv
         KW1p7IscOEd+cs61raL7vQb6qsxYfrYLbb1Xfmegh2ia4eSjXndMVJtEFzFiA3htPRkF
         IkPc959Rhc55QTNMnmXf+1Jc8W+pS12R+6Y3bmSc55BcYsXKH8Kbg44XzpenbRe3Yn4B
         WnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419641; x=1764024441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFDZWRBWGeSJJ18PHJTmScz5mdF08U3XJWNOIdU9ii8=;
        b=PAjNe4SC8WlYOfCwOCmkgUDFpIEFNDuHHVXHEEkKsCI1KBY6B0PJzAihOTay/NaR1S
         iK5lNKdia/HsrKoI4yd6ICRvU+Ng7gDBbrWYqfZKo2N934R+PnKS0bbJbnnqY1oFGUYR
         YG1vPg7Hu1qsSPFZ6bHzAMGvyvmnmHLkaAQAZowxjGNZDlpXBS1WXhc76lQG1Kz1CGz+
         vFEwSudJainHxz9k6VucWlFaKWJZ/TODSNwe4U5LXRFOlBwCtSsKXOKzNv5dmoH3y+9s
         vMAzKereQZE0ciJZgRNP5mwk/F+Ic2rzpZ+nLRJV5zA7utTMjouf3zmq/Uyg6TwunpMW
         23Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWuBneVzkPKQJ+tR7cobtyRO3Wq72dwECoKDqpPA23KX4Gbkk2jl4HTwGbNtc/GzQeTC1C+G8P4Mx6RdUwY@vger.kernel.org
X-Gm-Message-State: AOJu0YyAm5SfVEv287QiYHchRXaVajsMpirYCAgKHUiMWJJiUHwCuQcl
	86FU1Ko2f9FC2knv84NPUHBbRZk6XuYeWwZk458QEuMrqAnmzUW2xAayIxZcqiIUbutdh4dUctM
	miIQRn2BhqPi02odBUCga7Zl6ow==
X-Google-Smtp-Source: AGHT+IFUtNOkJGI+3slVxFGeNNElaZyayySLSHWAkJnaSwQ34c9nCY94UPN7a599kL2+pa7XbABtWWuQu1NQqX5/mw==
X-Received: from plok14.prod.google.com ([2002:a17:903:3bce:b0:297:ecd0:777a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f78c:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2986a75010cmr143554585ad.47.1763419641381;
 Mon, 17 Nov 2025 14:47:21 -0800 (PST)
Date: Mon, 17 Nov 2025 14:47:01 -0800
In-Reply-To: <20251117224701.1279139-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117224701.1279139-5-ackerleytng@google.com>
Subject: [RFC PATCH 4/4] XArray: test: Increase split order test range in check_split()
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, vannapurve@google.com, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Expand the range of order values for check_split_1() from 2 *
XA_CHUNK_SHIFT to 4 * XA_CHUNK_SHIFT to test splitting beyond 2 levels.

Separate the loops for check_split_1() and check_split_2() calls, since
xas_try_split() does not yet support splitting beyond 2 levels.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/test_xarray.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 42626fb4dc0e..fbdf647e4ef8 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1905,12 +1905,16 @@ static noinline void check_split(struct xarray *xa)

 	XA_BUG_ON(xa, !xa_empty(xa));

-	for (order = 1; order < 2 * XA_CHUNK_SHIFT; order++) {
+	for (order = 1; order < 4 * XA_CHUNK_SHIFT; order++) {
 		for (new_order = 0; new_order < order; new_order++) {
 			check_split_1(xa, 0, order, new_order);
 			check_split_1(xa, 1UL << order, order, new_order);
 			check_split_1(xa, 3UL << order, order, new_order);
+		}
+	}

+	for (order = 1; order < 2 * XA_CHUNK_SHIFT; order++) {
+		for (new_order = 0; new_order < order; new_order++) {
 			check_split_2(xa, 0, order, new_order);
 			check_split_2(xa, 1UL << order, order, new_order);
 			check_split_2(xa, 3UL << order, order, new_order);
--
2.52.0.rc1.455.g30608eb744-goog

