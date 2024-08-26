Return-Path: <linux-fsdevel+bounces-27244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D0195FB8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52B3280C09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35119AD70;
	Mon, 26 Aug 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjEDZ1G+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA69199FA7
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707208; cv=none; b=Fz6krkNEw6WC7vVwv4dNDNq3A0SKFvTcgqHlRd6mo4Il1ovL0FQaE31PhYgaNXipTVOofq+mLY8j8O+KtXn0p9mGLLGdg1v2C9Az7fbciB2LypkNVAhpZG8SS5IHh4fjuwqJN5zmojiRqQIgT7Ok6hON69/hz35/rA3GWZfp7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707208; c=relaxed/simple;
	bh=eaHwMeJ0CTx8L8hGmD/ZgvwlqQiriDj4xMCy/d865M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfxpsjguUI6f9UA+IBcLldRyl/Vuwo17uIlFM2wp5HkS/U5tgJbA2UFFsDobGwgWTqgjHv7mVz1T4r2ENtfFylJqni2JVJbA+uh5CwiJFSQpnkBu2AZzxGxm8Rq70gDNR59CvHNywQEkLkLWzokd6Szi651kHBV3A7vzsGDT+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjEDZ1G+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-690aabe2600so43003497b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707205; x=1725312005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+JBESYi38EleyLEk7wLfDndWDrXHxRbRmO5HxAqZX4=;
        b=TjEDZ1G+wjN9TNu59ZXe0z+qcdmBTEDYMvK9stk8uzzZ23jC8TuNGfS4wBHtIe5l1B
         iut73T1yeS/ce02VkiBG+PiCQhufvZIDLfMh4utZWJiGnmvWcXJw+yhZRLMvZP7kLG3R
         xqexTgfPDKqHVrVZQVEkabVD9dWaqILZY9YgRRFJLTeES6hJ6nDBmg7j8SkL00+TM+P4
         MIsmLBlHOCumKEsluXQMXD4GLc13H3OzRsMr2ADvsUlImStR2hyODpqVJeIHcj30g9ph
         SsMOAut4L1OTWYL5D+yjGfZDGM2eyy0eyHtgTirrhuZeU80YZxgRkXHMPxXs+kPxA2Lp
         Kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707205; x=1725312005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+JBESYi38EleyLEk7wLfDndWDrXHxRbRmO5HxAqZX4=;
        b=JirH1dL7Rzd9buOqM3Kewl/JIgGYE25ekKWhZutag+ETVjE1oRAbYVzWAzUG/wtbt1
         0aPWEFTfLDFekZlnKuOjadtZgel1+NwDbE90K0JL8p/xL6CImo35Qs7p2ObD58uv1NH2
         19o/dSs1usnP3sWOHpyRuqVausJC3XB6Vz/BPzBFw/ISlRSui7sp9yKjD0U4RSM2yFI3
         oaSe2Hbph3eMi9Pvi2GFXdkMRb8jerAObL63v0Wav0EkFXRhxVzimKg7d6oEW8bwAcs7
         xwhcY0/40vS0Nn/poTYfMxtPzGVspJHCLhEvNHN4JU40CaQ9d3LrLeMTEjgiZRFVAik2
         ypHw==
X-Forwarded-Encrypted: i=1; AJvYcCUcvpicAk23OBoDVvuF/Q+01FAmhZwahyR8m6qJ6PjRRKANBVTtt92x38UaaR1MYWZY/u7gfCZ27vPSGTIP@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp9YOdK85hhwVSXJa83MwzNE9uvfneKsuWsn8imuAx5DBNIpW
	1bIQuH3o9d8r5luwXcalXrjIA6OF7zjXLlzGFQYEUpDznk8uXz4fSCsKKQ==
X-Google-Smtp-Source: AGHT+IH9Zkh2fvm95EuP4sI5zsaDGuCCq/9KaTVofYUUsRtIqIMSxtqAElssm0WKlesWj6L8ZzSVNQ==
X-Received: by 2002:a05:690c:3484:b0:6b0:beef:2e80 with SMTP id 00721157ae682-6c6251a3e82mr102609777b3.17.1724707205486;
        Mon, 26 Aug 2024 14:20:05 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b006490sm16732717b3.63.2024.08.26.14.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:05 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 3/7] fuse: update stats for pages in dropped aux writeback list
Date: Mon, 26 Aug 2024 14:19:04 -0700
Message-ID: <20240826211908.75190-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
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


