Return-Path: <linux-fsdevel+bounces-63593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE0BC4EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FE9401428
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541025FA2D;
	Wed,  8 Oct 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpTP8yIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA526056C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927473; cv=none; b=rSWwQTaQMPUKuuZQiig1BYHNeeas692KPydA2zy+XMhhx9EptlO/8xhFCpphe8zxjlW6WnRbu2SP+ArYyRhlCVbdDMhjK1mRjBJI6GgloNE9IZKUqjZf36Z9tiBIrzbojkq1HtCkAfbvsY1CuWlq2ztSmj3KJ4TMezPxognccBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927473; c=relaxed/simple;
	bh=0FQzczq+XvPIcLSgmN3fW8/Mf+a99S5LM/p3VLvLUUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4xjhpz+gZjRypmZD9v/IZoZKCWXcuPBx16ijOCBWcTdkoKA/hUauBMbAulfr+CmGZz/03Og8GVvjWCB6KW6dDXZarDIhkIgH45yi56KDT5iz74JyjK1fBUGNPyN5ckPTLM3nnzSsB/N7wxEXUKN3CqWxbHzLVT+oOeapDoRrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpTP8yIZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759927470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTuvQMGGyHVj/GABY47oNzO2RJy8snMcE51C98ebSFA=;
	b=HpTP8yIZWcjqQI2KKV95aoP7teZ7uYi+Mt6IH60k5JUUgbvukdGgCs1Of8hCI8mGKNnvwe
	Kqizn8GI32rrXT1MgAtI2peVvbniX46PHCrLk9ctyVTObEu+gwplUnz9kgjihEeic1+6jC
	BBDzMGJMPzQK1vnGZF/X+8O5eGCGyUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-UStUJ8gHNnuqDWWyP3vFPw-1; Wed, 08 Oct 2025 08:44:28 -0400
X-MC-Unique: UStUJ8gHNnuqDWWyP3vFPw-1
X-Mimecast-MFC-AGG-ID: UStUJ8gHNnuqDWWyP3vFPw_1759927467
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee1317b132so4091372f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927467; x=1760532267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTuvQMGGyHVj/GABY47oNzO2RJy8snMcE51C98ebSFA=;
        b=ml7LpDieed+uqRUjGVORJFiDvHOVjFiSUXFthnonCtlAolFGCX9CCkkyH3c0G4+nQd
         +1WFqw0HDwryWhBe0HHxTBxllnra6kj/sKeKF6205/F0h8cf8MkeFTNG77t0uNuvoRXU
         YYyjymz0gPmkmayydN3Y9AADhQRR5G+F8ZltZnhw7o0SA01mOnGsUZgtcFPyViN5rTK7
         8I83F0L7WOxHbLocrnr/7o6tBG0lIL4+Viza9AnszqXSg0lnjm3+PI0+4X5yPNAsBxv2
         FQzBerdGzFSBGW2lBZJKNPdl9AFKWon/x1IZ8+zc05xh5DCEiijfy9NqvCfzlmjXc/TI
         vDzg==
X-Forwarded-Encrypted: i=1; AJvYcCV3z3B626Eky3ImGC7T0iIpzA9RAyfh2GKOl+SpqH6cK+bOExsN/OVJJULPMJ0N2Iq6YYcxn7u51qSeXJuV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46l67Asbz3zs1wfLklIqy3ue+VBeWQf4Jt021lz33XcKmDNf9
	t8ieP+Hn99P/5KVzxzuStciwKxpb2MEcZPgacLUP1ixmbN9orGZUIvH6LOj8mjEVw+o7AFqneL+
	+hW28yTPHnNl/zQz5q68Ze0bsOyjs1oTDS/gpExquW+kYqV8AurW0pe3Qu1AY02G7ZA==
X-Gm-Gg: ASbGnct32AOp6C5WteXI0QN5G4f4J1TjQXktPxja5cCydF0/Dr43kg+kaQyRQ7OsPI3
	hfr7Kz+hTfEH91wAqhxMqFYtJDXxex49u/qUI2ySNXUgDKI/0QDdHIUkFuM6jM7p5CHpe5QU6BQ
	OvCtCl4qGDAcAZoFk5WafZTvanBnFZHcjxk0XHwAZRb0qFR2wCzNKtDYsabnwordr3sSVUyz4D6
	XkAu/l8OYWsPgeyA5UXaCFjfQ2o5rJ2VukhSEPrmwa6KdKRKK2sfvF1IiN38sv2RnQAqSacU4ry
	eyzfgpiN2NgbG38GlRVx2H6Qrc5j4JdkBlrosaFl1jm9rr9BQBh+jE8bZRtNzbvdSu2oN9rx
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id 5b1f17b1804b1-46fa9af0621mr20360725e9.19.1759927467230;
        Wed, 08 Oct 2025 05:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUOOWjGZbNdj8gMQY80gtaJEpiEmEfUTkvwjILGRLj8xEez7HmT/bGwpHIikuJuXE2VGR3WQ==
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id 5b1f17b1804b1-46fa9af0621mr20360455e9.19.1759927466628;
        Wed, 08 Oct 2025 05:44:26 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d438fsm13918765e9.2.2025.10.08.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:44:23 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 08 Oct 2025 14:44:18 +0200
Subject: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
In-Reply-To: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
To: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=0FQzczq+XvPIcLSgmN3fW8/Mf+a99S5LM/p3VLvLUUI=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMp7FLGXrP8A6vbUxj0FJYk7QpN39id7xEkWd89QkI
 zpFkg//d+woZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkdJChv81zi23ZYUvSooz
 rV8jnbo2JlSBw+6ARlfjho/CMi9lDOQZ/unft+y8uohbU15J7LPhvrUve3LPuzVyGeXnnAn6cq/
 9HjcAeUxC6A==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These syscalls call to vfs_fileattr_get/set functions which return
ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
inode. For syscalls EOPNOTSUPP would be more appropriate return error.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 460b2dd21a85..5e3e2aba97b5 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	}
 
 	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error == -ENOIOCTLCMD)
+		error = -EOPNOTSUPP;
 	if (error)
 		return error;
 
@@ -483,6 +485,8 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	if (!error) {
 		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
 					 filepath.dentry, &fa);
+		if (error == -ENOIOCTLCMD)
+			error = -EOPNOTSUPP;
 		mnt_drop_write(filepath.mnt);
 	}
 

-- 
2.51.0


