Return-Path: <linux-fsdevel+bounces-53829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F88AF80A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C453A0606
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71802F5098;
	Thu,  3 Jul 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g38Tbq8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941852F49FD;
	Thu,  3 Jul 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568659; cv=none; b=ub6TJo29RQEaUVRp0mMKLlXEp5FlFL5bHEKMJFWDV1NFFQY7qOzRxqQnA8hM6ctq5oqHnc7fBsHlU82MdD1R69oMOsmLuzWIAdg+IuzzIrXS2sSx7gxzw5qxxOKMW72X4HN0P7UiRaECCf+z9Xhor/uIqPT01R+Y6blQFCBItk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568659; c=relaxed/simple;
	bh=9z/0+wP63OG5wXftLWkn27sSwdysRUwo3gRSnRSt66U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMWHow8dL7Nns5Egqc9qxNYMqzqLi8nKN7iEixXOKWjvWA/RYBEefjJFywYdvMRcwkC77AMdRm4rkDY/Uf4ha/02ficMGrDV5czWfjbL2KyoTgKwmQx19TFqhJuZEXUlZWGNb8IdAw+o/yh5O1Ui/Zx2TZAJMLJV0p2k+u2k6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g38Tbq8g; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c14138668so96510a34.2;
        Thu, 03 Jul 2025 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568657; x=1752173457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHFHSP5AI7GYN3LviveRts2reQTV/UFJRypYogMzU4M=;
        b=g38Tbq8ghEAz5EJUZcKjNtNc0Icf/uHsp9c6BNxz+M6RxENGeXEjELrK132DVLXqg5
         Dr0DAtXqXnblS/FqCn0mFgyJ2eLeFyUWf0aZXZ08kFpvFrHf1CnAK0w5Yf3FSVYQzvSk
         9q63gAei5QC5/r3DNJWlP+SvU7CFJ17S+FhXUE8K/VdPfOY93QY0gGZRXExDkH9W9lqK
         PHhAYcpNv9EcjpbpJ7FBwwnk+7Srl69syHAI8sqZePft+9VFLrV/lg5a1NDftGOXS1Td
         tmBvND2MeveghiMdlH/QU+cIwopYhsXdBTQJaV7hDdIr7G99+FMrftneyijxuraM4n3T
         IzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568657; x=1752173457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHFHSP5AI7GYN3LviveRts2reQTV/UFJRypYogMzU4M=;
        b=Z4LeIfY0tif3q115ulVOuwnS7R2B1Df857zxLLPzMDkzIRKhwtbIhe07tqd1MYSUg0
         SjxKSgjrEy8xvk4vkoID3pRua/+BJ8d1tNhDgyjCg4Bh4EFfffGDTmLCDvNU0LA2sOjt
         N/eHHHMMzOo6mjyfh/qkyprXlVoUckCVraGyKM41NeUUCo2adYzEz/EcGVW6PBvy3zA4
         LrjipHD2HsZd+R+DCvOCBVmVCE6ow09dbZvmnd8cHmmaOUlC2MPfhP9XQvAaLU7FWeKV
         tLlrP5U4zZgDaU7PAusf+Q3AenQ24q/Ck1tw6WlaOFDHEb9fStaVkYCpgtFxKzuZUIQ/
         YCNg==
X-Forwarded-Encrypted: i=1; AJvYcCUXTiUIFVJfydTfeR2shBPwUoaMjYGUI1v8Lsy+ptBsOh3/UmwGuMErBmTOgLGI7vLIAF70LzCXSVJpk1xkqw==@vger.kernel.org, AJvYcCUnKlb4EA1BkR+HoEsxSh6LpCRer2kUd7T9+9t+AasOae8k6dqaih2c3LNEsFiwGeYJC4jTLtei/AXv@vger.kernel.org, AJvYcCV7fQX08uNm/o51Iq3REzZkUw2YynN/MiNV5eecPJjVozxHszABjZSEbz5yCFqXx1WdDWAVYBF+WR+or1pI@vger.kernel.org, AJvYcCXusgD9Wgpe2ei7aIF2tCctS9EOx7OteJbZI3vXTDUcAoQ0MKLUYg9qcwS1k+apGCvpOXE99mPcNzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8MujzIX2m6E4I5gY/LkhBIdX1HcZ8pCLSs8Uz+x4YQ0c2DTf
	lVZM3Gdc2//TIxhWfhOEyTbGLMZMeQh4IglOXOYMW6KLsRyKAfGXU6xV
X-Gm-Gg: ASbGncs7hm3nZfCsZPWcSF8R5fLDm9mXFQDcYOTI1XtTP62cVMI3ETG56so2FOMWe0Y
	H5tOe/RAYWqcHMQRZHJqIs/LqxZA/T+o9JXkrs8ylkUgpaMUq4+BimMUNh0wNOIOJPlInJZK3aC
	X3FSQTgKpFKjU2SeSNeitgukwHLz9iVldLn/lG2tNJZWEOUDKwnHyM4zu4VK7mC3J8MU6/2NRXt
	6DHIoYNuk2ohMHhOKQolw4L0w1MCupyPMWBn6EcIPy/JCmaQQ8vmhTnPVtTeuV/ZLFmaTYIO9A5
	gHvJw9bo0mFW19yzMZ/IRc1IXJOQPAeDpbnyIhV9CRD2vZ7BVgGYauCgkqJRicB14v2T6z2Dr+n
	AaQ+S2oz57Mi9jw==
X-Google-Smtp-Source: AGHT+IF0yW0ffG1FgWh4UvPzdITwKwUQUwagTaujR+MOBNLBlFUmukcBu+glnTJT7fKxI7YS3bMYPA==
X-Received: by 2002:a05:6830:440b:b0:72a:11aa:6ebd with SMTP id 46e09a7af769-73c897e113dmr3275732a34.23.1751568656688;
        Thu, 03 Jul 2025 11:50:56 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:56 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 06/18] dev_dax_iomap: (ignore!) Drop poisoned page warning in fs/dax.c
Date: Thu,  3 Jul 2025 13:50:20 -0500
Message-Id: <20250703185032.46568-7-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just works around a the "poisoned page" warning that will be
properly fixed in a future version of this patch set. Please ignore
for the moment.

Signed-off-by: John Groves <john@groves.net>
---
 fs/dax.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 21b47402b3dc..635937593d5e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -369,7 +369,6 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 		if (shared) {
 			dax_page_share_get(page);
 		} else {
-			WARN_ON_ONCE(page->mapping);
 			page->mapping = mapping;
 			page->index = index + i++;
 		}
-- 
2.49.0


