Return-Path: <linux-fsdevel+bounces-45829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1BBA7D137
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 01:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098C7164383
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 23:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AD41C32EA;
	Sun,  6 Apr 2025 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCsMhiOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99F1B4F08;
	Sun,  6 Apr 2025 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743983905; cv=none; b=qJQkCPlRCtEI474EpDKgAqO4MhwKQqC+EeCPbrUHuC9HhiqiM7tYRsKKQ93Hr+SSUewDKTiRJXHuhLoTIgBJXfz/+yOqiXKzsgL+rv6oiGHnx9DCYMRWpfoVgX69ghjeeWgJqCOB3hwP5LgseTCL1bnPq3vF9Gqxbnpo0ZCEyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743983905; c=relaxed/simple;
	bh=f4GK1bZfYEOHX+GKwkkO9F3l4/+qzrSXQSWbSN8r3BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W49u1w0iqODf3aqiCA9c0gLEYNr6IVIeBLnidTAtEFFT+R0aUxwAyI9yx8+gex5jR+u8PI1mCKWpFq5acmMAbTw/YbCVR+Pzfe+VnKEaCnTtO9G6vM0RL6W09/mOBRa74jVnb2YaklwrMjprwtkhuAFPapDnsIzSR4ohDxfoDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCsMhiOG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so18567255e9.1;
        Sun, 06 Apr 2025 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743983902; x=1744588702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3FvIjS8Ct3GgSEMwvbC8rj20GUnEzJRZeANZTDwOXM=;
        b=WCsMhiOGnKeym+XabsL6farxtBFzOac92E3J50J+74kP+0hx0Sv4N/0rMY7iX8fQUI
         2ADT9a4h553C+JF04eF101eAp4qoMhdAs/s2rYpbzJjNSx0rqHoaAHz3J33u35JHg/Xp
         0rxnfNjb7M4/cnCugmKjiI/jlhdUXSd1iEETX/nYjUdUdoBeq2P8sQZqFs8eQbl2Gyg+
         /PNu/ZzIY9sGxlCul1rRmEm9TELNG77zwv3rbLlwKJL3m0F1b5oZYa3qNmwQDmPmQcW2
         cVVfcIm7q02mQD4To1h98MJ+xAxn9mw8fvdeIRhbhJg5ruBgVLUkRWzazQ3MfNwQ44gW
         ivWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743983902; x=1744588702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3FvIjS8Ct3GgSEMwvbC8rj20GUnEzJRZeANZTDwOXM=;
        b=g+zf4gg3zT31BerMklWwkTcj8YV/IszETxTTxOS/d31uWr8+/yGU55ULC6OK7JXwGA
         E/fmmJkVK9kxN9WLcRCYkO1B9LzFkMMCViZvvTDJhy6Pwkk1b45aRS4dt/+OaYVDR1Pj
         NX42QJvNdeyV0SHW2bqePgPnmdm0eb/MzUel9Q5MeMm/rsIOY5oaLJEoOD3NoqPbRlOU
         hKGRh28/pqfJ+nF4g1Qd373hfYB/ujZ8s6vce2piAK1CBF11uwFsHg3qwwWO/Lo2T633
         CdN3Qa1JCud0heN0+9g1NOQ+brYI7Sj99tbXUmhOOiLnFPRSM7GSM7Bwh81naU0nILzg
         PqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH2ZuUrNSsJZFexclgRUDrLANwp+G1RADUwq2VKhzzaUeDqhdVPA1mwRxBR8A5icRk3Ux3TBwPIrET+oLR@vger.kernel.org, AJvYcCW4HZAQyA3dI6bK4Hwr/vLh/K2+0QeCdfzqwykrblVZm5LLrdwedDaVlqrsoeVjFSa5JKyra6ijiM8rBTTH@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFieomqg6M9FeIz2n0lUQzNtdGeuJXle0fruRRDE6S3gi2e5t
	MrXoovcUiukufc0zm01WFcsJTxN6xdxZ1p+Hn4Ge+h75aZuBuYT0
X-Gm-Gg: ASbGncvJeOpQ6VBcz6a+9W0dxfkRvoW0sGA1pm68Tx36UML6F27EXQOdtKZXDEB/ERl
	50OoRme2Yuwqp4e/TTucNmCW61KcW63NOudrM7poCLZ3c7IwJT9FbcU2ICtSyvtaS0slV3bKitC
	phiPvm6gVrGvmkoIUTHAOmIbvgzUfPvb6Owh5fEcycZI2xoSAuMOvTbtYtyb5lrtXxAiNo8ymXb
	E5TsYbbGB1OdDK70VF+Go9GXE+EeXnFELIqfSbEiF9hmVfPKdKSppdiWp9d0rF1OpSGFjWJtNz9
	fIyJsHhXxOeHc7VNijfcnANkNVYk+/W5TP44GjPCkX8Y+IgsNcuwxL/Y2qecawo=
X-Google-Smtp-Source: AGHT+IENn2R0pbmEOwK9Ce8QYGEKO3b7BdowJK5Mm9O5+xyBysr6iZrhHkiXtlbjrTUtw/bPljo2AQ==
X-Received: by 2002:a05:600c:4f45:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-43ed0bc8db0mr99515035e9.12.1743983902170;
        Sun, 06 Apr 2025 16:58:22 -0700 (PDT)
Received: from f.. (cst-prg-74-157.cust.vodafone.cz. [46.135.74.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096b9csm10576598f8f.13.2025.04.06.16.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 16:58:21 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/3] fs: predict not having to do anything in fdput()
Date: Mon,  7 Apr 2025 01:58:05 +0200
Message-ID: <20250406235806.1637000-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406235806.1637000-1-mjguzik@gmail.com>
References: <20250406235806.1637000-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This matches the annotation in fdget().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 302f11355b10..af1768d934a0 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -59,7 +59,7 @@ static inline struct fd CLONED_FD(struct file *f)
 
 static inline void fdput(struct fd fd)
 {
-	if (fd.word & FDPUT_FPUT)
+	if (unlikely(fd.word & FDPUT_FPUT))
 		fput(fd_file(fd));
 }
 
-- 
2.43.0


