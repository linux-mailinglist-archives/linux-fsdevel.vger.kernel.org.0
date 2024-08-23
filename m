Return-Path: <linux-fsdevel+bounces-26934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7B95D352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E9C1F231F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B618BC24;
	Fri, 23 Aug 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJWziSr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E318BC02
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430464; cv=none; b=kiqa8c9qV7fuJiNdd0O5Ol7W+/Y4zaKtA/QlE5zZfGzxEhr2POZAvDS9VvPZbgKrF6ne6bmPnVb4rClsMa/i4hAn1ArYnmPcg4kQruhDk2Z5EUVdHy6mDKx8zYixtwU/Cfi5pyXzg9Q0GN1UnRS8/BLqdmbTgJF5QwsRACkmtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430464; c=relaxed/simple;
	bh=eaHwMeJ0CTx8L8hGmD/ZgvwlqQiriDj4xMCy/d865M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ubcye+Z8A2ONy69OQ2iRyJic5SQsumJFLBFzlhpVXtGT0NUlOUi4wmrVKmPJaH8ArrEGpc2fAvbpXnxGGjbQXSL+9qbBAK0lvS93SdXglILP6Jm9FwjQQQxofI3ONRnEhx3GmRtqz65WGYG4uWWP6p79SFMDUDquc5kK2n4RAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJWziSr3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e117059666eso2182275276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430461; x=1725035261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+JBESYi38EleyLEk7wLfDndWDrXHxRbRmO5HxAqZX4=;
        b=dJWziSr3XQ53U0zNtIPj/sa7VpvfGRONR8ujxXX2LWpQNs1b5OyOe/ta9vO/rQ598p
         BDKDTQjYQnMXD4Kd5Ir9zHivgDzcG6jkZ5cT0p4zZIAORPC4iegiKwnaIxpj81logfYK
         HrRmPN0Q9ySIhzrvJoJ9D6FFcugb65GqCTHHjdJtAM4F22jeI3sAVUEvs78Gau0nNAQ1
         ruvMYHfekADHpsaYJjKnJp9bw7bY4qogqutRfTIPW70yNFmcsnXrf+o/XvEpp2egEFXG
         1Feq+LdK64Dw3s8mwrP7Hcr1HkjUBix6BGEsQbldQuko28NTA9ynWQnXuxAXgexuAkfg
         D7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430461; x=1725035261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+JBESYi38EleyLEk7wLfDndWDrXHxRbRmO5HxAqZX4=;
        b=CPpq34EZKUUS9Y1p5nQ3gEBC2FtCA2Phq7faUAwK6Di9ac6JNxQ+yl5A2LNtlfgLCu
         D+cv5Iqo8CRFBru6enBkdd9ibB1tohq3WvK7BHz+0LQJsNNiXIqOWG63p9sOUr60nVub
         FO0PsJwEghkrxFVxhOZ1ErvA1xSwmqRrtRjJXi8Hq6CAQFYt13jZKA+KH1kG2w0pdlwY
         LlKbCiBQPQIoN2khM6p7gpHScNf4F1fgwPG5C00T/4w+sG8D4MxoufETDCkUEK8EYPah
         c94zxngZgIdoRnwpFcn4B+oyFhWszHirlHdYqb0VmeccqQchLTpQhlQuWnhRqCtfsau8
         hVTg==
X-Forwarded-Encrypted: i=1; AJvYcCWmY7yVA19QwPBy9GaPKibLABwO+Ji53BJ+m/Vt1tsH7oMY/i7de51RHoHD04hlg5yb6+mBRkwuLAhIFWrE@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlGiC+9Mk6aXfEQjzKe69XDmOTI3zWq6RBzIeufbSfbPrVBHb
	eaUvMBjuUMGVOOIWAzRAJdUSCrgp1j5Yo3m81+G9E9w46rNp2DpS
X-Google-Smtp-Source: AGHT+IF91VYXjuhUg8ewE14V0S1G38gggm/K10gjMxFKcOA5ipwIAVaqEHPcUcoQWDJOYrE4klCPmg==
X-Received: by 2002:a05:6902:1603:b0:e11:6c6d:8c1a with SMTP id 3f1490d57ef6-e17a83bc673mr4217461276.8.1724430461366;
        Fri, 23 Aug 2024 09:27:41 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4bc94asm740133276.39.2024.08.23.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 3/9] fuse: update stats for pages in dropped aux writeback list
Date: Fri, 23 Aug 2024 09:27:24 -0700
Message-ID: <20240823162730.521499-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case where the aux writeback list is dropped (eg the pages
have been truncated or the connection is broken), the stats for
its pages and backing device info need to be updated as well.

Fixes: e2653bd53a98 ("fuse: fix leaked aux requests")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 320fa26b23e8..1ae58f93884e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1837,10 +1837,11 @@ __acquires(fi->lock)
 	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 
-	/* After fuse_writepage_finish() aux request list is private */
+	/* After rb_erase() aux request list is private */
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
+		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
 		fuse_writepage_free(aux);
 	}
 
-- 
2.43.5


