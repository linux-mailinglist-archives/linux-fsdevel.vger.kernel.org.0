Return-Path: <linux-fsdevel+bounces-25677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E9794ED84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C457F1C21D9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753C17DE06;
	Mon, 12 Aug 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ec759tHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5E17CA1A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467471; cv=none; b=S6ntCeig8iezWotufUEFlFEjtdo5GBvAFlRHRlkSO0eb0DkV2z1JW0Mt1A65IM5pARVTBKyRvDwK6wrUq4uH1hM/dnkotP8yzEok6yYgFdkUVNbdw6pJCOpGvReSNhlMkWsw1Fo7CAEU22/86r8BsGv1SygcNIK/hWh2OJtdEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467471; c=relaxed/simple;
	bh=uGO5dEJrzAGpkDGXLrC8ztAywM3dRMCy6F4elADygWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrGEx2+QZjhNrhXtiOm8SUXa8sKA5Zux7MuuM0/ZslTKNZIuEOzJeXpsver4+DqLryrQDKhOaRJOwh9Rne46bPXEFdOa7Y06n41o8jSQI0wVMLXN0O1fKO6Sxav0oVvQHaXSoZ+JtPliJJvTDOplDED88r5GmjEUcrnCM6uKzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ec759tHm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso3380538a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467469; x=1724072269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58S4qbuyYKoKQjyHpzs28ekwRvFYt2yreo1eLG7u1fM=;
        b=Ec759tHmiiGhgXoUEENfBjcubXA0apvXqhwmY2HjIeK4pU4mXeTqHHRpIzpRCmZydv
         ZEUTnBcD/A6jnVUa2hdCfp0Wsxdetqt8g/7KVs4/H9bV1MeKqWEQFvbwtPI2P/HKRYLH
         B2I3+X/BFppZjTgk5y7WYuZWqm8ilH+/sg7w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467469; x=1724072269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58S4qbuyYKoKQjyHpzs28ekwRvFYt2yreo1eLG7u1fM=;
        b=dA12LDXbbgtTqbxylayCT4rXZ0AxExj1LfrEphj4k4e9yuCpP/ieGlhz9e86FBkRNj
         lkt3b6ibmOMgIh57oIkw35RZWZ7cCCnIgTHzJ0qxLwXdZpbE9ODM5nuppW+WwyZQKqyW
         H7mj6oNg4XVEXRj69aXwNAIjLoEzBfufr02xI869pODbijeC/w3H84PgaWWfccqj+wTS
         M92jAn0zxe2wLzkGZVYKSAq6uob0FVlgpYDTc2C92uLPvbe58A2cn4k3xYldEELrFcH1
         9o1UcTFiZh6kZ+5pDs2J//l7sQ+zhjLWKT6FyumxG0xcj4TKNt2MDtoBGn89sgsK/ALK
         407w==
X-Forwarded-Encrypted: i=1; AJvYcCUPbGc7W/2or0Sg6U1+26hiQCMlelS66VhE09yZz9fam/Uq/1tRNRdDTRNhhIuItHn/EKvY0ye2sESkY+TYmHH3TZyxP3H+huORBpGPOg==
X-Gm-Message-State: AOJu0Yw1c6dNhFi4hkwFwWmPk2mfjnxgfgwlkNSDyh887u/QtnhVez4w
	Vw8hjODJCsYWSJWDdLryDglacg+YcspnJ/dRS3mjQoFmtHr8daVPHqla/9QkGiI=
X-Google-Smtp-Source: AGHT+IGFlBi1X8/Y7i5u30ax6RMbfkRifnWc7b7YQe3Aid69JjvZ1u0IpdtiYAyCV6l+7Dbup8PUIQ==
X-Received: by 2002:a17:90a:53e1:b0:2cd:40ef:4764 with SMTP id 98e67ed59e1d1-2d392510ccamr117032a91.17.1723467469481;
        Mon, 12 Aug 2024 05:57:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Mon, 12 Aug 2024 12:57:07 +0000
Message-Id: <20240812125717.413108-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>
References: <20240812125717.413108-1-jdamato@fastly.com>
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
---
 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..cc47f72005ed 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!ep->busy_poll_usecs || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


