Return-Path: <linux-fsdevel+bounces-73757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5647D1F8DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2876C30263C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B130E839;
	Wed, 14 Jan 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqjCmBrD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sb9jDr0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318430C353
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402441; cv=none; b=stctbMSA6IwBAPjIXN9fIndPgDYGGl1hCrvE5UDW7SBReZG2ARR4jwGSfD6FXz+rNCorhOqy/zJQgqOlA+H+G6h6jDd++g05t3xe7oy/vn9Uta5QJ1koYt4MrrI9oyrGkUqo3InClY95DVnRaemPK3ZNQSeIhNPlZGpFhE+cjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402441; c=relaxed/simple;
	bh=f0df0TjODpOhULZYSd2DSULVypu6W6WrXz23ZLX2Vqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvCYdD3beXzQhW9FFtLkfsRHUEUM4LBAM/0QQjOTBdg5PRhHB0f7ISc/etmJJ++SBY+bEFJ5me7rh2/5/R0KFyg6hU3IjnW41DFpryi9WaxSVKOwjFXmBLXsJWLlp4J9uKgYqnHn1W6wduKZBQtBxtEuFneKeh1EyZk5rDkNJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqjCmBrD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sb9jDr0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22n24Ca21rPEEnw4Dy/j53PTs9ZGPRbo0h2gU16pg6E=;
	b=PqjCmBrDrECQltBfGh0GyNcABOJtA2tZSEZdtOrYYf51yW8IZu5f1ZO+Tw7gn3Ctpcl8pg
	F6jjvPjHvhNeo8IhH5g5ZVQrbxmrey0ljGGlZwdwWgZXRSJ8xl8cmx2TprdXLRhw5d0DEo
	GcGz/8OwwLZ8XNzKCWHnmJ0uU7crCm8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-ZdE5ALQlNw6bIdDr75nOVQ-1; Wed, 14 Jan 2026 09:53:55 -0500
X-MC-Unique: ZdE5ALQlNw6bIdDr75nOVQ-1
X-Mimecast-MFC-AGG-ID: ZdE5ALQlNw6bIdDr75nOVQ_1768402434
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64b9ee8a07eso10165227a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402434; x=1769007234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22n24Ca21rPEEnw4Dy/j53PTs9ZGPRbo0h2gU16pg6E=;
        b=Sb9jDr0Cbm3c8CIYf11lGo5rxzY8EZuCR+wEAoOXrmzHMsP+TmF/xV+0tI6y1qQZPA
         +S5KftPn/kdDt08l/lvL8scEwI2dtWDElRruBjl1aF5OMd1Uzfvbt13JYHrH+iLxGP1i
         4of93OWGlnGIT35pcbt+NqsfaSn6Zwrwt6pk2pE7My5cp0ZH9XLvk4oMTqA4cn4Df0Wq
         zpADLEFMVWkYXjGgOHwxvxqvecorvgHG89bfqjyEXTOv1YLLtgEy8QZOp3PXWs7aJozb
         jHySLFevJxIFVsQOwdeLVMiyw1tbF+pZs8tMqQvIPX0yFVvIzy9xgrUd4+N04lNkCfDX
         EfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402434; x=1769007234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22n24Ca21rPEEnw4Dy/j53PTs9ZGPRbo0h2gU16pg6E=;
        b=mytYXIT/Fsxs4ViIa/sJ/nzKLs7ZjQ/luLp0/ozaYsV2/U+Bl5Y5p1l5ykmUo5rwpF
         tuWVMxE0pZ46KLDq2obtHcDhmdEIkxFCYfA6Rp9Lm0PQdVGaz3Pnhkb230EDXRxicqav
         f7o3su67cyAZUtgoJ5vbB8Jl4llfrLTHGVOjjHFebOK4jhgy+CgR4//X+C/nnlYTA6on
         F+s0Uj3AP4cm93W5XxI+/YAw1PbYofMOsdwefTXzN9dRINEO3nhGG7Jrcqj9U+8vdnPl
         RqtZGMpVq/66WpuZG21jYTT5DMXrZ46F99Wk2a1y+J43GJHLhvzOYsb/+1ioz0YXjyc6
         WTvg==
X-Gm-Message-State: AOJu0YzHUam6a7AMgkJ/uodmNnQUON5doN/Kp5yX/TV8/I10aiJ7Sk+J
	U3opFP7ewWFjOp5xaJxf0FyhCuWOsUQU+/NfhID+Pbbsw89xThKhkGqtyretZADGBBGrNp/d58M
	Jk2FCahaEz1Xd9B6F9Lr2jGoCwqLg/Ag5q81E00yYujHcVJXtuf1BYx88TZf4lF/M87dD8zsK5E
	hkWwDKBpqkz16yfV6jOb7HU5vhEc5gld/D4nR15bUIxkC2TbFkPAk=
X-Gm-Gg: AY/fxX4NsHinv6/OqNnokYcopm1JATO8++F4nW4AS63MggLokCSydLewU2EU8pc1wIZ
	y8TshPKvMXBa+iM6VbtnYD+tljzsxqVTlJqfQ4+VKl8RBLUsQ74yN7bTKpFuyOHMK0UVk1dqOM+
	xs3kdTvRdKtf3IVJVxsz1VNAygVM2lm70gG5JsBqy0bfXcqzj5tJUGtOp6PFDSQiX8LlHajbq4v
	y7LJipt6WFVjWTBxEm/iP+H1/3gFW6TW0EafGo2VyZ2hcqh9ghbiYERwPpfYKsmKR4VL+t6oPBX
	DnQHRaJnhsAF6WuTchuLsS+didkKwC7iagoSg/0FQo5rajXt7HacPJqFwX9+p9qnbkftjnqDGID
	CLo3+MRJcIXpA9OwQB2iSlQeq4gSBOCk+Ret4JJAwsfV6HOYIKGpfpMG7J68fYNXk
X-Received: by 2002:a05:6402:3487:b0:640:ef6e:e069 with SMTP id 4fb4d7f45d1cf-653ec0fadddmr1998141a12.1.1768402434066;
        Wed, 14 Jan 2026 06:53:54 -0800 (PST)
X-Received: by 2002:a05:6402:3487:b0:640:ef6e:e069 with SMTP id 4fb4d7f45d1cf-653ec0fadddmr1998118a12.1.1768402433522;
        Wed, 14 Jan 2026 06:53:53 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:53 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/6] vfs: document d_dispose_if_unused()
Date: Wed, 14 Jan 2026 15:53:43 +0100
Message-ID: <20260114145344.468856-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning about the danger of using this function without proper
locking preventing eviction.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/dcache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index dc2fff4811d1..66dd1bb830d1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1104,6 +1104,16 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	return de;
 }
 
+/**
+ * d_dispose_if_unused - move unreferenced dentries to shrink list
+ * @dentry: dentry in question
+ * @dispose: head of shrink list
+ *
+ * If dentry has no external references, move it to shrink list.
+ *
+ * NOTE!!! The caller is responsible for preventing eviction of the dentry by
+ * holding dentry->d_inode->i_lock or equivalent.
+ */
 void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
 {
 	spin_lock(&dentry->d_lock);
-- 
2.52.0


