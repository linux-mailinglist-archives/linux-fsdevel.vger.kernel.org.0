Return-Path: <linux-fsdevel+bounces-22713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572991B430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E8F1C2169D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC66224DD;
	Fri, 28 Jun 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRVP6jZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAE1D545
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535098; cv=none; b=t88RsmqyQOAO8YwTFzm4LT/vdp3T/4coVehNY9xMGD5iaDEsEgprCa5oJ+cCTJyKji5aHCNYGMOxLPKYTQE5rcbLXVLzDoPJB+WnCt5ItuFBjUF8844Zu8pcBgDsmqkaSix4QI03ge4tIfGAGpGCOugr+A6bUSYL1yn1OBp92O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535098; c=relaxed/simple;
	bh=+4+e6BzekZJNnDjFnnOhhaWUyuWndWTUObFeMdHxjWQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sv3p+IrSwguvU7wcxlPnS/ladcwwhvB+tqmyYtxgkDn13o//q3KzDvkja47p7Krm0TJGuE5907FXPDe4qoGklA2/B7zqtI5hg/2QqfmSlcfrNwHOJaNKCuNpZCDxXHXDv2PiwSyHr0R7zlrDKtqgSHvreKgFUw1VWR8WyGtKoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRVP6jZh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29Ula9NPUYU9ZHKXK1TTET3Q7YUfe5/KhwenbSdyx5g=;
	b=dRVP6jZhTpLgwBH0yJC9+ZiPccW5i5sY9keGdfU4l2tHolc1VCwc1W5jjdtP8FJbWrJFni
	ZaPBlO4zZP+njnAYWNNL7rJIQPhZpvUL/5i4znw+fs5LVOyGaDz+iEjebq/+VRLdDFmAn+
	6Us4+VzmderRDo7TByq5uBjCVpvM0ns=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-NfN5utNcNUe8vun8yRuRHQ-1; Thu, 27 Jun 2024 20:38:14 -0400
X-MC-Unique: NfN5utNcNUe8vun8yRuRHQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eafdb25dbbso3799039f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535093; x=1720139893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29Ula9NPUYU9ZHKXK1TTET3Q7YUfe5/KhwenbSdyx5g=;
        b=CPT3k57uEz4VsIn1Q/8UgQCDRV84W0w5cZNNA73B82U1AFkUISiY+UDhQTCP0TCTpx
         q9zbHXcpc4xRn/neqK3r3bh4lAqXo9UJTq5lNv/tCUd7kmCMyvZkjfC4xmvvY7wBGnCw
         m1mGZ3Ha0KGQTjzIe92AD+2XSuLZrqMtZA/RzLho9qvL458F3VJ5i5SuYwsGnrJhPxqv
         9xe1YLHdYYtvuZYtGrIe0hFmA8Oe4ke7M4vcQt653WOS0YES+hYpUwpBlXrYhWT6fB3J
         lHgF4LPw8F6uffc9AnjNQa0xUBkYJKVc7GHWLv4YW6K9IkGpGw7OjDW7+/BlzgmQLfwo
         9lMw==
X-Gm-Message-State: AOJu0Yz3j94qjk77LFF1bf1nu/M3O1A/sY94LlW3MM3a8fK73l1Bm/B/
	V/Q1lrwvS4t0MAEgzgw4cQ14eTRdqBPGkSukreOo67f3sZsocakLkDsrFlBk/phorz1tZc14Grz
	JkqO1HmByTiUK9Lt4yfvFy8MiZdmxXE5ddYqdqemma60BX/h5vmRurg20APWkkfCpcob2nIWUOL
	bXU9EnlX2hysLNUy4mTQCa3naA74QZcDo3MIAKlDmM75zgmA==
X-Received: by 2002:a05:6602:1648:b0:7eb:8887:d6c3 with SMTP id ca18e2360f4ac-7f3a4dda0d6mr1937224439f.11.1719535093222;
        Thu, 27 Jun 2024 17:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxqgFVI3k6X0qAOuP2yi+58eeC72Sq6ILbNqb+MthMIuCOYIhyyBK37gEipr9eZhFvFHZE7A==
X-Received: by 2002:a05:6602:1648:b0:7eb:8887:d6c3 with SMTP id ca18e2360f4ac-7f3a4dda0d6mr1937223139f.11.1719535092889;
        Thu, 27 Jun 2024 17:38:12 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bba7c0sm226668173.16.2024.06.27.17.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:38:12 -0700 (PDT)
Message-ID: <06b54c7c-4f08-4d99-93d1-32b9f6706209@redhat.com>
Date: Thu, 27 Jun 2024 19:38:12 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 11/14] tmpfs: Convert to new uid/gid option parsing helpers
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
 mm/shmem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a8b181a63402..922204184a82 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3903,14 +3903,14 @@ static const struct constant_table shmem_param_enums_huge[] = {
 };
 
 const struct fs_parameter_spec shmem_fs_parameters[] = {
-	fsparam_u32   ("gid",		Opt_gid),
+	fsparam_gid   ("gid",		Opt_gid),
 	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
 	fsparam_u32oct("mode",		Opt_mode),
 	fsparam_string("mpol",		Opt_mpol),
 	fsparam_string("nr_blocks",	Opt_nr_blocks),
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("size",		Opt_size),
-	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_uid   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
 	fsparam_flag  ("noswap",	Opt_noswap),
@@ -3970,9 +3970,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->mode = result.uint_32 & 07777;
 		break;
 	case Opt_uid:
-		kuid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(kuid))
-			goto bad_value;
+		kuid = result.uid;
 
 		/*
 		 * The requested uid must be representable in the
@@ -3984,9 +3982,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->uid = kuid;
 		break;
 	case Opt_gid:
-		kgid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(kgid))
-			goto bad_value;
+		kgid = result.gid;
 
 		/*
 		 * The requested gid must be representable in the
-- 
2.45.2



