Return-Path: <linux-fsdevel+bounces-68041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D411C51C82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B323A2D7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7423305068;
	Wed, 12 Nov 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBX0gD6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E12F9D94
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944285; cv=none; b=RhM3GItOGs7z0ZpxlHGiogNjviO58XAgwiEurzSecIKX52HjAd9qiUF79QFfB3micm2AMWK+CiDqBL9cflbA44h695Zzcb7anbltbGUTaqKI4hea3xmaCYInH6D+O/OxruS6v+Qp8tlI88DAHe7c90bm5aXshu75Q6IGPvys3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944285; c=relaxed/simple;
	bh=fybpzSb46YiF9J26GboN2B+pgJim56okIxMbRhK5hcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tr0MdnzhUStMRnw8yEGn7jwQP6kH8LHY35pO9EGAs2GuzxKe69ZXKS077Rq+ZJAyD/o03raTA8PhLzGIt12ArMiAIfycG74xzTB7FEOeRczfLZZrYrTFcaZEX1lauK1/Sjjs0bLX1ybw+rzRPlpKjDp6yCzkPGDMMf92p7ZD6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBX0gD6U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b71397df721so110737866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762944282; x=1763549082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFUEBsO/Qu/uezzNpLMFcp573WoF1qga0QGU2MJ64f4=;
        b=MBX0gD6UwHChen2bu9z3uDyw9h14E02S93I26e1P7RJUh60njWEKD/GxFZO/DeEedQ
         1tXl4siLMT2AWnuuDwZG3DXytRv0ynUPFI9WlMdktHH/rPwwDPvz2W79MvY+30uNqzPW
         Ej1n1mKXpsSa7HjcgrFecIzjJL+cKoW2Y1gpQxShp1lDle0B8+cefQPih1uRpOeLT2dF
         YTbutq8n05dSSFwXWUhQh0saiouOfLJRRxs1pwh8JRNKUAqyEHkF2BI17pQ/L0Rl1czc
         sNDnsu2djQr8q2lasuJd4MqLMpWJi0eInZZyUcwfHbS3u280Fjhm6oTN66kGq9g7yU9X
         s/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944282; x=1763549082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFUEBsO/Qu/uezzNpLMFcp573WoF1qga0QGU2MJ64f4=;
        b=CT721j1K936/TdvgZOEhT4jLqtB/v9yPSeEM7qjmo6NvNHCWrk8xhrvsSIaRc1lMOv
         pv9qTbkZrQA5RdmNKAwIJQIcF5d4OJ1zF1tb8oegz+P8gkgv9jYDajgYRcLsQMDcK3zy
         K9b0CNuutFa8jPHUqhOEHF9bmH3jfPgmxZmj5DwujWHWrY/AyDjh31LGgYzN/NW0Uzbk
         9MHDNGz3NvduXY+CylcZE/wjYXDErfBlSSuGv2Sog7adZggxLx2FfazU+fskVfE0NYDK
         pr6jVW1Mh5PTkl9mwdlNFwCX9aomz/IMatNx5lz1OHrZQpNXoAGIBtRYb3X6xhvyQQ7G
         922g==
X-Forwarded-Encrypted: i=1; AJvYcCV134LFjgOza7oi6oXQLg/p0f0FFnxx5gk6qXWyeQ5Fw+WKqPUsTbfF+oyVEdZc1M5uoRK88h8HvXNmT3LY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6v5nscNdGOj4BTOMgZNpkA7WTfI6GBwH/tPnpoIQVuyN0m9u
	ypa3wX+E5dGzDVi6tjdHc97CEfQrqAbOi39yIU+vzjgYBxJ//kI7HH73
X-Gm-Gg: ASbGncsY1OC+asuG1PE03yjBhmtE5FlAV329sO0bDDHPOcgWIQD3VTtJIzgoIJ5f77d
	hZVQgSNUXGrsP6ERuyENOHfGYsW7kG8eLu18aDFL9nyO5xtTB7ekygDi9ydeBy8DjuJICBb+48A
	jhOpPp0CgqjzQDUblIJSV68fDFDNZbjhi2FMpu7CIPff9uJjNjEjUJrYRicGL8t33PXrJBUr/Fp
	Y5dZu6vlZ2FfT9oUclIWlnLp7YQn14ZoYVpGmYHes4ytTB42VlmX6RZ4PAQugTdKmT0LITsHBRB
	cWIeX1KGw3oiATgGmUGkZsKv10eBsrQOP4uM6EqgeQW3vqOcBhTDkUA0OHVQ3wi8um5K2JtIUgp
	uy5zD2kNfOQMaeUvVj9QQEwh8yYB1ruIpyToeXJAmyoqBGwpgyQWqLZFRICsf1fVfr9YdRWC2r5
	YnVqZ40c7mIppZgog7t1U1wEHvyb8sPJe+ws1R0dsW/UXsFMjX
X-Google-Smtp-Source: AGHT+IHrZmIs8nk5ArTcfh60GG2k3h+jurwLNlYK2ksnYIGUN7QecVUHw/+hmvKIg0JO4bHSSO/DUg==
X-Received: by 2002:a17:906:ee82:b0:b73:1e09:7377 with SMTP id a640c23a62f3a-b7331aee6b3mr247579066b.58.1762944282086;
        Wed, 12 Nov 2025 02:44:42 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc874sm1606655466b.54.2025.11.12.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:44:41 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] filelock: use a consume fence in locks_inode_context()
Date: Wed, 12 Nov 2025 11:44:31 +0100
Message-ID: <20251112104432.1785404-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matches the idiom of storing a pointer with a release fence and safely
getting the content with a consume fence after.

Eliminates an actual fence on some archs.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/filelock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d06..37e1b33bd267 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -232,7 +232,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
-	return smp_load_acquire(&inode->i_flctx);
+	/*
+	 * Paired with the fence in locks_get_lock_context().
+	 */
+	return READ_ONCE(inode->i_flctx);
 }
 
 #else /* !CONFIG_FILE_LOCKING */
-- 
2.48.1


