Return-Path: <linux-fsdevel+bounces-32891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8209B070A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E538128494C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271917C225;
	Fri, 25 Oct 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIrzg0QV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A817BEA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868526; cv=none; b=W0Qekl1zvmjGu1n2g9b51qOUrXjLHHoeWHtVdZJz00cqix7ATPoaZrc89oM7oaM+0lpHwt84QAkspk4XWl4OMBfBf3nH5lod7lT7OAi7cRoYLyRyyPRoj0oJ+WCnYbA1ZibY8OXgksPGLhO8BGN8D5w9WRrOgfppR+SuzjmrNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868526; c=relaxed/simple;
	bh=6DQItpHNmPUlinaFM/3uXjfpJKAJ1LMbiY7pPkgBTbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6pwsC+yzbM2wUWJFUVshrtU0AzBWCGV8UquqzFgCOuqXDcGFk4ItNzQmnYOHjF2SeyqWPM00pLvLkPBAHcK6YQywsmOGeQq0Lkam5DiXRJMu1diMtOrQ8CjcWknDL//alEf2BqgfAjKlMkrNtsSK+QRuDTs95w2O80cSsNV0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIrzg0QV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NQCVyRwqLq17C0Jl7DZDgiok560sNkHv2+RqbNocmhE=;
	b=cIrzg0QVTwGQgJiGC1DVGKzcX1HktSov4YIbtvmhh1MZqOWTAxxdi338ykzgNlXAdQkb0H
	BV8iAyTHrsVFjBO4qrWK8OXfmnLvi/ghCZJ1XAkDE9D5zwzDdH3Oek6Ka6MPj2TSfTgD/t
	XSMlBtkaYSFpRBC9v62gKjDYozvo4JM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-I1kyeft0OXSujOkC8PS0yw-1; Fri, 25 Oct 2024 11:01:59 -0400
X-MC-Unique: I1kyeft0OXSujOkC8PS0yw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4317391101aso15267485e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 08:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868518; x=1730473318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQCVyRwqLq17C0Jl7DZDgiok560sNkHv2+RqbNocmhE=;
        b=L+o2a2FWnGiJoVlRWZTr+5TdUfP9HrBYHh0tgm0hVZ97SxSYHOyoWIg7e8bfSpa5kf
         3SbsVDcSq3bI9gPZyYQe2OldjGJ6ZK8xsTv0TfQ5U/y1JbCSs9FvETK5nV/bPSreurfA
         Mx0+BgOwjLQGdHsJqAGOLaMM3Iy6AT5/0FaKPflDwzndB2G5XPMshOsdZPadoYiFi0o4
         L7sRnRxPfmjx1TP50GRKBFnik/pNGGPYe5Wje0+Ze7pvkpLcx5Bx4/c3iqEARmNmegnC
         y3Vsv4RuSjMx27CwigcuPFJMZB//ViqEBtCFB/4ILf+717VnuJRPSIJcrd6675zl7ob7
         vuTg==
X-Forwarded-Encrypted: i=1; AJvYcCXxQWylfgVYyQoZ5G17YoZO8pWw1z8226B8ZHwYUzZuyPGVSYRRM4HQ8m/66qm6i5obNjW6Hg+BdZFXz5Fk@vger.kernel.org
X-Gm-Message-State: AOJu0YwNe9ePsbjrmjnoqf2c6bLnC0cyFncHWPhs1lHZgLimeNNaYNwP
	Fk45XWVlfh2W7jeYXPwzrJgWhL+fqZgRSjb0OawSD6dHOxVIkv6ecX1ufJOx5v21LggB2PZ+L3F
	rsTdEQO6kRVxNPP8jiYlUZKhZU/b3s5kW+iD8Fu2ckVY4CMKXTkCIH9PsGc3kPcw=
X-Received: by 2002:a05:600c:34d4:b0:431:5533:8f0b with SMTP id 5b1f17b1804b1-43184246647mr95157135e9.32.1729868517938;
        Fri, 25 Oct 2024 08:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZusoAnePpnOR3fg/5cReNvWrXU3jddzdpjthTe0IoyPPx2z5mCJo/FAbfR/pC8GUtBEuFtw==
X-Received: by 2002:a05:600c:34d4:b0:431:5533:8f0b with SMTP id 5b1f17b1804b1-43184246647mr95156495e9.32.1729868517407;
        Fri, 25 Oct 2024 08:01:57 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-6.pool.digikabel.hu. [91.82.183.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b92958sm1717817f8f.106.2024.10.25.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:01:56 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] ovl: replace dget/dput with d_drop in ovl_cleanup()
Date: Fri, 25 Oct 2024 17:01:50 +0200
Message-ID: <20241025150154.879541-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason for the dget/dput pair was to force the upperdentry to be
dropped from the cache instead of turning it negative and keeping it
cached.

Simpler and cleaner way to achieve the same effect is to just drop the
dentry after unlink/rmdir if it was turned negative.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:
 - use d_drop()

 fs/overlayfs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ab65e98a1def..c7548c2bbc12 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -28,12 +28,14 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 {
 	int err;
 
-	dget(wdentry);
 	if (d_is_dir(wdentry))
 		err = ovl_do_rmdir(ofs, wdir, wdentry);
 	else
 		err = ovl_do_unlink(ofs, wdir, wdentry);
-	dput(wdentry);
+
+	/* A cached negative upper dentry is generally not useful, so drop it. */
+	if (d_is_negative(wdentry))
+		d_drop(wdentry);
 
 	if (err) {
 		pr_err("cleanup of '%pd2' failed (%i)\n",
-- 
2.47.0


