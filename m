Return-Path: <linux-fsdevel+bounces-11027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0D84FEA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FC01C21A09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2003A8FA;
	Fri,  9 Feb 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wLoX768r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822C3BB32
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513358; cv=none; b=kB3wZqvH7iarPBBEZCFcnHlgjCcUv86bPICH51pPpPBj/FJJcFXQ78dnfOjRmTKEXHtJXIU4aNb8SX5H2S4yNOw9dQKuPArTs8oeU2x3HoRUqW5YhcaupIWIFSIYgbr6a/zKbkuHVItVVAb39kNcRCQuzHVOkFUqiVLwwa2C6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513358; c=relaxed/simple;
	bh=bU1lRcpmwwquP/3WT3NzDHAkVOQAiLuggZfIHJAVD+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/+5g3Z/7lLa/zNNq7+ltkkYtj1SpMh+HeL5/svjFaMZb2ExVYGfZGYk85l+gvD9FEG05PWubXbHJBxrFbz/J+AcIoTVOVr1WAfQy59HkiM6On6E2Wo/86sEEokLGk21+g4p3lazLbkoABq+UuJIa5dIZP13YR0PcPsd5Ot9lSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wLoX768r; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0a5472e7cso4627b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707513356; x=1708118156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T72+tfYxIVMKkrQX69I/sG/Ln/429Cv0P7tqGCS/cM=;
        b=wLoX768rhfA6KiMLsxoXieDDIgiLiuhFmxIyhI6YSIG+EK1zztLADr3sCzO3Ug0ajd
         InGT2QhFIXO0/IBTPq+qbKMx3k0ba1LnfNqpKknZ5Y8YDVf0sJmpF3N0X1+4b4LQtGKQ
         /6PXRPFTtWM1DH8u//n8KiSrtV7cVTAGB7drU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513356; x=1708118156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T72+tfYxIVMKkrQX69I/sG/Ln/429Cv0P7tqGCS/cM=;
        b=gw18k+6/ZOZ2KlGyZv/gHbY1rC4a/EgD8ZZmtARi/R95sLpVtulQOuOMiG6LBxiHAd
         AFN/9mx81e6wUU1NlRXO0xK2uhNqu1qiJckGz/fb0CE3tKNzy9r5iqd8BIRaJNtFcp7a
         zwVEWtOh8fgf5kkOYhSiuoeEzMY6rAk9q6XT9+fxjXcA3Kqsu/N/wShemGifts374od6
         JWqdkXASD+Bc0Ej92Fb5A0IEkycPPd47cr0kYS6d5qlvP+l0xlDohZYSOMvc97jQkdpb
         ikOoQR2tdsch1kcVGtgAhgt0w+cTz/YrODtKS1UalHB0Dcb+lQ/KX5I6bQ5d7IsQoy+5
         SjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB3ccKwNJnB7iPcfQcFRR59p8z6K8Wc0IIQwSMuR0038VAAl6NbquZcO7z+Ku7uNVtBHMK16qZr0lg+Rff0AHcnhcyYSt+HHkCxt6BSg==
X-Gm-Message-State: AOJu0YxQBpoXtR4vHi34rf/mEJtXKxIMhITAjNKcW8vXy/3JmwslHy7X
	uT/PBF03vh0A4jPMI+vEbQlAzBTbU2wutS9N7QqpGqzy0yTMQyoK8cN8CA1gdps=
X-Google-Smtp-Source: AGHT+IFTvTVn1r7M2cMGDn1GxO1rvefrugDtzFOvNOEbtdqsnrdmUVe4Ula9hxSHTfs/Pt4TrxmGFg==
X-Received: by 2002:a05:6a20:43ab:b0:19e:97ee:af55 with SMTP id i43-20020a056a2043ab00b0019e97eeaf55mr416941pzl.1.1707513356321;
        Fri, 09 Feb 2024 13:15:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJj4LR8eeRuam1BjuM1EtiGu4vRjwhKwhCP2VDo1jULvf+oH9l/0VIv52J3i3gAldtueQNp1HaQlSWVqUAOltAJbLlwiAvsey9QvL1B7bO02YsgDNJopPwshTnQ3tyFQ6D5kt8M3NjEpwPS6FLo2uH+M+2v0a/RdTTzAQMW2Wu/fkW2IxjaJRXRaCPKig0A7c+szKH2aD5loF5hu1ERoEbVmJPJxxXdkT/Vt0PKlnyYneCEtS7ltvzrsljk8C3Bpg+W3KkH9i4zF7se9Mg7h2ixJKrXbXUfB1SPt3wfJNyvDnaj3Ske0SQb3UB66GJk2kpsCuTlpKGzysTVLj+0RNmpNSkFGflrBDALZ8AHclwtbHrFS46Qk4vju1eWXlcXIBFaO4B4M+QJBI3TStBkygryk8choXmBnwFue451x0uWFjJ/hyUtYHRnl06YSLsOdi3sq93YtBuSxTZTNm9dO0nB9E6hPNoFgQg7TjU/KepJumiDHhPjJRqkhepXJ5Rr0gucnslzFbw8Vt8wGJsMuP+fLBrI5uQMlx1h9mMGYoJsNFKMlsh/rX9ssjr5PWAD1Pe8L4cPxjWGwdpeTPzN6lFYbsHnTGqTBZ5Di6PHpnyv3VSDX2xhwCPnwEV9nbI9Nb0MIS3t+QdYy2jHaEyiWwsB3MwHluQ5zsHDIv2nfbSanPshj/sbNHgLmrqsc0bdMD/Zzr8YqNOwI9PyrBc6ntkp7F+p9jl4i2svMK7kg+UZztPA4V5jfaqDTHVD4BRKLWaoaRI/F9Vas3w1UwNh9r1dc0VeTJBmuvQ317k9SaD1ICDR2/yT5Dut0Qp54NyDdhHTFSeCMLiSy9u4SMwngtb4Hifi+a71p9k1vZLWaUxxbA0TdxSCaPzXni33Ur8qjXbknmy6anUxmQ1COpjI4kmgzhjw9T8U6GhwFufx6XZF5IaHrynioWVsudVbIGracylX7
 a02wPNR2PPU0KDXcJqz/4oACS54pay537goYpUUFa77oBslUA1Ow==
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm969629pfa.199.2024.02.09.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:15:55 -0800 (PST)
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
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maik Broemme <mbroemme@libmpq.org>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Thomas Huth <thuth@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v7 4/4] eventpoll: Add epoll ioctl for epoll_params
Date: Fri,  9 Feb 2024 21:15:24 +0000
Message-Id: <20240209211528.51234-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209211528.51234-1-jdamato@fastly.com>
References: <20240209211528.51234-1-jdamato@fastly.com>
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
  - busy_poll_usecs is limited to <= s32_max
  - busy_poll_budget is limited to <= NAPI_POLL_WEIGHT by unprivileged
    users (!capable(CAP_NET_ADMIN))
  - prefer_busy_poll must be 0 or 1
  - __pad must be 0

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 72 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 13 ++++
 3 files changed, 86 insertions(+)

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
index 1b8d01af0c2c..aa58d42737e6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/capability.h>
 #include <net/busy_poll.h>
 
 /*
@@ -494,6 +495,49 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	ep->napi_id = napi_id;
 }
 
+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct eventpoll *ep = file->private_data;
+	void __user *uarg = (void __user *)arg;
+	struct epoll_params epoll_params;
+
+	switch (cmd) {
+	case EPIOCSPARAMS:
+		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
+			return -EFAULT;
+
+		/* pad byte must be zero */
+		if (epoll_params.__pad)
+			return -EINVAL;
+
+		if (epoll_params.busy_poll_usecs > S32_MAX)
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
+		ep->prefer_busy_poll = epoll_params.prefer_busy_poll;
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
@@ -505,6 +549,12 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 {
 }
 
+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -864,6 +914,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
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
@@ -970,6 +1040,8 @@ static const struct file_operations eventpoll_fops = {
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= ep_eventpoll_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index cfbcc4cc49ac..4f4b948ef381 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -85,4 +85,17 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+struct epoll_params {
+	__u32 busy_poll_usecs;
+	__u16 busy_poll_budget;
+	__u8 prefer_busy_poll;
+
+	/* pad the struct to a multiple of 64bits */
+	__u8 __pad;
+};
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.25.1


