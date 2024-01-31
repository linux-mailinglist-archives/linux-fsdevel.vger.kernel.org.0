Return-Path: <linux-fsdevel+bounces-9600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CC8432F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF721C252C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB75677;
	Wed, 31 Jan 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LBX4ZcEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD794C87
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665676; cv=none; b=Epa9f1PuRI04o4hIfNq4nFPj32MHUuQthvHE7ZMlJDilew/5RzWnfXnd6beIW+GmcP6hGYG5xTI4Ty2PaAc9EUnMFcX0CMWKrQJZS+5DLRHSvc13/G3t9V0eEYh9pmbEvjC6SqDnddQjWuPSrN3UhjT9jaNw/aRqRtWbRm5Y59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665676; c=relaxed/simple;
	bh=PCgM0jeKVsYznDgZ+Is72gv1JvGoJVesIskQPr8m5bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxKfHHwTQtp+xA9h4w4FzCx42EqzCLKbKra5xXWsx3SaFYtmLzxfdidrF+yYqN0XT3uOieVXq655GjlJNjHTLu0VYDeOb1C8KwmOrid6f5KYTxKSQaIWtZAnNjtB99QDVhc71usAciE/94rROc2dWOS6Y2u7DPgiNoCCOSfellA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LBX4ZcEd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7881b1843so38596725ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 17:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706665674; x=1707270474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eiQqj8AyPJBMkwxcjL/fD8XyFJwiWNQcNlhT/VtKOo=;
        b=LBX4ZcEdP1MS1rkBBEBMw7hzj41jHuuW4HbTFgIDzvWrgKxKBrZDr01AelE7XpitZa
         80JTYLeH2b5GdWDyCpAYDCZa8iMe2elI0oEKXKsz0qVTZ9B0eNJo4F+kzqIqZbWZ/SZv
         MWDEDbGL16imyHxrzn8oWhRp5znSl3R1MSjzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706665674; x=1707270474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eiQqj8AyPJBMkwxcjL/fD8XyFJwiWNQcNlhT/VtKOo=;
        b=ZsFa7UEUvNA2H35H/Oc9L/gtNBynWjkpKP6zRGCdHJYyApQpFT4yiwMujkaMkfOY0I
         KHIkUL/U/zqAzwGkw5P5NQosAT+9o3+grCaGvPZ4yTAL5O0Bd2plBjzJ+H67dMLCLuEd
         8iuWu6OzH1/n6sGfjriT/OJHQWEULxpbg1tQiBLiVbkT7ZyPLajLG5VKeFMuVZEPzOln
         9acOGZ9XB69n7GoWujfk6ttxoyUQWJQCUaGKTb2HilsmC48bVjth/3AJhnTkKhzrY9jc
         EmlWvhG9pwwzBDcXe+GD7ipy2kYCQlRDDWio1VDzklchJ8Rh8O/yxViZPp8Y8JHhbcOE
         K4Bw==
X-Gm-Message-State: AOJu0YwupYd/p4xsLH/E8a5KJo9NjUOXFjeaaP1w5SbzWuIkZbwKJCtl
	N1nz8hifpOUrcCay8NXauSUnKuC9+T4TDbMT0i7hJkC4k2YlauMOCfBpPNo2L5w=
X-Google-Smtp-Source: AGHT+IHoqZW6Z2tzjKd4C0U5jSuUHmeqk/pJH2zIOvUa65KkvE6gbo1Ev/DhUGFaZ+5GRyx9NdzxkQ==
X-Received: by 2002:a17:902:d38c:b0:1d8:ee30:aaac with SMTP id e12-20020a170902d38c00b001d8ee30aaacmr309763pld.69.1706665674460;
        Tue, 30 Jan 2024 17:47:54 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id li6-20020a170903294600b001d90fe6da6esm1837846plb.305.2024.01.30.17.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:47:53 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maik Broemme <mbroemme@libmpq.org>,
	Steve French <stfrench@microsoft.com>,
	Julien Panis <jpanis@baylibre.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v4 3/3] eventpoll: Add epoll ioctl for epoll_params
Date: Wed, 31 Jan 2024 01:47:33 +0000
Message-Id: <20240131014738.469858-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131014738.469858-1-jdamato@fastly.com>
References: <20240131014738.469858-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ioctl for getting and setting epoll_params. User programs can use
this ioctl to get and set the busy poll usec time or packet budget
params for a specific epoll context.

Parameters are limited:
  - busy_poll_usecs is limited to <= u32_max
  - busy_poll_budget is limited to <= NAPI_POLL_WEIGHT by unprivileged
    users (!capable(CAP_NET_ADMIN)).

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 65 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 12 ++++
 3 files changed, 78 insertions(+)

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
index 3985434df527..afdb91c6faa8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/capability.h>
 #include <net/busy_poll.h>
 
 /*
@@ -495,6 +496,42 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
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
+		if (epoll_params.busy_poll_usecs > U32_MAX)
+			return -EINVAL;
+
+		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
+		    !capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
+		ep->busy_poll_budget = epoll_params.busy_poll_budget;
+		return 0;
+	case EPIOCGPARAMS:
+		memset(&epoll_params, 0, sizeof(epoll_params));
+		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
+		epoll_params.busy_poll_budget = ep->busy_poll_budget;
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
@@ -510,6 +547,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
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
@@ -869,6 +912,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
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
@@ -975,6 +1038,8 @@ static const struct file_operations eventpoll_fops = {
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= ep_eventpoll_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index cfbcc4cc49ac..98e5ea525dd0 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -85,4 +85,16 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+struct epoll_params {
+	__aligned_u64 busy_poll_usecs;
+	__u16 busy_poll_budget;
+
+	/* pad the struct to a multiple of 64bits for alignment on all arches */
+	__u8 __pad[6];
+};
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.25.1


