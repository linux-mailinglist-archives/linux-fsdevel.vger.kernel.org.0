Return-Path: <linux-fsdevel+bounces-36439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7EA9E3A75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE528182E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827501C82E2;
	Wed,  4 Dec 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Atyb2NQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAD1BCA1C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316896; cv=none; b=n9656Eokrc/RA1TR+WvjHXPs6hSofaylUhi/MFddFPiILlNKPre8go2dbxslPZGWdEyF3blCdQuEa4AfrKj/4x4tCOztvjWpNiGnn3LzCTGuracfXbCaty43OcOBgF90UlgVQldKyBnDoUFXGEmNKWzao8FcePI5gZMnLbacWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316896; c=relaxed/simple;
	bh=DemhL4cc1sp6Aqy2pgRkUydsYoG35xqCQwkgVd3ioow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUXwaHmFJV3v9bimOaF3tOnmoZDK8mFqDsE2krC5U5hS1AvErw20yh+LvnOPlLMx/0WxMLNvVvj7uUPlA6K0Y/5YjmYBsCNUX7uOHkg+S4d7sDXJKmSOPSsFbiaHvIrNm+QGa7UFF906R2rLVSsFJSKhmBkYLyapcRX9TMmfqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Atyb2NQW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=;
	b=Atyb2NQWNWizwui7xN8ajltan6FBuyq7UlO65Ufv4ko++YRnx8roJ8zGNfD+AumLy/S7XG
	N9KUc6KW5HyWkqYu5kT4L5sVuIPDFOYjoxOvfPIGCc4kGxuGN23Kstd/2LHZZz0n2gwJtS
	BRDm4RUoE61rgSo3WvPlfKjdJ2FVXzM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-7mTJFaXYPy6xKYlZMsuEGw-1; Wed, 04 Dec 2024 07:54:52 -0500
X-MC-Unique: 7mTJFaXYPy6xKYlZMsuEGw-1
X-Mimecast-MFC-AGG-ID: 7mTJFaXYPy6xKYlZMsuEGw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcadffebso2594991f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316891; x=1733921691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=;
        b=IEQQlJGsBvrp2tEKEcZ3betZQiFlkXK1FscjThSOmYzNE1984NXD92YLkc0FAZzEFf
         kLEDysXynF/9OcUrIJ2FOJD7v5sYHp1Ppro0Q+Filzfu/32jHgi3ghQoRWaLHnDI5qpf
         bkk8EgjIKVhx/WMlV6qoo2UaJOVsumCTAJAZpPeEzvryFYqVVvOuq3WGSz/nwNZsblLa
         M55wBQ2DSQzN79I5fQNiRNSipwVeqyCK83lPUwvTUtpwefZreIaJEUhlrNlZRYRx4wYF
         Q6IUGQRzdiYZksGVFEmSVriUIkmtQJIcm/d1NZyBlef449RtcfwMqbdCb+TILKDThuow
         iHFg==
X-Forwarded-Encrypted: i=1; AJvYcCWdNrfA8uw+MtFMXOSjxb46qlv3DjB5UGkRAqnEye4oXfwUItC9oExfdIfcrKDrUa9TugmffnLYUzO+sqlt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqj56fViRhS+ryjTntK1Bf67Bj+om3BEGss3z3n1LwzCnPJ0h1
	k+m/nUOtiFedwqjIPgkk5JaHi4Zrcc0HOAJ1FlCk8/sMXDifSUKSR7mbKNjHrzr8Ke98VoAHfF5
	lUNIsjjmlgSiaopMybLFTy6Rq/nrR0J85+Elhdc+voXK8aF1/ATUNPzyFxm+HPxM=
X-Gm-Gg: ASbGncu+8yWeWn8Nusc4Ia8EM09ZaNffihKFYAvxBf5MopLBB9awpfIW+76nxOSv0PX
	1wPDcAQxbqUFzWtaqw+8FZSAJCQWcSYbWkcLNQVxk9H0tPdpXtSZx4UYxOiv8hCUhvO4l3Q5Qzo
	aGcDPVFXThrnNqZTPtsZpEzrBMhavsvWbvITYWJW4XmFJK1g3KR/qiuzZHyIcdXxVUg/1pV369d
	g7uBgv0Ah9LSU/hoqnNeOalspU30HM4/oxYleK4Op0AzUPUz+xFLgBo4wez502S9nf9bgniy8jw
	ZSzLSJsf0bd6PvU5ztMdQmgc9/hZXr7+dwM=
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr5360096f8f.37.1733316890960;
        Wed, 04 Dec 2024 04:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGOcFoEjkEw+PoNC+LLaws3waLwovX9iW85k260HP1nxTmH4H7ZaUgV85wmWvqw6YlLZ08+Q==
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr5360063f8f.37.1733316890620;
        Wed, 04 Dec 2024 04:54:50 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ea9c5952sm11045422f8f.67.2024.12.04.04.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:49 -0800 (PST)
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
Subject: [PATCH v2 01/12] fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:32 +0100
Message-ID: <20241204125444.1734652-2-david@redhat.com>
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

We want to protect vmcore modifications from concurrent opening of
the vmcore, and also serialize vmcore modification.

(a) We can currently modify the vmcore after it was opened. This can happen
    if a vmcoredd is added after the vmcore module was initialized and
    already opened by user space. We want to fix that and prepare for
    new code wanting to serialize against concurrent opening.

(b) To handle it cleanly we need to protect the modifications against
    concurrent opening. As the modifications end up allocating memory and
    can sleep, we cannot rely on the spinlock.

Let's convert the spinlock into a mutex to prepare for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b4521b096058..586f84677d2f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
 /* Device Dump Size */
 static size_t vmcoredd_orig_sz;
 
-static DEFINE_SPINLOCK(vmcore_cb_lock);
+static DEFINE_MUTEX(vmcore_mutex);
+
 DEFINE_STATIC_SRCU(vmcore_cb_srcu);
 /* List of registered vmcore callbacks. */
 static LIST_HEAD(vmcore_cb_list);
@@ -72,7 +73,7 @@ static bool vmcore_opened;
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	INIT_LIST_HEAD(&cb->next);
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&cb->next, &vmcore_cb_list);
 	/*
 	 * Registering a vmcore callback after the vmcore was opened is
@@ -80,13 +81,13 @@ void register_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback registration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 }
 EXPORT_SYMBOL_GPL(register_vmcore_cb);
 
 void unregister_vmcore_cb(struct vmcore_cb *cb)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_del_rcu(&cb->next);
 	/*
 	 * Unregistering a vmcore callback after the vmcore was opened is
@@ -95,7 +96,7 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback unregistration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	synchronize_srcu(&vmcore_cb_srcu);
 }
@@ -120,9 +121,9 @@ static bool pfn_is_ram(unsigned long pfn)
 
 static int open_vmcore(struct inode *inode, struct file *file)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	vmcore_opened = true;
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	return 0;
 }
-- 
2.47.1


