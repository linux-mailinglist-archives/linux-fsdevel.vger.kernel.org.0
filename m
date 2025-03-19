Return-Path: <linux-fsdevel+bounces-44391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A79A68149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE9342550F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145C1C4A2D;
	Wed, 19 Mar 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LdwLkSF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED71B4138
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343350; cv=none; b=bmimXXevLA+uE2PUzWhNuTTyESG3LVqGqtFaPGh8O55ZEQnAKYYwS7wU4/c19H6TFJ4lkxdLEvQrJLDZx0d9k1bHSvvWGopvo1W3Gs635D3Vm+ZtR+DK7wn5uMvXLBMH8stV9za9ZLVB6tMmHFuPQahygp71BQ9hyMEMlQ5DHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343350; c=relaxed/simple;
	bh=vqb5bSp3KtgrIHH2C10i+ZCVORS25O8aQdSoxaGrdX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+QhHAJMcaUN0aAjfEvATAN1HC+UNFS4di7zPbwOAIz0ESlTKt5ofm02RgUR/G8jzRmZdQbL/dhbx2bOmzsD6oI1lGGIlQYkNkFgTw9pzRnj0grIiFsoAVBmVpY6VkWfKdPMwnbQSV5kW+QT55YRGWSM7RfdL+CwnLQQeY5E6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LdwLkSF8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22548a28d0cso18570615ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343348; x=1742948148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XqGZqCGsxMqM6QeHlFNqgLyn7L0jWSrp5tLsnvgx2I=;
        b=LdwLkSF8TBzC36dt6CntOhHl+LeUMOlyXozok9/QMwsLzJCbZQtUiV5ZsMTPkYtqcJ
         4vcWfNjrYyGyxoOe5/0cRUNiClXg+CCpU+5N+tyoxTI6DfO2pupR5WhY5mA3NEiF58ul
         8MrOhgdbfV7a7Eii7fwAIIFWtUdit226D4msI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343348; x=1742948148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XqGZqCGsxMqM6QeHlFNqgLyn7L0jWSrp5tLsnvgx2I=;
        b=ShZxSo47azRtKPDDreiW1C3MQLWIwboeMwyOBhLQIbOP2ahEOnq0TK+Lu8IkLTtsCi
         8RAiK0jr3deg8x2oYZn5hpbZhlRNQcFtf+2m8Q0L3uQpe+dg+3rDq6/la1nOs13Nt+SE
         IbKrkDwx6gUVZw6S+gZ5slikv/yq4GO6bSki9JcdXaNyIfQAXS52n3Esdtz/65cVHvMM
         cJE62u40c3DTmIkrCebNo+KKrlW3IfFW0M0VHlYpPjBTzT+Uj1QOnJe+TFNKf16Viz9w
         gKXlrKwnuAnrQjIGOnuXKGae9NkxYZ6+acoWSaamnff/GYwqtlAFn1+js3XNZjV4gSQu
         KvnA==
X-Forwarded-Encrypted: i=1; AJvYcCVbVcLqeX+rWWCE0myJ7ZMDPJ4zNJAIHPV6L0wCIqjxtuLkIbXnySRvXr+3B2jG+a+FYOwaMgNLhgrphviR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgtli8kDiNlHFS86c6kRa83tjbAsdPoIdfahWZqi/sZ/KR4z+z
	43bU4IDb5Z1jtzR1v/kuwGOPiEVCjB06z7E6/U5QGXYg2RC1oCa3OydNn6ZG2FY=
X-Gm-Gg: ASbGncu5W+ZGUOPPS75GgtS99w/J3E1fO2UMzCHooHTN1cqCVnxvdq8KBjrwMyqUlM9
	RQAi3UKn+L6H4wOeeSipS7fB/E8X7Fhj60pFpiJqrRszZP5ArY1vn+H+VZ1sQU5xO8ZI1Fx3Ze9
	IgAGarAVS/jXbewTW5paYayTuPaITBkmHhUPEghH/i3EAdqL7OaT0benTsgbn7qWuNMUgNpDnoo
	FDFMgzFK47PhAZ+hn+tN4goc4hwZdc0kl3UKfavH5kwfs6VOl5AW9LlL/WVHgWucfm0wMl4cQPF
	JY0AUnlyGwgpwlCbgxqh7JeaaIr3wmjEoqmCbHya2wYvbROqqcG8
X-Google-Smtp-Source: AGHT+IEmJYpbp+6vVhqsiGvsZq35cbhyVslRXzs04bm/SNmdXK2RzQx72NbvXgQ96Ga+Vw4Kk+NJMQ==
X-Received: by 2002:a17:903:22cd:b0:223:58ea:6fdf with SMTP id d9443c01a7336-22649a3c6a7mr8745335ad.28.1742343348190;
        Tue, 18 Mar 2025 17:15:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:47 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 07/10] fs: Add sendfile2 which accepts a flags argument
Date: Wed, 19 Mar 2025 00:15:18 +0000
Message-ID: <20250319001521.53249-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sendfile2 which is similar to sendfile64, but takes a flags
argument.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 03d2a93c3d1b..057e5f37645d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1424,6 +1424,23 @@ SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, si
 	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
+SYSCALL_DEFINE5(sendfile2, int, out_fd, int, in_fd, loff_t __user *, offset, size_t, count, int, flags)
+{
+	loff_t pos;
+	ssize_t ret;
+
+	if (offset) {
+		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
+			return -EFAULT;
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, flags);
+		if (unlikely(put_user(pos, offset)))
+			return -EFAULT;
+		return ret;
+	}
+
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, flags);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd,
 		compat_off_t __user *, offset, compat_size_t, count)
-- 
2.43.0


