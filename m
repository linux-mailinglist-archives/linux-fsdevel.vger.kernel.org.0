Return-Path: <linux-fsdevel+bounces-34529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AD9C6470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29CBB62B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1221948B;
	Tue, 12 Nov 2024 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIXDw/f0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128A218D7B;
	Tue, 12 Nov 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439548; cv=none; b=krI7tQJm7u2fEeF6030K5y7NFUfA4C8y69sur3gXqLtZD/fvWUAit11SJppducFAoT3clz4jocXAWdBuoPc/0wkgH3GagHHXaJkmpk/c9ZVkDBtyoK4V2utGeSHoMyfyeFUtNU1RKWriKLs2eXPf76Eu5ALOE9Plj4yH50WQVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439548; c=relaxed/simple;
	bh=qgKutzNu4CE+HFlPUmtW2SxT4kOeImo/BSnUuZYkoTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZOiz/iihqZE7D4z0jyM6mwdJG5cd+OaHj2yn7/4CEjiSElXdfZcLq5dT8Yi8s7xJ39MjTGS9Ir+uMy7VRUTIr/BVMmqulOvRR2kgY0i4UlYpuWdJx7Y1pC8re0cA+n6gWONzvf87/QdTJ/1KqGYRJnuWl8XSpGZDvKiiRvkU+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIXDw/f0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4609beb631aso47861751cf.2;
        Tue, 12 Nov 2024 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731439545; x=1732044345; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BQa33967CJui7gGVWn1/nvmGci6WcK8oCxA2wwMlUo=;
        b=nIXDw/f0rechdai/rOABx1dVUpOSv+cclPWd6Yhm4DxEHSHaMyWMwzjN/qMJE4MS24
         szK/qc0Il5fyPHZageQUu4jTu92ZRhpCJe+WuVY9pEbZVPsNEHugOWOBLPkJgBHWg5zK
         gGjNT59iLlkgXfGin+x7O+e2KDTxbOMfv+Aqni5zAYYhgdbMA1mucT5JmMbdCWy/DOGz
         eR5PfgCZBVTP5A4f+UCh9e0oJDP77ilDeK841KVR9WbUdyXW7EqVL9R3oc9jwNLyceSR
         jyzxZQmgErJ7NfZtSziSv5TcGVRaUTz4SPx3kIchIUs5Xw+MAOzQvsF8f0XlgyPapQk1
         OXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439545; x=1732044345;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BQa33967CJui7gGVWn1/nvmGci6WcK8oCxA2wwMlUo=;
        b=FZLWEuvzOM8fnwDGEXMf59Wo97J5hnl/61bMXjcdp4OKPtRJRZ16XZekR/SYolTavp
         UshqCIi9eprm1Tcyi0KiD5tlZ9CRqOpj60IMtinKahcffxdqhXSV3yltQL+ojPs9ZJlV
         9/bPLSzhUwis2ihlNo8m4nCgPdBgA8C2RDmTbAo202NcMZznIMUwlOQ0rTKdgDD5T5en
         wpOddz5yyLUNaYUodFd1GriR8m5p8MYmpi97MCJ4FQkAT8r/lYbS8Os8Z0BMoX5O/svs
         1rfXiNJ1j9rvqINjsp6TajvtNyliVRDzeTU4GPdpwetwXTaAHHCGLNcxzIvYrKvTZeUr
         DX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLMeFO3U8NXsSjza9GutKo5fDxLI4TaJ5c69F/2hv2ulmyvAb+8AN+z/sqdriAkMcyh8RlPZ7Fsn7rO04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEM2zfTGY1wxtoK7hh6tQFWNTAln1TD1oNgVRvj3nEZK67WAa
	llKSr6C3orGY2SGJNFdvUqQHSCh12fUHbksAo2R18uQ4EGILwEDS
X-Google-Smtp-Source: AGHT+IFa4scHKQw0vxqFfbsFP6SZgS67FdUsmV8xlXJjW92bTgRhnfaD7t2mhmb2DAt4UWJukfrg4A==
X-Received: by 2002:ac8:7fc3:0:b0:462:d75a:e2f0 with SMTP id d75a77b69052e-46309319448mr199818891cf.7.1731439545603;
        Tue, 12 Nov 2024 11:25:45 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:2ba5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm78395581cf.86.2024.11.12.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 11:25:44 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] xarray: extract __xa_cmpxchg_raw
Date: Tue, 12 Nov 2024 14:25:35 -0500
Message-Id: <20241112-xarray-insert-cmpxchg-v1-0-dc2bdd8c4136@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+rM2cC/x3MQQqEMAxA0atI1gbaOip4FXERYkazsEoqUhHvP
 mWWf/H+A0lMJcFQPWByadI9lvB1BbxSXAR1Lg3BhY93ocFMZnSjxgJP5O3IvC7Yur7rPM3EnqH
 Yw+Sr+f8dp/f9AXhhkdFnAAAA
X-Change-ID: 20241023-xarray-insert-cmpxchg-507661adac1c
To: Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This series reduces duplication between __xa_cmpxchg and __xa_insert by
extracting a new function that does not coerce zero entries to null on
the return path.

The new function may be used by the upcoming Rust xarray abstraction in
its reservation API where it is useful to tell the difference between
zero entries and null slots.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      xarray: extract xa_zero_to_null
      xarray: extract helper from __xa_{insert,cmpxchg}

 lib/xarray.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241023-xarray-insert-cmpxchg-507661adac1c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


