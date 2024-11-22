Return-Path: <linux-fsdevel+bounces-35620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006149D664E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DA2160E3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761311CB528;
	Fri, 22 Nov 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+HsX4q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31518A94C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317871; cv=none; b=nkpu0cFNXyuzCrogaCuRqekssdst8Ino/SZp0/7yneF+pyCnEZsdH3EvVvJO7pVjuysj/1fU+c4XyX3VKD12IHub4o8agsIhSMX3RJJ3F9cjQl0vnRpxh0PWb5CZaXE2tyvdyJcmUJmKMypj9rnEFPIVpv2EeHX2lNUklaqK0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317871; c=relaxed/simple;
	bh=IVpGLtzMb4kNKP9bQAnrKqlOV5ZZtfVQVvyUBCZQ4Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2vYFpbj7kbnS29px/gqRqGgbEYd9UEv7GWnK/70WbrhEKdwpZ2Cdk2afBGSGpjS3XruiRn/QrPs5A2pTHkSNo9MQKzgQHKnKdOpr2lOLJQiDY+o/KWrpiN8BE6kvC9XwLmyXnD3VaI4MqfU+HcrCcf3zNsEZAv9xMXPZupSe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+HsX4q9; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e38b425ce60so2288729276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732317869; x=1732922669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEBVGrksPHjOfc4WHY5YwyTpscFate/a4s+cTyDDYoU=;
        b=G+HsX4q9AXZZUaqqH0Jw2O6e/BvCAWU0gQXqrFwfGll+HlPIjCXGCiy/dR7BiWdl6Z
         0ACMEMwt4+ge2ufiaYm8C38xfsBPmVZApqbkjqIPh5vCChMKza/xE+oYKhG6qPjauQ2m
         F/7myQKVUJQce1ED0//96hgPCNQEzpiWsIFdBp6jwgI3GuWNj4vusEtthLeLrrQcOXYp
         vcS6KhupNNhO+FZHD4Hc0cr22NoiFiyAW7u8JPS3urMkdG057ThaXj7E+qO2e7ayooqq
         QVw65FuNjbE1qsAM8RSl+ULhcWxHTGxf5PHtPUg4N8QR4WMShl/rQ1iPhcdw14pyIkES
         GNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732317869; x=1732922669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEBVGrksPHjOfc4WHY5YwyTpscFate/a4s+cTyDDYoU=;
        b=brs5rvBbrfVmdwhmvHY5a+ibYhzceGqfiELzMtGaUF4ZlrMHmXUi73LkrtevvGUnEg
         o60bNjpTeQJAap3xU0/uYuV4lIhgHf9Pt/S43cJxjYA7ZeUWPv/UNallTIEQpzVRUqX0
         AAMnTuhoLyriWSE7VK/p2z/+5WZOQ8D3tsO4/GlnxntwqDO+YpS5YpFHHsoDU93xppOD
         ZZIGbsLVsFe0lcDLEqzAv+EseMhXbEoyluwKZII7M3lQXR9sXWBLhzBW1j65ed7+spJF
         c6i154R1FGhFWxDiLSdibiAIYenGm/V28snqjIOu78s0fzQmlgxc/FK1rhG1F/SwY972
         PU8A==
X-Forwarded-Encrypted: i=1; AJvYcCU9U2JUrpv8V8SL/pCuJUa0m+Fq+BmQfPHR+nAB1OzYHeyV72e0oosIiyilNbc/i+APoUuFQi1r9dr6vUqi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzor1NaDxx2WWobTcSFjr3qZJul+LBUJEeu2CeHtCR7dZaYhJR
	w5A65H9qCHtM0XL7w7zY6izWquQR4PjEh9Jrb1h1rjT6ktq661G2
X-Gm-Gg: ASbGncslRqMDnHJwFNkSDcQm0tgRfd2IMV84PyjiEVfUIQKsaFpNlL/lWSpzhuW8CxY
	/Gzg2Fbe3H8r2h0ayJ2S095DptaeFkWnq8sfqS1CqmOpYRAVoHC7thkF/WRisWJN/xZk9Kls0eD
	5drwv9XP5HkgymSvH4FF4phWSzgtu9xOfp1oqEL+k7Hr7+/zXuIrzyV16qfYmneQTRkhXH5ZUov
	5fZXOktrUBq/fb3R0WgBzHiMwlzxgMZBWnauYcRbADXTioWGcR1c+WSKkNeWziX+qiMMuV4sZfm
	tM48Kr3TNQ==
X-Google-Smtp-Source: AGHT+IFqmAlC0SDQCwdmjhSHUlnQkK2XB4yL/Hv+xmhGPIMjC7dibMuwLQyjuqRbligoAGkvKR8vfw==
X-Received: by 2002:a25:720b:0:b0:e38:85ec:9f28 with SMTP id 3f1490d57ef6-e38e182add6mr8426271276.25.1732317869472;
        Fri, 22 Nov 2024 15:24:29 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f609c74esm874073276.35.2024.11.22.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 15:24:29 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback with AS_WRITEBACK_INDETERMINATE mappings
Date: Fri, 22 Nov 2024 15:23:58 -0800
Message-ID: <20241122232359.429647-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122232359.429647-1-joannelkoong@gmail.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
writeback may take an indeterminate amount of time to complete, and
waits may get stuck.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..fe73284e5246 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		 */
 		switch (mode) {
 		case MIGRATE_SYNC:
-			break;
+			if (!src->mapping ||
+			    !mapping_writeback_indeterminate(src->mapping))
+				break;
+			fallthrough;
 		default:
 			rc = -EBUSY;
 			goto out;
-- 
2.43.5


