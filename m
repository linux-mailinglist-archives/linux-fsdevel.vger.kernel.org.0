Return-Path: <linux-fsdevel+bounces-25288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAA394A659
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DC91C22516
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791D1E3CC7;
	Wed,  7 Aug 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dF3RJzUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83901E2865
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027958; cv=none; b=YkWwGC41TQ5y0zGq7GDu0IwR15f60S7qT+fgvKtrrLjoMrwxsvF3VWIEAdFKzDAQ/U+ZD2CBlG0hWd0MHrxvJTPMbvy62rwlTHlCpVQstsw+S8natMbNCMEz1rRfFgLoOKQqmOMoKU6bVcrCspuZHFdEpoMQm1LikaEsXKAnMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027958; c=relaxed/simple;
	bh=ELCNY+rxDsgDHW/+80Up8lrF6MCpVdjED27XLaBDzH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHS7xe44l1o+W35xaxe1E+xdZUgSgyn6vCqi2R48y8T4bjLjww0akNvul+O6HpMQK5cbc/QIyUWSNMkkl4wCUM/2XETWp552z9ONn2uSOEz+viVLiFpd5JziU5THnn2dzcnZPsgcrFoi4qQu8PngXAVj/yG0Lp0jewUcc3C7HMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dF3RJzUL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so1356307a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 03:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723027955; x=1723632755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwt3lSi6Z4A8hazmpA+Rnhfblb1do8j78yHI+U6dKhk=;
        b=dF3RJzULJS2Goew1JEFG/yvDfwLU4RVMn9cAvzUl+u1jHLa9MxOx/P/WEi8IJdLjDJ
         kLqKp+ZKRlc/AckV9Uk1rppEGJVNxVs5V8kpQjxVGiXTM4PgdQkfcnZBU9KwiVxAWNqK
         d4kEvMbnFVZ4bZMg2aLORAVeQwUDBuOAE6EnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027955; x=1723632755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rwt3lSi6Z4A8hazmpA+Rnhfblb1do8j78yHI+U6dKhk=;
        b=epQYhKOjswwwRughwQ0gQlhYo+l2OqCNm4ZRTHr+NW+QAT20a9X9LXYee1EomLJo1D
         2wPSC5XtQT0Tucqbk8ShfJrELcpqu1mL+E9POFvP1RYXuqYw2ggPomIiHDx3qNkgLPbB
         RHTFEcvgS0Ra02FCXKT8ZjBpAG8xWMbfIXtH3V8Y6dYpiYWE0Rpka2uB2LCn4A718SP9
         doHJ0aPiV5sHFEefVCtTujl/5j7EvDRikFujZX/o3ut08oLLZ7N8xsgvLgWuaHtrcZNg
         AhWm0CjUnBCN52y7MbUhGhuaMqwntKXvvRikEoOI/URq+ZhXpQE/dBQ6Xuay+gWysSAr
         r8ww==
X-Forwarded-Encrypted: i=1; AJvYcCULi1ZJ2XCIIT7rk5WJPA5PhcuXhsNZwFUULtr7IaUTeQYPTMhO+TM42/T6Lwr1VdWuT8xY41qFbqAzYzKX/uoqvPdpHMGyfEbe0l9scQ==
X-Gm-Message-State: AOJu0YwN6h2uIywyU1Km0jzlwCFdT+BjYnoeq5EtYml/3QnkvW611rJf
	xRzFae86uakvYXiRXpL+XMgBGMNBXJHsTKHC9bYNmMCPVkYnpySF5DD3KUgtcRc=
X-Google-Smtp-Source: AGHT+IHQHmxsKg8noU+VS7nStysBMV3Pv8KiIJj6AJXy8lsYF2lj11qRXOGJgJLKkMCqvSt9X0bocw==
X-Received: by 2002:a17:90b:1b0a:b0:2cb:e429:f525 with SMTP id 98e67ed59e1d1-2cff9524435mr21812519a91.33.1723027954846;
        Wed, 07 Aug 2024 03:52:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3a9cba6sm1241481a91.12.2024.08.07.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:52:34 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: sdf@google.com,
	edumazet@google.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH net-next] eventpoll: Don't re-zero eventpoll fields
Date: Wed,  7 Aug 2024 10:52:31 +0000
Message-Id: <20240807105231.179158-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant and unnecessary code.

ep_alloc uses kzalloc to create struct eventpoll, so there is no need to
set fields to defaults of 0. This was accidentally introduced in commit
85455c795c07 ("eventpoll: support busy poll per epoll instance") and
expanded on in follow-up commits.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 fs/eventpoll.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..6c0a1e9715ea 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2200,11 +2200,6 @@ static int do_epoll_create(int flags)
 		error = PTR_ERR(file);
 		goto out_free_fd;
 	}
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	ep->busy_poll_usecs = 0;
-	ep->busy_poll_budget = 0;
-	ep->prefer_busy_poll = false;
-#endif
 	ep->file = file;
 	fd_install(fd, file);
 	return fd;
-- 
2.25.1


