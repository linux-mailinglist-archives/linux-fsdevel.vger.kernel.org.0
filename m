Return-Path: <linux-fsdevel+bounces-25618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB494E4F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C871C213EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32113AA47;
	Mon, 12 Aug 2024 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkhJrdke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593381E;
	Mon, 12 Aug 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429860; cv=none; b=TrlfioQk2QXDi8ZFFf9uOl0sPahKnML1sspaFPnKAfmhnE/O4cDqj+ySDBZyyNLnxLZwSi9KSN6KKopo8xlFWb57to0i2Sl6lu0iqfXzH9lkk3PQb/Zz8efEBpd4B57gDk+99e4lRKmYwxBwg8slB10vGKga1IbygVS6IAgtkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429860; c=relaxed/simple;
	bh=56ESQtaoBbBqZU/saKgTljkr5U/isylgWUhSQpUUDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3wVDjbBpyQH81tAvDfKTCrydZkWhU1GxL4VUfdML/l1KCIVf1WprbK7/eIzV3Dz9e6h8kL9IphuMiUqQM1JRwnd1w0YPDiC+bU87lD2K/PMn/CJNnQMOlK3Ol7qv6bRiIcDIlfMxG/s192KvgpkpwlxAZ27X+ncs9MAJj57ybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkhJrdke; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc5549788eso35532125ad.1;
        Sun, 11 Aug 2024 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429858; x=1724034658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=lkhJrdke0FaFrel8b3Eq4wirXXx9WWd6Nsbc3heR8IjNIpnvn2d5DivG6L61VSAAKe
         fUT1rY1JSueyP5JhTYnkY0XHXK3XGmL35bLM38PWSqabiQ1LQh+uBBPaY4En/I9fadTz
         V5oC1KGvI5j25X5+YkXlFcF2MtTbFWgUdcSp9//BqlXJE/SjUH25CenLeahjQTWskpWQ
         +V2TayO18+JFg0iBdxj+3wWe4vdfR3Q9Udf2BkZawUxeCEXkuoVStsrTHN3TJJ9X5310
         e0lEw9DhX1C9Y0iI01JWFzUCVUCqARrl+Wnorv0PoKi73QzNtQivWV1yaum4H/daGhIP
         unsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429858; x=1724034658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=iD2CQKz5sqhpR0zSM40lXr8QaN7iSaHuVP8yqD2blZLyovWiwVXilA5d8pUoGkc81g
         Kf5+33K6l676RkUkz0jwRP7OpHCBhL80PvrDXUixAs3Z2MswdHs/wxJ+/M4x5jRUYZNX
         NA63bLZaemuVbwAf+hkDB3HBs5EuLB8pUONMkd9bVA9w5cOt95Tu0UJCo0c73dxJASs2
         hbLxlLmS8tn+YctMHAc8e3/UhTv9I2YD8kPBIlJ8185nehYT585pNFX4qRQsLV1uKtQ8
         leyQtMYQdrarhlnhB0Bpgh2SEq8/CI4b7s0v8LchogFBbIHeG7jPo+2KTqJ4wDgiXTKW
         DoIA==
X-Forwarded-Encrypted: i=1; AJvYcCVqqnQ+Hmel69ZHmB85LqUzhKyuaujXK6iSYJFZY9yL4xHvYO8YIOAOk4Y8OiUTeI3kuq/EkYUBCQkcKj8005GtBofInegZjSiyFWVl96CEJMdskuAwCypeXAmI5u6A3wkQbvtiYDYMdDReDzlTkxDg2ImAi+JCfdmoF8HADcD6B01Lw0lES4NBkWST/9IYppwuejux1mRuILKuY/aOd6EKNj83p5eFpy7YpyX1lQ81UhGmXiqGyAl94e6QW8Imtk0LDPe7RX0LcstyDD1rLNC3FKXJjzxwqammlyD54bxZMEn4N7ZEaNBxhcfjPPELuMjF4S1vBw==
X-Gm-Message-State: AOJu0YzxQ7vO2hY7ZRIunl4WLNK7CPIqhVAB1bOaTzWjcsvAmPHptD3C
	qw3EAuQ/v9+1w9EIgXtZeFLaLL1bwWIpx2aKvjH7ueA/2rPZkq5S
X-Google-Smtp-Source: AGHT+IEa9lv8MoV6zk/9zF8wCzjKsRZm15PR0yRidIjcflgd8FgwO2+8+6fP26BlJQqb1WyA3rzQJQ==
X-Received: by 2002:a17:902:f54b:b0:1fd:d7cd:ee53 with SMTP id d9443c01a7336-200ae540e2fmr93875475ad.28.1723429858561;
        Sun, 11 Aug 2024 19:30:58 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.30.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:30:58 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v6 4/9] bpftool: Ensure task comm is always NUL-terminated
Date: Mon, 12 Aug 2024 10:29:28 +0800
Message-Id: <20240812022933.69850-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's explicitly ensure the destination string is NUL-terminated. This way,
it won't be affected by changes to the source string.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/pids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 9b898571b49e..23f488cf1740 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		ref->comm[sizeof(ref->comm) - 1] = '\0';
 		refs->ref_cnt++;
 
 		return;
@@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
-- 
2.43.5


