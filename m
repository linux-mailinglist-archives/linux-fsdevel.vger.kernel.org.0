Return-Path: <linux-fsdevel+bounces-59269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2BB36E9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BE7461B86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8804136C075;
	Tue, 26 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d+q91+Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE65369983
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222902; cv=none; b=KIS56v+OMMxjdRaZmTOQQGe/JSBdgOBYKOiyp6EdVKUUV1Yqfpcqp1Yxl8FZqh5smV07Q7Vh7VhsSW+tb2Vt7cztONDOE8lBMYNYJosrS2hPgI46loYA7wfqpqoqySeh91wskB9HEHO2Z/qudAh5BBm97H1O2HkfLX++ljRLCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222902; c=relaxed/simple;
	bh=x4c2iqAV39w68dzaJaOLDjwZ1CiAhVhup47lgo1+0KA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaKUVVk4CQn/rjFsZ65DIJU/vcLFMmdDNz6LLpKehiPSwOIIlH+HnQSGP+aSpcz/OfW09oeQNjHIg73XAcFLWutHQ3b5+YRT5o2ZWSy/ZHKYCuvQIkjUlcc996dlZpYtaAghgc63hnQBZ3CtlhG4f/wmx7rFEzw03+teNPfQp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d+q91+Ln; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e952a2d1813so2875281276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222900; x=1756827700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zphqo+knfBd/U7e2ug3JbW5SVnXfGmWeCnfWX3NqVkc=;
        b=d+q91+LnZeCKIF5NP27wS8hZQE7/PoR4R7ofsaefdHGnVzX4/dD1sKQYT3oudmq/nG
         2JLwDYxzIB5l+1yqc+nrTTC85GCEruVOxvDsD7KCunzaoII1Kv5sdQKsM4AM9YzwGuCn
         kxeMnaQrCB1WYInMXpR22ENyNiAmi7jiuuwFgAI5ikmEenVncS4nIjK1+SvOMNtQOtEk
         rMXjcv+pL2+sraPzhCzF/mCjw9A3/sHvRMPVvjLNv02cIbKROWKyNgghLKoV75POgbJ5
         5cNsRz0LjYOHPj5bZmIy7I3FqFUUyAZrIhPh9mZ2poJyxftf9/i1WhqzKoXb4nCepC9D
         N2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222900; x=1756827700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zphqo+knfBd/U7e2ug3JbW5SVnXfGmWeCnfWX3NqVkc=;
        b=s7BlzL3IWbG+0TfWIjhNlQxsJK9hNTqbttct4+DJT0Ef6oQ27GVJE5Np/dNwxztZ2A
         5bYhZvkQZ9RHj4UNEGGoV/0XjU7s5vFEbTcC2NbWJet8/kOM9wjQsigEWlEkEqjowZzD
         pgIUbStGbv7Id58gez88JJ7Ao3LT9dl+XozX9ewKUaFg6Wf9NZ0A/d51RSBs7II3xuV3
         Iz3a26Jr1Zlq5v3P3QQ793Ip6e3ULZOdMkpzsPx/Ej578ngWenBeulmPf9VEmxycMifA
         IG59Z/Dmga28+XKkKFATBm4qkgszNzsza2IyQhjY5lDysqxfVvYcv4mfi4h0va6hmaYS
         ttJQ==
X-Gm-Message-State: AOJu0YydUDKxwPCAc5gBsa2YrGwydH6nUGuy1HwCd0QTjaGrfrPF7xJJ
	CdUXQ4tKRxKvyHpLtVI3UpqAeZTiBP1Jt19YGU8KzbHeUCgdnoCiLkFRuv9yw4BZDqdd/aL2KNS
	VS5Bh
X-Gm-Gg: ASbGncujzleRDQRJKmBO3OtQDG1S2OZ2tj1khBJRRdOmZTojy16tVNKaUdt5YOBWQ0k
	q1V5FkjOIzagjbztKYSurUTmsOVkK2Gn6n+lX5FdNvmRt22Q0WBzUMjNQWeKiTAnX9sVYopXSkk
	5ihQ7+n1jDa0cVHJGPvo6iLq12a6gc7OjPnlHD820nu16ws+pDe+8t/6B8dEff80afkWmwNYNVd
	LFxujiaMkvXc8Vy69gHTKkCtLFbpuxsPC3SmAiuFQkBHMctO7GZzxndFl/vZXFzlN2CpJ/+1xBm
	pgvp8CbvL8VRh2F850AsQ3DmLs2qUGTW/dnUF+ooqmJU8dlQut4FJGJZPvwuBQtVCUnFDtst6jO
	U6kh3lroyABHdVdkbfP596EJhATDM8xhckdV7nupvvd7EojN6EJAjEwrSq9o=
X-Google-Smtp-Source: AGHT+IH6IljKhKMKAzfBvsIF2UqCk9sa/1rQsNeda0irdzGfCJ90MbR5GskvJ+4DVKKxRao85tvYhQ==
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr171930987b3.2.1756222899935;
        Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17354cdsm25393337b3.20.2025.08.26.08.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 35/54] fs: stop checking I_FREEING in d_find_alias_rcu
Date: Tue, 26 Aug 2025 11:39:35 -0400
Message-ID: <8077a41a37c9088d3118465ca7817048fac35f90.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for I_FREEING, check the refcount of the inode to
see if it is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..3f3bd1373d92 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1072,8 +1072,8 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 
 	spin_lock(&inode->i_lock);
 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
-	// used without having I_FREEING set, which means no aliases left
-	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
+	// used without having an i_count reference, which means no aliases left
+	if (likely(icount_read(inode) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
 			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
 		} else {
-- 
2.49.0


