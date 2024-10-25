Return-Path: <linux-fsdevel+bounces-32852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F99AF8F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 06:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E9A281944
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 04:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E0618C93E;
	Fri, 25 Oct 2024 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAml0Soj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3145763F8;
	Fri, 25 Oct 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729831221; cv=none; b=gaoJ7wqvDI6vzV0+lcpwyquaH92D99XIKMoKLLZbLP7KLhcE+eDLgG8DmCsSJm0dj1zZRvalYgJIno3kgdb/qu4/tSaan1tGuS0Uk12wFHXMz6V8K5dQbWozS+U8vDHxe5NbnwV4tQNe1zwyC9Y4+WOD+S4Y0P+kb8K6ZVnVTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729831221; c=relaxed/simple;
	bh=ld6+ggNizA3A2eIeDt5kCacXAG+qxFT6pKHcEwM1EYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dbOp89USb8eZqdXzy8FqR8HBENPhi3QtOmz3zoyQeocQcut0No0ihbSkcvkrT3qT+bPJswOcoGv/69tvURw8pNqOAe3tAc8ZhTSjRC8dO61JiBpOF45q4m6fLVTz8OY/CJGoSfjMGsvhYV9AAnXlhybn8s39pFETdlPHpXyBBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAml0Soj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e74900866so1182554b3a.1;
        Thu, 24 Oct 2024 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729831219; x=1730436019; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=To20Nw2+64QsmpudbVv9vAcH+arowhkF0pMy9qpll/g=;
        b=BAml0SojEUSzSwo5WOh8oY8a1a4i6flOEDEyWue0xeyS+ei4w4pC0NbAABOXshWwl2
         AXXNlWSuN7Hh0PnuUMNaPNlBI0MOBr8/Vj78oUmEhlwOEHk2iTB+El30/nKY9eV5qyb4
         wh2pl85If+T+eP0DkTHrvY3bvD+F1zxM+rt1BzXg+4Ahv6bYyY1WbF/vTquPOOIsFo9M
         dooFXTv1G5X/nxRG8ifZky+Zk+oKahKsI8DUgIB/1MSrtp5GR+64Etlve2F1asMtwvkg
         N6EF/1xLZmhwfZWCQV4OVnY9DB2bMyB6q5B95T6WsjZmYq7xG30d1Zcyq6zEvDd5N9IU
         hSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729831219; x=1730436019;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=To20Nw2+64QsmpudbVv9vAcH+arowhkF0pMy9qpll/g=;
        b=nh4etJ+kuPcBs/0mpADAjD7FNsbu7x0WHva0SqYd1oWWpOP3JV1tKFAiawpkyFnPuU
         kuqjhE9T/wrVGaZICykjT40CJhAyURCENn++46EjHoxNlqSyNqoeyrvhvhbfXGa5FDYj
         +aIOhIKUB9wNS6UoX+bf1rcmJtqz1NcqDhci0e9WXhkzqiARETRtsaRsKWu+xcuPTCOB
         L5jqautFjE52DCqL3IpQL2iR1YCf+IlTQZ6g6bxwqNQiviqWw4j6mnzPiSVqf1XEj29s
         svNFqFNEti3X3jVMC8tpAAbVK4ns4FM3/i5j2EIE0gJq4/1w2GM/q8PuxcGG2QlPJBpD
         g17w==
X-Forwarded-Encrypted: i=1; AJvYcCWw4uZMDrh27WxaSuRdDy/V8rTOCsn153sCVeObzMSWd4TZf5JSOKsqyRX6isaCxmr7o6otf0LFUTsaWnhi@vger.kernel.org, AJvYcCXUz3gPiJnC3ts1cXWW/wF2EhauhHedD/R7JgjRjmCAqPsLsiKJGDsC64EimMzUo5r/wlX/9Jw1xXqzRFH1@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZuAlehs81f+xTJKKTImEOc849UYve6I92FrRK/a4vvXW+OdF
	ZyOOGduB2ztTlSpb1SqiL9R9ohCxnWMNL8ZtAtkt9eqWp5XQg8xt
X-Google-Smtp-Source: AGHT+IHBTV8w2SbFVAAq6pGuZ4l55H/pI1GXYvikxial0g6R3qFj6l0XrgeElRJ8DSCk0nRjWidKyA==
X-Received: by 2002:a05:6a20:db0d:b0:1d7:c3e2:4e1f with SMTP id adf61e73a8af0-1d989b1ab76mr5069697637.25.1729831219094;
        Thu, 24 Oct 2024 21:40:19 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921a78sm256782b3a.12.2024.10.24.21.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 21:40:18 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:40:16 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] netfs: Add a check for NULL folioq in
 netfs_writeback_unlock_folios
Message-ID: <ZxshMEW4U7MTgQYa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

syzkaller reported a null-pointer dereference bug
(https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
netfs_writeback_unlock_folios caused by passing a NULL folioq to
folioq_folio. Fix by adding a check before entering the loop.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
 fs/netfs/write_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1d438be2e1b4..23d46a409ff2 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -98,7 +98,7 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		slot = 0;
 	}
 
-	for (;;) {
+	while (folioq) {
 		struct folio *folio;
 		struct netfs_folio *finfo;
 		unsigned long long fpos, fend;
-- 
2.47.0


