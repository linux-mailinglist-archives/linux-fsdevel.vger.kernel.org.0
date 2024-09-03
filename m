Return-Path: <linux-fsdevel+bounces-28428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11B96A21E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE78281A7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79949199934;
	Tue,  3 Sep 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OWMqMlUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE21990B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376647; cv=none; b=s86mpquu/aWiFM7O833nJ9m0je2pd9D52bwhnc9LNhIFcZH+RklxKBGbMwBjcmZEox7FqnWtyLuFYEOGVxdF/4KbvIvyL+oWpmJJlRTqTqJPilITU4C4S15LW0oG7+tLKOtrlNyUXkweEC40XTVniYfqlzrEJEMm1Wyhz655F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376647; c=relaxed/simple;
	bh=I5Ej9tXxsELnQaLpNn7Un8jHm6ABGkNJE4SsL33oa8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bz7XZ/NdkX8PLW0APHWTQ8d7NaFZP3lD+XebxUb+g7bxLXNwEcsHMxEs+dIzDRqmYiBh1i06OP0NgzIoSAXAEOp0S49LRFuiVlNJZ/Bf2SH6NYcMZVnrlhXE6BQjEH9fkdUC5vnVlmVEV/nyKR5JpGntTc+4FTB8RoL7BhqTI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OWMqMlUb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E54763FE28
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376644;
	bh=8g+CuHEOVaIi/oyMU4FT/dyfPKPOx4hjrvyEeKrnVIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=OWMqMlUbTfa646WlBogFxWZT13bkJUqeKkvfJwMQT9BXP+KMu28yHQ/Xrcbm4X1Z+
	 wyDUTG82PWoeAf3TFvkxXaBzX9KDBBfQ/Pby5ieJoYNOsNm8AY0mcADF6AzvmE3gx7
	 1zaLBM6i7qQZVIgyfY9EQC7gQwf7RCvySBGOgL8k+X16V8UBPmOlRJ2MVZPywssSQO
	 4PeB0R3e+Zi6F9lx4D6ugSD3vf5xlw8i9v5ZmYo90Ked8CZsVefa4HCSATNmmrOFU9
	 RBW/MNAyFSr2k48NYdydz0O0QL5I8x+joJf505rt64+dgPSTopn7Lbk42xfXahjanB
	 yAa7s9Q3orB2g==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53445c8a9c8so889862e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376644; x=1725981444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g+CuHEOVaIi/oyMU4FT/dyfPKPOx4hjrvyEeKrnVIU=;
        b=UbWwQGoIvTm9EyO35IxNk/EDRUs9YKvIkIpjWiSO68IISfjWQ32bayv25EuKILngz2
         yRhqnX1ohASBGZpp4jr7x+37ydy5DrbrYDfcQmOA0jwqnGKYeOTq3reyxzqlS0bPPIni
         WT+Q+IGg35CWbc7Ytv5kvcGggY34uOPMhSMUAV8Y8Hz8I8IsjGjvMyy4EZLKa6DOvlPV
         X9p6pMn5AQUt/7dNpbd7XSkGI8pHvKc1bpWxyaOTl2ZhfrsqdyrkUm2AM9CYfbaspVU0
         M3hE2oHn9tZLytkpzKHXsm4zTY4fUxTiYFDOwYM4MEPeWpFLoq9RuNMgqjTehdrin72I
         2s5g==
X-Forwarded-Encrypted: i=1; AJvYcCXL0ZUWJP8s7RHhpV0BVLeR09Sa3pSG8JM5ldZJEJpV7ZqzOEf3telyrFTYM6t72vG9+cBiWw3i+T9qq6jl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0v7h/47BA/jdD9tjNFsmZzY9f1QzY6TuRAD4zj0xjobbKhzAA
	23Men51Ibw/W/R/vvwt4DgLvThYpRqmHQtWcD9f7RnryM5lQoWt3h9by3OXn6HR4HuTX9P8poY/
	ACRBeT2jr9n5HMpfKQWxyIbPw/y1N+kmVE6pK9o/mLdCU292ve+jqRk/UqKYhLX2FTV0pB6r4Bc
	g37BE=
X-Received: by 2002:a05:6512:3ca3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-53546b2b5e7mr8720707e87.31.1725376643656;
        Tue, 03 Sep 2024 08:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+bq1GZV9X9d7kfysJWIp+YqAiYHgnriynd3aEYFL4ojAqTYw0oKyoeFn1hFPXtYAGSanyXw==
X-Received: by 2002:a05:6512:3ca3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-53546b2b5e7mr8720683e87.31.1725376643137;
        Tue, 03 Sep 2024 08:17:23 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:22 -0700 (PDT)
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
Subject: [PATCH v4 15/15] fs/fuse/virtio_fs: allow idmapped mounts
Date: Tue,  3 Sep 2024 17:16:26 +0200
Message-Id: <20240903151626.264609-16-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
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


