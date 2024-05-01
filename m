Return-Path: <linux-fsdevel+bounces-18457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A4E8B9221
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD416B21650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 23:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4216ABCC;
	Wed,  1 May 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+DaOK4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6B168B0E;
	Wed,  1 May 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605384; cv=none; b=IbavUmyKX2Sp1KhEeZ9h8E9YofQKB+/NnQJNMMAJz5dUpqR4TjsSHkGa2OtgiZkPYIaEkdj0AMGFanEjKNNZLnCJtgjyvwfbD/jPUBZFm+sP06pL+l/WQZyp2W/HmGL39+SM4i5Hyx7Ji8imVEAePQJu7jeU3Ipq7lIZnlrP9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605384; c=relaxed/simple;
	bh=LVTRxX7tLq7xv4yBLH62hWiZmad+nFmuL0ld8JvIORw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9XMhyXFb87shUXVMHRGTB+6cG5TnH5+6NXyxUML9R2iMi5NlF5hbvYFRDIvUPhjSVbi70lWySa4kGA7soYlN3xv1l3LaWFakslzGxQdhtYezl4wGxdg0HCCKHOCmMmrEG5bn9Amkjh9h7zVpz0zayDIxAv+fmJO05HfiF3Uxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+DaOK4a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so6605345b3a.0;
        Wed, 01 May 2024 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605382; x=1715210182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmcu32QBa6xSD4oxR6+wMTBjSGBoEIYCz1OYpSWw4To=;
        b=D+DaOK4aHuApvGchp9R0IGIaqh34ygppx6eB1TOayy6hXpEyAMzxC4dXCMS1QC74uR
         u+gN6bZlyyi3KJSSmZ0dLxHB3p07TjUXcfFzaZ4Qww2DWT8zoOifPPyqIGoY/Cr4VxO1
         fAPbjHIy5HyH2LnTiNGyEw3CQCqv/3r7el3mkk0d3P0HGd4EqJOc8zXmYtMlMWh0Q2RN
         JwpY3q3k3UOurfzk4caHdtc2V/7BPMVmQMy2ypP7Hja7I6oZ1ZGr4Y3abXF+DQHsFCTp
         ft2FUuyGi5ZrdaOEZm4hA0ll9/2BLLtaJbuaZwI+28l/9+fOix+aHTLrxhLHXdc5y0A7
         c4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605382; x=1715210182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmcu32QBa6xSD4oxR6+wMTBjSGBoEIYCz1OYpSWw4To=;
        b=GrZpjYQeUuk5VQd+rzNrBPkGRxcV8Bb4SLSPsgQSWdBEWrlDxor3JAcTh0gZeGgN3C
         INqyfd/oLj53WxmWhTDcQpa4BpHHNIDderaHcLCUYblwvaWib1Eu6LwAr5O7d3p5g+Hm
         pbpBivBhVM4k8cGr6YCqaB2q3jEGXTCSen7EuFQWvjGJ1LvN+kkCCi0DjnyX1PjW6QA8
         2VbLYu1XxOVi327c6GRz4Lzku5UycZMKwWV0s30EBslyt9J9pGjftppUcE97G4WZawxH
         /HaTiPWqDlVHisSJbgw/w5Kyrg1syLO4ulf3dZYmopubVO7Tj/ilXbbEJ/TGn1AjvQwQ
         OaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWrwcIX/RtQM2DlD+a981G0Wbq1R6+v8sHsOf+lEP2JFkKa+WJewOa05szp4DilP2eVbgDrzobBgk5igizDEx5R7oeDLTbsRl6VExbZH8glvShidOu2bdj6lQ7znZ1Iap8ET6b20e0QBGKvlbqJPDejk4MGRyPXQMs8Nwy1Z4UzYw+RENz
X-Gm-Message-State: AOJu0YwBNKudxFmzZEUph4Y5wZ19aIo9rcMIlUM8obgBp0QCtRdlIH9S
	20SfJSBBLgGtF4D3pFsLre9TmP6cI5OC4rQ3SZ14Wsof7i9S53F3
X-Google-Smtp-Source: AGHT+IHnTxtHsZ+glQR9x2lWb15F0oxsmnPv3fVD4DBzufkpvyplQ3E8IYw96+JvLkK9lFLm0fVsAQ==
X-Received: by 2002:a05:6a00:1390:b0:6e6:ccec:fdc0 with SMTP id t16-20020a056a00139000b006e6ccecfdc0mr494980pfg.33.1714605381730;
        Wed, 01 May 2024 16:16:21 -0700 (PDT)
Received: from jbongio9100214.lan (2606-6000-cfc0-0025-4c92-9b61-6920-c02c.res6.spectrum.com. [2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id gs18-20020a056a004d9200b006f3fda86d15sm6323389pfb.78.2024.05.01.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:16:20 -0700 (PDT)
From: Jeremy Bongio <bongiojp@gmail.com>
To: Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jeremy Bongio <jbongio@google.com>
Subject: [RFC PATCH 0/1] Change failover behavior for DIRECT writes in ext4/block fops
Date: Wed,  1 May 2024 16:15:32 -0700
Message-ID: <20240501231533.3128797-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Bongio <jbongio@google.com>

In kernel 6.9, for an O_DIRECT write:
xfs - Will fallback to a sync, buffered write for -ENOTBLK (for reflink CoW)
ext2/3/4 - will fallback to a sync, buffered write for short writes.
       If iomap returns -ENOTBLK, write will return status of 0.
block fops - will fallback to a sync, buffered write for short writes.
zonefs - Will fallback to a sync, buffered write for -ENOTBLK.
         Will return the bytes written for a short write, no fallback.

Relevant commit:
60263d5889e6d "iomap: fall back to buffered writes for invalidation failures"

In most cases, I think users would be surprised if an O_DIRECT write request
silently resulted in a buffered request.

The iomap_dio_rw() return code -ENOTBLK means page invalidation failed before
submitting the bio.

Is falling back to buffered IO for short writes or -ENOTBLK desirable in ext4
or block fops?

Jeremy Bongio (1):
  Remove buffered failover for ext4 and block fops direct writes.

 block/fops.c   |  3 ---
 fs/ext4/file.c | 27 ---------------------------
 2 files changed, 30 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


