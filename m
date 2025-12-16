Return-Path: <linux-fsdevel+bounces-71481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A7CC43DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF1E73065C75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9534730DD2E;
	Tue, 16 Dec 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlThjLIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F32EDD76
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901880; cv=none; b=ocmCz9iogce/IKSfUJHMMvTPLA8onhwDc053oXUESDS8NK1VbHr3FN3xpo0/UH6ey6J868nikEu7FnN7TuDbHijY5ieHhniJOxGx+pkr47Iy3fUy4SpB2h9JsJWHwkLiZqaFZgBi3v40T074Q/MJswWQPI8jJCEnDOwTSBgS/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901880; c=relaxed/simple;
	bh=NfVFaEsgYlTNWhHiG9lD88HgIX1yIjeLewaZDgU2dKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wrgtbe3T4nOeagtE4q3nyHUvXOE8/e574RCKed3myYQaolQ7vsaJu3bS8lXk1+I6jx3ISGyafPl2TF/M/aqU0vZxFI/ASV7P76SNzDS5eGIGmUR5pL20Atoi6PfQJLA9vqNLJnWhJABhEjT+XQOD8EOMSw7XvNNyT+ON0LVqsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlThjLIz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7633027cb2so843491466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765901877; x=1766506677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc74d610ubg8JlIaa6JmNgUpYxdbPfvvf6uFfQxvzNI=;
        b=AlThjLIzoxD3BcLFdC2V2jydRwD5nq594bpgF95jJReweec4to8tfQGS+Lx1pLGAA9
         KRfL4SPnZYBPcYxiw9/GWdwCUqWTp0l5cB41cp3isjJu+RdQ9+CcpnKaBXGpsWClbuO3
         kdzJBOxu6A+MobLFWPU2OK4oqep4G/l8yYWZeNDEyUt0yXbSPTYXSLkLDD+CslOlbJc5
         ga3sIv8iECLoOw438HbGhA2xqLIuIqb3KEuD9/NRodcsRgmjT/jHlZc29EEOSRFJwS7W
         LCP1iJNjz9OlS+4f5JsxXkDTw4sl/ZWYYXqiVH31AgXmHYqeLPVx+O54OZo0tNhMcERl
         TBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765901877; x=1766506677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc74d610ubg8JlIaa6JmNgUpYxdbPfvvf6uFfQxvzNI=;
        b=NrM4bH9i5s2hJinZaeZljd9HkQxZQ7ZNpe6V/Smjz1SXXdBCPzsMZHzAQDVQF5O5us
         Xr5QFP56VyqecVGiPqTGatmpI/ufP2SpCfueQl3faemW5gntmw/Wun0ikn5AXBkj1T7w
         q8rUuTGdijMVk6hHrMluLclqDJzmNLcBYUtKNUp3e9wjiAdc04anfwagV6lCr2vDZu/G
         JLQFA7FwspSmpmEFMlMF0JG6O3pcXIKbKOqjzQwY+edTb3T/+m6191TaYzjgULv/Jpy0
         TgfGyuIARYeGUtk67yHp619r62QSNh8hU7jflnXiBDJLRbr1PGF48o0gzkURCFC0UpyH
         N07w==
X-Forwarded-Encrypted: i=1; AJvYcCVjz7P4PGXmAS9GSLe0+wRT/sTfIoOO6cwaecE9J2vhSBNjSuN+/gNwvvXvlM0ks9G9E9wcxDmWc3l7KgH2@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuGJMrb8KHB+H0C+pfSR1zqMIMpknCr8rmkfF/1/opUdtydRy
	Gj/veReURFr5kWGl7ZVa8KTzmtUcfoIIFWjJbtuGil1JjflVGhUtCVJ8MTXYzA==
X-Gm-Gg: AY/fxX4/v9x937/3hds9QD4cYx9YOX+3Jexg0iUAHE3uuuoyHdlokftrFbnrUo5GH+g
	QoIVLyQPwSZbEUfHCi4MfGVHzzAwkjfj3WKZS5RpjtVbzQqevTZBwANmJnKH2WBAaWkpTl0ddMy
	I2014c+EXoZPSD0mzVb34Jq84J1Umb48dmxxRlT0YLXp/um3m/T0OsnSGa68/P7KeQLddAtD+hJ
	6tYxC9DLejET7v5eU5As4kTmD+B9Ox3fjCCXvQIPYIwY4q0j1H11+T34JJ9Jz65g/QHhPzuwIhN
	05q/2H5QvnK9DGDNHqaPHKxRwSA60evBtg5f9yUJoYmy+xWs9UzBTzLY9660ElAB5k9mU8S22DL
	MxFRwt3N/f8NnOiIg3sZMdLl9pagp/BBYoPOA62m/FopI88AK+SK5Ty/Fh7UvA579bcdUz3iC5n
	CPZWHo9GWnq4rwmHqGtrYd9nBmgSStjuLsDn6/kQOxgEyoWrm0UIVdUI9Svoqzj5IOL1CyVy5w
X-Google-Smtp-Source: AGHT+IE++hUTpvVDoXTnEPkKwj2xABrPJXo5oPLEznAqITCPrZaE2A39nltiMCOFhyKLkzIMNDObkg==
X-Received: by 2002:a05:600d:105:b0:47a:97c7:f08b with SMTP id 5b1f17b1804b1-47a97c7f1a9mr66099745e9.31.1765894609327;
        Tue, 16 Dec 2025 06:16:49 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm240035745e9.3.2025.12.16.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:16:49 -0800 (PST)
From: david.laight.linux@gmail.com
To: Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fuse: change fuse_wr_pages() to avoid signedness error from min()
Date: Tue, 16 Dec 2025 14:16:47 +0000
Message-Id: <20251216141647.13911-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

On 32bit builds the 'number of pages required' calculation is signed
and min() complains because max_pages is unsigned.
Change the calcualtion that determines the number of pages by adding the
'offset in page' to 'len' rather than subtracting the end and start pages.
Although the 64bit value is still signed, the compiler knows it isn't
negative so min() doesn't complain.
The generated code is also slightly better.

Forcing the calculation to 32 bits (eg len + (size_t)(pos & ...))
generates much better code and is probably safe because len should
be limited to 'INT_MAX - PAGE_SIZE).

Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512160948.O7QqxHj2-lkp@intel.com/
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4f71eb5a9bac..98edb6a2255d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1323,7 +1323,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
 				     unsigned int max_pages)
 {
-	return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
+	return min(((len + (pos & (PAGE_SIZE - 1)) - 1) >> PAGE_SHIFT) + 1,
 		   max_pages);
 }
 
-- 
2.39.5


