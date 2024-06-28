Return-Path: <linux-fsdevel+bounces-22710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9191B423
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9111F21245
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E663C7;
	Fri, 28 Jun 2024 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQJNWdiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC0D304
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534918; cv=none; b=n3sy/QwXjoM45jPqt/5O60ZwX7YAZrOrCE6XIzAK/HMFhQE4k3oPyYVAPi8P2ZrYiWFw5XTJu/ZIe5MOIvUrJbMwfDS0m/2u9A5zK6ltEHkTZUVmc+c+Gh5W2sZGjoijo2y4o8/8bW3TUZTvHDLgBfBl9xIfSWr8WQHf2Ex5Rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534918; c=relaxed/simple;
	bh=FpPiL/t10HZ8MzrR9SxKHIyYJGbHROTOe5kCW+T8G68=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ism+C1ZxRhiOCwaEAnE5CF6dlhPIcd120LCXfo/veIHFfxxbvIUGLM1ErvW/DID7XZK50C/KuOxXI3rFucQO4WBqh8/DqN93uaAfnXhlcGvWcir5gFdWOt/modpSlOg65E7udy4tveCxc59cG/IiwCKaMSl+agz2CjqRUyy909U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQJNWdiD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uXKmUT/nwyBhbjHXhbeGwv5exw7uxZHD87X7TVS31A=;
	b=AQJNWdiDupx+0nEFdDyuzPWc+lJUIQTOoiUYT3ei5blhm5/82EcoDl9xbagD3KU0oLkV7W
	5n8RBAl4lFZ3MvFm2429mYh5tLhf3Ma7rEaj+4zPwiXfGlJxlLATykwO/0/eDjH2bSgxom
	/5fDf0DrfztIzQtGc4qSFztzcF18IyQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-oZUq6DoyO1qX_TKRARXCxA-1; Thu, 27 Jun 2024 20:35:14 -0400
X-MC-Unique: oZUq6DoyO1qX_TKRARXCxA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so3620839f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534914; x=1720139714;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uXKmUT/nwyBhbjHXhbeGwv5exw7uxZHD87X7TVS31A=;
        b=hG0ie8TfHwNGse4YQ1IyqJzPM1IBT3d0GxsaNSwuFbP2ZjdXiauv5KqmxXebQpVwkC
         r6S+eZbOXX5UNA2ypjyzniLFGDLOtmiyrJw5s00JFzCI/gBRFbCAYWCxVKmXnlDOVcZ1
         /Xqc2KyAupQ4kcPM0VY1psjao7n+p4zMJiIV+aotvmwk/5TGfuu19759FcPOHq3+2MGR
         xAZNQhtaDR8KredwvMlmZ9+T0xONGaXm0QhcyBEq8WKbKkpix30BhgnjEuGXFELqP6Qu
         gqkrevMuQI7agWJc995keuk5RZIjGgUZcc2ngsRzsWYUVTeOx6O84/czFpL5WMRyfupD
         /PIA==
X-Gm-Message-State: AOJu0YwFwqYT2FL/9EzDHruX1yTCqBEeDcry0Fu6MNQLfsTl7LnZZROj
	0+Xaxyutt8okHIOAbePltn4e9w6dwbG/CgkTi4VWiQSn5tt5aThPhv3D9ikafT4l3zHxxuPRxcE
	vVfVjfuo6AhBHB3JJA+vWt2gxwVFx5NENbe/i+SofksHrKwcs95oO54UI0mog7PKaoWat+070Se
	M09g0MkXM+/qw7j1HVbkOP7sWPZyvPiCUCMed1OItPd/7Zxw==
X-Received: by 2002:a05:6602:2cd5:b0:7f3:d2d5:f06a with SMTP id ca18e2360f4ac-7f3d2d5f2acmr847380039f.13.1719534913952;
        Thu, 27 Jun 2024 17:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5bkzdQWyhKslA1Bbi7lsK+W3KJetd3xDc9zpQWMVm09ROQZ7lBfg0thxSlPP3X/rVq2ScLQ==
X-Received: by 2002:a05:6602:2cd5:b0:7f3:d2d5:f06a with SMTP id ca18e2360f4ac-7f3d2d5f2acmr847378239f.13.1719534913643;
        Thu, 27 Jun 2024 17:35:13 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd71easm224905173.62.2024.06.27.17.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:35:13 -0700 (PDT)
Message-ID: <6cb0dcfd-f837-463f-b5ec-0e7d2608b837@redhat.com>
Date: Thu, 27 Jun 2024 19:35:12 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 08/14] hugetlbfs: Convert to new uid/gid option parsing
 helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/hugetlbfs/inode.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 412f295acebe..81dab95f67ed 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -73,13 +73,13 @@ enum hugetlb_param {
 };
 
 static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
-	fsparam_u32   ("gid",		Opt_gid),
+	fsparam_gid   ("gid",		Opt_gid),
 	fsparam_string("min_size",	Opt_min_size),
 	fsparam_u32oct("mode",		Opt_mode),
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("pagesize",	Opt_pagesize),
 	fsparam_string("size",		Opt_size),
-	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_uid   ("uid",		Opt_uid),
 	{}
 };
 
@@ -1376,15 +1376,11 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 
 	switch (opt) {
 	case Opt_uid:
-		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(ctx->uid))
-			goto bad_val;
+		ctx->uid = result.uid;
 		return 0;
 
 	case Opt_gid:
-		ctx->gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(ctx->gid))
-			goto bad_val;
+		ctx->gid = result.gid;
 		return 0;
 
 	case Opt_mode:
-- 
2.45.2



