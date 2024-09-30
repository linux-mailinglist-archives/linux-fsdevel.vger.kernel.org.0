Return-Path: <linux-fsdevel+bounces-30404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62798AC6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E61C21932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED7199248;
	Mon, 30 Sep 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="uQOeVS5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047D198E93
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722512; cv=none; b=kHYV/sMtkbQUIMQGa3ipfRqoGipUWIK8tPATPRprJGJWxCsQCy/luUUagp/h3xlXvt/l5UI+l472Ho/6XveuXLSI9BD7hEsa5iC1FzZCILZEpxcoYqnZ+ZkhJiWCuNylpJ5VNaHBQ5y9BvG2y/F8l454jqc/79MSuqXDULIu9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722512; c=relaxed/simple;
	bh=DncG/RMrnPEbFWH6D8LtrSW9LSny2ClSKkba5oLV8OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTey9RnRoqsF88OmnHnP2f9H1GkJ5XUxQNJ/r6Di9J9dEeijoJncSEzTVH6PW31QK6FCHsskZYwHHFwDZZVQbXgLrUHaTDJ0lp7SdltTWLT3MGr3rHSzE7DJq4AxkBs9Cj5eqKvhy61MbM+QhKklzHf4H6fziHwakGg1EzTXDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=uQOeVS5V; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7dafb321dbcso238686a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1727722510; x=1728327310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VAQ/SmVDfVAhynU7T94wopV4O6hecY0N9QDW6gOokw=;
        b=uQOeVS5VSUNKrhpOv4MZlHklzL/7NfACyYerOTVZoJTxkyl2uz1Yw/UTBrzXKx2iJ1
         Dh8kRgdZ4URtZfbDCvNKQwEfMaDSweHRpElkWhcYX03CmFdjJqURKyedaQm8F89Se/SR
         KohNnJUhqNb45fmc7LBx3YmQKzJOoPVfcUvkSYIqSz3x5YqRrDwKkiY5kkgplDSJqDSQ
         JT475/zhh9sADjs1IEJTmpqEdSXPEt9FJek/RRYNx1PWevz01pa7nqvTKrbHH3r5iiHi
         fNlegkVOR76xffwASWZZiBlJGn6sF8sOXnDlxrDGYi+maxLPa7WyDtU56F3k1PoMm43v
         X7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722510; x=1728327310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VAQ/SmVDfVAhynU7T94wopV4O6hecY0N9QDW6gOokw=;
        b=AiuKA1BKD3mqEVke0XL3iRm1Ga1LrMOAD3TjSIvIjhmmt4LpGBeLL0R9Kr2MphNghr
         gX4UwYij3TIeiPKDjoeyXQ4EncNj5rdpGbzu8VCnw0bjCOpYGzJN61sxpLQu5USWUTFe
         K4dEqi4zMCI0Otbjto0PvJxcOXdtl0z+5RkTgSvd1I32woApu4t1jLKxK4tTGy0vCxdJ
         YZcv03RlJEgpl7SvdYM5/hhvznC7ec9xBfUA995yZ1g8CxBUrVvqY7uKC/PWDza3tPHE
         b9TwozvNzFBTL2C1DIDw+A5jB22mWIgamHq2MhpdE7ap7y0a524Z/TlHXKt0QgQ59Du+
         aWSA==
X-Gm-Message-State: AOJu0YwuxoXuf7mVlzjPNbgY2V3tPgSELBnU+8APYdOArLTu+3amgeST
	SfoqyVxmAdn538b7HPKN8KCwpA4ySQWxPseMpIorq8RQ0Yi5/7jUiVf66xmOWVedu3QIwb3vXMm
	4
X-Google-Smtp-Source: AGHT+IEHnADY9Lk/jZUl1YRpGsPuBms2JZDBO/xgFDkOwrdjxf+4j2N2oNKU13O1aDFUuC5vUMn2fA==
X-Received: by 2002:a05:6a21:3283:b0:1cf:4903:7f66 with SMTP id adf61e73a8af0-1d509b1c3dcmr6304093637.2.1727722510147;
        Mon, 30 Sep 2024 11:55:10 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:e49b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc3ecsm6610976b3a.60.2024.09.30.11.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:55:09 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com,
	v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Date: Mon, 30 Sep 2024 11:55:00 -0700
Message-ID: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

iter_folioq_get_pages() decides to advance to the next folioq slot when
it has reached the end of the current folio. However, it is checking
offset, which is the beginning of the current part, instead of
iov_offset, which is adjusted to the end of the current part, so it
doesn't advance the slot when it's supposed to. As a result, on the next
iteration, we'll use the same folio with an out-of-bounds offset and
return an unrelated page.

This manifested as various crashes and other failures in 9pfs in drgn's
VM testing setup and BPF CI.

Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chantr4@gmail.com/
Tested-by: Manu Bretelle <chantr4@gmail.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 97003155bfac..1abb32c0da50 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1033,7 +1033,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
 		if (maxpages == 0 || extracted >= maxsize)
 			break;
 
-		if (offset >= fsize) {
+		if (iov_offset >= fsize) {
 			iov_offset = 0;
 			slot++;
 			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-- 
2.46.1


