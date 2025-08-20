Return-Path: <linux-fsdevel+bounces-58384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C79B2DC72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 14:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EEF5E06F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462F33090C1;
	Wed, 20 Aug 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iatrAwy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD801305E37;
	Wed, 20 Aug 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692866; cv=none; b=ofpjMSD2HNyyfmfBTiLmgYPs9OiZY//cdZacyLWrYlkf9VWMogn0uyrafxomWJGbsC+NlvFqX75/LoqCPcVtgFFAW2HHmQN9TVGaE+ed94K3iax0mOHSfzCzqdzYnAas/fgrC6/aRXKwNO7q81loqb0bc7fY9GqMuBadfgRcOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692866; c=relaxed/simple;
	bh=fozkKZ+7TYpGVtVQqcJ9yue6BIaaRtrQLet9kli0FTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzoCTbCJhsE6d73cYzj7G1Vs4SGvBWecvr2GBpRj8ZhsNGmeXvSo/LQR8K9jRBu5z5xnKZGxslUB36Lzd239Ry4RWAzE8oj25UnmlAofWEYQN3TnPVRg6+RtXz8cergshgR/pyDhNMgUoJrbsdzIauzE/2lKEYIBzp1qgDDmWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iatrAwy7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4756244423so1250789a12.1;
        Wed, 20 Aug 2025 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692863; x=1756297663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dS/Qz4iPQ/6vsa3rpI9isTAuo5vfnUUc5hPRAtnu9g8=;
        b=iatrAwy71yX/gHN5GjXXmzyAFW9GG2RKv92UYTVaa064HGFyy9W3PQxkSu7BLzVQeP
         Qo2PsJld/hxVn7fqVUr60rJV1vCRDlfTu8qJhXMc3gV8RpMxDHuQI+LY3y3suSEZZ396
         6lSss2N2LbYyeguGmLLmoj+2HWfP1TE7gBvXqLkKxbcVADNZ+Hy/qGgD4sS+76ZC2Icn
         E2RE59FOviscuZkWHOLMD2H3hmgyF6ACJ6mOrHh70VPKtEuMZVlyRqPdgNsm4l2ITIL6
         tvmFEV1qNvPxanPN6Hx4dWtstTEcY+MiCgTjK/wRvw6kokhrCNJ6CblKeO+UTd+wuqbS
         hMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692863; x=1756297663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS/Qz4iPQ/6vsa3rpI9isTAuo5vfnUUc5hPRAtnu9g8=;
        b=Q7qlrZcfoSTQhTfOt0jcRK8VxheaPVwSQdagH3oC8po+xgVlVn35uzQvwFWqmbmPim
         fp0CH55cjwdtzZHV7dgddIp50znt9ugGFj9z+CuVxlHC9mEjevGGVkVi5NRfeGcWRb/6
         VQSNzkwiGh0DdVFIZ7F4iohWzPcT4+2bSGW3i2JOrAQt+kbNg8g5NA0PtuThSMa2uQSR
         4N4jTm203UVJeBTpy8yNjQBMKsLML2tGUsVNPWABUZFV+uZ9K417PtSIjlpWVTstfSBO
         gvhVZoB2uls/lUDFcTqOI0FrnTr66Hy42/1DCFRBEz9+OaRhuRiNSYEZJ+YQaJa35WrO
         csDg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Wrtvf0uNXwVkIBbkf946TYO38V6L7LH94iA1LETzm3bYR1+cltgndy4mpaX1jRJxzVOLXBmKg5ws2VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7h+vvf5dx7R7gX/DjhG0lZGdCNY+7ueX+pbYLEmTET2aJqV/
	usytjtgc7wkXAKmazoILikgknO8SRl0XKojcWAa7SAg84kX/l6ErhGxe
X-Gm-Gg: ASbGnctWoXhh0Wp3bH2VxbLfXhpn3KNOsveX+oOv052DR/aw6HoUPJA14yU8ZWk2ETw
	JQHFzUS2JOsZaCPRKWdZQeiV+cjjwISYVpFXrSkQ04e8yRepoPRHrWXnLIiQlP049xWIAYl/Iog
	o956Ax5rlq46Lv5CWyYqAtE8r8ZlPu81lkwzns0f1WYwrQIdSYoE97+EArVX5GrKeBgKG+WHb6C
	8myCYdo7xBosaZA8Zel4r3kDDVYZC+yDmhNdkfntuCSOHMLD8RfrontWRyRpvx7CeAZRWhkKud7
	crVTaIcN3TkC9rqun9gb80QD84iIMpkru+6vH/8M/EVptGkP5CbQYoBkxEQtFjy5cDDcoMCP+Kp
	Z113NHV4/pzN6ANZJifS47vxEuiv76dADJQ==
X-Google-Smtp-Source: AGHT+IFuCwF1+L+JyamxJlydbb7ZqbPnkIJic9UgO8fWBqUJFoxgkpvrESkqezbmIhEtaDPhbD7EfQ==
X-Received: by 2002:a17:902:f691:b0:23f:f68b:fa0b with SMTP id d9443c01a7336-245ef22dc84mr27967745ad.37.1755692862794;
        Wed, 20 Aug 2025 05:27:42 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed336002sm25949565ad.5.2025.08.20.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:27:42 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] Documentation: warning fix
Date: Wed, 20 Aug 2025 17:57:37 +0530
Message-ID: <20250820122737.13501-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix is to mitigate below warning while generating documentation

WARNING: ./include/linux/fs.h:3287 function parameter 'name' not described in 'name_contains_dotdot'
Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..1c87f9861ce2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,7 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
- *
+ * @name: file name to check
  * Search for ".." surrounded by either '/' or start/end of string.
  */
 static inline bool name_contains_dotdot(const char *name)
-- 
2.43.0


