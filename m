Return-Path: <linux-fsdevel+bounces-63816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BDBCEABF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9083C189EC07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EC26D4DE;
	Fri, 10 Oct 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUMO5voM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA16189BB0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134107; cv=none; b=DLvqH4ccs2maJvJ8hgPt3aoyKJPRqRowuSf2ZNnJkGD6TP77a9P4SKDWTcJ41M0BUos8OBTJG48wuN00CeEVQuho/bdHPqZEhscHwuiVc+VvCIFmUxvCncxJlV8fUBZ09L5S/0uczNbQH61JYrKsk78wkhb13ZRy+eWmUd2URWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134107; c=relaxed/simple;
	bh=HErpdg5co3e2TXxN6KqXYFLtceUcF4k1iz3ql+7Hacg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xdbs4fKDYL3jlb6Nk+leeXq1CLuvWYNUTbEkIqeYLsl37lgFqfDhm3qHE3nNkjps2wdJrJYCnvklu9jkN1BbsMsTOJ3ryWK1fzxj2u2kbQP4F4KxBfVkkEFW/f3PMP9yf5nFwiM4mPv9SbB4ljYCAfNlQtkJDNXBNrdOPAqpU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUMO5voM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1650620a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760134105; x=1760738905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVIx61hvWHfoiLki3MNm6aJ1y93AEV9snTGoD9GypSE=;
        b=nUMO5voMvUHPSOrw1Kwt2/5+bJO2GGBQR6NNGyIOKK7Hk8ZWTj5uwpKQQ0AFwt8PEF
         khJ4qmC+4nFYy/vX4fSDa24qqKKL5KXTJYzgwGvREr0BcjdPH2ck5SoXP4YIdQeTmSLK
         2HMd0c65SO5VLeUmxYt47MciM8dgoeyT0Ra+Iih/Fy75EC8SXHlKF0u0k4U6xn7WwLtB
         ub92SrZK8R/YRkdNKLdbJCE5CpgGXQcJBivvRK9sPWyj8odThpxjTtDh6DFwLMIqi0L8
         3xiN/tHcnbC8WNa9Z5fimd5aBiriXKI0DDrZj40wCfZG/sewKPC46MB1DG7vtRZeBIkk
         zTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134105; x=1760738905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVIx61hvWHfoiLki3MNm6aJ1y93AEV9snTGoD9GypSE=;
        b=BrYED+I8UNRajzzUNvVR0ntq7GJU3qiC8bvsb7bRLeGy7jh0BrfrbM36rjB/23vnxn
         zpd16r8Qy8Zu0HX/qrPpT7nzIv5mv/O5po323Me4jE3xLiIs4g1wD0TY1mVFq5p9RJlv
         C1nru8dCr29TUBlAaAodpkvAxxY6nhKmODxcH03mB9Y2Rxd3rVkSZtDzzUg8LPB/HcMP
         TouKziHxdNZkW2DWMOF+quP1xmNw/GVMI9rhPIqChdr2JLIIHsZvmi+moOLh1GaY8YAR
         kgKymdJ91c4DUIy18L7OHgb7SEWLRwS9wuJc3Vj8eLGvUT6N7DppZ/dbrxJ6d4r6z814
         Mf+w==
X-Gm-Message-State: AOJu0YxbpxQB29LsrRpUPqVwacyfghyq8D0AMeTjjAHuNKsLTr6ieEz5
	VXdxWga0NzanBW6+rSJ5WzOAzT2yCra0p2NChE8ZLYfIrRSEvp7yQ3QO
X-Gm-Gg: ASbGncsXj7+PTGTDWNlsouC9O2gLIEaouyBGkJ+cgP+g2KJceP8bd4csDtETr783HQS
	3ugHQTrSVoHc4WC6BoTY1qMdpvo8yHKFwlNYSnd+AHzgg2f/toeXHU8Na/+IO94GQ1D0ln7K/FS
	ykbYtU80gEJrjR1Pr2Wd+UZBs1wkDeyWQ09UowuMV9VqW5wyQgiFR6txUDqFKO+g4aIfEoNiRRl
	JVRMpsbfPtMThDGBRBIHxLsniFQRlNGWx0RJW4I2qglzF/uQ4OLDYY0AoPVVkf3SzQpH4fH3i5j
	moLUWyhwZsaemPr5Xp67424JN56YcTB7pFxf2xQlk6viF+HQbkSMqatl8zdusDCBQQ8xX3nRV5q
	yw92FXq61+G4tGjuo4FBH1+CIqmx8QhMbjdFhz43fw9QJbDSMriPFQvBSnfJFwiQPh0US2WpKOh
	5qeB8=
X-Google-Smtp-Source: AGHT+IFVzjZzbIuh+AWclkQB5qcISlMH9nFFkvN3BwtAFAYfzMR37IoFlMlHn/7DTutO2Ho6LZh8cA==
X-Received: by 2002:a17:903:1a86:b0:290:2a14:2eef with SMTP id d9443c01a7336-2902a143dbbmr150504575ad.0.1760134105446;
        Fri, 10 Oct 2025 15:08:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e18557sm66826955ad.39.2025.10.10.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:08:25 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	osandov@fb.com,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 0/1] fuse: fix readahead reclaim deadlock
Date: Fri, 10 Oct 2025 15:07:37 -0700
Message-ID: <20251010220738.3674538-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 for fixing the readahead reclaim deadlock we ran into at Meta on
fuse servers that don't implement open (fc->no_open == 1). v1 is here: 
https://lore.kernel.org/linux-fsdevel/20250925224404.2058035-1-joannelkoong@gmail.com/

This approach in v2 fixes the deadlock by allocating ff->release_args and
grabbing the reference on the inode in fuse_prepare_release() even if the
server doesn't implement open. This is an alternative approach to v1, which
explicitly grabbed the inode reference before sending readahead requests and
dropped the reference after the requests completed.

Thanks,
Joanne

Joanne Koong (1):
  fuse: fix readahead reclaim deadlock

 fs/fuse/file.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

-- 
2.47.3


