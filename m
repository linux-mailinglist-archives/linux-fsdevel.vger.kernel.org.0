Return-Path: <linux-fsdevel+bounces-22978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FEE924B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C461C229E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC51DA308;
	Tue,  2 Jul 2024 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnhrFens"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75221DA305
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958968; cv=none; b=oENukq8I0eWz2Hn3UdsXzS8eRHmfgnfaFAC6Oa0MdcWn1SA4uUu6MOG6yRZWG/ZtP+GPTzoXxaOXOkI/HdAEqL5eyEWMUlW443O7Y3Hn5MK04kijLHIsmkys/4v/BVS6frbmC4+0KwTopU3MqP3gynA0zlG7jEnDXMKo3yM9tKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958968; c=relaxed/simple;
	bh=POC1LvdVSGsaJZmhm7oG2FEWQz22OxYbCClJZ+cJh1A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ep/2C3FiHgyahB0FGO4bxu7maDzgYnfmh+N1dYYqOyfHsHjahsku/0g41C2is4/xVmSoDLYwG9Zopon+F+O6VPT21G5mzNPs7BH5NEkZBPxJEC7VWB/m8X+ETSnKNg4yTfOBQ3UNsdbKjgCGQMeJvvY1MPiAh/OFtDugdytFwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnhrFens; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719958965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jv30lmG1zcI0hBI3PF1eKlWDo/lkNGDeeZud6vI1jGE=;
	b=DnhrFensAJknsxK0V8QujuDw3BzZhb6zvi+dA2tVnAqBeA3EDrvR9Aaj92SknA2yU3jk3x
	tfCxdkqXgAGn1ntrOb3Tvnll5l55VBaN/EaXzvX0gjdi4xsukJgLSPCDawIynPXsxlV1mY
	tQ6tIpq8ARfm63oJnRvRPiWqtBRKmps=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-kquraNPJNC2ByirZqdGBVQ-1; Tue, 02 Jul 2024 18:22:44 -0400
X-MC-Unique: kquraNPJNC2ByirZqdGBVQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so535180639f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 15:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719958963; x=1720563763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv30lmG1zcI0hBI3PF1eKlWDo/lkNGDeeZud6vI1jGE=;
        b=Xln6aFYwL6KIKCYCgR4DDhlbBCZIjiJziLJGDzvIXfLgIVTjnOlEMeXRydny5Cq2/a
         InLzjHaYlWQjf/TkxT/fM5EnHyW0LFZxLAe8aMTnvxGxCC+tU86a5+W3++Ee02rEP7Be
         L1o56wWBZSgTMVuJ8DpmiQkhRYb9kbPDs+OtLnTFK8+JNG7bD0hbFqSrwyOLA6veztJP
         MboXKAVE/+FTxklWyvo5jW31UOHlVO4R2h5N3gtPClZXdM1D6bdEQw6uJtQcIuL7YEFH
         Wi07Z1uYeVxp6V4wGR87Li8lQmlxq2YH4RmNcq1XLDzV2rsGLRx5KlGCsH1mGhZhOcKR
         0atQ==
X-Gm-Message-State: AOJu0YxKPowReKfw7XcYkPLM5dry2uZR40QAwrA123qXkrVtEGG0pv2a
	P42/sRtd/16pH4tBe2Zi9yzGYRm9rXu8mcAYB+SuXhui4Vhxg936kxRtvhblUOs5zEcQSTkEPJA
	im8qp445uxQzkvbq+gXJ3g6TdQwxjsy5z/J9IWMtrk+SN2yKJKa+B7vAf1lCQb8f0lJnkvjTXSk
	OpuU1tGIFn1T1Ikk09KGE8XD+E52p7116XleevSXl4IqDs/Q==
X-Received: by 2002:a05:6602:1781:b0:7f6:1b3a:4360 with SMTP id ca18e2360f4ac-7f62ee1d7demr1153481539f.9.1719958963309;
        Tue, 02 Jul 2024 15:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrA93zTvtoBvtNOA5hgUOffCLIyxV7Xne1NDtk/FhjuICJYp/znKIxcG6eOS8/xmwRaKgopQ==
X-Received: by 2002:a05:6602:1781:b0:7f6:1b3a:4360 with SMTP id ca18e2360f4ac-7f62ee1d7demr1153478539f.9.1719958962865;
        Tue, 02 Jul 2024 15:22:42 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9de0dsm286658139f.20.2024.07.02.15.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:22:42 -0700 (PDT)
Message-ID: <8f07d45d-c806-484d-a2e3-7a2199df1cd2@redhat.com>
Date: Tue, 2 Jul 2024 17:22:41 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] fuse: verify {g,u}id mount options correctly
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
References: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Content-Language: en-US
In-Reply-To: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As was done in
0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
we need to validate that the requested uid and/or gid is representable in
the filesystem's idmapping.

Cribbing from the above commit log,

The contract for {g,u}id mount options and {g,u}id values in general set
from userspace has always been that they are translated according to the
caller's idmapping. In so far, fuse has been doing the correct thing.
But since fuse is mountable in unprivileged contexts it is also
necessary to verify that the resulting {k,g}uid is representable in the
namespace of the superblock.

Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

p.s. sorry for the delay getting this posted

 fs/fuse/inode.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..32fe6fa72f46 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -755,6 +755,8 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		/*
@@ -799,16 +801,30 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
+		kuid =  make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalfc(fsc, "Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fsc->user_ns, kuid))
+			return invalfc(fsc, "Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fsc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fsc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
+			return invalfc(fsc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fsc->user_ns, kgid))
 			return invalfc(fsc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 
-- 
2.45.2


