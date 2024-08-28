Return-Path: <linux-fsdevel+bounces-27651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8279633AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BA6B22045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006B1ACDE1;
	Wed, 28 Aug 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i9og3gst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A81AC89A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879689; cv=none; b=dE2vdlN6IXnd3nDZjhc5haPsZRcVjuhxKdnMnRjgM2jjyRIjhND2yDyO0NHNhZUnGR+DEEXwoWn4VrIWB+iORFO7vPNcbJ5uPmMXrqHUCxsFwnkwTdE1mGyysd8O2ClbR65p+gTtxAu0hImhILpG55mHPAxLAZQJq1m6QEddM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879689; c=relaxed/simple;
	bh=y4QahrmTUMKQVV2JMmvJZB0ByBfJqirYLBWu49zssEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIIekCNUjomJKLZQG2H4Lvl00pnXkE9C9y3Vwyh0ECpTLW0PruzDHpUynkxENbxPK90Vjz4+FBhPdTFYU1gNYgQP4EAK1PBlW8TuPyoZzFCAgjAGQTdoJnN6n2TqXMgU4aQWbUtsF6q/jtzdtgFZdFRzhkskka2uDMHqXPp1Yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i9og3gst; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf7b48d2feso37683196d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879687; x=1725484487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwLAwhjDUEdsahEgqv/OLlx8yFCmH3GI1KdeF6Nt2I4=;
        b=i9og3gstA9/oWCU4tfI1acpYmJwILfJlXGYHrNx584p0VZcCu4pAFWaTDT9IqtiISb
         1WcekbLRgezXsfHI/Pajyt57mfZFZldN1yEs6mTa/kRQqAH6pB5QbxFFG2/TSpUemSJ6
         /D+c0dFJx2NiK8nmcfLW15zzq5kyfgFDA8Y32SX5JOpsBPHx52NCHi9nV6Xb1Zg+0mME
         gTNsMG+KdfuZnc7sDn9xtofnvs5A6YMHAqAb5TOX4sjJBrM9PU5ECf6+ukPxusC6uH7H
         K3kIJEMu1pMvfilC6HKOQjchk0OpUW9qO4ZuC4PsHYL/BQ/KHYzP3nhLH2aEsWnQwG/E
         nozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879687; x=1725484487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwLAwhjDUEdsahEgqv/OLlx8yFCmH3GI1KdeF6Nt2I4=;
        b=ilJ/keVBJ+Ry0VQOu+A1UvRqueTsAWKRB9OcisRTzZ599W1ptPB3UqXSOWPLZ4ICjX
         qxOHNkuvt44djga2OkgDjG60CXlWdzhtMsLrM7NRfRoITN44HHkO9MTHFVBSdypGif6j
         qy2V2i4SpfYZoyNN2m6KTqQ/AMRJQOdfoS9wpu2n5Dbj7SfBLxG3BZrsXxwGF56roLY/
         jZc7lOWsDGNbIrBxJOg0V4AFPLxNRgbX+8jirzfhfKfwQ4qEpZTiMSswk1MlFFhG24XC
         d57JIsi+V+IdX2KEv3ZWccSOBbebYzi7PNfurrgmlo7pNC7rq6SNblnBbSRmY7hL1qoV
         2OYQ==
X-Gm-Message-State: AOJu0Yxet5lBPNC5WIfRsOXt93rjk3VlGmzX1xLemxZtSC0q/dL4h9Ej
	fQDNVoenA3V3x9p8mYXGzGt1wINYANU199eG4Ycmcj89cPABv8witeLSLGX7kCjiP6W6sIQ9bAS
	l
X-Google-Smtp-Source: AGHT+IFHHgHWjK+Zz2P4+tMOgJrZ5Ro9UEYYQjZrPlmaLaaDNzWdpfxb6JfGsHdxTZQvQhf0TaE77g==
X-Received: by 2002:a05:6214:4890:b0:6b7:aed3:408f with SMTP id 6a1803df08f44-6c33e626481mr8394886d6.13.1724879686371;
        Wed, 28 Aug 2024 14:14:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcf034sm68009996d6.106.2024.08.28.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 05/11] fuse: use kiocb_modified in buffered write path
Date: Wed, 28 Aug 2024 17:13:55 -0400
Message-ID: <f1b45bf6d5950678d1815a5ce70a650b483335ec.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This combines the file_remove_privs() and file_update_time() call into
one call.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 830c09b024ae..ab531a4694b3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1454,11 +1454,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	task_io_account_write(count);
 
-	err = file_remove_privs(file);
-	if (err)
-		goto out;
-
-	err = file_update_time(file);
+	err = kiocb_modified(iocb);
 	if (err)
 		goto out;
 
-- 
2.43.0


