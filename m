Return-Path: <linux-fsdevel+bounces-21344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E5902634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AD81F2332A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98185142E8D;
	Mon, 10 Jun 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9y2KBuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11871E86A;
	Mon, 10 Jun 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035237; cv=none; b=fWnswzrW9N384BACWAlBC0nKGH/iKzJjZgP+NiNg8dBaFaJE+77ykrZ2Yi5aZ2L88hhyYm1fKgXuinV9VzRHZMpQWqvX7duH/UHaWEd4EZ9/lERHtEyLb6c5N895VUpoIkagKSRkL52yzkaM4dQ1hVWoF2qfL5XcOCrUQuuHvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035237; c=relaxed/simple;
	bh=HCVWtCZ8PFOXlB+wK7c+ca5XoCFrgynMHlDeMP6f9bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=peskzgWocbvgPLHig2t0ZcQMyL7DMpsqV7VrJSSft+AZPMFy57Qt6U2cSopaPXMs75LOpgtUmzrE0Z73fD1A2PdMIiwk5ZBKfzOIbCmbbl8+G3V8+jnheaQMd1GUfTyaz4CYpG+ZJtSfASfwa692k1KZv98LKx14deWRYJCJn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9y2KBuQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6819d785528so3035035a12.3;
        Mon, 10 Jun 2024 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718035235; x=1718640035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2uFsjZY59HKl17I9IjmNWHWtW0Dkg82qvwOhOjzL78=;
        b=X9y2KBuQ+1BDrIfDj+Tn3kjfshA6C6Ql8ymKCqSGcxxU4da14ApEfo7cPo1MQgvVIa
         z3B6/EgFVYQpRBMQcvO4AMFBJIO+2wZOdKct+fDGQgzYMyp3jxMxsZvSw0HGatg87z7s
         /KtKYAnemDNCiC/tEKKkhbAvtvjbYFwjDUFvB82cgOdZMvG+BEMaghRz0tjVSHoTuhZ1
         V9pcE/YCiYNv6AVIxtvxrysOR6fC4gaLqU7FrqAxczBeQzBRkPAK7LiHY0GuCe4CxNsV
         PexoNKum1sJ9UTqwyD7Vqy4UBKRD6qNbFPR7Po94G2Iupe+prxlXx5q79HQRx9y73ICa
         q9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718035235; x=1718640035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2uFsjZY59HKl17I9IjmNWHWtW0Dkg82qvwOhOjzL78=;
        b=hLxiZOra+MTN4jBYmafGy/zcCOJLoGn9068bEDuqlew27UCR5pN1zpL7vSOo7NZIyU
         Pdd2ybVo33XZkL02kY4RUSmN470cRMruuuWMjEpNyQJsnG9auqA/s3JGp1tjo5aYYGfk
         wJeW6nLdVMhhhd1b2+mh+lelP11laTKFQC4hsnwJGbuyQ9hQcfm2Vk840Ho7TS6XIqLH
         d2YocnlL18iGXRYb9MavCHFa8Htx0E54gtqMjFl8GIg7aH64MJ5Y1pqooKu42KQKPMR7
         WESYP4QbV7Ff1o/QUgV0fjl6Me7KD/HC6yHmwGfhXxxzkiTK1GkTAwof2ljKONV72h38
         bToQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4gUGelUv6CHTh9QVKtHFbP21kLBDd7NALzZSWveC1VV5YneANNCaL8v4f3ucYjhiTarmQtdsDxgtGOE9baB5Zdig3zXLXf2cpjGMwXR55g6ZaYUyr+fDr38BQBbnzRAoqmkmLlat5cSXlBg==
X-Gm-Message-State: AOJu0Yz9XmVrhPwCB6S6wqEFA+eZP349wcPiPDxGLGWiN9082JA8zuJo
	dO1eQsh5uVsd0K+5WVkM+sphM+B4+96SNNHNYNEu2lDGcyauMcEJD+nSZg==
X-Google-Smtp-Source: AGHT+IFUKOedVgVc8UW+Trz+83IQFsUxMohgSuzpDt2RYxUt0e0RbJQPgJqCmYkabt4/6uLjxFNJrQ==
X-Received: by 2002:a05:6a20:948d:b0:1b2:b2b:5698 with SMTP id adf61e73a8af0-1b2f9aad7f0mr7679091637.33.1718035234756;
        Mon, 10 Jun 2024 09:00:34 -0700 (PDT)
Received: from carrot.. (i223-217-185-141.s42.a014.ap.plala.or.jp. [223.217.185.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4532507casm4872411a12.62.2024.06.10.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:00:33 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH -mm 0/2] nilfs2: eliminate the call to inode_attach_wb()
Date: Tue, 11 Jun 2024 01:00:27 +0900
Message-Id: <20240610160029.7673-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew, please queue this series for the next cycle.

This series eliminates the inode_attach_wb() call from nilfs2, which
was introduced as a workaround for a kernel bug but is suspected of
layer violation (in fact, it is undesirable since it exposes a reference
to the backing device).

Removal of the inode_attach_wb() call is done by simply using
mark_buffer_dirty() on the backing device's buffers.  To use it safely,
this series will prepare it in patch 1/2, and perform the replacement
itself in patch 2/2.

Thanks,
Ryusuke Konishi


Ryusuke Konishi (2):
  nilfs2: prepare backing device folios for writing after adding
    checksums
  nilfs2: do not call inode_attach_wb() directly

 fs/nilfs2/segment.c | 89 +++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 35 deletions(-)

-- 
2.34.1


