Return-Path: <linux-fsdevel+bounces-8516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D88838954
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BEC1F2A64B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4B56B6F;
	Tue, 23 Jan 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXUEoZH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8753812
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999419; cv=none; b=ZSleGLGHLj7UK6jVZYQUs8PGhhWa8jRC1aQpX/3zFXni4+/vRh/U56G9n+71AlF8rZlU4g+fGYMKY/mFqsvEnL7yrFuajC49irfjQ565ZQXDERJdlib/Ptog+biLHjcFgAebSAU4mHKiKZQvp62rGylsssnMkiAvz6HUYk8uBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999419; c=relaxed/simple;
	bh=8ggbYcQpb5zQg0ZahJhbrVhWtCDKZZkKrKr0p/ZiqJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooGEDsxs3wbJ1arrqGJoD5zzrJdj1LgMDTBIPRDfHcem4cMbQsM/OnyrOOcBlcOB72pgM3AH6v1VYkzJNAEdHOgvHbhA/d9BvEqnoEAXC95ZEE66Im0JEJD8vboNhDAZsFjoL43wSkMXu3kumUXInck+fiJl0drRixJT0tPbMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OXUEoZH6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d76671e5a4so8155405ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 00:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705999418; x=1706604218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKXbhYk6xHU5QDZM6UCfPZEb6281Qyipiwcs29NfETM=;
        b=OXUEoZH6jEoSdOrNL2tgZObk8bK+HMAC1VKVpTC5DIz4m5IkCebJX8CBDVu16cq8mG
         I7EcNnOYAjspi7ARFxtZvYr1ZBzJHnenHJ5rLgqqYlhaZ6twPK5z1LZFi45WUeKUN6gA
         tKXulJgeApvsUrgTaWCO/lTPfhvZB21Zh2jpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999418; x=1706604218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKXbhYk6xHU5QDZM6UCfPZEb6281Qyipiwcs29NfETM=;
        b=nUv/myl1wIzPB//PQzeC42WEpoY+gaevTgV/Dum3toeVjvfJXhgWyqC2etq/DrodEz
         Ii7WLV5zGs2rsB/r6MYWAij7TtmkLiSzgtU0Xt9VDN28hsm01FGypk+XMpuZhkALPRc2
         kjN0pZofr2wjyMIw88loBSGGA9lVRIDsMyaqKWPoimp4Ex4ni/773J/LIT55/aEFkIXy
         uXWbsTuek3DOX5opAAfbL2y35eyIgNHpLeKzXc9AEXkT5wm2zlDPiV6alVegul/sPfTj
         6h0XiqW1xoy8Tuonhm3taAeM4Q1z5JBYOVLSEDHysvbJ+azslXxUXRduvHHl7O6ny5pB
         OCmQ==
X-Gm-Message-State: AOJu0YwTM+lmL1N2XotmTilsBltZRLYmP21iS0OUxTWhAD4tx5w6ALB4
	mgXGzlQFmvmsVFWZ7qNxJQg+eg81eAx5J4W5da41cM01GndSCsegDp4dmkJF
X-Google-Smtp-Source: AGHT+IFRsWSzz4mY2tcOxC9s4Njec3asIMhGNNuPS82PHYJULmdOfcP4LHtoOz46XuJaWTuhs4Gw1w==
X-Received: by 2002:a17:902:c94d:b0:1d7:2b80:ad9d with SMTP id i13-20020a170902c94d00b001d72b80ad9dmr6438401pla.36.1705999417915;
        Tue, 23 Jan 2024 00:43:37 -0800 (PST)
Received: from yuanyao.c.googlers.com.com (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001d6f7875f57sm8383232plh.162.2024.01.23.00.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:43:37 -0800 (PST)
From: Yuan Yao <yuanyaogoog@chromium.org>
To: bschubert@ddn.com
Cc: bernd.schubert@fastmail.fm,
	brauner@kernel.org,
	dsingh@ddn.com,
	hbirthelmer@ddn.com,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	viro@zeniv.linux.org.uk,
	Yuan Yao <yuanyaogoog@chromium.org>
Subject: [PATCH 0/1] Fix-atomic_open-not-using-negative-d_entry
Date: Tue, 23 Jan 2024 08:40:29 +0000
Message-ID: <20240123084030.873139-1-yuanyaogoog@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20231023183035.11035-3-bschubert@ddn.com>
References: <20231023183035.11035-3-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found the non-existing file looked up by _fuse_atomic_open()
function will not set negative dentry properly. This issue came to
light when I was benchmarking the performance of the second open
operation on a non-existing file. Using _fuse_atomic_open() resulted 
in a 10x performance regression compared to the original 
fuse_create_open() function.

With the previous fuse_create_open() function, when a negative dentry
is returned by fuse server. kernel will set the dentry timeout and
return with finish_no_open(). The _fuse_atomic_open() function will
return ENOENT error instead.

Yuan Yao (1):
  fuse: Fix atomic_open not using negative d_entry

 fs/fuse/dir.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0.429.g432eaa2c6b-goog


