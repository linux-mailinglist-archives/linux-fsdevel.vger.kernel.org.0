Return-Path: <linux-fsdevel+bounces-10363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDC84A84C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453B61F2B95E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECD13EFEF;
	Mon,  5 Feb 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Lp9+rMLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBD13E22A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167115; cv=none; b=GqqpRR93AQDB8KeK7dvc4qzH0RX5iG0BheB+3xTHNOWQVs3n2OV0SoeHUJnn0j2/SCQiudHsrDTg8MPPYhoX2OM0MPJbP1tNbqDYdVJBgcEQeqKIqgHcn3dhAhACVqOXfehccHjilcXH7KzcaE2DBQbc3nF2VhaEhNTba1QUiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167115; c=relaxed/simple;
	bh=heAQsVdQyZX1S3QWfoEAK9WpamlcuDvtpD/1aq7LXwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxSTa0tJC3FMVvJvtoIBbq3pEaWDIusKNkx1K2wCdt0BwHgvDKOs92Lcc5/1wXFV7YgDbOtVcQIhhmRlux8DnvIvZURpdOm0rTzKdfYBrqHTNi6ZR6GcQXDf1n1PEVFTgJxPfWpaZ3+1LLryJLDkUf1vJ55V8lNa7kgyb2nRH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Lp9+rMLu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0518c83c6so492062b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707167113; x=1707771913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOYgxaVhBBqkYTQLahlIJIPu6cEXeF8iHyq//4nC0Dw=;
        b=Lp9+rMLu+2bmP1Trs+oEouQO4pUbXiU4wDoVDJVjsMrrVe0igbsYsgU25t0NTNkLl5
         E4aXA+HvovmeQ/62QJYvtrRsjanY1kEAPTWzHnHeeZZ+VCqzRZ+iqf9FEqI862zDLLS0
         FwGGrzFKGIgdo21lpWE8VviJIShiJMpLnT7Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167113; x=1707771913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOYgxaVhBBqkYTQLahlIJIPu6cEXeF8iHyq//4nC0Dw=;
        b=cuwqsdHuqAdu8ZnLtK0XP3Kh0tz80ISTASnUyxlH1q2gDf/ukIB0ize8YSMXKZsJi6
         eZ70Xv3Jz5MS/mKoVtL3z4b/HaxwmdMCcgbYvhJ82jptxo/Iqq8IWDQmWaGAO17fkZD1
         fLWJdOGnUYJtJ5zhe4NZQROXpRKkvrkj5lk1dV4hmDlqLefA8Q5ECF4QKiZFw23Izewj
         HmZHsmiCkuZHp0XrSMrESRo7HFl+/xVHeTrBzi5JLpJSEE1bzkDST323RGT52zHUoDGt
         LZ8eC7FRymDLK1nbt04nJNbdLAjkEjA/5Ii7SuQyDX5Rc5nAlL7Ik6HXVt1PpNzSo2ak
         jeJw==
X-Gm-Message-State: AOJu0YxwU/E6wh5R6ohafIi67oX76NFAFo7KXwLnKFhmWijvy2s2XsYw
	CjUBxNnuyfSqS2il1dYZISk/oKnrG9Q2Bj/057zJ+Covu12VeTMT5o+X3kVcFP0=
X-Google-Smtp-Source: AGHT+IEN2JzkXMgtMH2YLc2zdh+mocqw5HKQ0uqEVrGv5/eTixeVNSp66nv60dTNZ0o0bRFI9geckQ==
X-Received: by 2002:a05:6a00:1882:b0:6e0:4797:801e with SMTP id x2-20020a056a00188200b006e04797801emr951487pfh.12.1707167112887;
        Mon, 05 Feb 2024 13:05:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXgARtOfY85fQ804fqgf9R3N0xD8xUK5NSW8I+9Y6M/3k+8ChC8R5MV2ubEiCHQXgUGHWFilMag26kloIdmvbD9DNBx86K/gl8d1bft6Nb583fIfQjKVW9R0y8f4J5+KhKgbtAUPhyZIRX/1T4HLEMMMKztQDj+Jd+ZiB84H3wbBaEgPrATM+47H8g0lag3VMroI0ZMIPKwrBkHMoh0qSU50c6/HfV8jfHaSK17tAcl0j6cPGL0t88IJlsr3+pjIv7qqdgPZ8IYpJrsu4POxQOsjEQOXt3GhgI5ovaLB2mK6DcEgkasP2zUj9CzTc6HsYuSnAvJ79QPDLOEt0u0JGm8YykxWinu8pHBBOqQ1k6Je+GQ4gLzc4yDwbmQX+14bUDRL16T/G+FIrsNw2Bv9JagyHbgTIrCRUvRG0NFHDzPZXPql61g2rQq8qVEdn/2HDRcO8y/2h9JFeseS0wbxPd6iHdco0jfe23hulnmdJcZEtw9aflDMfiNG00RXeaBvH/L/2E2nbzVn+s11S5vLOeE64mMY52ggp9vnPCWds0Kv425amQm3PMKwrbDVL1phxyhcOL6bv031sS04NBVrP3UME1/r4kL4XyZnQiK2+xjmhIvFdia4NwzMLjLcSfpboCdFCoYM4ChPQTdguCyaS+TItcwazJryiKCasKM8QLTBqnMutci0DaFPOlb0WkFfYVbdzs5dF2cIyA4ZEKAmfOFfrFGkTopmSxENnHPZxB3VX7aQ7FzFtY8/mBFipAq1mbVmc1CuHIR0xBBz88Dn8lDDh1D22FmkyGsE8U6ncOXbedp5aqBjkP0Ub9Ah+Q2jttXZ0l4F2G2UcRg8oeT5Z1DCkswlfqwWGpCK/e+YqzG1PCOEyVwtBTwCOZ5SkZ4TYiyMwtDNk7wKmQNNnO6We43Lf8Tujv/1xlYtjhQ05KMHdCty+C7O0cVdeXV5RaG2rAMK
 0KMRCGzZ0YnIga05VUKAmY/H8enp6rxbu6VurdaXqikHPhoSOfDzWKQH2qdc8xi1WAiw==
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b006e03efbcb3esm315750pfq.73.2024.02.05.13.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:05:12 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	weiwan@google.com,
	David.Laight@ACULAB.COM,
	arnd@arndb.de,
	sdf@google.com,
	amritha.nambiar@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for epoll_params
Date: Mon,  5 Feb 2024 21:04:49 +0000
Message-Id: <20240205210453.11301-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210453.11301-1-jdamato@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ioctl for getting and setting epoll_params. User programs can use
this ioctl to get and set the busy poll usec time, packet budget, and
prefer busy poll params for a specific epoll context.

Parameters are limited:
  - busy_poll_usecs is limited to <= u32_max
  - busy_poll_budget is limited to <= NAPI_POLL_WEIGHT by unprivileged
    users (!capable(CAP_NET_ADMIN))
  - prefer_busy_poll must be 0 or 1
  - __pad must be 0

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 73 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 13 ++++
 3 files changed, 87 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..b33918232f78 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
 0x89  0B-DF  linux/sockios.h
 0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
 0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
+0x8A  00-1F  linux/eventpoll.h
 0x8B  all    linux/wireless.h
 0x8C  00-3F                                                          WiNRADiO driver
                                                                      <http://www.winradio.com.au/>
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a69ee11682b9..8eb4ea2557af 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/capability.h>
 #include <net/busy_poll.h>
 
 /*
@@ -497,6 +498,50 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	ep->napi_id = napi_id;
 }
 
+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct eventpoll *ep;
+	struct epoll_params epoll_params;
+	void __user *uarg = (void __user *) arg;
+
+	ep = file->private_data;
+
+	switch (cmd) {
+	case EPIOCSPARAMS:
+		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
+			return -EFAULT;
+
+		if (memchr_inv(epoll_params.__pad, 0, sizeof(epoll_params.__pad)))
+			return -EINVAL;
+
+		if (epoll_params.busy_poll_usecs > U32_MAX)
+			return -EINVAL;
+
+		if (epoll_params.prefer_busy_poll > 1)
+			return -EINVAL;
+
+		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
+		    !capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
+		ep->busy_poll_budget = epoll_params.busy_poll_budget;
+		ep->prefer_busy_poll = !!epoll_params.prefer_busy_poll;
+		return 0;
+	case EPIOCGPARAMS:
+		memset(&epoll_params, 0, sizeof(epoll_params));
+		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
+		epoll_params.busy_poll_budget = ep->busy_poll_budget;
+		epoll_params.prefer_busy_poll = ep->prefer_busy_poll;
+		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
+			return -EFAULT;
+		return 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -512,6 +557,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
 {
 	return false;
 }
+
+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -871,6 +922,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		ep_free(ep);
 }
 
+static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	if (!is_file_epoll(file))
+		return -EINVAL;
+
+	switch (cmd) {
+	case EPIOCSPARAMS:
+	case EPIOCGPARAMS:
+		ret = ep_eventpoll_bp_ioctl(file, cmd, arg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int ep_eventpoll_release(struct inode *inode, struct file *file)
 {
 	struct eventpoll *ep = file->private_data;
@@ -977,6 +1048,8 @@ static const struct file_operations eventpoll_fops = {
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= ep_eventpoll_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index cfbcc4cc49ac..36a002660955 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -85,4 +85,17 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+struct epoll_params {
+	__aligned_u64 busy_poll_usecs;
+	__u16 busy_poll_budget;
+	__u8 prefer_busy_poll;
+
+	/* pad the struct to a multiple of 64bits for alignment on all arches */
+	__u8 __pad[5];
+};
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.25.1


