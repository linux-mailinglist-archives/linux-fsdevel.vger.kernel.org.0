Return-Path: <linux-fsdevel+bounces-39897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA9A19C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D9B7A55BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8873597C;
	Thu, 23 Jan 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bci4Lhnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F735965
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595697; cv=none; b=PUOFHsvF+Dt7pkI3YZ4jJTBO91sdEuJ22m31RngoZY2XydRYSHObx2fsn/XZtAw5xfRE6dzYixKTnSlq6FI1oV7oaawuafJq7WDapATQzV+1sdL/R7CJDolDFZvprP0UHzTQMj9Tr3uRAqlImEsqKEJNcMO5S30RS3gIfy9h2pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595697; c=relaxed/simple;
	bh=OC1GiSYAhZrmdt1mSJtRgFpEf8qJsyucTFbQC12omhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhEC77oYBfuVhILbJsvIIgankYPqMHnRIfOEkR6mxW82wE4RnErsAXBqsWxHQCahcyDze/fb6y27VdfSJdOGmW18/dAopX5lZyDYYDSPzkTATaYjDjQlj+SL3bJuLv0CJGFVi2TivGNb4v/Qe9ZTF5YgC1JgbNpuS2MVVv1LHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bci4Lhnh; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so637220276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595695; x=1738200495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAl903GvphXE8ZPhGxZFfsYEx8X+yFUAB23raLOcIek=;
        b=Bci4LhnhTvUEZVcP/SYfUQGMr2xJwLIWqnqbq9klTz2SA4sqydIQIaNAZc+uRrtq4j
         1eZTijEV3opS0k12KWOL/vusDGoA3k0LFGaxbuL7+j5tF4I421hWpCSjgqwJKHKp2afg
         WRSmizI2BfdgjQLZdE+7LCzAWq2rQZ1a2LGXwULt7iAkXlbBEn6t/CfmEwPuNlcokhB8
         a6sU1FXYsjDKHn5J7orjPTJLAxiWxIQ4BqCK+Kr8/IMo9QOpz3XAHvD3g2iYGRsdAWpi
         xOakoZm39qLud/cr81YEQ0MfqJHotwHHvbDIl7GhPnHrSV6MckF7RIldeFwbY6rsQ5Nv
         0StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595695; x=1738200495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAl903GvphXE8ZPhGxZFfsYEx8X+yFUAB23raLOcIek=;
        b=bh0bw1zav0QFszaqjtKfTKhRmoU7JLVZXUfHYSn27A6U5jeocNqvYRzQ7/cLWGWm+c
         mULqqiZiYARYKRwmT2V9AcfX87xPigb7ZzTUFJfehfmprVYKi1GUq0OCZJ8tgrUJPsmO
         e98ebpciDjP7v6J3SKhfvKvs9vLFXXWDkAf2vOq/RYdKws1gIN0d/FfyyGWm3/pQcBoY
         FCkaD0K2luc5XegyR20q0Ww5psQlOw5reJZdbcq+VU+fh5bYrawj7OobwyD+euIy5JMb
         KdHo5XRBQuAvxCoOlVm905//Aif/2HSVT7PZQcLvwwoz06XMUhxDit6Utt3j/x/uvgan
         iSgA==
X-Forwarded-Encrypted: i=1; AJvYcCW9T8FHedk33YDWsz2L1xUKpJMQ0YO3Lk7Zi6+ILw7lanFu6LExrtYZuz4Ea1MJCwtbYpvvBFKbFR+96t8A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Gp4Xer978O8YCaJIBDdTB8e3QShUr9imYmkNbDdzSUgknlMv
	m4uOIjnf1Xq0eE0OAKpQLdu9dBWAkGLWDZRr/bTaSvgq/LqXjSm6
X-Gm-Gg: ASbGnctVG3MO2s1qhX84CavCdG5vOmTqFgJpjHWNPDkLsJO4fNxtrjZWik7fB2+bXtd
	NEBZwteBmUbRi4i0XCzhWM5Y8Gt4LflJ8ggXty3RUFmUtA/nSTWm46kefe4++3TxGxEqTVuRmlb
	pFr2UUGAyyAgUk5ZD0weBKaC5xw4NzyYV0UexGqkKZHTFx9OHHR/I4jjJmryuD3+cJl1qa2htSO
	n42jpbuDAAqz6LyYh4DmZkzww7BEsTECaS2/igTLXB3I7omiY8PsHSpWsyGHAfFZ1VDkU43E7on
	ics=
X-Google-Smtp-Source: AGHT+IGBVYXlE5eM/qcOklOHgbbbf1RCNia97cDi/1CrxVbNar5at6TKKb+z49JGG+1P+zwW8E3ttg==
X-Received: by 2002:a05:690c:680a:b0:6ef:6ba2:e851 with SMTP id 00721157ae682-6f6eb671d77mr183555737b3.12.1737595695127;
        Wed, 22 Jan 2025 17:28:15 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66fa22bsm22194397b3.110.2025.01.22.17.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:14 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 08/10] fuse: support large folios for queued writes
Date: Wed, 22 Jan 2025 17:24:46 -0800
Message-ID: <20250123012448.2479372-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for queued writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89ca6ac49187..a178aee87e74 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1876,11 +1876,14 @@ __acquires(fi->lock)
 {
 	struct fuse_writepage_args *aux, *next;
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
+	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
-	struct fuse_args *args = &wpa->ia.ap.args;
-	/* Currently, all folios in FUSE are one page */
-	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
-	int err;
+	struct fuse_args *args = &ap->args;
+	__u64 data_size = 0;
+	int err, i;
+
+	for (i = 0; i < ap->num_folios; i++)
+		data_size += ap->descs[i].length;
 
 	fi->writectr++;
 	if (inarg->offset + data_size <= size) {
-- 
2.43.5


