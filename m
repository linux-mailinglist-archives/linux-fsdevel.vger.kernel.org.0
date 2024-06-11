Return-Path: <linux-fsdevel+bounces-21431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E26903B77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036D82819C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373ED17B50C;
	Tue, 11 Jun 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+EgJgZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BD176AA9;
	Tue, 11 Jun 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107597; cv=none; b=Fq/lvyeeMlT0oECKGgWgbfVctplAjYNrcdswrk1aLQkMXzC/x6aYbC5WFU3NdKmzSjxI25gO0dyXwOU9BXLeViMslA+AOyx1VeG8KxTr48A0yvA/WW3tsEjcjiY41y4V7OQw6gy0oaqa+CB8x/mu79px6UHn13rri5YaMdejRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107597; c=relaxed/simple;
	bh=mVCI+A6plNF8BlzT3vnPrJSKKFzlHUVQGh2G4msiTxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4GvBI1w0uBLZclJfQp4qdaO32D1i9XaNXkOx5VC0ays9L5KNkEhwQuU6bl7OyXaC3VKLrJ/pul9nSozmVE1fUCz5Pnm71H6LiKs/NMtU0cG12XXIdWIjB4JSmEdeIkg5pt9+8YDnniT2BDhpZV4pfOfJqxBCFFiN9hIRSfZ6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+EgJgZn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso21747045e9.2;
        Tue, 11 Jun 2024 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718107594; x=1718712394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idFHbfZ1MRRrV9H1nBOmJ4Ddmhdw7U8lBB3oRBpJaoo=;
        b=H+EgJgZnkDycbTdlSel3b/r1h12f7b+k01zwQjkJruWzQ8YxqfMXnnVqmb9TzL3F/S
         pOtaKtXSE8NYD08CCVq5qO/oCYMlVlGLn72S9TZ8Ag7DVTF8Xx9vv4j1q37Enffbczvq
         RpzmqqqT3asJHUBBPzS/NxPXUhh1op83WG2sNiZljq60HR+L1/PTPsKnj5Ep5k3HELhA
         NzTagKsGdgBq6/5wfI4EI04aQMSzYjy2v+BTceKWFe9cWAnhxEN/YxlPv9wuH2+bSOWT
         5ank00x8PQNWTZ2yKiY7o3ngX7NfeTttJU1TpyVQYrdvI6v3PsyVyR1xAsvJN+ZyWCr4
         u60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107594; x=1718712394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idFHbfZ1MRRrV9H1nBOmJ4Ddmhdw7U8lBB3oRBpJaoo=;
        b=dEhlFzBO9EHYulldK4NOYIYJOykYCf2IuE9Yy0pL2MYEcmtl9kqtcfD2oX4YlalquE
         toZhjrhaCX6h0dpvA4luO2II4d/OjEUubU4ULWhKaNUyblIASLoghwxOXDSCbiNuqPVq
         HlbE8Aw2LGiexV0vPVg03zOjgaBP33XEWB5uW7drlzhtDtV8FunbLLdEKE/Q4A8/GFpi
         GMATztu/pMpOo1lJcXh1p2xu25bCUwLS7GDLbQRyxMEjX6l7DW8H6Nv3pi+rWlTOFp02
         WIiy0zcmODqggFwJW2Tiv6on8EgLC8rmg2pOZO1xMR3ReldKs0qMJ4GFVkSAMHFZQn+3
         9VAw==
X-Forwarded-Encrypted: i=1; AJvYcCWaTC1Xqpa8f+WwZADkQmA3DSr0oFutTJHo/jqfpeElSzJMcmVl2KZxqyj5P7VmaDiRr3j6py5JlXAYmVvvecBBKSfszAzZm4WyQXQh1rzui8w5gRp7yHkErOVifmZ9nb3vYHpWD5QIh2YTcUGBGSeEm9jjHxByCaKNNO6um5Sn7ElRchgFBbUTsGKljfBXG/R2m6kb5N71TAYI358xdRbNjaPaxbg4
X-Gm-Message-State: AOJu0YxqWCeLujQvLbi3fXheS+bLh8js39gzDF/aCMU6JfRKGiFn60QT
	z98Pj/0GUy8V5grlxlL8PTUVDgwbVjBq0LivIxsxEd+iRo9ZC9By
X-Google-Smtp-Source: AGHT+IEC68uiBdXVZmND7KxbllrA4m4C83/6AJ0FWp8MRWLD10K7Jrw8xbrY7XaD1BX2Rx123rEYCg==
X-Received: by 2002:a05:600c:1c10:b0:420:78f:3f9b with SMTP id 5b1f17b1804b1-42164a4472amr127843235e9.37.1718107594369;
        Tue, 11 Jun 2024 05:06:34 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm209315785e9.42.2024.06.11.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:06:33 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	linux-xfs@vger.kernel.org,
	david@fromorbit.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/4] inode_init_always zeroing i_state
Date: Tue, 11 Jun 2024 14:06:22 +0200
Message-ID: <20240611120626.513952-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As requested by Jan this is a 4-part series.

I diffed this against fs-next + my inode hash patch v3 as it adds one
i_state = 0 case. Should that hash thing not be accepted this bit is
trivially droppable from the patch.

Mateusz Guzik (4):
  xfs: preserve i_state around inode_init_always in xfs_reinit_inode
  vfs: partially sanitize i_state zeroing on inode creation
  xfs: remove now spurious i_state initialization in xfs_inode_alloc
  bcachefs: remove now spurious i_state initialization

 fs/bcachefs/fs.c    |  1 -
 fs/inode.c          | 13 +++----------
 fs/xfs/xfs_icache.c |  5 +++--
 3 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.43.0


