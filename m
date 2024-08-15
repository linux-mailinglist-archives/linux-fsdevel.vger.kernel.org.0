Return-Path: <linux-fsdevel+bounces-26052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2478952C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53D31C2367E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB121C18F;
	Thu, 15 Aug 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ORm2gGoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7B21C160
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713916; cv=none; b=boWCboX1c+vYoxFmiinqbH2BpGVuCM2d20dmPYIvl86MWCmd2X3xvUPNZxdX30jMuxfkvQ1i+UGwX7RQ2408iQi7tloSg12Dz+npzNz3JQ6weJaKKCwJ7gclH23vYZjX+d69gO9exqaxUhBgY1gjo1wYORLMdif/aJf5H0A1EI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713916; c=relaxed/simple;
	bh=ymy9AdLU4FnRhhiUnMjD0ZbEgyL+Q2k8uHDQ8UA+HNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnCGPp8S7cf9D+QVOtHm8IiBa/nQ7gzoQJyayKaB6GP/wM/iuJ7xHBI3IaQIphW7bLbuZgQnb8QbNgwdwTEPXXhhrm2tEtauPMgukCs9cTf16TkAT+yOA3iAwovfJ73WiEbQnVDebq/PWO/M4qq5+7e+xw+43cV+fEx+TnAMim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ORm2gGoD; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D3EB13F670
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713912;
	bh=mjFOlrsdA+rODkwJYHT/kVKlqhDJvVibiu+JqNMSC1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ORm2gGoDL4V40CyxZRLO/AO48sGW16oz+oWNDdjw8iC/FvkJZsYU3eLZRNUOPUcoX
	 mNB5dXFMwjDWEb6Wkp7Nkb4cn+CkkExSjoZ5iOkNN/oApNI9B1EhxiKX5EjVGdrUCm
	 j4ON28VAam68el/G82rUir6fYK6RX6IgVTVz24W0LF5tg7Ntgkt6WLkWR42uu+2xyF
	 5rgbpd6YQwdk3x4ZZKQsf1XgOTxvyfv0l+20wMNx+8nS7IHg4KpqhQrpXFtd7d/ZQW
	 HhG/KGYLy42ia5VluUyPnWnbo1492Wo48Nw6+UsQ2ddNYxID26CMXauBcZpeenRwvZ
	 Z/OZIvz+/0G3w==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-530c299a480so647257e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713912; x=1724318712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjFOlrsdA+rODkwJYHT/kVKlqhDJvVibiu+JqNMSC1g=;
        b=wqC8rTyuYXAS3pQ3iL/+gD7vMsrangVHRHL1WC5JpJVAD/ZPyi7HHl7xDg30zkDTlz
         FHQPjZjFnssYrNwWLNEFglf7xGz9hBNcQA7Uu1zH2dkPE1CUwlFBrNO9QWjraJ8QHjt4
         RUXh/YTaVDl9/aNHnsXvFpJNHdpwxrj55AK/tL5bNlPbhZYf8emZKxBW/DpZmXdQ2stA
         HQG03bPQaNRcIximAK+AWCko3y8sZsR9frKtNXaSfkUou3wCBxHv0mVp/qwezUDMwelo
         xSMmza62adarO9V62P+85gwGuOt0l6uhnpVeq3N2IPOYX1UglgldrKEbU+D8wfxN755y
         75eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQByAVLgYPEaXYLofoMarn3MpnF3+VVZ8Lq8Nj/2SNKv4gYXaNVikWJvbLZjpBfA575XfqAN0EmLUUxtyDsafKGVDJHKC5h08rbTt2mQ==
X-Gm-Message-State: AOJu0YwpSeuURIJlymGXybDrBERAmmf2bQazAtat6K2OSAqS0B801xws
	wA2CGW3A4XAODqq6VtMtJ4pYbnM7wXyiXx8UEy76GQcY9maK22nIaV7MH9JmFVYYix4iUZZuxqQ
	FEgGYgWROk2d60TwEDd0KqwcRX86svf+2frECZbQWcxinWBreX/MdHfoVRsPBIW9E9knWaJTd1i
	S4ius=
X-Received: by 2002:a05:6512:3c8a:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-532edbade41mr3498318e87.41.1723713911619;
        Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXVHcom9bqqi9GSeZiOw88lrHGMwV+yLO4NjQtn8iMbKuCv4yuzR2v2cJk7x7ywlGr+9KTSQ==
X-Received: by 2002:a05:6512:3c8a:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-532edbade41mr3498304e87.41.1723713911159;
        Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:10 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 11/11] fs/fuse/virtio_fs: allow idmapped mounts
Date: Thu, 15 Aug 2024 11:24:28 +0200
Message-Id: <20240815092429.103356-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow idmapped mounts for virtiofs.
It's absolutely safe as for virtiofs we have the same
feature negotiation mechanism as for classical fuse
filesystems. This does not affect any existing
setups anyhow.

virtiofsd support:
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v3:
	- this commit added
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dd5260141615..7e5bbaef6f76 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1628,6 +1628,7 @@ static struct file_system_type virtio_fs_type = {
 	.name		= "virtiofs",
 	.init_fs_context = virtio_fs_init_fs_context,
 	.kill_sb	= virtio_kill_sb,
+	.fs_flags	= FS_ALLOW_IDMAP,
 };
 
 static int virtio_fs_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
-- 
2.34.1


