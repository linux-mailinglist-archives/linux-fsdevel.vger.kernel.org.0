Return-Path: <linux-fsdevel+bounces-33991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84759C1437
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 03:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607891F21D9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0DE19259A;
	Fri,  8 Nov 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OOida9Vn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE0183CA5
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033582; cv=none; b=K/qMSrN3J88Q68dANPZbkM5BOGRZ8u+fycg2E7Zd9MYd6XMMzErgILhfc3ImjR6TSfb7UN9xaUe137LMyPC7Yieh9KH3gRD+8mNJtPqkocVT5HgoodXWrc1nCHKdoZPpzGHzyLtXl2GwZlhvDFcM4dEpo9GJo0sVFx2Vt89i3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033582; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5baq56hvWaoA4MfoJtgKl9aGVfUoc7BA7bwQ6N2gCaThyso1mdYUusm3xRGGh87NAytrMKx2/teqstMDX70s23HxBYqQCpn++Nuoe894ehmZKtn8phXe1ScMh77WU6YC6Htk5LGRBWJEsObuqgGtK0ZzKU/Q6VZLpiPTPZRQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OOida9Vn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1265384b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 18:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731033580; x=1731638380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=OOida9VnztwHPkKj8/SaJe5KkFDqgOkWpIWLsWmKa+vKaLQkLTacCqWLeEbUM/doxa
         XXko/Kj9etoerBzHDEZK24GkDTaOh0RFkkij+359kwNjJBMSY3mRkTl9yhRe8R6+MHLf
         NBGbWyYnhiJJGEvDMTMGWw0o0WpCDg8Zp13vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033580; x=1731638380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=CKTRB5qV33IU3CbhR6bFUlwOA3+8dL4tDiYgBDfaJOyTyCvMdjxLytPRPtMzesxhjB
         vscIWEnsVBQpUEY1WGarCtb36VUke3bsQYgZPx0NMKPwfaU30p597K8nj9TXtLRJ7mZD
         8I0T+RBy8CcfKzPQTjnVpLLSmKY+hNXcmziJnRMNACX5I1iEFA0AceOrrypqhZhJCJjJ
         D0xdegd9ZXlefPb0XMnvTd5MPnBHl9aBCDcQvb9NW2Wt8AgZhabt/tRyV5gUsmP91UIX
         +BpKkOPmWr7iik4TqxmazXs1DhCSMXlLiAdGTc47vt0iNPdsmzkKSVkWyQh4EhMJY51r
         LrKg==
X-Forwarded-Encrypted: i=1; AJvYcCUWK6KOuPUzLLvLv1u+bhl1e9IIG86IiLSzmNx2D6AcFcH0qkl+RrdB1MkAJUQe5JuEULccxDipyDe5iaZW@vger.kernel.org
X-Gm-Message-State: AOJu0YztVX7YseP2LQSz15sC/41kIBdyqi2G8kJJ+IUI2t3o+AKMJ0JD
	YltxgatSpLqIYxWWHqV+eoomjHfbA3p4UPdnR7HpUQUn34rhu8XLinsNRmvr/mY=
X-Google-Smtp-Source: AGHT+IEMedPf8Gd4cnsji0k8y5FqSjEthT/NDHaffj0vgohWQEnnWYSflFAy7c/ZagbJxzaXfOP9PQ==
X-Received: by 2002:a05:6a00:2ea4:b0:71e:5950:97d2 with SMTP id d2e1a72fcca58-72413348feamr1807866b3a.17.1731033579715;
        Thu, 07 Nov 2024 18:39:39 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a403fsm2561208b3a.105.2024.11.07.18.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:39:39 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v7 3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  8 Nov 2024 02:38:59 +0000
Message-Id: <20241108023912.98416-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108023912.98416-1-jdamato@fastly.com>
References: <20241108023912.98416-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


