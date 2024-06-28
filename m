Return-Path: <linux-fsdevel+bounces-22709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C932891B422
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8624D283CBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E43CA40;
	Fri, 28 Jun 2024 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/qj0Mfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADE14F98
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534829; cv=none; b=ZAITCYxm5jSiiikevs8+RD0QNrqZmJu72EVz2DpOkzu5ajm4+ZUPcgkHOMANPNAjJkYzY91J+JGNhuScMQt50r3MGtVW9SLZoumFyA4nXDVGE9GlKyB23sdLjAvJ2V3nglax25gx2khcdXjkhmlWtHzREXH7R4TyaaCF/SQiSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534829; c=relaxed/simple;
	bh=YBjNBL3ZI8XMLnFFvkCOP/3a8J9ZpUn9wm5WCknMTf0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hlduWmF0UxnO2aprERl+x2oGWORSbrFOQT7X+i2XCEQ39q/pCnG/FGoyjswh7+XyeVDt1erQs4Ncugze+GK1MpoUL3pycvq3tCs1P/UbKASbQTX3MSRTlzAyQ34jFnIQjxH3KnD7cvNX4sne1q2wY+3bcRhokdn0queYZovpxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/qj0Mfm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QibGL+vvqq0wMB+UsoGLlCZB/mxqsrmjQq0cSORajaA=;
	b=P/qj0MfmcWW/W4jy4oTLWB+H01Rxs2/jEwuh7puxxCCVOIyG7clPljhBvgGg5d0DRUby72
	xDaysxHsmgaed/Sg+7QxHIJyKyblBUQ5VlIcE4IFKX9pVqmkzhEXG4uh3jkxdFCtsytf39
	3dugThRpStl1LmAwE3pipKFT0CFuV7s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-G8__aMNcPNqUfuhMsC_JHQ-1; Thu, 27 Jun 2024 20:33:45 -0400
X-MC-Unique: G8__aMNcPNqUfuhMsC_JHQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb84511dbfso3533639f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534824; x=1720139624;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QibGL+vvqq0wMB+UsoGLlCZB/mxqsrmjQq0cSORajaA=;
        b=q/lmeUTI3fcxqf7Q6LJ//4TOvzY9gxoAh3Ye6QNjDeY34oenjpaCaEqkYVk1PBLFFk
         wgldmWtI4rVaVpWb1YcjiCpA7E696uNWFOhVWHJ+843VQWqApCVK9n8ylFeHhTpi0d9S
         q99PiBLcwMKI4HsVZAWdZepG35GQ1c36TYeL2lMGFyfGJzSViGD02Wc3Y8rIUAMjgnCv
         sgWHXTnMAmWvS8BY4HFYUTnwGByqq+eY6bIVR2ip8RcxoaE2ooSNBoInAooPlJ0RA2nV
         SxiV4W7O+nkSOEPOF7k3GhdKr7jZOjqTNIf8wxxCdopHmNAkM1YM0HIgVwiiBySzZ9f9
         vdWA==
X-Gm-Message-State: AOJu0YyZUwBiiytkgjc7CqQE55y05sl7ug6qW8boTLuScOr//JY40sCx
	Gg3nWaGX/J2dCNWnPq1/Iy5ixe2KI+wk3qJK9eHrMSnlsHK0G3cDDLAZruYvNSupr/1FU4gs88P
	+DodFVSDfck5fDbUAY+wcghhF65RUSPu7u6Z+1oVDJr+VRWUZL65oNLt3VVdRi5Iey3LCNHz0jE
	duhYWuwBPJzoaJBUebBGKRD/CfTkS/oZhdFoPro5BFn9CkqQ==
X-Received: by 2002:a05:6602:1582:b0:7eb:7f2e:5b3a with SMTP id ca18e2360f4ac-7f3a4db2390mr2023996839f.2.1719534824638;
        Thu, 27 Jun 2024 17:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLHLOhGCcweETa4ASZ5p1k/qKBA7dRKalfxzAvHnS4heo8nXLZlDbu1Bkj+2v7ghwA12KzhQ==
X-Received: by 2002:a05:6602:1582:b0:7eb:7f2e:5b3a with SMTP id ca18e2360f4ac-7f3a4db2390mr2023994139f.2.1719534824285;
        Thu, 27 Jun 2024 17:33:44 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd541dsm222305173.55.2024.06.27.17.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:33:44 -0700 (PDT)
Message-ID: <02670c04-2449-443f-bf44-68c927685a1c@redhat.com>
Date: Thu, 27 Jun 2024 19:33:43 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 07/14] fuse: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Miklos Greczi <mgreczi@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/fuse/inode.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..1ac528bcdb3c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -740,8 +740,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_string	("source",		OPT_SOURCE),
 	fsparam_u32	("fd",			OPT_FD),
 	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
-	fsparam_u32	("user_id",		OPT_USER_ID),
-	fsparam_u32	("group_id",		OPT_GROUP_ID),
+	fsparam_uid	("user_id",		OPT_USER_ID),
+	fsparam_gid	("group_id",		OPT_GROUP_ID),
 	fsparam_flag	("default_permissions",	OPT_DEFAULT_PERMISSIONS),
 	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
 	fsparam_u32	("max_read",		OPT_MAX_READ),
@@ -799,16 +799,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
-			return invalfc(fsc, "Invalid user_id");
+		ctx->user_id = result.uid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fsc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
-			return invalfc(fsc, "Invalid group_id");
+		ctx->group_id = result.gid;
 		ctx->group_id_present = true;
 		break;
 
-- 
2.45.2



