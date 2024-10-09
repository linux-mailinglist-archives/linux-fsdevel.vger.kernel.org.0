Return-Path: <linux-fsdevel+bounces-31447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B6996E58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23CEB21289
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6D19CC3E;
	Wed,  9 Oct 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MR0ulu1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E314A0AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484900; cv=none; b=MgIoy4oHa5NbZuob9+jluv3RkOne27C6CDfI5jXd1ZlIdW6o6fl2hmetAYoPteBCiZbt42PfU9S6UPUo5qfRlHNFayFnR9d8r623XCAZppmVQPdf8UszZkU41uitFcImIx2khkuEIHHfkTbEhGIQJKCPWjDrNwIBFMd+5J6vJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484900; c=relaxed/simple;
	bh=32vFmCSc5ZEMb4AhzJtfcV3h3hUM5xDYrKqyzkNbPEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zw7B11Toly6y3eBl9tV53TcBUoLFBgK+Q+THv8jokaOO+2r1tad3ntMQT3fDs/HDJVXH66CR1YFVgVcalAT9loKLrn0gxP9BNFAU/jKVnI83ebeNFnHoP/BZkuh4l1kmdVttiWaIH2OykDBbdLOMuAsQibGwGGVayBXr/Boz5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MR0ulu1t; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so2261715b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728484897; x=1729089697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qHFKwQFtdhqDpsvNepQo/3TMbFBjVSDDfwKOH3x4ow=;
        b=MR0ulu1tvKEemN2nXI8gEoQ5ldOKxAVMcyb8voWt39FxJe5+oJhaSK1YamHig3084e
         3yXV0fzBLzshPhiGWuC9alzTJkMkL7CR7wA3GqtpYIjkhDVt22QYmoowN329GKw+pQol
         xnpVRE7WgAY0hXWJX07hJVVb41vu/OJo59LlehwU6JjEq2oG9KpF5xCp8/02GpWPsFqK
         YME0nSP2nfcThIWqkGO4/FCZ5irzkz5uuVtr1exdA8/I0XCDJXqLrNiyjV9iEMPiqhKH
         4WVYtCtRGM91saZMh14S/eiGceviMRkFeYjmOWca0PmORaiJJPV0bTae6ZlZB6QVY2Yl
         tcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484897; x=1729089697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qHFKwQFtdhqDpsvNepQo/3TMbFBjVSDDfwKOH3x4ow=;
        b=MvfBVPP7ktXWWaBgFj0Ppfirp58+gM9cPhCWzOQa31nf+o2OpITQpCkUis0pvsA1QL
         1YvWoeyKSAAKpSlD0PRdVRqzxzIPLSokq2xEjw/X/xRdxubRmQ+siukF/6ZlA6ddl/Pb
         SVFVjYVfLNlqGPuRnkF7215kZA825cR3RePHNti7QvA3nX562lUTiJs+kRBr+rxkC1oy
         yCI9184rm7/5UKV8WacYGYnx39AZ+KDSBq2eYuY5q4DlwwTo3ZO4J0GzR8/WhoxFSokn
         ZYFrWR2CpCDs5sqDcJZSeEBhb7MO+5I1Akx3J77H61YP21edGlLkdj6fhi+jae0LQI2z
         /VzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9PtVskchIW69+YGGfN/92mfDD3XvmxI8bAjhghkdpj05rHaBvNM/yPhNGjpOTIaCOqmWEzUBKVOXmw6l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lVCOR5iqz7TjHPjDtZSl3OVRansm2E1Vh6/DDuyq3bssJFMj
	uEd/RBzlxCvtlyxM7nhjaTzVI6XTBgyLkM8pQN4tPSjK507fRGrZuPSlrqLR/LQ=
X-Google-Smtp-Source: AGHT+IFpmvUjs98ZpK9INq/XOOz7Y1o2mXU9E+TcGA1VnD0NJIUMPP6zP7j/gYPu1kScqkViOogk+w==
X-Received: by 2002:a05:6a20:9f8d:b0:1d8:a354:1acd with SMTP id adf61e73a8af0-1d8a3c1def1mr4460478637.25.1728484897223;
        Wed, 09 Oct 2024 07:41:37 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb64sm7852764b3a.48.2024.10.09.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:41:36 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 0/2] Cleanup some writeback codes
Date: Wed,  9 Oct 2024 23:17:26 +0800
Message-Id: <20241009151728.300477-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

v3:
PATCH #1: We haven't found an ideal name for BANDWIDTH_INTERVAL, so update
the comment only.

Remove PATCH #3 about XFS.

Tang Yizhou (2):
  mm/page-writeback.c: Update comment for BANDWIDTH_INTERVAL
  mm/page-writeback.c: Fix comment of wb_domain_writeout_add()

 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1


