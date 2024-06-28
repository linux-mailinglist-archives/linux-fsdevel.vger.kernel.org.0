Return-Path: <linux-fsdevel+bounces-22753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D99E91BAFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF2D284C6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D041514F8;
	Fri, 28 Jun 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS3gq1YA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1E14F11E;
	Fri, 28 Jun 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565576; cv=none; b=IPztj0NXuhZDegbrVFQzVy8nFotjSTi3JP3bNoDbVZY4Kh/wc82vc9/WvAnMl1g4Qh1DDJ1sXdO6+cInKSYmmZapuFBRLP75xaOwtfP1i7KBwN/8/oGxrVPr4pPT+atVKKIbCG8RExL8UpnAxn8bujVVd0YazH5nGlgS1NNTT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565576; c=relaxed/simple;
	bh=TGYLyUCIjyALT4hs8afmO6j0YAO8SFsfcw/1VlLlPhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIx25xf/lJDz36GxmB4Fql+7rOwPRX2XdSh+miiY1VIxPNUJLHJYq85gdQx8/TnPVPWiFmqtmy3gNmWVHurmR+FSyJlOkjMdq0zmMPDqQDeD+BQU4E970DD4nzxIB4A4XPVDY8qN36CTNgOD6JW00eZ/6ax0LisVBVMEDArOotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS3gq1YA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9cd92b146so1820125ad.3;
        Fri, 28 Jun 2024 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565574; x=1720170374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN2V+duoRLP5mjQclolxXRJl1PN7YZIwA2PLtFFVKQo=;
        b=hS3gq1YAOcjThymW8mmS00o9oPQwacKMt3QVqkjVtPH7WF5LReVafW93AG57JDD05e
         5ADo6t7II4CUL6jVKKpNab2nT8CRGk0KY226rialVEt0N6uGjZ371onancryoz3qUy4M
         xzzw9GMNzdgZM1b6JbnBRyK85nDNknAZHqVfqaN8ebTF0LdBSsNXACoJNiEZA0CceYRS
         JkRZIJ40xvl9d9x4z/VyU/Ur/rzcu+NmgG6hxoa1N+q6aSl+AHwLNoFwa4J/5O5P3l+X
         K3Uzxip85ybasGhrC3uAk4Ra7Fo++GhAfB7aT3WCt1iJfZYUkDN6pzmQae8YQzNb2mG0
         aUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565574; x=1720170374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN2V+duoRLP5mjQclolxXRJl1PN7YZIwA2PLtFFVKQo=;
        b=kmzoJFMIi9FLvWFJCCBxtXOg3kRTnOimM8YfUyX/Fe4vbt8gX420QgwszqMA6pXXZD
         haB/ZVH2COjA8TLO99COPuyUJOCUg2kx7CZhSnaCFzhEEP3LMHhgV1t/pltR/Ehym/53
         9QCsHsZl9mBwo6oRwK8MbbcsW2x1rSGeVWn9BNpeJq0AIMybGhhy0C3wSt4Ei40HFx1y
         dJmbPKI7JmCVMfL6jik2W3szkFF+g7/EO773xFS7oGqmgVU1R7sej8ENpbTfVVcxMvNo
         fUTY6Uq5lJZ4J2zmzgeG+tQESioVdKVFh2E6/Kzmou7g34p2GkI0aofyeEX8rrhu0Zbv
         nzQw==
X-Forwarded-Encrypted: i=1; AJvYcCWCq86wSQ5PY+iytlUmFV0X2AxfNWjRX3bN4SKNCoVn7hDN/V6KFrFs7oOvlM8nktUkWxCqlQc5iMoynFjdhvS9rtKM6dwjmI89vHTnB8XOM3vBbn9vtthHdORAuFpA2At4ZvwDRKwJ54qK23kL3XvG0LM7r5Tg5O0y/PjUfCylNlbZL0CTOtEfNDCzCyS0BMj4gaHSU4uyvWDr7Nu8w7vNmJ8REI1huZrYLFgKtSEJgLo4tMJGt3ND8addwCUOg7QUgWTNVNQhXSQ5D/FkhDvVZPz0xT0bNjTmjff3eOhH00dm8jcyc4550DxpNO70Vjwl59pdtg==
X-Gm-Message-State: AOJu0Yy1+L/SBXEOC5l7M2sjmKcIBfkPzgrDIK/bfN0xyppaq4vnmCs1
	uZvPDYN1hLbBuut6Nn3wSt5zoymbEv+67e0qcEKRbL7PK+PA2Eg+
X-Google-Smtp-Source: AGHT+IH8hbTH/mkdkSjyBT5baT0IFO1FQw7wMYLskc8y3Zcc6iSLCmGElb9qtOP7mNAm10MFemyYoQ==
X-Received: by 2002:a17:902:d50b:b0:1f9:e7b4:5def with SMTP id d9443c01a7336-1fa1d3e0157mr181052415ad.3.1719565573956;
        Fri, 28 Jun 2024 02:06:13 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.06.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:06:13 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 08/11] tsacct: Replace strncpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:14 +0800
Message-Id: <20240628090517.17994-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/tsacct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 4252f0645b9e..6b094d5d9135 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -76,7 +76,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_minflt = tsk->min_flt;
 	stats->ac_majflt = tsk->maj_flt;
 
-	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
+	__get_task_comm(stats->ac_comm, sizeof(stats->ac_comm), tsk);
 }
 
 
-- 
2.43.5


