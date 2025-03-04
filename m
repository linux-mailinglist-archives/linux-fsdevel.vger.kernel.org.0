Return-Path: <linux-fsdevel+bounces-43085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331DEA4DD33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0392A3B086A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BB202C20;
	Tue,  4 Mar 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFD/FZKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B51F37D1;
	Tue,  4 Mar 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089358; cv=none; b=rpy2+rJfks8v39Cnqwis4d2QTwLGxtuSNH8rqFlK2nAhoV2rxEcWJ/mhlOyI7TLQkWzl8Lgmi3ll4eUu5RJd3Mk+JspK8Fw+SwOyHNBA4tZZh/V4T+4764rW88JYhwtZpoGITixyhBhBuw3VzUJecyvxOM40FXti/A9szQwyzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089358; c=relaxed/simple;
	bh=yRH40rDIK/iTxsQ7JMjQiEWRZvZjZMzNRUZOf0S0fwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvspMaOj3qJx60DbVLK4eqdonhEAgnFCcJ8ddO6P9gNc3QMW1jqwrbm3N++XWCNIGv0msxjw+PHrg7YBxBVjlzYoasvTjbjKirGQeIvL2fiPTDAhFkyIAXqeC4VnpLz38QNyD/IDx9AhtNpJOAUn2ZcdhuiTgsALLgOdTbvgl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFD/FZKb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22398e09e39so43950085ad.3;
        Tue, 04 Mar 2025 03:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089354; x=1741694154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4D6/AgpnW2rZdpyVRClRAqATcUqw7oA41wM8sB9+o=;
        b=NFD/FZKblOdN3Pk6fC+BfIiu+LOfqE/Yle/9NC5wk7id9u3szXtA62jvayP5/F1xQ/
         0nCDa6vDb1UqSiNIaQSUeocW/IiahOg8ZCdUKu7K0cfE7+DQhU3t5MPtjp9vv+4U0JmZ
         JTQmwLsxCQkh/2WKZT7XnM881TpJcSsHEYVLSbxcmQCIIikQ2c+yyqE5v+JMu2Vef2kq
         mZY9CWCFwDW6Gg8b5Dgj5OYooRoVVQWrwfUnnGkbOm3ZaE7cOcmK2IpGI52naYG1dYYP
         kL+gY2eEpfVzLuMtu13I+i/ABeqDzmlcVNUbHgr2IpqKaWZIWycPfB6LF+a9y9ptdgh1
         ZioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089354; x=1741694154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft4D6/AgpnW2rZdpyVRClRAqATcUqw7oA41wM8sB9+o=;
        b=LByS3nSSlFd7kwHw28BW+s2D8stSh81UkRSC58LLqJulHZwoYOcyqzFyjYEE/EBVdS
         xTgHbxUCahanh3YHbIUvpulEl1SIAuSji9flpZUsjlb6Tx1KBtwMkCV1jyzCtBYB2bNx
         q88/IvLcmQ17Dp3MZZBIgeiD/WAOpRf6qNE7bWBsW8zjeKYPCt7lMAPuePXLSa0WKvLT
         eUPae7SALEpEy39sesvjudt/rmk/ESURsagiihjKp0PaeJkuEBZi4AxT4pHI667lK2Bg
         virH365EjrdMiV/v/G3jiIMM8K3vL6IsoATPIygh1JFyNcz+GEpy/VCsBYH4NNnIi8uZ
         AMog==
X-Gm-Message-State: AOJu0YzPoGr92mZ9+GIdU2yg3Ss55zUnDMJ039cTZJZ8LW5VUnxIke6u
	q7/nT3L8SasgBGxkw2RlPZfLXY2+HJC5QpQJ3bcoaEb5ujJTfBzhsrMIAGal
X-Gm-Gg: ASbGncvHsi6vLQ6YO+VtIyai6kmbyQq9ct6hH65aRA3uEO2kK7U7N8aio68NQVph/7Y
	qx0WDTkYvIcS1Hh189953P1RuDD7bl9U4XSOq1RdieBnqjA6dKjAjPaEARXPn71EuSQ77Yqr655
	SsQ5cF+4WIBfjqi77yDOeo6pe4hMDaMMtKaOX1LiLodwHTat/ugFg9rEM1HyXh3u0vVCvOwd+SJ
	hA5n5pV1M/t3JwOYXpEi7ErBQxBINX34EQI1DepUgNtxpODM8thnz9Muf+v8pw20ec2hgMwhadz
	ADzwsLvD1qVJigd9ENvWmGjyU1ZSw2KNuU17yHrREVjnCX4mgp0=
X-Google-Smtp-Source: AGHT+IFnQwcllLfHrKPZlrEjVhCRDGujVqUYGHTH+CIUWkgaNmsLaWK4cJh0S3hmoi1N7vvtN4ZG8A==
X-Received: by 2002:a17:902:c948:b0:21f:1549:a563 with SMTP id d9443c01a7336-22368fa53eemr288650295ad.2.1741089354244;
        Tue, 04 Mar 2025 03:55:54 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d28desm94154565ad.16.2025.03.04.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:55:53 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 0/3] xfsprogs: Add support for preadv2() and RWF_DONTCACHE
Date: Tue,  4 Mar 2025 17:25:34 +0530
Message-ID: <cover.1741087191.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- adds support for preadv2().
- adds support for RWF_DONTCACHE to preadv2() and pwritev2() calls in xfs_io.

Ritesh Harjani (IBM) (3):
  configure: xfs_io: Add support for preadv2
  xfs_io: Add RWF_DONTCACHE support to pwritev2
  xfs_io: Add RWF_DONTCACHE support to preadv2

 configure.ac          |  1 +
 include/builddefs.in  |  1 +
 include/linux.h       |  5 ++++
 io/Makefile           |  4 +++
 io/pread.c            | 57 ++++++++++++++++++++++++++++++-------------
 io/pwrite.c           |  8 ++++--
 m4/package_libcdev.m4 | 18 ++++++++++++++
 man/man8/xfs_io.8     | 16 ++++++++++--
 8 files changed, 89 insertions(+), 21 deletions(-)

--
2.48.1


