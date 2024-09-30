Return-Path: <linux-fsdevel+bounces-30328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC0989DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37912B22184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E7186616;
	Mon, 30 Sep 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbJOHuAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BC184539;
	Mon, 30 Sep 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687199; cv=none; b=uG5rzphyYtv32JPQvFwXva9kU9wxEltoN1owNgMCLnjwf1OPHD1QmRIYxxGpXbg+idK7ZAyThb0c7KlRIISMoHiZWAVgh/KcsURu4GX6UHsstTSsngcL8aQo+a1objAp2mEcEow07FtMRU8iwDSwBSwYbrxSPJZUNsQ1wWpoohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687199; c=relaxed/simple;
	bh=6CfvxrHYGFiEEtpC6SCQ6ifQcyQ6oKY8kncFGteASpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFAK3VNcSB5Z34WbtY3lEdoB5uMW1TNsTEGCsgpHKgGrhrzCsr63vjysjcHSzI2C9MRvemda/DH64I/BTPZPNafry2p8ZV+4vdRlJji8AbI2fGISSEL6FevHnywynoDlbKFQ9z8RECJk466mAyvp8WM1eUKFLqHYVRprq35dgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbJOHuAH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e758093so32542785e9.1;
        Mon, 30 Sep 2024 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727687196; x=1728291996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T8AFr4bQcCZmnOMOOHwvGPz5biZtlw2dtZ+xRXq6po=;
        b=gbJOHuAHzbq/bcrornthlPy1GaLZheEdSYMaAt1xiOIb0f+PrYZKpTXXAyuba1ZMU3
         n5WAJ55rgw3HLJozQEjpDhW/yB9NRjQT10dRltqAP9nrM36wgWXjKFInDYqN68XlWXUB
         THsoBoflZQSbiKFL5SHScdhd24zrBO84dDXMt42iFwM1KH6iK2uwNdqUW9Fr08UQ8kZH
         OHaU5gfwy0p1sZIeHn2Lfx6MB27rJrPGFNJPnbJMsrg0EaK5LvY4lfcb61NVbX1wIG4t
         dMS7QW1NtkBhOuF+uMOgQ1HaMl+sbhxLPhGcQb5Vg9aqFs3B+26ZPHxvcPoNfFHVJOkM
         Nlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687196; x=1728291996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T8AFr4bQcCZmnOMOOHwvGPz5biZtlw2dtZ+xRXq6po=;
        b=oCdtUCdDvnwIRNIIzMDpg6DbhMO8AUuv7uzy+SJ4XTXrWlhFXCMQXiMsR2q3Z0quEs
         +1JlAEzG+44FiUyAr4knJ8LG2vEhmbvIqM4/tNyQlHtxHfwZH6M2QqKZXLKqnot++TlD
         gu+P2qQF+L5ToEaySpZQl0CNxczQstRUxYHwKccJ8eWke7ovuJHZbJ/hg1mkZW82fSkb
         o0mPGoWBsFfF3I7YkV5B29WeWwBWAaG+IC2dmMCVBittrtr0ACG7YKB0iCJTHqyJN4mf
         +XCe4J79uAJlCM9eB2fPc6TfOaVU2uksWz4KHNorYH8DR4rpPg7FK1Y1ZFzpXT7x+DGW
         iyOA==
X-Forwarded-Encrypted: i=1; AJvYcCUkrOefnk7ISGGSAGv81HJBJuYsBmMXe+nYQrjkuVCyzl2JUkcbioaxEVEs8iUNzB17jefQFxRG68lI6T8V@vger.kernel.org, AJvYcCWjYI4tx8IySGvBvsS6JziG5gSmYvWIwr/e2EhLZLRndsbq+9ltsvSsJiqNd6Vb8w8zXYft/uMa95Eiap4Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OrMSTQulsoHjSnpVUMZPwjdXAuJHuCZXLvf9LJBBi9tztCaj
	faSELXo+fdtY1AlRRT2wYogfwGofx1VnutbWYKbF9T5tBvGjWd3K
X-Google-Smtp-Source: AGHT+IE6NnZTvb4qmbIWGzzx3TlbOvkKjzQPrdKGGkDQERZCO2n+QeWtsQr8b4562XtqBE03o3sTzA==
X-Received: by 2002:a05:600c:1549:b0:42c:bf70:a303 with SMTP id 5b1f17b1804b1-42f58497ebemr81465295e9.29.1727687195666;
        Mon, 30 Sep 2024 02:06:35 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:d70c:eed6:c2c4:fae7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a56fddsm144297025e9.46.2024.09.30.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:06:35 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: gianf.trad@gmail.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	syzbot+4089e577072948ac5531@syzkaller.appspotmail.com,
	willy@infradead.org
Subject: [PATCH v2] Fix NULL pointer dereference in read_cache_folio
Date: Mon, 30 Sep 2024 11:02:26 +0200
Message-ID: <20240930090225.28517-2-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240929230548.370027-3-gianf.trad@gmail.com>
References: <20240929230548.370027-3-gianf.trad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check on filler to prevent NULL pointer dereference condition in
read_cache_folio[1].

[1] https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531

Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
Tested-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---

Notes:
	changes in v2:
		-  refactored check on filler.

 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4f3753f0a158..88de8029133c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2360,6 +2360,8 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	/* Start the actual read. The read will unlock the page. */
 	if (unlikely(workingset))
 		psi_memstall_enter(&pflags);
+	if (!filler)
+		return -EIO;
 	error = filler(file, folio);
 	if (unlikely(workingset))
 		psi_memstall_leave(&pflags);
-- 
2.43.0


