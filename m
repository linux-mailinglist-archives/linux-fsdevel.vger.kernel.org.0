Return-Path: <linux-fsdevel+bounces-56170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBFCB1431C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CDE1637FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B827F011;
	Mon, 28 Jul 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrnQIyCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAD27CB0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734698; cv=none; b=XtDLAZGl72Iva3Jf1P3OJEIaSYR32v9ckQmHwjyl/xRgX6zvGGIj8ELQz9NOdrWvu9fGAUqCEXco074/9XgVcHy0YgtTGgDxz94H5GhQ4grlb+V28x9vW5seHmvdjBTjSvjL98dUA3y5OzcXXIVB/uVNZuDjcyZyx1BpaHZuWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734698; c=relaxed/simple;
	bh=tuQ8f/tR8bjNxLfdJGG+rXIm8Iltuw4mIWHpny+mKAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=fcBFw0yphWerBvemD6lcs/n+U+NkhdEqyOEX7zo2fzqv7zm9FzF55Y44RzGtgN6JWi46CnD4bzpDNb5WZVGzDTj4dx9WD27xh3K6npgoulgADPidUzYo5S7/6nGpHnbYrSGiz8gVtIdrNTvdTbEP6bASIBpyi6LSuwvDCR2ENm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrnQIyCJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhSSjYb+lsJdO2qb/nLz5H47+MobT7klHyOkyC/1bzQ=;
	b=IrnQIyCJqVTbqqlzPS2Ya+l7YckNrQ13UmMQuVqCRa8SSVY0GDDgr+oWuD6bB6AI7C2sd5
	xh/7e9Og0fR/hypkrNHlMxs+EVoO3BxlDaZK9I3jDoJulWQKj1+NSMy6L2NzBBtkHCXx1K
	THT0joUSerIUTopK+vaNKkdbh7oukMc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-0Jsj17FpONKbtbz-1UU9WA-1; Mon, 28 Jul 2025 16:31:32 -0400
X-MC-Unique: 0Jsj17FpONKbtbz-1UU9WA-1
X-Mimecast-MFC-AGG-ID: 0Jsj17FpONKbtbz-1UU9WA_1753734691
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6154cf8c32cso1050627a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734690; x=1754339490;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhSSjYb+lsJdO2qb/nLz5H47+MobT7klHyOkyC/1bzQ=;
        b=WlV3l7yylbwiNdlBVzbo5w280sihvm45cg9/QQ3wCROvDrJ3TbM5ZAfN+qYJLMJtkG
         Tsq1BbBm7YX1tmnVrChqKsmMVmV+bDYRYgzlKZARJAY1gz8D+iN8R4QveLAaknglsTPt
         9m0eitG7gQiB9RS8vnU6LyBiLPHdkNtj2lVGKfNluuqdf8yl8Csk2ooHmdFr7oOkD4sb
         IUbt5PzVtS0OqH3QYA7rGw7+dmZQnjp+CzT2A96IGvEX+m0vOzLRT9GKarCyI2FwIJlY
         EM8YBLZAUfmXMeY05rq+3fb7uhCZUuYxg9Lc2kNvBC980muDm6tG2zBQb8Mj6zZqguYE
         2LgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYqk91X3LJ8D8zcoqFdyWYWPUe8+qCBBOIPaXJWvZybxbOIpk9UiY04yGXS5NyLC9JgGVzn3PsNjBg2edg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4S9hcsFefhKg7F0GuWWPOf21awghr5+RP5DukXNV3Dqo+L6h
	QOK8APz6BwTU7LP7XsfyuDq2M7qbyfn6ebvnll3vjYLbkAxj9XgM8KIJX85kPGv4z/CehLlqj7w
	cgI6AI2d88MnJXl9pIfVKqPmOTnt/p8avX09WVVOB3bm8CzBdovS8HMyi2xfWBf6KtmYxe2I1lj
	yLzG5XXN3hwqRmVEhG35ZclioqlHEa16C5q/TrOlgqUtWLNV1h8A==
X-Gm-Gg: ASbGncuQhAA4uSMGC9LY9pPyyHuv9BpdG50zqgrDFDICYznnX094SFwSe8Mt6wI4CBs
	ZuuuD3zsVRAU/4N0Lz6PFMPRWW19436aF4C2QV/tZow+vFlhp0Ux/VKbfnnNqMU5PTAEw27xTxo
	97WqYBOzyoyATlxxv6UmKnOOfiwuaR0W42qo8+e5MB4V1GFL3MUfFDxdJLd3LRVOMNXcF6WGJfL
	uPmqJAK4DV5+s8NI4OUchsBZ19fxNDaqefPd88fFAvEIOsG+FUqN8nwLRDytNoE7yMxFpFsXR/9
	yURlA0KqfT+L9xzNUTKOcbhOqJkTMx2F6NqJcTYc4Mwwbw==
X-Received: by 2002:a05:6402:51cb:b0:612:b723:4d95 with SMTP id 4fb4d7f45d1cf-614f1f2e494mr11033338a12.30.1753734690346;
        Mon, 28 Jul 2025 13:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXBBqy/vXldtxYvrueHJwpZSvjKZbwQ5tpqwAu8FXFyHDjYlJYgONObn7uPdVanUULshRM+Q==
X-Received: by 2002:a05:6402:51cb:b0:612:b723:4d95 with SMTP id 4fb4d7f45d1cf-614f1f2e494mr11033310a12.30.1753734689864;
        Mon, 28 Jul 2025 13:31:29 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:29 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:13 +0200
Subject: [PATCH RFC 09/29] f2fs: use a per-superblock fsverity workqueue
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-9-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=x2fKAqj6yt8VbdL2CBtiIb5g4L/wAAI+BQgEGBHb3is=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrviU9w/cd0wMBlz8mjEoUXGhI+xnT1muzczC9Xc
 r5SfdImZ8GOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE9H+w/DPwCfpgdSX8PiN
 e6+ZROQZ9tyOVb66MuKFruz8jV1VC4tkGf7nfrzP47+oXuLCn38L324yOnHy1wvZTbMUfThP+Vz
 MsT3BCgB9sEqV
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Switch f2fs to use a per-sb fsverity workqueue instead of a systemwide
workqueue.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/f2fs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..043e76b8efae 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4634,6 +4634,17 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &f2fs_verityops;
+	/*
+	 * Use a high-priority workqueue to prioritize verification work, which
+	 * blocks reads from completing, over regular application tasks.
+	 *
+	 * For performance reasons, don't use an unbound workqueue.  Using an
+	 * unbound workqueue for crypto operations causes excessive scheduler
+	 * latency on ARM64.
+	 */
+	err = fsverity_init_wq(sb, WQ_HIGHPRI, num_online_cpus());
+	if (err)
+		goto free_bio_info;
 #endif
 	sb->s_xattr = f2fs_xattr_handlers;
 	sb->s_export_op = &f2fs_export_ops;

-- 
2.50.0


