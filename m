Return-Path: <linux-fsdevel+bounces-71270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C646CBBDD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 18:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AFF23009F9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18A2DBF45;
	Sun, 14 Dec 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYLe4OVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6157E110
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731789; cv=none; b=KDAo11bWD/uZCuUCJpgomug9o1dqdyDdp8Vobf55bDt4rkcwBi1Ouan8A4Cd6C1RjFNJxP/y82T4PX6u+s7N7c5CaSPEU089Z/8xrGBVrQ5w2oBzRwfkgrD4uO4ZQMItBIQpv5CKTW21qjzd53DLHbweu5I39BiFpr0U7BcgSEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731789; c=relaxed/simple;
	bh=v660C2Dk/Gx8fiGsyuR1n9r+m08wFi7kF7l6Mcq494o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyhaNR7nS4s9g0KVx0ndB7S/CUVQkMPQ+r3vWuuUJFmI+m4f/YBp7wdSkkwVCAo7DCJv+G7ApdGja9kH+6t82s9CbPP6xDpFVC84VNMski9agoawSQ/4MBjNEl0q43WcsqdYrwfK5BwGICOZjo/pXqK7n7mynZ4xzGSLZL/sbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYLe4OVF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37d275cb96cso23909271fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731785; x=1766336585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyfSmnzQ8O83AsWeCYuUm5FAslFHwFSDWhZIVSmFfHY=;
        b=nYLe4OVFrH0J0j+rmOYGwSr1JwG7qJlsZTDrGqcsqhH8b0YTP2mdQNxUxUEjKhfL12
         OK/CXbfugoI2YbbM+18EMKr4v2pBHWxcTHScfnVoMHNC79Wpex0ffDxqIIsg6yLACp1q
         NuXPI1qsbagauUTx/35Ti/mcErpKJzSrceY0B6ppMKNsrIFHLHhZ6UFtOhWinOFbU2N4
         /oUiaFhDbEv2bFATB3+5LKK00vhQiH+itynHJ02DqkwxNNgq72nFBFKfCGJ+rG7Qv8Xs
         TLWeXdLC4MtwcmFny5u9P6IrzfCmjDweaQr4rELFOpRvfs17xf5fvRD8FGz/hP0uDtTi
         1MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731785; x=1766336585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyfSmnzQ8O83AsWeCYuUm5FAslFHwFSDWhZIVSmFfHY=;
        b=Gjr8buV4Myo6gI/OMnzIPNjDFS+wBIHkzbmkIOVPGPJX2YZsmjkFgkFG3vIPX+Z9Vj
         NNAHW/NQ14RUIe0ctlm+NwbtBeKHfYNLnClyJzSnTHM+Ow5xbKRYxahGvQij77o52qif
         490QjUoAIAU1CjXpJGWje/zED56cfadibKNCxQ6g0RrIm4b2umaz8lP1c89fuxyM9wuo
         m+kNItjnbFsR2QIp1RoZDZ4Do5iIlJHw99n7n+Ckf3VDlFBO2lkPKnhkYvZhJbmleKEJ
         8jJAuKumJ0i71ZK+doBeIrYPIyGeXA35+1AkHniPOy5ceZIgR7RC7KvSD43soXdaV5p5
         fRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeHykOWezv9F9pq85dyWOIjvG9wFQUpd1bUrCWakuLYoAPPo+Hc5X/wP3O/HHYh2SyTf0xXYfnM0WRGhVE@vger.kernel.org
X-Gm-Message-State: AOJu0YwLh+o1uDjqgVYkwlYM/cSeyTKlAYR+k3rnI6BU0FsC5EeUd/Wc
	vX3AW606P757yDxK8JJA8DWahnH6CeWYMarv7jmTdolDjNVE1hpyNMke
X-Gm-Gg: AY/fxX4ADqngNwqU20Rlp900aBphLg3Rp1FAPFqgFsvabWMThIX3SU8N8fE5xtOTiB5
	qlifos/jBYaeFvo3p12r+0NFp87UQ5gtjV1zysw2TddotBp0LhoBSjiwbl+K6Y3x2OdcYUMGF0P
	qD/LhZBkg1uGCADXpxvaUpz7FkaLYLaeTYUBw6yKA4dLMfgz/JnbGriKvzCDCMP7adw+PlGoNtR
	DeT79U4adiW3eqqaWdRVnRBQgIVX+NZE6Mjta44xr8qvBiCbEi6Oz74rEMv34ouovMsT70FsgGx
	5cA6Vj/2cTI+jvq1DivNH63jHo1MOKrB4NUTruXaTCyYfckS5qFRaiKLuC8SDP6lFc2g0kWlukL
	nMi/TabqP2RPrs4wW1zXGY3go83Ie7oVVgxlR9U8hQhAbq/yIkMc5FthRYscz8kC9cmpayr9ytr
	kMrm+pZ6SC
X-Google-Smtp-Source: AGHT+IF314RbItjfgLDzXmIuQMPnc0ktxJg24TOlijEKCh7eZ+wiajZor58nxzGV4TLGgiLgOP9pig==
X-Received: by 2002:a2e:a545:0:b0:378:e23a:dba4 with SMTP id 38308e7fff4ca-37fd079dcf8mr24178981fa.13.1765731785064;
        Sun, 14 Dec 2025 09:03:05 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37fdee364e6sm18994371fa.49.2025.12.14.09.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 09:03:04 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: luis@igalia.com
Cc: amir73il@gmail.com,
	bschubert@ddn.com,
	djwong@kernel.org,
	hbirthelmer@ddn.com,
	kchen@ddn.com,
	kernel-dev@igalia.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mharvey@jumptrading.com,
	miklos@szeredi.hu
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
Date: Sun, 14 Dec 2025 20:02:24 +0300
Message-ID: <20251214170224.2574100-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212181254.59365-1-luis@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luis Henriques <luis@igalia.com>:
> As I mentioned in the v1 cover letter, I've been working on implementing the
> FUSE_LOOKUP_HANDLE operation.  As I also mentioned, this is being done in
> the scope of a wider project, which is to be able to restart FUSE servers
> without the need to unmount the file systems.  For context, here are the
> links again: [0] [1].

Will this fix long-standing fuse+suspend problem, described here
https://lore.kernel.org/all/20250720205839.2919-1-safinaskar@zohomail.com/ ?

-- 
Askar Safin

