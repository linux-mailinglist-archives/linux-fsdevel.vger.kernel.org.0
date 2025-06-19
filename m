Return-Path: <linux-fsdevel+bounces-52229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F78AE0549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E22171739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C007022F77A;
	Thu, 19 Jun 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MduUsCsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C22222C3;
	Thu, 19 Jun 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335425; cv=none; b=TG2kC8LMlHSoeCnD26+uM/9VM0gqX/zyC8TS97yUC3tdCdRllgbX+9uAPfdoslAKn9bndfD+6kT8HsJ1LGtBX7ssRc3Lro7CHQzJUNRuF3k/g4jqOO25T6ZcVEITdh07YmQzSLUcyt+oUEyzgWdeeVW1HYaLGC7FzfR3oCepGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335425; c=relaxed/simple;
	bh=rdGF6VJkcw9X2DRx896iss7YrlAfYC71roWFecu+XZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMnYTI3Lz4QIJJ2t+UBaWOWgVCSRmZvajcHQX8H4vcDadyDGDiOoSyRh4ltEQBO+Y2Ptmy3tgeIhO8mf9E7K5oUU5i82teedjXjXs9xcT2DnSOkcHpizTwYszN7SvRR14lUxG0bWYzCjyw+TVWZntEMEwBHiXwjcpv90PYtSV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MduUsCsq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso890573b3a.0;
        Thu, 19 Jun 2025 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335423; x=1750940223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+HaGzP6lmIJBRwqqaUMOnA43WMQxxygiHyZNWqGWT4=;
        b=MduUsCsqKaXlFNLDuyB74vBKyztfJaaePrwf83HbB4aZYK6m7NTNysWnFGuVxLSrAj
         gUktNzyb1n+tFHZysSuZ4U3Kvvr8Au7u5fT4kblAzDR/NeeOsxgND8VSsvFCC+v+SUvZ
         gn+B0ITi8tv0I/1TsLrExjGdYsz/N8HGFbTgop7hzq8uTS06WG3iI85eW5KpkO/MrqPU
         wdbNsnniaPj6LG/yVu0gQwAsvKXhlEyuT1/cRcdmBoZ+rYdJ8qL2OXp50OJbZig1QwVD
         dcuuJEqiv1IAXKoJH+vr+aqLUYWKgG7rnO+Nl2hdNzDANBDW4vD7x3VCOMuydZZra0yQ
         lAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335423; x=1750940223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+HaGzP6lmIJBRwqqaUMOnA43WMQxxygiHyZNWqGWT4=;
        b=KgjvYyxNm7qp5AVxzlqHhl2YHTsdGFcVMGpqQ/bfVQMj6usD6zifnwsEV4f0GyqcKO
         btSFpTnpFdZ7VGVF2Q2wpWKJJcSQQt4g+B9P02vsrG9l0dxbONCqlmyXWA8XMAXc89zJ
         bC0zDJAuM/N5FM7DwrOs8wChJdJYuI36W/15x3daa2rYgNbwEfBPXofWya6lMPUPu1pY
         GDTLBw30kv3bJTybpFjmT/i46Eh2V/tuORp6ckRJTn8DUUdYHl/wNzNZCmf7w51a6V5t
         ZOWIZ7T9Gvzk+EY0ISggYNqqd3+Hu9FNva36DM72Vzkc1N7Gs8w0NRQ1TaZE3W8bmmpa
         XvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG9HBAUToj53HD9V5eJltj4TyBvHzxoq5sWtkxdz2L6E4/ykzpyH/Tvhj97FPqbH2NVfZbFuPdDekM3qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9ek+SpNClEU8KSFlETCTbg6y906ZSIv7YlFsiAb6miAgRacf
	K+Q7Zlg/mUEHMlEaS4WZ2KND8O9CdzUqtk3ocqwJkhiS3qh5edSIsYEP
X-Gm-Gg: ASbGncs6UP69M+HEah4sS2ZnjlnANaBgEIudApmXyZU0WPWGUe0p7q4JUFZ7RE8wuVP
	RLHlnNL9lu31IrDAhR0xC2DD1hxfQ0EEflmUj+TUeFIpQqwp2i7wkXui+wU4WaZbNVtQOkkjPJD
	F76DWpCg3lPk71HOHm57NLmcgy0tXXEsn27A1aUd3irV41W+xCB3oY6OHvRyrAWgAQlvOUipbM0
	Z9vO5bo3Jdh0Z0MGQkdVoWw6aCKsU3jvVonh6I6dczD79qjZd/1ewIGzjXgv5UsCVgvSetFgw7f
	d+QE+FRDRntIFk74Mv/I6Z2Up7Fd8dvkzEIiPxMZghCDqathI8syD2vY01sRkRhqlkhbjK6Zsm5
	688AbJReaSN2WdflXg79M
X-Google-Smtp-Source: AGHT+IGF0m9g+dKRp/zj+sv1IMMTa7YfXintMgX2N5TSQkjJnG1bw7LH1I70Vh9RPvjvZpguzWHcvg==
X-Received: by 2002:a05:6a00:14cd:b0:748:4652:bff4 with SMTP id d2e1a72fcca58-7489cfcb16amr28248513b3a.13.1750335422813;
        Thu, 19 Jun 2025 05:17:02 -0700 (PDT)
Received: from avinash-INBOOK-Y2-PLUS.. ([2401:4900:88e2:4433:2a7d:bb88:9d3c:be74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168a0f8sm12818425a12.53.2025.06.19.05.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:17:02 -0700 (PDT)
From: Abinash Singh <abinashlalotra@gmail.com>
X-Google-Original-From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: jack@suse.cz,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
Subject: [PATCH v3] fsnotify: initialize destroy_next to avoid KMSAN uninit-value warning
Date: Thu, 19 Jun 2025 17:46:52 +0530
Message-ID: <20250619121652.126502-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized value use in
fsnotify_connector_destroy_workfn(), specifically when accessing
`conn->destroy_next`:

    BUG: KMSAN: uninit-value in fsnotify_connector_destroy_workfn+0x108/0x160
    Uninit was created at:
     slab_alloc_node mm/slub.c:4197 [inline]
     kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4204
     fsnotify_attach_connector_to_object fs/notify/mark.c:663

The struct fsnotify_mark_connector was allocated using
kmem_cache_alloc(), but the `destroy_next` field was never initialized,
leading to a use of uninitialized memory when the work function later
traversed the destroy list.

Fix this by explicitly initializing `destroy_next` to NULL immediately
after allocation.

Reported-by: syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>

---
v3: Corrected the Author name
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..28013046f732 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -665,6 +665,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->destroy_next = NULL;
 	conn->flags = 0;
 	conn->prio = 0;
 	conn->type = obj_type;
-- 
2.43.0


