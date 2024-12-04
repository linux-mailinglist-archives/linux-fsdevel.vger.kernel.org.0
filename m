Return-Path: <linux-fsdevel+bounces-36447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2759E3A99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B1A28298A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AD20A5E8;
	Wed,  4 Dec 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFomIgrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57011C3F34
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316919; cv=none; b=R2gRxav+goOBF6j+EPfqpFhXGs2yNTC0AR8c0zNufPP4Gpk4bDyhtnisvxREhbHbligLuE+D4SyzzfnaEU2KWZA6jhL0bzQMfpT9dFeuPW0Xz7CVTk2ZEanM+OW6E4YZYdSPRp7MQtNHjrQvKVRRAXgVcbf82OwZ7536A+LyPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316919; c=relaxed/simple;
	bh=+kw0hVN/R7EKfAHQdf+parzKCkCR3tVH/e099GIq3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnnsMmh58lLcouyvtBcjTwBOh0t6u68aWTrRyW2TvXAwljzkCp+Pn4xZsdD5d8Wae8EZO0aV73ckpDIrvdVaU7At6UuOlwf6XDeLKT2an27oR6OZKnptEzp5tJ6JsdbwVsJAF+9kB2FghZSn9UH1z5OAHONjYPSyUKIaY10ZaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFomIgrP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
	b=ZFomIgrPWyEqZA16QxQVbj5dj3zEpDpCeIbOYVdI+NAfyp9xYxh3X1AhNtLFyvnkbmEFEG
	Ex+Ys+DGTrpYQ6Euf8ZYRt2/fYi0lk3/4jzIuFgcQGOHAubOrQFxlxz+Vmm9AyzuVyC0oH
	Ot1SRxkma+T7Dz9WZpZHjMSYaHBpWzg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-jokfRLQGNye8wOw0x71CyA-1; Wed, 04 Dec 2024 07:55:14 -0500
X-MC-Unique: jokfRLQGNye8wOw0x71CyA-1
X-Mimecast-MFC-AGG-ID: jokfRLQGNye8wOw0x71CyA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a9861222so55180565e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316913; x=1733921713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
        b=DSmkvFPZ+Q6PoL8LxmNkopJ1kqrf1uss1kZMmJS9O9S0vkYFgsatKuLOqxKEdW9K6c
         CQKp/FdRz8Dc4nrH6fojk006FdgQyhPbVSxC0J3t1a5BjQu43UVO0H9Y8WPX9sRCzAPf
         D8vwA0oj0aDmnHcISNIeaQw8UHY/qAXkOU8Yu5lifpkSTUYFdzBGPi9iPWb4dSLUgQ+p
         /tHVHhEXNfDY9a2Y23qk1i6XVUwMuvitjHFlvTnwhJWCFZ8XiUXbuOWwBhCyBXdE9cFm
         7KZaxM+P6A46xie0gyBpLTDScOTP4GD1rXfJ8Fvke38RW8q6Dq2cvHP4V0gkvJ9OPdh9
         GISQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuiNxszNpTrbwmKqDmwk7zYPVj1Okzk9XCVPmiFg8lhuFGS48yfEVCQvRCmVi4V68+k1SBbyBFwyZmzVFF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9VuwclWIJE81p24j89425iehr/+SQZuZhofGr5iInJT0ufQw
	DB8QoakXJT6p1HE65kHd2dMcmwpRdOmbWwnWKceSkQTbqJxDR0WcC/E7NVjLnZrmlNLYVszmcMZ
	3hSkVL2OgZo2PEoh1ly2oxjw7P8aFGiWrMfyg0rrVeu85SPV7l9tSH8Px7hSZXPQ=
X-Gm-Gg: ASbGncv6mzOKyVEF/3CZhLolcJhAUoIVAsqC4slhLkLTCGkqk6EhQ0JzZKbyer1nEek
	n/kAyQZdRBgwlheoTK1C3Y0fiXhjiqZiCwbx5jUUBh+6lMd9SKwDRXjQ+dP1vby9ANdbKhxj70v
	5uFSHEywZy4FIBMA7z0KNfINtZNt48jKLDSDdnzht8qnAoyeKou4U48RUFZVjn1M387PQ17Tiuw
	zmeFNtyOaXGyRBK4IreYwyA9D2IFpzjgWTMuty6OjFtE5Kd22hba0mOfEcmX6NEs0Z1dbm9KH43
	EfH34j3KN3qZeteTaz3ybR/70+cQmex1EY0=
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62644225e9.30.1733316913734;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdVB6YFjtubaQuZKYqVl7K3swrZVKNM9mWRen9YVYSXicgBrRTJ3zdugRU4fK2CCWYQJl/Fg==
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62643915e9.30.1733316913375;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385df488559sm15210226f8f.63.2024.12.04.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:12 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 09/12] virtio-mem: mark device ready before registering callbacks in kdump mode
Date: Wed,  4 Dec 2024 13:54:40 +0100
Message-ID: <20241204125444.1734652-10-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the callbacks are registered we may immediately get a callback. So
mark the device ready before registering the callbacks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b0b871441578..126f1d669bb0 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2648,6 +2648,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	if (rc)
 		goto out_unreg_pm;
 
+	virtio_device_ready(vm->vdev);
 	return 0;
 out_unreg_pm:
 	unregister_pm_notifier(&vm->pm_notifier);
@@ -2729,6 +2730,8 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
 {
+	/* We must be prepared to receive a callback immediately. */
+	virtio_device_ready(vm->vdev);
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
@@ -2870,8 +2873,6 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
-	virtio_device_ready(vdev);
-
 	/* trigger a config update to start processing the requested_size */
 	if (!vm->in_kdump) {
 		atomic_set(&vm->config_changed, 1);
-- 
2.47.1


