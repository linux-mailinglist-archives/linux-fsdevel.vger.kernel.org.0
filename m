Return-Path: <linux-fsdevel+bounces-30435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82C98B471
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C81C234A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92E1BBBEE;
	Tue,  1 Oct 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMv8EPgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FB2F50;
	Tue,  1 Oct 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764316; cv=none; b=fjtI1xvtkmkAqc87PtcAD86exAzxYc9uS91J2TEaECkMQMTVQmyUyYfpT5O7JKrlWYAjYCFAl+bRk22FHKC9DRDLW7dfQHRb9+uzWJvITW1KFUBEqAC6RGHe2attQCHgD3jclB+5eaXc3v4XNoR3N6BVVVIwrNWlwrMvHjRwYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764316; c=relaxed/simple;
	bh=V7IE8NHdwZvkG7MqnoCNEa+e9sLgurK9Qa5ui+9fzqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tW/i2eZfVuJlVI4BJmwjqGl4NU29iJAhq1bfj0Iwxt6q6GSYdNJ8P7ClmZO3+c4rbu74+VcliPIqfdqsC9PwSvtvXUjOxq8cm+NUBVWo3FfogPz2X0U6RE67U9QXKzcNM3fn/3S3aN/3j7PApba5bkIMsAYLeK/rYJVcxu21730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMv8EPgu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20bb610be6aso1893285ad.1;
        Mon, 30 Sep 2024 23:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727764315; x=1728369115; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ietMyAYw6+fPlNA9nxxGMDX+EjbWGZRBErvoQIibJ1M=;
        b=WMv8EPguYNzoSohJS3kEuWQdRI/PgMQ+eS1tVJC1ELCyNaQkFaQUcGG9e5fVz8szZM
         vUOLEYu3DLzdGqxqT/NXjNi9IsNdjtGh0bGEQjar+qwQCZLKI0cX4aHPPYP3xMFonrdO
         QbK8SWlD+3c6U0fA2WffGEaGKChnXIoikWAxpnr43PWroWHSP8UOe5q7f7ajUNp3wkcU
         qeeKLHblXyPnPQf7pQ+w3iG1rMfmoWMl2K2laVhL0CLqeioLjcKxxOtS5DFKsxM9ZiAl
         BmvZBcjUTEf0QJfU57SaLwfpWb6PIEYSHC1scXTd1gcyytDc4r1aXzRrxwd7fiAqXK/3
         EY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764315; x=1728369115;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ietMyAYw6+fPlNA9nxxGMDX+EjbWGZRBErvoQIibJ1M=;
        b=A1YxgVlxnVjcyGEfXY94vB/pFPYOYpCx17hppvZlN4JzyIoa7sBcOBd1EZFbd2jCa3
         rQoUca2qRhAKqC2OOJ8VJPor9OtTYKr+155+evQhwloCrexGEdmXMahigpOJovnIod5Z
         tpr4h5gW+UPXpeM5XflXI8M6roV+FtNR7wOUc00VlXa1f/P0Pe+GKpUE+xw9jMX5x9o3
         /2ag1gskDQfrWcyPKMZplLdz3dDtYtD45aaYfnWw+7PZI23VswjQMdzOS59U3bwaz/UW
         rVaRzPCaOpvKp11WPIdx8oI5egVJEgBddGtRb8O2vIRXDGk4rd+JXw13Hr/CCUxh6Fa2
         TmfA==
X-Forwarded-Encrypted: i=1; AJvYcCU4L1JOMD58fgeiYwbtqCyXrHOY3+4N00prUPWSUjKx5UzRc2m4GBNeJrIKdBqnAind3ro720tT1UN5WVQ2@vger.kernel.org, AJvYcCUrmrykWUOcdv/KLD79jvwcsJuosBu9MigzELEcwWfpOFYg4Mr5plIk0WVMZ3LwZRsZX22qN/5YUxsXkezk@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaUZlAWzBKuXGkYKmwWfPGOYG/UxtQtf/9JKrcN9oVJ3AxYfX
	BniVhXjGIkqQFdsTwwVyK4B92LXvHSFRDeDSDY+DBcV0+RoNH0EO
X-Google-Smtp-Source: AGHT+IHgLTXQFOm2nfas7td6RKKxViMS3TnkaZ/ETwRUZ8C4GfYVvBwNgF/ge/Jym6wTwcUXDwn93g==
X-Received: by 2002:a17:902:e743:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-20b37bdc6a4mr193337525ad.60.1727764314723;
        Mon, 30 Sep 2024 23:31:54 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4e632sm63809895ad.230.2024.09.30.23.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:31:54 -0700 (PDT)
Date: Mon, 30 Sep 2024 23:31:52 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, marcus.yu.56@gmail.com
Subject: [PATCH v2] netfs: Fix a KMSAN uninit-value error in
 netfs_clear_buffer
Message-ID: <ZvuXWC2bYpvQsWgS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use folioq_count instead of folioq_nr_slots to fix a KMSAN uninit-value
error in netfs_clear_buffer

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
Changes since v2:
  - Use folioq_count when putting pointers. This avoids touching
    uninitialized pointer and is a deeper fix than just using
    kzalloc.

 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 63280791de3b..78fe5796b2b2 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -102,7 +102,7 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 
 	while ((p = rreq->buffer)) {
 		rreq->buffer = p->next;
-		for (int slot = 0; slot < folioq_nr_slots(p); slot++) {
+		for (int slot = 0; slot < folioq_count(p); slot++) {
 			struct folio *folio = folioq_folio(p, slot);
 			if (!folio)
 				continue;
-- 
2.46.2


