Return-Path: <linux-fsdevel+bounces-33986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D469C12CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033B21C227A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556531F6673;
	Thu,  7 Nov 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmD6uMax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F11F4273
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023797; cv=none; b=dul3dXFB6GPy0LUjU6vgG3gi2KOubXl+KXKmhfFuTVGnX1YbW8Vsnl0hiTJqZL08bj+WXEJwyK4bSh+7h9Y/rHok17HAlTF3PeYinIrtf6ObAKGAxHuFVJtXfJPQ2tp/sgmgyPr/pOXy5KZf5laIFq2kTMcT0vulxF3IqXq2nM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023797; c=relaxed/simple;
	bh=TkAFk54d4ZFvcKTSnxnBXeZtlkayKYj0HI4okcukWRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlr39GzBJbPMmNApZsKzflKzl8ndDxrCcHhtGs6EhJlSxYzvlu/R/ooxRzhlv30oq0raKOniwUT1Rqk/BF5MPSD/g5ZayTVDyJwz/RMKLN+NIAiueHAA34EXvOGJ6CI0TiSzzl5eR0sok+SRFKIGFY9ivOvYqXJuIUao2c7mEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmD6uMax; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2e444e355fso2178798276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023795; x=1731628595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr8JpF5lWbeUzT238/bHr55gxwNV9GQSeDBdKh6actU=;
        b=ZmD6uMaxiXk4YDZbSTNvQLQyVABeV4CY60Vb5uK5eFl8XJXpvfKUz/VM3mIudPvWTf
         ye75rSlanh4sYBHjUB8OYakvYneygMxlWhqhmrUYGrKRQwlvD9rPy+gmslsSWYqrjaSl
         HGd5a5V+7BPPXAXCNBBTWEI+VX8810k22MTAYovMqWN6SOOp4vVowh/Oyf3lNSuWr0IY
         B21rfPvNuYRHZfHlWIyZjoU+hxwURNBSQN/pMLK3la9Z3S/fsAyfOh5ZJMCpfeA8Ys9k
         tDo+tXybg3MDZGoX3SX5g/5BMtUVP5vqR0o2ZH7A2n9raxkcUTM+cnFvlWIv2cRTf7ll
         0I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023795; x=1731628595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr8JpF5lWbeUzT238/bHr55gxwNV9GQSeDBdKh6actU=;
        b=QJM7ZCSpGteGLVWIQoHRB3IlCzNCf/OQ3u8uJkRQuRoJBDjGz+DHQlo2Gozc8lEsHm
         Uvb/axZ+dqDV/1rIco6VVENS7ExMBWLU9dD2fTViUf/Wlarvd06bichYwATivo+zfRfO
         iL6s3dyYrlTmSpy1vY3mwU6t+1L4xnjWNHqo+FcNxesdlpM0VMtV0ceY0UeHc5BqAsKl
         UQMvaC/hpre6+ECm6ULPseFQTwQEp3g/SGPdDtjGHm0AXFamzDKKRw4X+1cTMlB9dkMk
         CHHmeY5lB8hHSw4ac46aA+PG9id3fPnAoAputAn3SrAcQNlH993zTG0tp3ce+KLCY5EO
         +sow==
X-Forwarded-Encrypted: i=1; AJvYcCVuylfvzELyJa1Wy7HcvakzG1SouQVk7yaJTeCqzK6abBsE4Foum/xuCU/9pslPaD94FHBWuLG9HoV/wQFy@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2fF03OVrJJL6xekKOmLvYdRToG51IxkIzYb2057B8bQNnO+4
	+ZIDqAKd6hnOWEV+jTcwY3499/0f4SzrVlStgTrGJIi3B1ljxQ9PQLU4sQ==
X-Google-Smtp-Source: AGHT+IGOIT3+Xy+DzAbYdTcJrTAKRDTg3sonybdp7wxjtEbgM1bVGNx6YfgaqkWqC5P3MjLQHVppoA==
X-Received: by 2002:a05:690c:d8f:b0:6e3:ceb:9e5c with SMTP id 00721157ae682-6eade52f876mr6909907b3.17.1731023795158;
        Thu, 07 Nov 2024 15:56:35 -0800 (PST)
Received: from localhost (fwdproxy-nha-014.fbsv.net. [2a03:2880:25ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb96901sm4840707b3.131.2024.11.07.15.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:56:34 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v4 5/6] mm/migrate: skip migrating folios under writeback with AS_WRITEBACK_MAY_BLOCK mappings
Date: Thu,  7 Nov 2024 15:56:13 -0800
Message-ID: <20241107235614.3637221-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107235614.3637221-1-joannelkoong@gmail.com>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
it is under writeback and has the AS_WRITEBACK_MAY_BLOCK flag set on its
mapping. If the AS_WRITEBACK_MAY_BLOCK flag is set on the mapping, the
writeback may take an indeterminate amount of time to complete, so we
should not wait.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..1d038a4202ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		 */
 		switch (mode) {
 		case MIGRATE_SYNC:
-			break;
+			if (!src->mapping ||
+			    !mapping_writeback_may_block(src->mapping))
+				break;
+			fallthrough;
 		default:
 			rc = -EBUSY;
 			goto out;
-- 
2.43.5


