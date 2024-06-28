Return-Path: <linux-fsdevel+bounces-22705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF591B363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC3B1F22FAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9F3224;
	Fri, 28 Jun 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBoki0ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4417F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534594; cv=none; b=DyqnsxzoTGU0lPQ8RcMxkh5Qmt66c5uoRZ9UOvIoDYiF7kEmUO3JolTxBG62VNLc2XzgPtQP+w2tHLkVFikwJkaZdlJrvBt87oNTN2Q+VDszOJJ+3WhlP1nskddszNm7OazDK9qFvcqPZ8b1c3mv/f68jUmTH8JM/nZJWiPK8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534594; c=relaxed/simple;
	bh=8VoF2X4B0jZD0zDxyfbRc7nZTqlYgEYQgw983ZWV+2E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ub7zACoTcxlLJ5aGoY8nLp2KR4FTpIrGR7e/sh93L4E5u3E4r9hZPTegjhElMTdPmJImy/Ngq3ULi7AjHHaEYglbx8hXNAa5ylm1qJZfuIJt5fSyGszQWenoV8nqtzwglFMd0VE/usEa33vYK951zegRGa9E0ATuep3X7005Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBoki0ob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSv7i0qDIEkS+ppeR43TIf3B4nv0jOxW4hW0qfrZQMI=;
	b=jBoki0obUk0w764dBjc5XaySLzuJTJVAwOzWfyFvseO2g4ErL372RK6TlFhYcm/NR+ptRu
	arcSe4sTTOpPdrMC+NDjrWxd0TyhAq15It53Oroj3lAHpn5jvt/UjtX7HJQTm9B/UMsRyv
	j5jCOBv00O+mS0UQZckiQPT9do3ROis=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-h68YM_YKNIOhQOlIgdqv1Q-1; Thu, 27 Jun 2024 20:29:48 -0400
X-MC-Unique: h68YM_YKNIOhQOlIgdqv1Q-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375e4d55457so1278225ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534587; x=1720139387;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSv7i0qDIEkS+ppeR43TIf3B4nv0jOxW4hW0qfrZQMI=;
        b=P3dFnM/BHKNfCx9bdhmN1eiD3eE702KEQcbR9agDWxb9A3X0rwFE8bafL2rtdfQR15
         qUeG48yqA6NEJWWwE32mm7kbIm0rmJdL9RElHQVkAMeT2gFWrU4w3lcvFhkfziPyqel3
         KvxS48XX8HS2tW0lblwgjF7V9F3w0GMMvMlXkLAxaOtZ7mOvfRKwjOwrtP56OaaQo0mI
         GgS4IAC1id5ku9US4BlzxCyP1GIAnqcRLNEFBko2O+PxsEj0M7W57t9ceDThevH+3nR7
         bz1uUERmE7/cowh0ZnNkNCTSu1njwJSIRMd5hMSd+MS4FsxkP3c1DD6ytwCwZ9EzGuRQ
         4xdQ==
X-Gm-Message-State: AOJu0Yw3/j83ilCiFuWT3ZYc0IjwaPsmwreDp33Sc5oqNEp6ISfB9CUT
	rCbLsnCPIAc1c3VGxEZ5RQjaNs/dlhZL0avob6X5j8EwFNc4CpWM8WnC+cpxgaijPRJXpynkzMf
	RnVHw15xzyD8Lbn/wkOwZPRS7Zg6PySDAr4cM7jnqE3iOtZHR+7FtX3Vz1dz/RVYAswnPzH5ZVX
	+xmzcAapcklbkJ5zpC9mSswOrc7+PZfNJf/Nl8Yfv6clTvPg==
X-Received: by 2002:a05:6e02:1d01:b0:375:9e3f:5f6 with SMTP id e9e14a558f8ab-3763f5a3e26mr190746685ab.6.1719534587278;
        Thu, 27 Jun 2024 17:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGyhFrtW+EJajjBfiX272bZcWNrR62s3O/d/YHQ+hO8rjrB/feEFoBk5FjDgW4A4xT01w6rw==
X-Received: by 2002:a05:6e02:1d01:b0:375:9e3f:5f6 with SMTP id e9e14a558f8ab-3763f5a3e26mr190746555ab.6.1719534586928;
        Thu, 27 Jun 2024 17:29:46 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad483bfe1sm1692835ab.80.2024.06.27.17.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:29:46 -0700 (PDT)
Message-ID: <b2f44ee0-3cee-49eb-a416-f26a9306eb56@redhat.com>
Date: Thu, 27 Jun 2024 19:29:46 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 03/14] debugfs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/debugfs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 8fd928899a59..91521576f500 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -92,9 +92,9 @@ enum {
 };
 
 static const struct fs_parameter_spec debugfs_param_specs[] = {
-	fsparam_u32	("gid",		Opt_gid),
+	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
-	fsparam_u32	("uid",		Opt_uid),
+	fsparam_uid	("uid",		Opt_uid),
 	{}
 };
 
@@ -102,8 +102,6 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
 {
 	struct debugfs_fs_info *opts = fc->s_fs_info;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, debugfs_param_specs, param, &result);
@@ -120,16 +118,10 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
 
 	switch (opt) {
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return invalf(fc, "Unknown uid");
-		opts->uid = uid;
+		opts->uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return invalf(fc, "Unknown gid");
-		opts->gid = gid;
+		opts->gid = result.gid;
 		break;
 	case Opt_mode:
 		opts->mode = result.uint_32 & S_IALLUGO;
-- 
2.45.2



