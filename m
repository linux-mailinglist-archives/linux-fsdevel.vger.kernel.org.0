Return-Path: <linux-fsdevel+bounces-44931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD193A6E81C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 02:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C93B7C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587E1624E0;
	Tue, 25 Mar 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxhG3Bd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C628DB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867785; cv=none; b=Dgx6zGV1r3zzI6OcD8SCb6ktrALPCr57AoGejxn7awT5LyqJyGC75eZM+HyYGdNBsHGTCQ5CPU7tuG5q0j87KyiherE4mmOOJiXvAgAhgie00cBCAhfHto0oHiNQV1OULNckrWvGtRDi474iBWuJTTdDgtcmaHP18Fl+XhB8ZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867785; c=relaxed/simple;
	bh=iW8dJ7iHFc7kJ17qorglPOnxf2Mp3LzySJvvS5iXDTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pFe4Me5jUQ9iOV4P6oWkMA2P/T99M+l1b38dMWGKzsg5r8HwoYxzCPTEQ9KeIM27GfgCU1fCYa9gi7tBwctyjfg2Yt+6/NtfMH5Sdqs2PD3wnjjN71+81ZGbkDMSfbO+Bkyd0MCvpEVW1kq88F6MZPhYGDNnzOcnuq1TvGCtb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxhG3Bd/; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-60047981020so3975704eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742867782; x=1743472582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ib9+Q0ada4H11TeWZKVSJ40rZdGKNeCFH54Ppv1IWfU=;
        b=rxhG3Bd/oQeq9vCDpIIsJO5JPm/nxulyfNTPMcCvRr1Q4JOVghdI1OSh14lmgQIXOv
         DMRRNvNrM1k75JUQQJZ0wjICYmuzHaa4U2oY1oGN6HhVRoWnh2XEK2vDt4D5MyiySZqs
         lAl4H/MaD6QJV2KlwuNEcGzPIivmWM6Rel74+3Wagx0BdlxqIQhmzpUSndlDbE3HmAVf
         eKqdGsR+O9xDPqE5ghb9cAd+zPsukv1x8hvqrDd3VObrSuTC+Tlj4UAcoKiewotdJFiv
         XihQz1TYd/khfjK19bzXG20DFoyql/EUB/WU8/RuFGqr+9XgzUDC+FAZBr9FoGa7Q6GL
         ubEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867782; x=1743472582;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib9+Q0ada4H11TeWZKVSJ40rZdGKNeCFH54Ppv1IWfU=;
        b=ppNLAiIIcZuNUj0HAECsib+0IdNhoXrA3wPC05vMLEB6ANeTRF3dYCTQaAz+IdJGg1
         hyw+QVwrgTnuO0mTp9zTmi7DMw1GNi1TzjEPjbjgsqfhKPjvZrw7n1rbnQ2eQOoHXpMb
         SaDlgwaUB9Q2TV1BZZLZCC/15DaUYh+mExgSio4eJ2i+bivNIfleYK7qeG7CX3s/M1Sw
         jYG8R8FVN7ebFjamWK9f8p5rksQJ1jPlZ3P2at5AFdhOqKVoOYPc/uEgVQ/+tfE+4eBL
         lUM39j6/sOjqwXishHuqLuSS4tVGY4NNDCRK3TF32CbI/fks+AfqfN6zKy5Gkm/1Jmf/
         H5ag==
X-Forwarded-Encrypted: i=1; AJvYcCUHr9AzzKMiLA4NbFRt5QUNM9ZnJvh5AQlC99T82V8DuZYS3mf/wmgxO8ZoqTHDHVYpK1gMcr9czO8wgzNo@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCxbLsWlyeTUb++jDlda2lHQttNFGB1ls0mXzPR/MilS4G+IS
	3r3Yn2z7djdHM5xlAYIvOC4jM9AGHm5L6PwAPz6IieZ0DFzLNhitaYKflcwOmC6OGA==
X-Google-Smtp-Source: AGHT+IG0+uLGPYG9slyIicgnfJMvJ/fL3LCjzaIbzQaDguDS59/5o4ooegKCdV6c7y6nONpb9SxgUdw=
X-Received: from oacpc8.prod.google.com ([2002:a05:6871:7a08:b0:2b8:faad:4f1d])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:e496:b0:2bc:7d6f:fa85
 with SMTP id 586e51a60fabf-2c780298b2amr9783186fac.16.1742867782106; Mon, 24
 Mar 2025 18:56:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:56:13 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325015617.23455-1-pcc@google.com>
Subject: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

v3:
- simplify test case

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 13 +++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


