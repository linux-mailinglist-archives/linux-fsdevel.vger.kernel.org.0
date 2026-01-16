Return-Path: <linux-fsdevel+bounces-74267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DBBD38A33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687EB30ABC71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435119E968;
	Fri, 16 Jan 2026 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYM4mB74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4930BB89
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606297; cv=none; b=XtEUdm8acoVM1JiueMVVSw0BkVpwpNh3FP/frJNdfGfLPmWAOj9bBqULUZuZklWeazc8a7nOb0mLZTmFbOUe8PRSaWESPjEgiulpJWc/8s5F3/7Nl+07kAJMLSLOVBY/JMZisUZZvYLWYPyV49rOL/KViEdv7aC5k9dVXmqCkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606297; c=relaxed/simple;
	bh=JXMvn1NMlj4tmOrWG0zkpmdnP/Xw/eEoEIkqSGKLsO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arLCe27Krh4f32MnPB7GJJBjFdQwVF182etXpXiPUDtV+8INWDLd55G0DKv6WHN5LWjDoKJZI8dxb6brIynOWuvSQn5i8dSHZUlOTULobvGA3cpehKhk/Z0trvhW3rcx+Fe9IZds0QDujFKPBAIpYHFVTvuFYCVOlN5hgc50Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYM4mB74; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso16585475ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606296; x=1769211096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO1WrE07m4/ps4EUGl0M4D/d+Qo8L6vNQWiuLZIYXDo=;
        b=IYM4mB74hhsOe0y0F2hTxPavYo1kX3x20sSsQ6f4y+pAMTTchN6qMVjPenhhOsnYyl
         e67zqtnYFU2eac5pu672/rRp5Cr0x9Dcp3EWvAjCqSGywu2nS9wZuaJ+PYJH+8PsgBA3
         vQ+qfWm4r/uFs/6jZIEvxR008BT1OKZFCcbGVq3ZszNYXeYV4p5A8EOr24GVlBvmdjk2
         bZP1h0tBgwqQF4zNAYmcXs9hntyvgnagO0Ozbr8eimrOoJMg/xBeZS39U99ciDlVmSIr
         lQbUXl1qXnO3TggDQz2hCOTXbQmxq+Cc4+MKjVqBYi0j1oYQwh5VAXc5hMmcZ122z0NO
         nyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606296; x=1769211096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO1WrE07m4/ps4EUGl0M4D/d+Qo8L6vNQWiuLZIYXDo=;
        b=Z4h2WBcamu1aWCKnCmC89T45kYsSD91f/tdBMkvaoPQiNSP7Ecb/g6G5Kmm14n/Qe2
         54f4PiMSjDRt/VP/bnRnetLJbwNQD/SyOL1JmeWAlNVDuEHKGgSrP8FtoG8XbPp8LUGn
         VQEjvdG+teHXC4rWv49R04WPMGqGgEHUi+tGlrQA5/1Q25W2ZLJdLpzuqlrE0CysvLGO
         cnoWZ7O5UwQb+05/+LHpj36JnfGnqz80Nyarp+XKHKikmAxbyf4r0i7TTADGn58oxXzp
         ujEZqm2pDXhCHUlHHt4DuEVPGGlGlKjDGuksMYJy2fvy9bh9VmI6TAmt1zXFt/4V8Xij
         Adfg==
X-Forwarded-Encrypted: i=1; AJvYcCWvqHMyFV0Axm1ttaxv+fz8nmeKiQZU9GhsdSsiXBsPB3co/U1ItTlVboPUKHT6tJvi2qFMrSjkg4rQ3tJB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv11K8M+VZ0ZRgGQEkhs/qKsgOqmikNNjsMtBBOT1yl+G/XqvQ
	O0FTmvTHoEfmv3Xhb7ZUhYXTs7yMVMOSvrQ/l44yBEuJr79VyF9j/0cn
X-Gm-Gg: AY/fxX4HZ+qfBMOtZZn8+vY/5plA7j3EXL2UdtNktjC+6kKCm7HggUP6DAKfplFNSbL
	qJGk+r3riC0tZ5JsN8tNf66M31iDxGqQZsZM1AiWXkQAOO9SNp0RpfYgxsrEJaE74cK6SZOwTTH
	imDXSNa+RyxI7FxroDihkTf9lJ4SbAteheKdYLY0ulEhDxTarTJTr57MQd0J1eIGg92IJAmkPHT
	rF0K9Mu+b9T33e3Va80L6v6dLTbFVZ5COwskQdGPVkf9qQ273OvMO9Rd56GHopKWVyVq2IqYTzd
	+pWCYDHOGxBxuey49Cnuxbj/36ZI38xrYh264f8scXs26wJQqaYLhf3KeUsEZMj4ZW6FJAAGqHu
	djRP1v6TddRJ+z1K0Uf7Wb7NQlBpNI80S3tSJuGUcw22iTJvAx9JRuvT8ZzzpLbq0auCKMyScS/
	XCD2U4lQ==
X-Received: by 2002:a17:903:2f8a:b0:2a2:f0cb:dfa2 with SMTP id d9443c01a7336-2a71754509fmr42826345ad.13.1768606295822;
        Fri, 16 Jan 2026 15:31:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce4dfsm30060265ad.29.2026.01.16.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:35 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 18/25] fuse: support buffer copying for kernel addresses
Date: Fri, 16 Jan 2026 15:30:37 -0800
Message-ID: <20260116233044.1532965-19-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory patch needed to support kernel-managed ring
buffers in fuse-over-io-uring. For kernel-managed ring buffers, we get
the vmapped address of the buffer which we can directly use.

Currently, buffer copying in fuse only supports extracting underlying
pages from an iov iter and kmapping them. This commit allows buffer
copying to work directly on a kaddr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c        | 23 +++++++++++++++++------
 fs/fuse/fuse_dev_i.h |  7 ++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..ceb5d6a553c0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 /* Unmap and put previous page of userspace buffer */
 void fuse_copy_finish(struct fuse_copy_state *cs)
 {
+	if (cs->is_kaddr)
+		return;
+
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
 
@@ -873,6 +876,9 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 	struct page *page;
 	int err;
 
+	if (cs->is_kaddr)
+		return 0;
+
 	err = unlock_request(cs->req);
 	if (err)
 		return err;
@@ -931,15 +937,20 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
 	if (val) {
-		void *pgaddr = kmap_local_page(cs->pg);
-		void *buf = pgaddr + cs->offset;
+		void *pgaddr, *buf;
+		if (!cs->is_kaddr) {
+			pgaddr = kmap_local_page(cs->pg);
+			buf = pgaddr + cs->offset;
+		} else {
+			buf = cs->kaddr + cs->offset;
+		}
 
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
 			memcpy(*val, buf, ncpy);
-
-		kunmap_local(pgaddr);
+		if (!cs->is_kaddr)
+			kunmap_local(pgaddr);
 		*val += ncpy;
 	}
 	*size -= ncpy;
@@ -1127,7 +1138,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 	}
 
 	while (count) {
-		if (cs->write && cs->pipebufs && folio) {
+		if (cs->write && cs->pipebufs && folio && !cs->is_kaddr) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
 			 * copy user pages.
@@ -1139,7 +1150,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 			} else {
 				return fuse_ref_folio(cs, folio, offset, count);
 			}
-		} else if (!cs->len) {
+		} else if (!cs->len && !cs->is_kaddr) {
 			if (cs->move_folios && folio &&
 			    offset == 0 && count == size) {
 				err = fuse_try_move_folio(cs, foliop);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..aa1d25421054 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -28,12 +28,17 @@ struct fuse_copy_state {
 	struct pipe_buffer *currbuf;
 	struct pipe_inode_info *pipe;
 	unsigned long nr_segs;
-	struct page *pg;
+	union {
+		struct page *pg;
+		void *kaddr;
+	};
 	unsigned int len;
 	unsigned int offset;
 	bool write:1;
 	bool move_folios:1;
 	bool is_uring:1;
+	/* if set, use kaddr; otherwise use pg */
+	bool is_kaddr:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
-- 
2.47.3


