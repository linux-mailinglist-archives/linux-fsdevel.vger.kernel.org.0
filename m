Return-Path: <linux-fsdevel+bounces-29139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6D39764F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830FF285E15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF1192B8D;
	Thu, 12 Sep 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHNnCAO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E711917C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131145; cv=none; b=e0PwCAt7D9g1PPE419mQ/h8IzYI5959EzuvG5kjW1mRypu9z4ZtRfAq6io/ahrsKQIQB+qZN24CT5FdBb+t5CC054fVy8qcwJ1m2zfFHlu9ASncgVOZzuSFArORb85mpbR2mKPFoa9Ho0ndlw3lIUQHEWiKSCO4l5GSKI6KKr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131145; c=relaxed/simple;
	bh=+Uv1yRx1t/nh3AdvtaBsQpatvoFp9YWwQHVWraJdMZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L426VQrkLwCkfc++7IcTpCFvreMXc+4SgvHoFvYKt0896PO6WrhqODIN4O8ohtywozV5NOEhEP9fnwGx+Z2P2R0o8RlvMzXwJLx+aCAs5tbiVQP9x/FjXXdQBmgV0ChFYTF945ipsBjcvg5GZx/8EnrswdksgWwRUc2snJOSCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHNnCAO4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so7445245e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131140; x=1726735940; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jfx4IHYM/f9TvrOy+r/MT0ESdhaPDLWNq6uOUg30aAY=;
        b=dHNnCAO4zhZC+qsMBiIoDyxScRAY6ZFWHKAeJJZrHWQWIegYrqq7DZA4plol5xZALa
         oStXpSsG3TCBOAQ/5x2lXzz6rI5nIVc38cbamWqhS86GaxUyti4G9tXUh06gyKQrIdFT
         VidwLHdWyRDA88uZWxkCdU/Cc0W0AiPN2/VHGEIT3S03qJ1L3kNxM7JxH+RW7y8QmDf8
         bDryWOEcHgMATg54uRn1hWFWoMZ62eeG04nwQaA9+ULqWxffK20RaZhhA3gZXVqgU5Ac
         hZ8lFshApIV5bF5mqYUCbT05a6oPnD3+Wtl17D/8z5ti1gFNzEYY+eyO6CaeDqEc79Sq
         Bp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131140; x=1726735940;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfx4IHYM/f9TvrOy+r/MT0ESdhaPDLWNq6uOUg30aAY=;
        b=T8dq9+dP3x3nz9OOTbx2h/nFDDD1JX5NVJlI5NvDJVkb/L6FEjb+9RW6pAusXT+ILH
         c++Oox3WfDs7UWaTl5jgY9d9nbULr3xcQ3ujqrUM5lkMNP9Qh/oiBKy3772u8TjddfrE
         CyMlrrxi6f32nL9DZtAmakzoGrqfskzlEVlBxQwXmV2MlrW6akXsxvq54P4VvAZ3AKhZ
         G68MswNULVmhhM14Y2vg5qloUM7UjQVeO3JidjgdbzIE0qYIO2U3umPNp72BlkyIaxDf
         iWbly/PIINYZXJwvF+uhsCODi/DJP6f8xLo8SS6eLjgz9/F3LOTlQDsD2V3F5dkPnZ1e
         HBOw==
X-Forwarded-Encrypted: i=1; AJvYcCXb41426aVECUkDh1baw8RLpKyNJDWKNB0Tk1u01aRfhkVFieQAq75ic3ZFCWSEvqbSZcfocr3AFECvk4UJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxnS4FW06LcwxnBlNeuRm1uryAuyp/TGmKIuEE21XKpcsuF0q51
	af0+KBxSRMKWaXKjBK/eyXEYc61s2BI9UIYwSZDVO6Mz5s4/UIiAY7NVGdlykZ4=
X-Google-Smtp-Source: AGHT+IE3JvQVI8H7Az2p7xH5qjI8YDyhtJ3aO9BUYYnl2AM0k/tr5zbW/XahZ19yePpZcAyKjxL+wA==
X-Received: by 2002:a05:600c:35d2:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42cdb5112eamr20411895e9.3.1726131140394;
        Thu, 12 Sep 2024 01:52:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm86851825e9.0.2024.09.12.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:52:20 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:52:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: remove some unnecessary code in netfs_read_gaps()
Message-ID: <df691112-1114-431a-8c71-09d1656f0771@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We can remove the "sink" initialization and the check for NULL.  It was
already checked for NULL ealier.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/buffered_read.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..9f96844205b1 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -481,7 +481,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
-	struct folio *sink = NULL;
+	struct folio *sink;
 	struct bio_vec *bvec;
 	unsigned int from = finfo->dirty_offset;
 	unsigned int to = from + finfo->dirty_len;
@@ -540,8 +540,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 
 	netfs_read_to_pagecache(rreq);
 
-	if (sink)
-		folio_put(sink);
+	folio_put(sink);
 
 	ret = netfs_wait_for_read(rreq);
 	if (ret == 0) {
-- 
2.45.2


