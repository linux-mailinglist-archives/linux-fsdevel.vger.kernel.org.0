Return-Path: <linux-fsdevel+bounces-36442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD369E3A84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AB5167FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEDD1F426E;
	Wed,  4 Dec 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW5FMw+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3441E3772
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316905; cv=none; b=tS+ET41RD3C477eAJVPiCBlOpC76D5NAtAkxWlpSKK+fqcf2rt8PsixRRSaUaWU40AucSVTewwRwqHT+RG9Zf8na8UU3rYp+XMB3yfrqYNxn6cyPjgPOI+qA0HMkijxepXAVJAf8Oy8T8cvLbFTRsM1UnvwFcgn3PqVZCOGRlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316905; c=relaxed/simple;
	bh=BgMJzD3uvTJhEKjQ1/IdIeY2entK2KsTWNxYBemJ1qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anvpoDbz3eMIiOcJiVImfNGM/fLPPzE7YntC/GUR7nzii5gaUQw3D7N/4BlnL/z0RivXP42ACeEocYpBDvSyrzQHcGsml8UTw1GGGH5yapRNXJ4+ZqzYqjFp2IYCaNfCpJac6V0uRWs247mSnD5qvPxpAXwmfLk9YKkI1tGTNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW5FMw+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
	b=GW5FMw+auNEG6EXHPF67S/0tV49wAULCi+mreQUSFeALvtdoZnysb8nz7ceYBWJX8tboi6
	6THrdZYOxdNTeB8XtoD4xUNnG2si2Oi+iP0khCca39ZyoeLPibNnGcrLKfPpZzVaGt+q1r
	MYrncwTcwGvU1JJON8ONB/E8ruFTBgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-xxIYhT2DNZ6PcKLjC7WgTg-1; Wed, 04 Dec 2024 07:55:01 -0500
X-MC-Unique: xxIYhT2DNZ6PcKLjC7WgTg-1
X-Mimecast-MFC-AGG-ID: xxIYhT2DNZ6PcKLjC7WgTg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434c214c05aso29037705e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316900; x=1733921700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
        b=ty8OiXkQk4ha3CnbjADPwvrH6xAmFtgVGevJ/cddVMMjfw6xMKhNQymo99Bei/W9R2
         GFRoF4yrGBk0lI/4qfdvkJFFh+WYz8mRKALWlAY0CSVV/o1XP0B9fL9aTAJLSriOCGTJ
         cwwbRXBrUdnGiMkrrofxmIZC+dMAKSmoi1+YETytFflJldLqRViCWbKJqD/nuC+0VMD1
         JFHxEMo7VD0exNAt9kk09ptXk9/O+SJk7CJGTeyMZsc2DCmEcPbAMf2RU0WdL2sIc5p4
         4zbk6E+KQBNl1joRZuD4e2CFq7zIpQ6LG5oXjrG/DoIf7+XaMxdE1sVrSvLS4R9XnRih
         liQw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNvjRlGMHGHqnVqU4Idm4mlYW91eFtdxM9YnysK+yVV+mD9/bRpNoQTC8SLYBd+erEOcPhVaBEPQchRtx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhlTEFwwppoV6ztXLZFZCL+P3XTfZ0QoaF27FTNlYvVx8gOh0
	ET19Tgl4FAzLTGH81nXLj0zFTPr95EUHwU2XESiO0SwJjsDmn/yCb+oflyUzmFmoEMKG/RpdETz
	JQBySNTxL8Ql744g+W2lJH3dGUPFfyn0Cve9CZZp/89aWjX5R/B32N5yx7jRQ7Ug=
X-Gm-Gg: ASbGncvJ+QvKws1kaWU9eh0rtiV4Fehf2fCHRKIeIgXVpzcp9OuQHZLOh/4bnSgKuyW
	H0EXsHcF/IMqUXBkgRp1t+qVIYN+X5z7YAmPoae6BBtUYogWjgepxKBh7QplOM0RrLZGbVzt1lY
	H7VUWm5N/zUmGWxCQ0GtBZTeO7KupdOPSVb0rbdptiFJwRjGTYnfbrbH+ZOhJVwuz8+Iq+w2ojh
	6e/7+bpgxUTpPxt9VHVBjr+5jKAa94ALmacwJWTD4kJUYym5+JMrlSTbNRG2cWTEvVzuEukQLZj
	lXLhV8TuxOOicPrHJI/QYLD84auDm2E/y7U=
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431755f8f.47.1733316900237;
        Wed, 04 Dec 2024 04:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkIZLfFS9dd4mzise8YhuqVkFTd47qC7aw9US3336mGUo5e0+UH/rIIT1Petk2to7fPbudFQ==
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431725f8f.47.1733316899810;
        Wed, 04 Dec 2024 04:54:59 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ccd2e1bdsm18785865f8f.9.2024.12.04.04.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:58 -0800 (PST)
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
Subject: [PATCH v2 04/12] fs/proc/vmcore: prefix all pr_* with "vmcore:"
Date: Wed,  4 Dec 2024 13:54:35 +0100
Message-ID: <20241204125444.1734652-5-david@redhat.com>
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

Let's use "vmcore: " as a prefix, converting the single "Kdump:
vmcore not initialized" one to effectively be "vmcore: not initialized".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 16faabe5ea30..13dfc128d07e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -8,6 +8,8 @@
  *
  */
 
+#define pr_fmt(fmt) "vmcore: " fmt
+
 #include <linux/mm.h>
 #include <linux/kcore.h>
 #include <linux/user.h>
@@ -1580,7 +1582,7 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		elfcorehdr_free(elfcorehdr_addr);
-		pr_warn("Kdump: vmcore not initialized\n");
+		pr_warn("not initialized\n");
 		return rc;
 	}
 	elfcorehdr_free(elfcorehdr_addr);
-- 
2.47.1


