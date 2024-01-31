Return-Path: <linux-fsdevel+bounces-9687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776818446DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A421C209E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873813D4F2;
	Wed, 31 Jan 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PMtahE2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66A13BEB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724589; cv=none; b=IdMo+ewa7rcqI31mhgJuMUTWPbs5JoNIXFUA+StpUbE5Bb4s5bz4/Op7OUP2DVRbTk63O0mhiDxo8eztaeE6E8fD57rB/01AaYOchQGCCSSwhCrU74aFbxIflB+QbVHlnL9Ub8X76xsxr/swLX3WPRtYibil8cRfOn9b2DTjjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724589; c=relaxed/simple;
	bh=7A7sHroL9Ow9RB5SlrBbD5eZxpWYWwUbOvldYd9/zgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrG8rusKegtDUqpvZwxCW+zzzGoRTXOwIBtrBy9pDoj+r63NUanr/BVmrU2mKdgUbuJL1VRnZIqlGqjfCViy/cDKirqz+GrTYIi9EO58AXxmYiHQpzoXirqy+0/0n8brfDo/uy7fbT01mJ/NEjfWh7p9RB8kmYdnNqwnGi6Tktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PMtahE2n; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-218dcbd1584so15676fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706724586; x=1707329386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL7KL2gLPbAb4hjqxQ9bqO5kTIW0debt+d1tm+r3LDo=;
        b=PMtahE2nzTI6NrcNsv9ux64CWk/ga8Ey3k8fsDCJ0ka8O1FdG2frROY36f64eLQRJ/
         qekG4muZzU9V9FEvI5Yg+W0zvkg56aWQotkl/G0V3QG+ifqSLBdvS2sQqPcj/IKFPRbm
         d//41RqxlWTDNRZYpxI8z5FEEPwkD5Tt3cmw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724586; x=1707329386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL7KL2gLPbAb4hjqxQ9bqO5kTIW0debt+d1tm+r3LDo=;
        b=h3C5LxL6Q1tk3xxM1ruQx33Ry4aSiamGLZyHzdSmh3YJ2P8MdPxG2RCoVpaywRfTfV
         7Ajr5jIPlGi1CjciXgXtj6AN6W/Y9xcc0eiDpecJ0AxZTnB7JHEAVdz0ni9ey07oyhhY
         jbBlEgOVzlAoihNCb/brrkK+D2qm2ggPbv1YHLgdqlUNygtAF89lwSQyad5W1hxsLyXM
         rHN+icKvrK1211eO0p4natHEknPv3plBFbfu547o5Ndn/NcalOus/iEhENUBSowutFT4
         yH5eKUBi56lToBWZHvLuQHb7JdAq0tQSyQmGB67/YQUIIcox7Gx9nfz2JKZZOkqrohlF
         5BKQ==
X-Gm-Message-State: AOJu0YydO1MhMrRN+lgVtnCRaWMIBF8YB/Huq5byLEciqY7RJJhM5M98
	HrvTeyMQ9Pu0+sZuct+0qmu/GmP1R3WyFuLlUSDIwvka9zCOB5+l0SWcVTOXEss=
X-Google-Smtp-Source: AGHT+IH6vZMWPVrGq0O5BrjIonOKl2Z+F9QpaXvc/P9ImjsQryVPvIl2cAqRN6GYK8SEKr9YUCu6kQ==
X-Received: by 2002:a05:6870:8a1f:b0:218:d3a2:2430 with SMTP id p31-20020a0568708a1f00b00218d3a22430mr1705910oaq.22.1706724586595;
        Wed, 31 Jan 2024 10:09:46 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b005cfbf96c733sm10876004pga.30.2024.01.31.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:09:46 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Steve French <stfrench@microsoft.com>,
	Julien Panis <jpanis@baylibre.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v5 3/3] eventpoll: Add epoll ioctl for epoll_params
Date: Wed, 31 Jan 2024 18:08:05 +0000
Message-Id: <20240131180811.23566-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131180811.23566-1-jdamato@fastly.com>
References: <20240131180811.23566-1-jdamato@fastly.com>
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
  - __pad must be 0

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 68 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 12 ++++
 3 files changed, 81 insertions(+)

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
index 3985434df527..96efca6a9238 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/capability.h>
 #include <net/busy_poll.h>
 
 /*
@@ -495,6 +496,45 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
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
@@ -510,6 +550,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
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
@@ -869,6 +915,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
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
@@ -975,6 +1041,8 @@ static const struct file_operations eventpoll_fops = {
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


