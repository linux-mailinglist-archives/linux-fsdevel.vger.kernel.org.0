Return-Path: <linux-fsdevel+bounces-40683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC09CA266A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CB93A541E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F121128F;
	Mon,  3 Feb 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGOF/eyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0E20FA96
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621937; cv=none; b=Rc9wNx8UOJqvZyIu8tAwaINc193xutsFTSUl45LDy5Sm63wcVd3KjIkgRZHMXoq0Hp+VoP9cyeL6eM3prOCgLcZtJxWfVtpUDi+bho4fMhNzne2/9pFW7lAlwFmO+jf6qxhVB4UN9z8X/Izs6+EQFLEdeOJZWRlazawY2sg4u88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621937; c=relaxed/simple;
	bh=U7Y1F47nAAlQYSMCWCXd1FRpeEf7UqpkBxpCGZ4veVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESFteKp55jaimO1KAftRtUNRAByVX+Y0NLKlKhc2jWQd3MdGzp6FJIPE3x+8xmKUhOJSsplGOXOvBzroU82RGuP8LnheUTYLCOE1sufHa8pQRyc0wJ1EHmEhLQW9Ia8UIZ5pS0Jjq8dWv/tFpvMr2F3aWZ9zWJiO6HVCHVbdO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGOF/eyV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so817734566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738621934; x=1739226734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSEuVkiV1rWKb+Td3ABIB36iuAluDfJizSzWJdJxQco=;
        b=VGOF/eyVIugnw4RWjBAL6bkM7iaunFuAkEjwcQepWEUturQImIG7PXYN/o58xxs7U0
         bRe5bQaa85UYTWNWPieTFsmM0p4pqfs1xUbsloVpr+f7etkpLY7mNonXNI7+nlGqZQgg
         qHm20k32m3Ev0NMSKZcutEcBrEhQt9rK608Rja3PYyfdnVY6u1eOrgPGl9ckH62be9bn
         LKHXIXrXfsPaWreEn9+XPdBGlst443UFX6ggOaF5ihH845TmrhCSwsb6TwQfWl07i6O8
         GiOrdOT9pEHUG+WhUgD9Kf20470pP3XpZXRY6fwhSn/ttXPy52cpvfW9d6LRzVOO2p5V
         sGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738621934; x=1739226734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSEuVkiV1rWKb+Td3ABIB36iuAluDfJizSzWJdJxQco=;
        b=KRDYBo5UzOP5bZa1gepOLH6AW+GWONv9WL1AEP1AS3EaqYBiND9swfaGhWFhVNbL0g
         x36tWuE97+Ebe1cg0F6PhXb5vYlekcHGRIjjjvUDSBZwL3y6VVBVzsyKg+yCh7DfW3Vy
         1jU5aDELeMXpYOB/i+Z7t+Vl9dmwl58RglSKBX0MBGI0TwQxV2Z6hmIu1ifQMvMUC4Ch
         sC1OuLJyM28SlAITtie5XcRPpRZ53zmar/+zeMKa1bvacnbVHmVjJoKdiE/w2WyPf8AE
         l8vPz3IHxYYzsizHpXLEq1DdfrwYlCunrrn9WmN39wn7pEDZQ3mMIBaH27fHYVKIyvkP
         Fn0w==
X-Forwarded-Encrypted: i=1; AJvYcCWFDx4dYVgBaqX7Rwsttn9qX1TgH3dJ1oVe/TLH16GB79dBvdniwa6nYVdEcAffhRJLilU31Fc+LTQEUKby@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QGiXoH6ahDZ/1X1nsmOdEbrefZKgQEMfPvQVF4qaUMMb6gQb
	+VebyS/hd1wHzSlb+h6Hg0yRkiaVgCUU5uYcR7ziezzA0cKsWsiMhM9CnCQU
X-Gm-Gg: ASbGnct/w3Mbsn+YDfPpvdHcWHegcvT58x9S00WlBUfywWNPvda/RtwXklnRpAz3fUS
	LxsjuwGInex++MaRq62e6g3E53v3i/QivclJxPjTGtJJtyWOHSt70T75tsW4ZKweH5Llv5n52zg
	7DRFDdIh5r2hUTiQ7zE9i2qwmxP+pbav/bFsit8Yzv7CxamhYnq2e/r7XKU1DB//MVpcmPaw55f
	X02+sP2hFzmcGGypEaTGRMQotqylZHoU8mOu0TKWF5FhmBFcZB/Xi2tAZBz6HmXBXqd3Cey2VPj
	mCiMs0bkTWZ590rxLUXC3dd/yZgLxuOcIsk4ZTmeNd8CO9JmPM807jICp5lj7HjWZrEjX39BN8J
	r2Z+S+PBmaMO1
X-Google-Smtp-Source: AGHT+IHe/4l8G6B9iCODitiueTVU8YwllQ5KlCmpRsI1T9+u7kvDTF2u2CH3BtyhuLOgcxzGnHywsA==
X-Received: by 2002:a17:907:6e9e:b0:aaf:8f8e:6bf4 with SMTP id a640c23a62f3a-ab6cfd07c3amr2561039866b.26.1738621933287;
        Mon, 03 Feb 2025 14:32:13 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724a9c5fsm8339651a12.54.2025.02.03.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:32:12 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] fsnotify: disable pre-content and permission events by default
Date: Mon,  3 Feb 2025 23:32:05 +0100
Message-Id: <20250203223205.861346-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203223205.861346-1-amir73il@gmail.com>
References: <20250203223205.861346-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After introducing pre-content events, we had a regression related to
disabling huge faults on files that should never have pre-content events
enabled.

This happened because the default f_mode of allocated files (0) does
not disable pre-content events.

Pre-content events are disabled in file_set_fsnotify_mode_by_watchers()
but internal files may not get to call this helper.

Initialize f_mode to disable permission and pre-content events for all
files and if needed they will be enabled for the callers of
file_set_fsnotify_mode_by_watchers().

Fixes: 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/linux-fsdevel/20250131121703.1e4d00a7.alex.williamson@redhat.com/
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 35b93da6c5cb1..5c00dc38558da 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -194,6 +194,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
 	file_ref_init(&f->f_ref, 1);
+	/*
+	 * Disable permission and pre-content events for all files by default.
+	 * They may be enabled later by file_set_fsnotify_mode_from_watchers().
+	 */
+	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
 	return 0;
 }
 
-- 
2.34.1


