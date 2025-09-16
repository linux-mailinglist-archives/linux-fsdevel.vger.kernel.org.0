Return-Path: <linux-fsdevel+bounces-61692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C5B58DA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229E23B72EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F32F0C5D;
	Tue, 16 Sep 2025 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPVEEEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605972EFD98
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998184; cv=none; b=WigvsTxFYXF8nGMm8ueQUYPLSSQP3K/OCniQMx8Rn39d10h+vNjNFinIkNEHhKeZ4qrk6YinQTrgjno65T4B5G9YUmUTaTQgwGpfTsDfF77KKUZbjCy8SHQQ7d1bYSLGwBwDNlyyOjEV6dp6jznxtlFQqCTftI5d6BkWbjMq7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998184; c=relaxed/simple;
	bh=xZie7XPvdT38eYIBnvXACDOKlp4uDfFQ6p8xkwCAypA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6IXJI+zcwfkxQ/DmQKLR86ane/E37waNJtz8+/nnPhI7cnOm/djfvhFNlPlb9FiIjD2CZVRDXoHe3BfL+wSCB9+SQPVpOhifzTFeS6V+LXcL78BRhqwmiJGdodE6PbuiGNCKhb/0yO/vqS//rOYa5JeP77ucE6JM1VdD/nn6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPVEEEM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26799bf6a2eso13907455ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998181; x=1758602981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=VRPVEEEMyPFp1/apdgsdGcdVZa8RyIEDb4oi+MRkYBM99QFUqx8qesncXE5xPiXr4k
         5EmQzzVM6ROAy9MD5JQWOsyeqzNpcJOOfhDFpvyiLSBzgAVmSV4PpvkG7J3oLLXh3T2t
         aSGMxXUkZ/sTwLMVvwCxtrd/98Mzai0cB56bcT2QDXO9wehrl8U9zH9CWY9ycecU5qrW
         lgZghkMXBNPhiPB0dDJ7sUurWKQUnVaHBn61VqMU8sFvJRgf6DYXbUA1UPvggaPVkZ2/
         wEyAhf8NXX+w9nILAVNf9HZ/dItwjE6ImKe5EZYWjDrUvt9j68hAE0JwgxYdvG9auYLy
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998181; x=1758602981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=amlxZXaVd1UVC3AAuLqV/OKpqjl7Ilx97W15ryKvo8zBt/3QtvkrRmOHb506CRxs0L
         g1AdI7gJozWB4GBtJpjFiUPeQmu/B5VAvBXwTYiFNsbDcTNXVQ0YS5AzeoZth1y4gV6f
         dTB5AR076CyvuxPOtel/X/V6Won5y540X8XpdUWN4hin81z8bBy0Q0nVl8NW/ALtctgh
         CcOcPzemfFUavO1uhW3gbclZNVsnrENelEdlbhWGPd5W5XAvVmrYK3EkSeQY5U54+653
         bSBTEYHDXDlWx4jARu4GsTpGNkviyuCPWB9bhmMOCvwwbw1VsB2LwueDao4DWadx2u1e
         yWbA==
X-Forwarded-Encrypted: i=1; AJvYcCWQU82Dj1W9G0dDIRHI137LZYLcB9/zLSmEg0IO6H9ul5R6Od1AOBA6ror8WVZhZx0sn/HEUmLf5oJKjNr3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//2p2x06h3YTc9JrIdH57dYdWXpMrJOQ9y7bWWGFLtEILD0oJ
	bjQQyfAeIRmt41H5FyXULhDBNtAkqb43gGaOjx4N+Ik7srowhdcR/Y3W
X-Gm-Gg: ASbGncvNUyxqzN9ND3QyzVxIml6uDn0fU3Jn9j2v2RJue5qucf1XPvWacIHS+92U8uu
	fgaJsXu9BUYJO3RpQK0l1Li5jPwh4cAjmcRnRcZSu3YA+nYIQWCj0zcqFVogLC661bb74ZW/0IK
	bbp/d16NdRLLhMO1BM972qXYr0jrjTnkHBvnulhSH4+ogEX/RpDnObfhycLDTyEvUe+T1LUNrjw
	CxGuU6Im0k+SRaBOm8ZnY7nYJPqAq7qFvX23Cd7zQKCvfl+iMHyV28MEypiLeMiayaSlHUCjDNe
	99ybZfryOhKkehUx6GnnSQg/v7k6zpACI5ac1HX9LcV7m+JMeRehko4RFFmG1oR4/Tba5u2GlAM
	rp5ZvuUxhlaPdSS/m4Ka1L0rtqgd/yozwd5kGd9I=
X-Google-Smtp-Source: AGHT+IEk/DXYOCMhugqpymqTGh+KMlTQeAIuikssxOXlHLYZS5SBPJrXDrKkOxyomJ+DECodEM8EoQ==
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id d9443c01a7336-25d24cac4eemr191581215ad.6.1757998180587;
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 13/14] net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:34 +0800
Message-Id: <20250916044735.2316171-14-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
-- 
2.34.1


