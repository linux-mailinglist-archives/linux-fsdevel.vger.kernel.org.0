Return-Path: <linux-fsdevel+bounces-21592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57B9061FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E4C1F22714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AAC12BEA4;
	Thu, 13 Jun 2024 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqmpQnVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C3B664;
	Thu, 13 Jun 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245937; cv=none; b=ig7QDpqrXVTkMU/sSvdWjaEGoKyfdI3ezb7dSF3CcQyuuQPkKUysVaAG7j7vhxQN/N9sIj+q3L3E9p/OrlFvmRDCyoQ8nF5eIjjDGwDSPe9AH4xV4viDzWFb9nTjmYdp9IHlDKtHkbdhUhMkjMNvFEuOA7spjVu29cTLnMl04hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245937; c=relaxed/simple;
	bh=TWuud7jK3hME1+ZYOV8l3v30JtoJYeBhxXk+ueWY4nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YxCKyxOXv0IPzsuRwCggf5ijDMbOYWkvj1xlqpO1hbSJwsapQh/ITNapRpwaWldmNU6pwTDIsANAlZvzICpAlMfdlaZ8aw5d+hogodHHCP8nN2jydyWWd5xwaJFPnOk2f7piBWUTHNX6dIRedSn94g04fq1ZH90h0RX1pdlUi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqmpQnVi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so4496965ad.1;
        Wed, 12 Jun 2024 19:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245935; x=1718850735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLV4tdtvKwjUMxvLd3MjEerWvvi0S3KYqORy/5kgs/I=;
        b=MqmpQnViA3btrY3puGSfBvCJAvfJ2Iovn1Lr6IKTCp6IXBy79oeV+Bk+FzP8aRFBMp
         PWCuicLk1rSu7ynri8m5yc7Nqd9tADBwlQZE0tjrvW+9VQCVf9Ohlvdh/SKuvEIMqKhP
         3uYXjNjDj948wvqhiK+/SzQ8lqqF3dfwgm/sHK26L9Wq/+aIkXngclViccGODdbLxjv5
         58wvsH83+EnQEeZr4G/dlscYQUkYwfES4cXoHw2F0K6CkMqvqRD28Sgov+S1jTVtfNlW
         qAsWVzYKXXfljjS9gGPUrkrmXZYdpdzjWCWQZ31Z6gbeYt0ivCZY0xkkBzNL9ShcvVKn
         L+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245936; x=1718850736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLV4tdtvKwjUMxvLd3MjEerWvvi0S3KYqORy/5kgs/I=;
        b=RnJyO2kzov8WlDi9w1bz7BR6Qbnwh/vzC4P8yof5gfFaPawsLwrcqz5+57sP2hTaqI
         pkG86uYSuaxu+svU4I8CZjULMTLMuDS7LVpj/PHip1YrvckLNgYJfhIn9USYM4RbxGmX
         PQ/jCFiwntfOP748hQBnD2+4eQCCsZ0ZcjAXzQ0yRI5FM/cifzAYiYZSiXV3V4FdQnN/
         DmFJSyRVkWxm5wqwWu0Ha2pmOF3qZ02cEIFMFv9QhkiDt9Pk8eD5CwRUG3cWWaS9x28v
         ZFxfE+KDcXj4Xd0Jg1gWYHSRlLUqSTxgopsipoxaD7DTq0iXWh5TmO1+P3phha1gFufy
         BxGw==
X-Forwarded-Encrypted: i=1; AJvYcCX5381DHe0PNMv4Lbe4TOrgKRvfmvZl1zfC2CFqg1Cir5EinnFSYpdBBpqfqxHrN9pUjFKZ8PB/sMt1BZYgfGjwDZoeOFKZ0Dq+KfOA5es0fLGZOvpRJlS2+XqOl+mQ4CFj6oTMc8IQ+7GOlG0EGzBGuUJkxbj0RYI/akua6ZU0M0LvwHzfyqd2QcFIxAv6znunhd1sFA88Yv6qFBmfMEqcbN0Izsf8MV+pXYvBIcEiPwLpUOaLh6iVf9Y7fTZ0guoynhqKDDU8eJN4vtsfDKpPe32u3IH+eIqprkoqbMc6LdNgzX7cnwvk9JrvUzM5ep/8ioaT8A==
X-Gm-Message-State: AOJu0YwmR7JVtZoSYKz3L5S36ZLov9iB+hoLlmppkE8LI+rUxNpxFJcZ
	n/Zho51YyKHs26cCDK7fZz0rzE66C0n1qNnHjOgaGMGGrYbmt8C0
X-Google-Smtp-Source: AGHT+IHU8nljO/XpjX7VaEB7PAOC5fyOplOexRJH9EcW/3foBQqPSTf9j2DyRFgOTFj3wqtthRwoDg==
X-Received: by 2002:a17:902:d4cb:b0:1f7:3763:5ffb with SMTP id d9443c01a7336-1f83b74d134mr37873815ad.59.1718245935611;
        Wed, 12 Jun 2024 19:32:15 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:32:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
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
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 09/10] net: Replace strcpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:43 +0800
Message-Id: <20240613023044.45873-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent errors from occurring when the src string is longer than the dst
string in strcpy(), we should use __get_task_comm() instead. This approach
also facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/ndisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d914b23256ce..37fa3b69df45 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1942,7 +1942,7 @@ static void ndisc_warn_deprecated_sysctl(struct ctl_table *ctl,
 	static char warncomm[TASK_COMM_LEN];
 	static int warned;
 	if (strcmp(warncomm, current->comm) && warned < 5) {
-		strcpy(warncomm, current->comm);
+		__get_task_comm(warncomm, TASK_COMM_LEN, current);
 		pr_warn("process `%s' is using deprecated sysctl (%s) net.ipv6.neigh.%s.%s - use net.ipv6.neigh.%s.%s_ms instead\n",
 			warncomm, func,
 			dev_name, ctl->procname,
-- 
2.39.1


