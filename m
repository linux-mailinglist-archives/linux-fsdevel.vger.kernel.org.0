Return-Path: <linux-fsdevel+bounces-57732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221BB24D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F148877B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E121D59F;
	Wed, 13 Aug 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh+5l+tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276D1FFC48
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098426; cv=none; b=RtWJo90997aRsmHLVhF5Ly0Z1auNAyACBjq2W9nKoG1lO9vxwaxpUKU9ur2ThK4AM00v4RrUcNcdDhJ0qVKpnUiMbzdkBYFec+Z+rMQcDxg/xkKzBUMVIaNXcwg8GKGrEHFJczZp6PwUBQ5ORgMDTiJM76o2qG6S39AjkuGk87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098426; c=relaxed/simple;
	bh=J0Olzhfp398H83g4qgU0KwPikf1DxIDwgtT/Xr4oxYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h57KroaeNoRPzKVcXsD7KJEbbU4++oiTnTDOcyUsTIus79hZjPXJ+zDgMnhzRqf7FnBFbg5/IVx4yFaccsATzY4lTYaTxvXBVXvQTepCo2yPCKxtErpwKkob2idsChuihLaKOaHn+YsPJkThz2EU1NTgxTCmPzwinlsLOsyJ7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eh+5l+tk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luPG1goyuiBS0FvRsoCQ2oyoviuaJXbbLcf+yNSBvlU=;
	b=Eh+5l+tkg2Yum7XVx3CXO36zImngCJokjXthGR05nRZc74uFIB6w+TLXl11sFMeyNjpMSI
	kE9sGaTY7hmhKU3tw1fvWWkNBIRjPJqzmTCiCoWI+utGbrJGGEyzHTLIQKO41uoZQ3101z
	z43GMYfVMdX8PENbsQYjNFXLZ9B8VHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-jTcolfqKMw6AYEkGwZ0w5A-1; Wed, 13 Aug 2025 11:20:20 -0400
X-MC-Unique: jTcolfqKMw6AYEkGwZ0w5A-1
X-Mimecast-MFC-AGG-ID: jTcolfqKMw6AYEkGwZ0w5A_1755098419
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459de0d5fb1so51167775e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098418; x=1755703218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luPG1goyuiBS0FvRsoCQ2oyoviuaJXbbLcf+yNSBvlU=;
        b=w47Ufyx9LZD/x5I5u1qu1XHZ0MxuF7AsRQ2qwj9lxted7r6zZRz2b7oxfCQOZyTYfl
         46VKRL9Bw0TeXmx1N1Q7KvcuCnrDOHGl/KCJ1A40lrZUDRnaiOfOi5hM7WRI++EbYk4M
         IGZqyWT5EFSVovbprWnFGPGDiWnVNSlQxIzyS4VcLx4wI2h9hv1qKpP1zGH8OJRuuVHz
         MsWwdD+FbhJqFafW87jGBtbQG52Uvy/exeNMnUMTA6f0xL/0PSohPBH0mWu6F6nKLtRw
         /x4uw0OQTC7hVFqWrsWLNV/eq3/F4ldpH8dTNnuZZ/+6CRpt6JlTTTW5WR1h5M2ZNKQt
         53jQ==
X-Gm-Message-State: AOJu0Yw78+GP71wLHazbGRh0EtyFj3LQIc5Kvu7x9D6bg6HMSXVeeSun
	nEMSQzi84PQVPRs6Xtp8y1gO/6t7rm9qID5Ldd4JFNdIy7xViAeN8sDfm4CHVoApvhYJPE/7pey
	/+yv2+mN6ZnlxZEjhtzr8pMVS8GGhSICGyQrOCuKj4O7TcXHIl92inbhHDTarSrrr7jAXjhF7gZ
	nqT8W0FQeRiVp2ihJ0gK3rjYkzrI+dqq+yzYMMxnfIf+rWXjFuRroy6Q==
X-Gm-Gg: ASbGncsPaVLuJOjmfEeE/KkAeTpLzFy9uX7PIexDQUZzphJ2mdmonQIJw4PXp0c41wX
	q+XBomf5qpUdeD00j0oi8t6N/4hkqEkhp4FM0fNEmb7lAEahlDu2r288xvVl7Y37nCbJ2u6hE5Q
	aszAddnRJRptlH0D1KjjDxpCOChqtbx58lRcj6tAol1teXm+qlnq0z+8EK/8+aKkQv2btwtbxBi
	ImCbBvESXlRo1QljGHIL5E6xICk+z37qtV7omuO4o61GyugWUaop4BfFat0LmOJOVxE5JJOx0VP
	KOKyzU64boelomhUUrz4luryPcSIVCnmemyAEY6WyCbCuUAedYmNBwPQExMFWjJT/Ulqhm2itMx
	55jf6Uin86zu0
X-Received: by 2002:a05:600c:3b16:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-45a165dc92bmr36316555e9.18.1755098418241;
        Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhftQeRBnMTP79oYeBPrLVQFcy0YoWKK+VKIdNr6Tz5JmKc8vfXV57DQ7KTU8XyYnvbwoCgg==
X-Received: by 2002:a05:600c:3b16:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-45a165dc92bmr36316075e9.18.1755098417643;
        Wed, 13 Aug 2025 08:20:17 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48584381f8f.68.2025.08.13.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:16 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] fuse: check if copy_file_range() returns larger than requested size
Date: Wed, 13 Aug 2025 17:20:11 +0200
Message-ID: <20250813152014.100048-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813152014.100048-1-mszeredi@redhat.com>
References: <20250813152014.100048-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like write(), copy_file_range() should check if the return value is
less or equal to the requested number of bytes.

Reported-by: Chunsheng Luo <luochunsheng@ustc.edu>
Closes: https://lore.kernel.org/all/20250807062425.694-1-luochunsheng@ustc.edu/
Fixes: 88bc7d5097a1 ("fuse: add support for copy_file_range()")
Cc: <stable@vger.kernel.org> # v4.20
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5525a4520b0f..45207a6bb85f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3026,6 +3026,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
 	}
+	if (!err && outarg.size > len)
+		err = -EIO;
+
 	if (err)
 		goto out;
 
-- 
2.49.0


