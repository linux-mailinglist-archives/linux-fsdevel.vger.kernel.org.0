Return-Path: <linux-fsdevel+bounces-22708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58C91B368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EB01F23D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE34C7B;
	Fri, 28 Jun 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkHtSo4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA13566A
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534772; cv=none; b=HujCTWi9Zc3T59lEDuRaFEKJWeXQMpTNrcg13ySfo+U83IVUl/P0JPQrIc74gxsNxGS3SEEZy1O2KsL819UQc1YlQEevalXjCD0R8sZIxIuB+ulDBiRVSrVBpm3Ly9XFarqXvbVia4icbPaIBWNGWuQfYYS1GBadj8DuWIciAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534772; c=relaxed/simple;
	bh=Ulp3S5stzv++vXxGMYfQ+BcivZiIAYPslw4rKUn4U8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CqjASS6pi5ebarpfl3169StcjlkCuYSRctFnWtpwcH1bExb6bNQLSSuqON7gDdLk1ac/QKxTCc0Zn7gH9NQNCgZuZqIYDQd4ghkaLKWK1/spHoCX/HZxus2y2dtLKkJTNlcKZoKgvpt+9sZeKDROmgFv9zty/UvoLfdywjDZe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkHtSo4o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gF9nFCuf0kckhaKB+8V6fEgppLRhdmw1EGPzkGHiXpY=;
	b=dkHtSo4oKodpqUSityXVrCfxYgBG4EUxfqxTN0/zvhXK9UcLwl4+RFHBMobZs6h+dR+D0d
	EY6ZaorPNqskJcuD3dX4D5FFgYAVTesJJGPqJlYS530nI7B8276dKKWVqzdiGN5x8kSFL4
	IQ6BR7LBRnUcSjNdAT1KNkVCUP2euUM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-q4T9X-4YNZ6r_eJlsxwXOg-1; Thu, 27 Jun 2024 20:32:48 -0400
X-MC-Unique: q4T9X-4YNZ6r_eJlsxwXOg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso5305239f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534767; x=1720139567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gF9nFCuf0kckhaKB+8V6fEgppLRhdmw1EGPzkGHiXpY=;
        b=RgJ2uOkfcibM5upw3+DsgslgtpnYNt741f6PthKZi5bTl8DWLEJB6yZrEUOtctXfSQ
         FpBEq4NtSIqggVimQ6bK8tVZe/9XJMM5OHf47l6JOROW4mAYYEmzxFDBhra4hJRCctgr
         2mjnqiZ24ZeHvCPso8evuy7juaU8/4giTeCPByrDlYZKiBFw2W9D/f6M68vtjeX++v56
         jB5BTWoySJj9VS7DBb2C5pFRogdnyVlExxeVhKh073ViqxLiWpDwVOat24jEAD03GhhF
         nSa2kBXsMHpH+0tosQTgag7P2tb9MgCWtToDUyMRl/hpWcurq6+NhcNdRmIYS/vOc65c
         0kJg==
X-Gm-Message-State: AOJu0YymnsCD/qpZdEjHkfEfQHeEGvJ1EugWVV/6xEQazwXYvK69bLbC
	KhOogLlLruL1pGrq5TegqVZWAYTewjfpb6gQHznEUj/nQPIX5PULLGAZ/BtlekAQm5C/ImbPvYY
	itxvAcJmNv49/K5ja8VNi526vSolZIaRWaSNzI2NGLRtMyKQqKPWqOCaDTdwdea8oqwlH8CZSjB
	73R93o9D8RzaZM+SRDFC3ujDtYByxzEwtk1er/ozeaRN3MaA==
X-Received: by 2002:a05:6602:6b83:b0:7eb:89ba:44fe with SMTP id ca18e2360f4ac-7f3a4e5fd59mr1779260139f.17.1719534767023;
        Thu, 27 Jun 2024 17:32:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrEmB0ut+X5uwyOZY4YQ5np2u4zYFSu0O6OK+ZudOrt68gsCAqACfpyF4yngPu0Wnsr8jW3A==
X-Received: by 2002:a05:6602:6b83:b0:7eb:89ba:44fe with SMTP id ca18e2360f4ac-7f3a4e5fd59mr1779257939f.17.1719534766490;
        Thu, 27 Jun 2024 17:32:46 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1f6bsm217940173.178.2024.06.27.17.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:32:46 -0700 (PDT)
Message-ID: <a84be40d-5110-4dac-83b1-0ea8e043f0fd@redhat.com>
Date: Thu, 27 Jun 2024 19:32:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 06/14] ext4: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-ext4@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ext4/super.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..0c614df3225d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1721,8 +1721,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("bsdgroups",		Opt_grpid),
 	fsparam_flag	("nogrpid",		Opt_nogrpid),
 	fsparam_flag	("sysvgroups",		Opt_nogrpid),
-	fsparam_u32	("resgid",		Opt_resgid),
-	fsparam_u32	("resuid",		Opt_resuid),
+	fsparam_gid	("resgid",		Opt_resgid),
+	fsparam_uid	("resuid",		Opt_resuid),
 	fsparam_u32	("sb",			Opt_sb),
 	fsparam_enum	("errors",		Opt_errors, ext4_param_errors),
 	fsparam_flag	("nouid32",		Opt_nouid32),
@@ -2127,8 +2127,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	const struct mount_opts *m;
 	int is_remount;
-	kuid_t uid;
-	kgid_t gid;
 	int token;
 
 	token = fs_parse(fc, ext4_param_specs, param, &result);
@@ -2270,23 +2268,11 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->spec |= EXT4_SPEC_s_stripe;
 		return 0;
 	case Opt_resuid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid)) {
-			ext4_msg(NULL, KERN_ERR, "Invalid uid value %d",
-				 result.uint_32);
-			return -EINVAL;
-		}
-		ctx->s_resuid = uid;
+		ctx->s_resuid = result.uid;
 		ctx->spec |= EXT4_SPEC_s_resuid;
 		return 0;
 	case Opt_resgid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid)) {
-			ext4_msg(NULL, KERN_ERR, "Invalid gid value %d",
-				 result.uint_32);
-			return -EINVAL;
-		}
-		ctx->s_resgid = gid;
+		ctx->s_resgid = result.gid;
 		ctx->spec |= EXT4_SPEC_s_resgid;
 		return 0;
 	case Opt_journal_dev:
-- 
2.45.2



