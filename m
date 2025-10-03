Return-Path: <linux-fsdevel+bounces-63378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D4BB7407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A28F3346778
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164E1281371;
	Fri,  3 Oct 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="VDMPP8mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75478218EB1
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503397; cv=none; b=EYuy6+d8s4lSZLCJ/kSExdbyenrJqjcAI/K4U9lY2JLHeyvhs/sgYQXcK+4QaWp5vAGLOp0l6o6T+z6io7njf6nxPJzRs8rs7BwiheTSYJ4uapyqVlc/gaf2Xg6Qj1lMryzsCMzhYPUU97dOTO7KnYq1GlyKJT7V8vh4mcuSYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503397; c=relaxed/simple;
	bh=kRj9cnzzDxPKkfplHIrlfHEtlWfmNsk6zc5kNwv4ZXo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Vl4tOuWkNm+egELP/deEVSvK7KWwgSNDbb05RFcDKrrq8l7fQpGjvWjQKHXqr7G6Fv0ze9s7YUo3zxT/7Tv4jN4cGyBGyXpfUMf5BDQl7VxNodJgwIvECUTA0733rpvSRa+9K8TMLutUXxkc1ac0G/NPTHGL9zudqSbeWkta9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=VDMPP8mr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33082aed31dso2719230a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1759503392; x=1760108192; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SD/Rf1gCAPCc5tsJMPCFcW90YTI81aVrrWFvusMY6q8=;
        b=VDMPP8mrbgWBDihoyrN5JC7z6nBky2x5rvaLBGndMLLHa3DicwncZAP3BVftvHdKhU
         SaEQW78pJbzMDqgnzXcNIvTbwGbdxcVHIcmTlo9v/5FfoFUYtnuv3LJwUWRqUwGGRcA3
         rz0P3nw7kDtrOXhixfFVQj8Og4D5V7uHwTGihN8QFAkvOmsnCZzaSGyc1SOHCj/YW5/H
         AbB6FcrfSCHXpon+4ZAJ4wbqg4tmZLzu386YVOMZ5P+rzORUSaXqbihumJzfugEo+5UD
         VIexJ9h7w/K1GB4MsAHaiSOsaRb0gAJX5Jaz1eC0afngJKeSR59tLMmOyEIpFiGNYuyX
         Bi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503392; x=1760108192;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SD/Rf1gCAPCc5tsJMPCFcW90YTI81aVrrWFvusMY6q8=;
        b=vZG91lREgbBCbnimRoU9c6cgYttdZFGmCe3L3Q/zP2bnxOoNEdOTtUat7CYVW0muQw
         6kaU3tETaXn12V1nE+1advRBd3ORYEcG4lC5jBnkAYdf1F2CXzyt0XX3zgyCKB0d+Q/O
         XLvu/+m6sqBIlo74fZyqB1CoagkOKZPpINUY1/R8C0rk/c/+7Aw3fgTKOlGwRkgYObkP
         UKnbkrjEtt8I/yhvFLmz0OB6qaAjjNwssu2aIF00VkTzwnY9YqYB7zED5/MAYQDNdH7o
         Yy/6s20EwgujTBeGB3mjF3FIcb99vTfXjozszd+er9BwAyyw801XcIkk3T3kDKFGqFFD
         uymw==
X-Forwarded-Encrypted: i=1; AJvYcCUw/xO88jKJI/RMLUw6Ph+hJaoQ6lEyg4uM/JUpc36N6ADfXfMLFeLc1GtVhvL0J5GzYeEmP7WB5KZRDlbs@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0TiuSOhA6WNyTlP2GLXW4uSPgS6qEJzz3WuCrf/SVtt5qp9f
	cIdPblaRvMfJAVp8cDXXWosD3d64nWY3P8zSXFp+sGCRmp5PG3CApZ4GCy3cEuaDRRF9HOkPMa8
	BgGOEBCyy2EVS1G8IDaKj4AnZTSVguMp6dwUutpD3AUKtA/hjdyybBQ==
X-Gm-Gg: ASbGncv1HhifIKyFABwofz8G7oc1G5FxI8IGSuaeDlJ248TXVt37RVgKLP85eIEZcw9
	qVJPecrrfQvFb8499gr2uY4Py/6ofPfcBagkhsIctRSuJCeepDJGZ5/tMcoo9VsMRSJ/YDQlIeg
	gTzt87vFavTGEe+iEIY+I2kQIP3T7IVMrKE7Zp0aWz/CFjsCZfk+jeC/Ik/jMC0Z02oz9Pq85L3
	Rx4CdN05e87xBU/sLn9etxzVXLLsg8IadhSO9JF2ACW9qR+Fep4hQ==
X-Google-Smtp-Source: AGHT+IEIrPOlEncwSJEitbVSigZrsUsg6UHectGuyzjvz1wPMpDHxQ4+vsg81mtHKrYIY+R8qpcCRCCgEzi7hqwVfa4=
X-Received: by 2002:a17:90b:4ac4:b0:332:2773:e7bf with SMTP id
 98e67ed59e1d1-339c278d70bmr3789915a91.18.1759503391675; Fri, 03 Oct 2025
 07:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Fri, 3 Oct 2025 10:56:20 -0400
X-Gm-Features: AS18NWDh8ij92WhGeaq38hAaZiepUoHv1NoMS1-qtC_7rlKzcYiapsTFf99LenA
Message-ID: <CAOg9mSRFjtB4fSwU1Cv+V1vYJSppd4=5UcnO7M95yXnULMoZzg@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 6.18
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.18-ofs1

for you to fetch changes up to 11f6bce77e27e82015a0d044e6c1eec8b139831a:

  fs/orangefs: Replace kzalloc + copy_from_user with memdup_user_nul
(2025-09-30 10:23:24 -0400)

----------------------------------------------------------------
orangefs: Two cleanups and a bug fix.

Remove unused type in macro fill_default_sys_attrs
  Zhen Ni <zhen.ni@easystack.cn>

Replace kzalloc + copy_from_user with memdup_user_nul
  Thorsten Blum <thorsten.blum@linux.dev>

fix xattr related buffer overflow...
  A message was forwarded to me from Disclosure <disclosure@aisle.com>
  indicating a problem with a loop condition in our xattr code. When I
  fixed the problem it exposed a related memory leak problem, and I
  fixed that too.

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: fix xattr related buffer overflow...

Thorsten Blum (1):
      fs/orangefs: Replace kzalloc + copy_from_user with memdup_user_nul

Zhen Ni (1):
      orangefs: Remove unused type in macro fill_default_sys_attrs

 fs/orangefs/namei.c            | 10 +++-------
 fs/orangefs/orangefs-debugfs.c | 11 +++++------
 fs/orangefs/orangefs-kernel.h  |  2 +-
 fs/orangefs/xattr.c            | 12 +++++++-----
 4 files changed, 16 insertions(+), 19 deletions(-)

