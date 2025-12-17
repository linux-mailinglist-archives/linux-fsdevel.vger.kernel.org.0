Return-Path: <linux-fsdevel+bounces-71570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3ECC817C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96135300A211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B235CBD8;
	Wed, 17 Dec 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="Dbm09mrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458235FF75
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979916; cv=none; b=JKCZBLy0PKwb9onVo5dB3CzliVUVr9yX2bO4O+eI56gYrQw6VKbr/rZw1XHyeLm/eMJ2JOOWwmF+hCFlgeWM5AjFpEmlJez97l0YuiAmTpRFClMM16uySk1217b469v/C90YIm0xntiJQuuine0xTngYFTQgMg4W+DZAJ53ik1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979916; c=relaxed/simple;
	bh=R8cgFbGoCjpkgVOw8VeKpi8TaA8Mki30YFNEF8uu/Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouU1SYQIIb3O8ZD2BZ5n1C4fAUHHMarkgWyNPkpTXFH0GWdt+dLhQjxmr0uXCaCMlIVDmF6nBh1gHMalFn5XtOg/qZV+Q4inDT2AHuMeAM2VyT/pqu1UUg/RxZxKJhD5zDlN6EiSV6lLBFzRRk+IBK9VNqiwilp8fRpRaRQitCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com; spf=fail smtp.mailfrom=rubrik.com; dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b=Dbm09mrB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rubrik.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f0f875bc5so76493825ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google; t=1765979914; x=1766584714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YAhxB7bmu5MXyZxnKf9YXXdJkmIF+vrsHdN7KRRO7U=;
        b=Dbm09mrB7qfbLpNB3N7R6fuBISWm7e8n13OHNr+h28ML/IAnz1PTvOUWShtJQ5+B+V
         6C8WeTZUzbIQPXEPH5zpRzwpEBRjBawnmoZnHW+GA/ClzIloVADM69WvKf4FLIMPqoVc
         yBv7CDoSyVsqRu9XSs0T/zJ603Ae962FZuOgvt78QoIrwdo20Q1KVDH4q0jfkNXqS3mU
         bwDvPyQv5oRnx82e9P0vZDnzlDHmqMQbYT95htp2FGjFUjh6y4mXtKuypvecvfgWGLX7
         FYLcztj3oz1BOylhak9X2U7al5v3oW2lcriu+Q+6SdTGgK5KrmhFURR+wkXFQAek6pTM
         JLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979914; x=1766584714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YAhxB7bmu5MXyZxnKf9YXXdJkmIF+vrsHdN7KRRO7U=;
        b=KJYWqCO6MHA0JdMfDI3FV3G4yvxOcFOSpHqx/56usYCwU6kFr5JlVTtNdkfLEKWHB5
         dHEMuM26pQcD4/iDV2eSTRXM5UM0VqeNRjgYgVJ+uFC0I1kCcY9OedeWfKLFeQR/sEFZ
         z/b5hjkSYmVwRllV8J0HMgYQB+2nxVWny0PZuUy6g2ND6yCY25BtEYDlgnCwUPoyaV63
         q/xqTtR524JCBobDo/H51z3el/c0G11ZqAwDcfMj++F1LClkmAk97F/ODhlqP5N1uCDH
         6906otq9xY/j5Sj6izeE8wNHms1fVvP4+3q0mpUniB3tmROwmE+Dtey4dBYhNYgwuN8S
         fN8g==
X-Forwarded-Encrypted: i=1; AJvYcCWvZvXqwoQEfxitZgF2XpugcBCUpXuHOVPFR0NIomz1lYFcCQqC9Tgl3m9ixdUOFQkyimbHKjicxiWWqwVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmUeKuVrh8hA3FcfrnECSKUNBBSxJCqyfUROYlH3OIaQZG4lz
	Ss25N9oBgoSWnIi0ftulY6xu1MtgfTl12RbPWV+YAmJBSiCuic1BiMskRxLE/jynXhM=
X-Gm-Gg: AY/fxX5J8E8xvy96e/YZ3kqPVFEZg/Ox74P9IDK0lM7D1arY2leDAWRM7ylFhSZtfdi
	Sf1IQ/FHj1cuKx2Y1/uiteOiuppNRpP7Y5hSiRG7deopRqbBYZujm7ktV5IyQlx2z4b3/PsfVO3
	hOMUqCZTN9ISgHcf3EdsF6CKLFm1G/7XYce8296uE89zL2CODv/ooKbjdZQ8AEEeDaMMmvKIYF4
	GTO1ZsEdv8VrXHYSiQ/9twKlKcOnJA+aGVCrca8H9NA0WprwHOQr+/fvcm0jcMfm7iV380rs4mo
	wkknrmqtBpsY7iUPJNq0ho6u5IWyMspngApZXjNAhDZKfWWHYqIZiD5M5yKGB0YbhGY9vuYX1Nr
	6X5h5g9oMpQEDgAMe1ZFxtanHh0Sgur71sER9+rt0dS2TL7+pssa7ts4awWXlUjfR2nYLyC7zuG
	76OKv8qswPmWldAhxom1e7tyWBnfr5AZF2yJjh+8eDdY6rxrufe2I=
X-Google-Smtp-Source: AGHT+IG6OZvHpCCvcxnIwoAGtD/Eo/LUW+uxI6Ov0wNRz7YhzMBaz4FOJrbgZj7vD+XYSRn5DxQJdg==
X-Received: by 2002:a05:7022:3b0b:b0:11a:61ef:7949 with SMTP id a92af1059eb24-11f34bdbcb5mr14124127c88.9.1765979913484;
        Wed, 17 Dec 2025 05:58:33 -0800 (PST)
Received: from abhishek-angale-l01.colo.rubrik.com ([104.171.196.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30b799sm61526865c88.17.2025.12.17.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:58:33 -0800 (PST)
From: Abhishek Angale <abhishek.angale@rubrik.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	NeilBrown <neilb@ownmail.net>,
	linux-fsdevel@vger.kernel.org,
	Abhishek Angale <abhishek.angale@rubrik.com>
Subject: [PATCH v2 0/1] fuse: fix performance regression in buffered sequential reads
Date: Wed, 17 Dec 2025 13:56:45 +0000
Message-Id: <20251217135646.3512805-1-abhishek.angale@rubrik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112083716.1759678-1-abhishek.angale@rubrik.com>
References: <20251112083716.1759678-1-abhishek.angale@rubrik.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Miklos,

I am resending this patch as v2. It was originally submitted about a month 
ago, but I haven't heard back and the previous version no longer applies 
cleanly to the current mainline.

This patch addresses a performance regression where buffered sequential 
reads dropped from ~1.3 GB/s to ~1.05 GB/s following the removal of BDI 
congestion logic. By allowing FUSE to block on congestion during async 
readahead (similar to the approach used in NFS writeback), we can recover 
the lost throughput.

I have rebased the changes onto the latest tree and verified that the 
fix still restores performance to the expected levels.

Thanks,
Abhishek

Abhishek Angale (1):
  fuse: wait on congestion for async readahead

 fs/fuse/dev.c    |  2 ++
 fs/fuse/file.c   | 14 ++++++++++----
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.34.1


