Return-Path: <linux-fsdevel+bounces-69378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A3C7974E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 663C44E390C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EC34C802;
	Fri, 21 Nov 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx8rZv18"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E11F09B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732056; cv=none; b=R70vLesbuYN9Id7tlgq4X+j9PHG3N7uLxINe5lvsDPrdlxlJjntboyCVBmgPFIszIdWOg7YCm7YI7vfj15MTx+hpOF49hhVnbwRqYhXmjxKesFWmHQuAlxvmTlFkG/ct5Xq0HS2IhHfg3MNS/jRsFbL7+Dgpo54cnYAiXDTc9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732056; c=relaxed/simple;
	bh=zQUJYBQmVk0ptf5pEgHcnojTUQKHmZAz1Da32yhlxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WjuqDP9mVTBnPKpg30vg7G+bDImyjPUCqhjNIzomcpzyoMa32r9F+dpmiHo8PfmcLsqNIquUGoqyg2bKkrr6O4t7VwIXmB70WkEiXgaIol9annAXGMEowHCOXFn3GDAxrx/7t6e93Zt9MJI/k+tFEdbe3LV3OW9WMxgsqF6pK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gx8rZv18; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so21910895e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 05:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763732052; x=1764336852; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+L4T0l17WSA4vjG+LcSmcOxNpZmSPrGCylTE0ZSJZE=;
        b=Gx8rZv18ziUuus34WjMIIjx0W2fJqdk5fGwFyfP0IVcN/NKcULkyArzUYdz/W3mqbY
         9WqAUsY9Z1MSv6+IQg/H5/mZyk9xEtFhc2gBlWcpFT+oWvZAx7LAKNSKTSVmM88gW3Nx
         a1/iUuqpgWZwCVpxhZfpj66v5P09296SvUXEHl3IY1ijEqSHtACsd0UPxThdw0yTf+YJ
         FE0wWBBmZWfboOdXDTDNyLKW9eegVDhTNeik1q2b3gkeHis1tCWL0UBh0HLTN0Dr5IUl
         6019lvIhyy953MzODmcjPiK3eiVHAEyT+RsEC272x/6mxzbPrukA5cHnL28sDcyIDxLs
         tRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732052; x=1764336852;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+L4T0l17WSA4vjG+LcSmcOxNpZmSPrGCylTE0ZSJZE=;
        b=azec7P+JggK9RVsoHnPlu3NpEqoNSEz0RIM9No5AJwe1BgaHNj91igSCRkoh4SKcys
         rfDh02wNxJEQKwoFkqKtBOl4yoFCetsk7wxNlnFv+JiFB+JeiqMmH0FD4eXt0cLLX6VV
         E8/ZKAdSxxfXjtunNkjlwDGUsJ9UNJuOiwo3FHui7wEd5hTkPeQYnsCcfSeajiFlv4fb
         YoFEbxaiKa/mzvkcMqBsrxwww6N1kKWgGaa3FhdJowAVrALQCod9xjWUqk04g3q9Msj/
         +hi9gumyuOzCR6YBexjZjXgwGcvM2iCceFywzNzcYOgAhRrLtrioIfEljMWhgTqL8U8b
         UGsA==
X-Forwarded-Encrypted: i=1; AJvYcCWuqhCVEcNEFuIha3jTKGZq7pPlIr3jEulGtnYiZb3P2aA+Bi6cRy8/q/5MCbuTyhPtpfPERtGSgzp1doFi@vger.kernel.org
X-Gm-Message-State: AOJu0YwLATwUKqfl0Ci+96u6GvxsO9ZRc8tmKUFfoTBkEYT/JfwHUZog
	PdprFHOE6jLJ4S1liqpeD3d817X/gijyJaTsFgkvzV1Us4Bvoi/IPbPW+3+1giiDa98=
X-Gm-Gg: ASbGncuUJea1QDGnTzyhhs6h8j3uEorcka7nJf6baE9or/7Ge5x4S2zn5yv5aYh1t7m
	AZgCGRuzRPZWD/T2H1E6VndOiU+0O+iP/D6S6S5CVeDaAhMwVtwdPh0A4p9SAPob9ZfJJeMbwHM
	HATftTY0DzT1VJoQOTBoBsVFuYLfso2wcRvFwUM/cG97KB7HqMr9STOsGqHyFFHvddeazjNZ6M8
	tSRYAw+l6U0XqJ6OwY0ftmhYJBKZPI4A3hdRED1n6xf2A9jBdcrzj/DKPLPZ3gt71tIJelBJiRB
	NSsC66l86jb7n9OfHiRCGcV+vNd/mQqP4GoegH18aK2GzfJq3YEmjWkk/pxDgzfXm3BKb0AJXmg
	QUMUg3jEhmsJyBufq1ziMvURik+NqlhFKEfqdsANLKibv5wtlJV59DRISZUxfpjqrGXkC/3fAd+
	ogTxYb2fVMjhD7dn3s
X-Google-Smtp-Source: AGHT+IF1+crTfIYeEU9M7DsXBYJ60sLjbKYxri2d7Qo/kMnDk4ENkEccSfjGCmcuopV5Y5KjHpyOyQ==
X-Received: by 2002:a05:600c:4691:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-477c110e521mr21905045e9.11.1763732051761;
        Fri, 21 Nov 2025 05:34:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf22dfcesm43851275e9.13.2025.11.21.05.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:34:11 -0800 (PST)
Date: Fri, 21 Nov 2025 16:34:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] fuse: Uninitialized variable in fuse_epoch_work()
Message-ID: <aSBqUPeT2JCLDsGk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "fm" pointer is either valid or uninitialized so checking for NULL
doesn't work.  Check the "inode" pointer instead.

Fixes: 64becd224ff9 ("fuse: new work queue to invalidate dentries from old epochs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 761f4a14dc95..ec5042b47abb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -201,7 +201,7 @@ void fuse_epoch_work(struct work_struct *work)
 	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
 	iput(inode);
 
-	if (fm) {
+	if (inode) {
 		/* Remove all possible active references to cached inodes */
 		shrink_dcache_sb(fm->sb);
 	} else
-- 
2.51.0


