Return-Path: <linux-fsdevel+bounces-36446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E359E3AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF8BB2D895
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FA1F8ACE;
	Wed,  4 Dec 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbOHkUx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E01FBCB2
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316915; cv=none; b=HWBdAtyVYhR6UTaRqMlZbN5k9H1Tj6Lzb0UkoDYEQgdTmFKi7bu6a44zy9NxlG4pLHWNecihypZbIZowz0apsNp7k+Ko5LvD72sSofqJwwTDy/HZdZLn6cS8uBtUyQwAQ2g1mAxu4qNjc93S99xvwC57JEGJGF97HgH680TLmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316915; c=relaxed/simple;
	bh=8EJBn/hbfhsOHacsaBstPaeEQTFd5MZoCB7W0faV+24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqfFjdi/HhLjoRl0LnPzEQHCJQP7uywcu3hlz3DBCSPclRMIC5ExyA5DIS1zRfI5xPNh2EOiOpcOS/3zynZAPW4BNm1GELDbc0VS3jyKBZ/JNev3CHhY6tnCmd6K3B9o+/WZqQFhZSvvDvsK2DilInWEZVpPwEYuNOqZrPGTUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbOHkUx4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
	b=hbOHkUx4i/55ixVZ+5on81TwWQmiePi/4QuXSdBVmI1FgC6JzHVL27ZF9vp/V9OwJPTES/
	D3X0lSv4ae2TQZNUfmXxEeHz2kho/f/6a7CgZHCEdqAHZ55VFy3TDdSks4ULVjuZRvJt94
	8ztl80SvZzdFPcxMIecFLBpIKxL/UcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-oa4N7l8INsW0i82XT99mWg-1; Wed, 04 Dec 2024 07:55:10 -0500
X-MC-Unique: oa4N7l8INsW0i82XT99mWg-1
X-Mimecast-MFC-AGG-ID: oa4N7l8INsW0i82XT99mWg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso62398655e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316909; x=1733921709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
        b=lY6iWDLP+liYGEtsGe8fJs2czHSHopqXwdO6/abX72EvQV3Q93Gk9nb8qHPEdZj2ou
         7ovBnLZXZZnQg6bvw7bQH3pyndGXj9jsBnwqju25H3W7MKIoixJUeb7EzLZ/MFwGspls
         dSJac0rQNJijPcfTKvfSYg5aLOm7JkD0I0OYYZ7e36i8lFcOxbYfYyK1OkdKhpl4tI5a
         MnmGA+suO2YTL6UCARq0/jXwnDjaLypdkQ5gQK23vIGlN4GESR3+Rqsu9kmXc3HEi7cU
         DvF8umKpQnVS8H7JUz5gVk7GuLje1KWSnEBWdzIB1K9NPuXlyh+V+goAwIU45Sh0s+uA
         0wwg==
X-Forwarded-Encrypted: i=1; AJvYcCW18NRDVggp6nBCjPDBT+lT1qfWCnPQsAh2z+M5Rd7jw3emrSfpkBA2T3f7EmqlQ093qNtCF/ozAE7xx5kX@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfTJRXcHa8n6AYaUhgUbXUtYfGsj+QNNq3kvTWW3YT4osA4QT
	9w76VgcHAclzDj9awY28bX7PgGPZp4U0ZkpQ5j2O2hWzU2QBu9M8E5M6EXhQbESpCVCaOukNl9W
	SOXw5lcmlxBXRTI6Z7d69fKqihZZUztiBKJJvystDAqTi21h+hu4TRma6K6O4C/s=
X-Gm-Gg: ASbGncsOgp1v6HLoGy7paDDivfc+IcnWhzGLad4DjrA5ic59j/WwZvyTY5CbnqlK2Ml
	vSRFUCTIJFVquXLqMQ7/xVrCqF8GAxL4FwlpbzdMtyIc+FL4145UvVIkBW5djA7ACLJg7mjHcLL
	k4o2/Q2Gj2mZGwFU6myRKVhdN4GA01rCLHqJpNKFEKlDocC+pFQn4Mz85Ca/sTJQ68x1VbQWU5u
	kS0wT+CDYtlqXnmNkJWYz5jb+8FPQ2Q7CXUGG422roH0O9wtwczJKueF7riEgsiBSwyd27/uOLl
	Bkr7pZgH+/oQWD7fip5q6MQWGe/F/T1FCC8=
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274945e9.6.1733316908763;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKlYOU/tZlshqWyJGjVsl03zkEzffSPE/+D71b9Tfd5+g4TqcfXtmwO5t6x/22DC/lF4E/bA==
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274425e9.6.1733316908112;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385db7f86dasm16267209f8f.66.2024.12.04.04.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:06 -0800 (PST)
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
Subject: [PATCH v2 07/12] fs/proc/vmcore: factor out freeing a list of vmcore ranges
Date: Wed,  4 Dec 2024 13:54:38 +0100
Message-ID: <20241204125444.1734652-8-david@redhat.com>
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

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           |  9 +--------
 include/linux/crash_dump.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9b72e255dd03..e7b3cde44890 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1592,14 +1592,7 @@ void vmcore_cleanup(void)
 		proc_vmcore = NULL;
 	}
 
-	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore_range *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore_range, list);
-		list_del(&m->list);
-		kfree(m);
-	}
+	vmcore_free_ranges(&vmcore_list);
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 9717912ce4d1..5d61c7454fd6 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_range(struct list_head *list,
 	return 0;
 }
 
+/* Free a list of vmcore ranges. */
+static inline void vmcore_free_ranges(struct list_head *list)
+{
+	struct vmcore_range *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, list, list) {
+		list_del(&m->list);
+		kfree(m);
+	}
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1


