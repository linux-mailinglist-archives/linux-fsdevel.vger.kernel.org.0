Return-Path: <linux-fsdevel+bounces-50862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B9AD087B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652DD3ADCD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382D1F8AD3;
	Fri,  6 Jun 2025 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="fJqf8I80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E141F4639
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236697; cv=none; b=ZasiiiK7oM0Jtq3hQtMz46CjSqvV15xcR83NCshVaKXXvoE5uwHsQKkiRQ+ZlJu59BrhQ9pJJKJp5+NvLjAfTJWB+tAGmde3EOBjL74oTw9Q803krv36klLeGzEPY/EHeuSFB/4EwIXESDMcYfrPwENBXc33oAg8HJce8wXCePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236697; c=relaxed/simple;
	bh=1PoYg5xriElbwD7OvrUlYuqU3u4KW6RcM0X9faaV08I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qfso8023fTY8nh8F4hcpPetFtHj/qgzs0CdHofXAt26KhKxwylKkHuwO2HWR3fFGLkC1wsEu0uUo6JMDUgiL2O7gYhZ8O3TT2YpIovQb/ZmidLtFceMBo27nLqjS7CSWYzC3T0oDWIdNf4dN44x6sp7sf7Z3FUDxk0/HqRy3SyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=fJqf8I80; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7303d9d5edeso703117a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749236694; x=1749841494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NegMO1c52fxWWYkRi+/j8SL4P9IJsB3x+6XIFYEGA+I=;
        b=fJqf8I80FJXVsAmUtCe1U2jVibPTjJVHhHAK9xbgnBFDbMYJmtiyRNJkM5F3sBZ3Ed
         s1iMoK5LQTx0EoSr6+IezzxNM4CSmRVLMHyaXqPXqCJ0przq9RKFFaL3MqXLqWO3Gy7U
         VRPQaxCFTKQocDAdTdBnKV5wKjgpr4SHEGRuZW/mFPt/C9B+tvJ/G1bteQo1i2kSchxE
         Omrj3MJov1U/wL98kd14vcYsqJHhooYMZFiBp7RJkQbCBQVIw9Bqbka4qQ2n5j8/t5HK
         MJQ3txexpfPivmLmSua+v0baeo8TRSGCB9w0Xbj94BAtaKZckAlWMRXsSsdxeNewOn2V
         Epgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749236694; x=1749841494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NegMO1c52fxWWYkRi+/j8SL4P9IJsB3x+6XIFYEGA+I=;
        b=Oso9uSF2Bl1ToFonNP04Fc1m9c5pUuOpgGX/onye+I4TqhBQUnnGTqNCzRPSfjAqxH
         pCireCq+eFg11mpFG0Et+pdUmUN3HCS2J58cWvmuQ1frVfC63a5aj9KokgIBzz1MNY/Y
         CEE+FSTgIFGbbTl2SCVOBorgDz8s3v3i94l3WUuFST25doOcghr2Uoefg42qhRe6KzZD
         gR1Av/X6ZWL3ujSyFYTsXUtoGtt4sDtUt66YezBETiAAPHWgWXXVp2Fnk+EZ1W444HsE
         09GI244OLN30vMVOLDacbCP/zEf0oUhzZDKcOilsSiNTkmz3WjulIPEjNqr5K8qwXbCz
         T98w==
X-Forwarded-Encrypted: i=1; AJvYcCW2ua94LUjDhh17ydhWRO9YnnhTjES2gEuLslGfSBT5YtUsqtmfZUuwCgGByRttlE7QQJUlsFDPkZDMdXXo@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0YnZevYmEFAXwy9TsKmtggdMbGJqfuU7OhTo6kEjMMfqaXLu
	lzkE77ojxKIWf78F2wk7LEoz4syxYmfmIWOT/5i0nUzzTlX8V3RMbyJud5Ndvt6b7Jk=
X-Gm-Gg: ASbGncvm38gY89aScAKAOO8TlRGezolvhLAeFYI5zbDFwSA/C6fY+vn+TkE/LUE9lt/
	4Im0Bo8ycuwtHSN3bFDbsFlIElgN7/Hu+N6NK+QZUCF34hL2rGs9VzmGlZOT32GDiF6eLXnWQdR
	DweOqx0WKOQl6KVuc7/p5lLhJqDwg+0PZ1SHKqJ9ipBfMVWWNly68oiotmCdFHqnXQjviuSCbwO
	YhPp5PwmXagsltfvL6D4Wzs/Yb/wl3qtOZge+wIJSp6/wqakYb3vm+/TO4UxWgr1EW28RlxlV5Q
	RectLmTh8956TSVoI03K8gonuQdsn9Aq7I6i/31LOWifhZ8RoQdneGFRsz1tPf7qg76eoEim29R
	lxe6G
X-Google-Smtp-Source: AGHT+IG5V668k4zHZQ9Ar5v+iU5OrTVkUjQGJLKFP3HR2xaAkouPIssZkVherQ5fLsbkebJ2+9n2MA==
X-Received: by 2002:a05:6870:164f:b0:2e3:ce6a:f18a with SMTP id 586e51a60fabf-2ea0153c5camr2635547fac.33.1749236693650;
        Fri, 06 Jun 2025 12:04:53 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:fe8a:b218:375c:b2ed])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60f3e83111fsm323711eaf.34.2025.06.06.12.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:04:52 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: add checking of wait_for_completion_killable() return value
Date: Fri,  6 Jun 2025 12:04:32 -0700
Message-ID: <20250606190432.438187-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected the calling of
wait_for_completion_killable() without checking the return
value in ceph_lock_wait_for_completion() [1]. The CID 1636232
defect contains explanation: "If the function returns an error
value, the error value may be mistaken for a normal value.
In ceph_lock_wait_for_completion(): Value returned from
a function is not checked for errors before being used. (CWE-252)".

The patch adds the checking of wait_for_completion_killable()
return value and return the error code from
ceph_lock_wait_for_completion().

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1636232

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/locks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ebf4ac0055dd..dd764f9c64b9 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -221,7 +221,10 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (err && err != -ERESTARTSYS)
 		return err;
 
-	wait_for_completion_killable(&req->r_safe_completion);
+	err = wait_for_completion_killable(&req->r_safe_completion);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.49.0


