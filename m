Return-Path: <linux-fsdevel+bounces-49792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6773BAC2977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 20:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CEB17773B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB029AB17;
	Fri, 23 May 2025 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2PPoWTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C229AAF2
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024295; cv=none; b=LGkLX2jGHZeC3waZfOchjPZRXcJ+4WI0tQm9RA0SJw/5bn98SIgW53jQos4b91NonxQX7ooCNRPKxWaLucYaefepfZuZ5jQGce5m4A1yCkN9PG0EFKvM9CeDgPKq5ApiTGtNchKRWUXRcDVFIge4quItLqs8Mrw0+kUC1/0BwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024295; c=relaxed/simple;
	bh=CPxs5COYRh+RqIt6hwKj6IOUVN6DBHbWI+fEwc/Wlpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HKpFEbcSXXzugt0aJLsACPdlYJMrvKDgVSwJzdC7nkNUaHNYUQCyEFSzvlZUA/YMC/J6NkbtB/IXXuQJMmOLFyfchJ530RWz2XW4KqAkbJkN3uswNfu97qPJCdjCGUPUkaamPKbC7UrN7Gp+wls5rFut4XtvDSy7r/DtxFBjZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2PPoWTc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7426c44e014so271464b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748024293; x=1748629093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffn+OX8JsQpPDagOZSg1hEX7BKH4yzTY41iXVJWD1Ms=;
        b=j2PPoWTcRQxsTwsFyVekBbPxDjXEgVk159sI2iskgaX+HlKJXX8KyrGkfDdKGWANsQ
         +9xD9oplEDZWZQ+sVMLmhD84eUYgJwPG2HdCo0+0CqOSymuBMZ5zr5CAJ8wQM77mx+Ph
         L9Ciiu/TNvi+zdlKjPYfpE1NBdH1Nfv4o4DT1Rf5MWq7resPPiPUt9lR2arT0NyFmgKy
         9zafi164OkOvIvtufF+e8IMFIpJw9di5qFdy1iB7y6HwLCJ2gs8f5wJkCmkTyHgn4qSN
         LewNoP2htdiIbqBuZjmYc2E2AAekq+U03Q5AMemEWF9BWojBdtpy88YZhUOQjou0E8QO
         6lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024293; x=1748629093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffn+OX8JsQpPDagOZSg1hEX7BKH4yzTY41iXVJWD1Ms=;
        b=O6H56RIfX97e4VHxwjJ+qH64FYe+jFjUSTnXPoB4LoNynzpVNZZk+1VgJFzFUxSvMs
         5a9+s+oUA3Blzyv5OxJJ/0c06yA9jSBUwf54ProYLitm37z0Lo8pYYChjlTu48pYNKBF
         0fSjxIVZpyQbCcVwWmFcRhzXjaqmHwe23HgAFxCdlgB8embLLPQLOQapEv+c9uCJUpMD
         BwM2c8KB0o+SwcYETurIzNbay0N7YPz9gI441R/CcQYNz8wmSzsODLQTjlcL1716qXLj
         rKFNmGUyudr0MvUvxXAi7ElyzA8fubrU9aK2bRX79Pc6PmbUwoCr6KiTzTwYBbH9/+XR
         A+Qw==
X-Gm-Message-State: AOJu0Yx54zZrkr4cyZbc51XJalWCs2yPgkdyr00JuYeoeOge+O2u/WcY
	VELG29VB3VUxSpVwL6mdbQ2MbW6CS6k14qEQpl8ERL7hDpGaq1lrdWH+H8SQnA==
X-Gm-Gg: ASbGncuXRKZ2DW2GKrF7XuSDQK8VKti3iW/aYu592l4PVCvk6PFVl2D4K7eqmfuzQ/X
	JNeAY8odTipZEFWc1U38rWLElRwqmrZGEkrTOS51XjcLw0N3RNbVWsyQsIVPxdTT6Qr7r+gLYjd
	ahMhRsBdRFuea1hU+w3iT0DJEIbLM6cHkCJx6jcpXYuAefwv9ksqAQcZc0lc8fKiikz1t+I7g/j
	Bzn9HRPj4Q6t8BeacqA+QBSiAOwQXpAwXnaDSCoHXTAkBeEU6gBGLMPSxnBHLjj0KbWlhFzvYls
	fhQ/Q11Q8K9xjpUuIsP+BY4UTLpPYAWjbwoKQZf5E+eDn/w=
X-Google-Smtp-Source: AGHT+IFOt6mxXJA4R5csdQJz2kRYKkYZOOTed/Ij8gYnPf8NRyNvvnvDN/s/a96t0qoXjSn41pqNPw==
X-Received: by 2002:a05:6a00:a22:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-745fdf3f47amr654303b3a.2.1748024293274;
        Fri, 23 May 2025 11:18:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a3380sm13451122b3a.170.2025.05.23.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:18:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH 1/2] fuse: Fix fuse_copy_folio() size assignation
Date: Fri, 23 May 2025 11:16:03 -0700
Message-ID: <20250523181604.3939656-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only call folio_size() in fuse_copy_folio() after checking that the
folio is not null.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: f008a4390bde (“fuse: support copying large folios”)

---
This was pointed out by Dan in this bug report:
https://lore.kernel.org/linux-fsdevel/aDCbR9VpB3ojnM7q@stanley.mountain/T/#u

It'd be great if this patch could be folded into the original f008a4390bde
commit in the for-next tree.

Thanks,
Joanne
---
 fs/fuse/dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fa038327f7a7..e80cd8f2c049 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1098,10 +1098,13 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 {
 	int err;
 	struct folio *folio = *foliop;
-	size_t size = folio_size(folio);
+	size_t size;
 
-	if (folio && zeroing && count < size)
-		folio_zero_range(folio, 0, size);
+	if (folio) {
+		size = folio_size(folio);
+		if (zeroing && count < size)
+			folio_zero_range(folio, 0, size);
+	}
 
 	while (count) {
 		if (cs->write && cs->pipebufs && folio) {
@@ -1118,7 +1121,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 			}
 		} else if (!cs->len) {
 			if (cs->move_folios && folio &&
-			    offset == 0 && count == folio_size(folio)) {
+			    offset == 0 && count == size) {
 				err = fuse_try_move_folio(cs, foliop);
 				if (err <= 0)
 					return err;
-- 
2.47.1


