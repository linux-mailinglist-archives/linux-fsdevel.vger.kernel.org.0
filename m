Return-Path: <linux-fsdevel+bounces-12485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B928C85FC39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55451C23876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04014AD19;
	Thu, 22 Feb 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVS9aBAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D014A0BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615383; cv=none; b=qZg7nP0X60ifX93ocPfLLr9b9JmbE8YYhT7jf7MkU+/QPIuDhJCAgHicJUOno28Wlt8QARgcEQCGcVdGfNjZMpVJNiN3i/V1AizNKJunxEorCXI6FjSAfuAr+dT3abzgtnzxhBQWbey63H59eMC4hHgIYjYJqigG/K+4gBvLa3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615383; c=relaxed/simple;
	bh=XnHU4m12TNRTdkJG4SFaemfQWi0yUbwAs3yicS148ws=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DtqX/czhn4DDAvGALMMsobCeQG/DZ+PlH0rDPRT+YG57dNt9VQpIDh+GesfZpNAkTUHsGuIHPV36dl5C1H1XXbnIWMEBb6WiSZbmVXBlWKSAzc2AO5to2xknfLqk7xJtZHjDudIgghpO1gmgv54jNUhzSoBAgW3ENnMUUBPqjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVS9aBAn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708615379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QsD4p+4kvdwbRyF6LCwBabOaRQBJEtkwSwtY86pkDYw=;
	b=OVS9aBAnfI8Ly4Q4aO5aNd8u2arIBO+Oley70FlyUbdBS6KP7NJFzD1D+WDW7aO55nrRHy
	b3qx2SqzK91QC4Pwkd/pCWxM0rDqagVCSchGZUEBOQe5KtS4Ts5CuL1iF6fmJ2eOOU5BUW
	2ORkL8Nd5a5lc3pEDqVPQzft7azD3Uw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Tolzckf8PtC15z4o91PV6g-1; Thu, 22 Feb 2024 10:22:57 -0500
X-MC-Unique: Tolzckf8PtC15z4o91PV6g-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36512fcf643so55948275ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 07:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615376; x=1709220176;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QsD4p+4kvdwbRyF6LCwBabOaRQBJEtkwSwtY86pkDYw=;
        b=NgwbPSzZByjiCshEFtrScEtGwTkTHyuOYDdBkNuE3qCjx5ZiQIyH3FwedMu5TeWYL7
         l50Bb+zVlBkKpWVMLAx8sn9qcuhx3jc6f4QW7hofz4ppOKSQ8I9vnvE/0WamIL6Zc2DJ
         x3pIituFbjwPuXcRyVq3WfhWP+gCc/h3pqZEUnTvAl+mDB0ZLX9cvcP9AsRXLvnVkSyG
         Gmqg6/Asy1WgFhi2pq7I/TnDWvHS3wo0NRa0egh/kNUO9s/mNUZdvZuHPob4/Evz5yFM
         rTzN1O0h28y2D2PxGItoGHSnQD724iA6SnmCX7L2GThEqSY65hg/w+zuklDfl9f55F5A
         8FWA==
X-Gm-Message-State: AOJu0Yy9g9jsj+JFiOVnDdkjA54GUFRb4v7GlTNI1OTotOOjarxwK2Lf
	So8RdosF6yroYvzrmivlv2kPg37hEqTaoM+NTZPuDorsbWWUjTrBpGgZrXySbz/nKfAlNiXBm4j
	I6nRjN0KhEl4YSSXsQWuyxK25iZQouadQuh9MwLG8NGCg1v96IVpza1MlJ5AcDTeXPs5cWriuiq
	tyXOnsmJRFkH8dkal7LWPBBxu7YWNxdAaBEtHF6XhMOcCxylzm
X-Received: by 2002:a05:6e02:154c:b0:365:1701:5c with SMTP id j12-20020a056e02154c00b003651701005cmr19885914ilu.4.1708615375873;
        Thu, 22 Feb 2024 07:22:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI4EB7caowKsPHVPt74XfmA2wlyGvnMKH3GEoASJrTcahweXCFPjgTdMnrBDOKnNcnjY29gg==
X-Received: by 2002:a05:6e02:154c:b0:365:1701:5c with SMTP id j12-20020a056e02154c00b003651701005cmr19885871ilu.4.1708615375204;
        Thu, 22 Feb 2024 07:22:55 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id dk9-20020a0566384bc900b0047456eee3c4sm295531jab.90.2024.02.22.07.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:22:54 -0800 (PST)
Message-ID: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
Date: Thu, 22 Feb 2024 09:22:52 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, Alexander Viro <aviro@redhat.com>,
 Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH RFC] vfs: always log mount API fs context messages to dmesg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As filesystems are converted to the new mount API, informational messages,
errors, and warnings are being routed through infof, errorf, and warnf
type functions provided by the mount API, which places these messages in
the log buffer associated with the filesystem context rather than
in the kernel log / dmesg.

However, userspace is not yet extracting these messages, so they are
essentially getting lost. mount(8) still refers the user to dmesg(1)
on failure.

At least for now, modify logfc() to always log these messages to dmesg
as well as to the fileystem context. This way we can continue converting
filesystems to the new mount API interfaces without worrying about losing
this information until userspace can retrieve it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

A few considerations/concerns:

* viro suggested that maybe this should be conditional - possibly config

* systemd is currently probing with a dummy mount option which will
  generate noise, see
  https://github.com/systemd/systemd/blob/main/src/basic/mountpoint-util.c#L759
  i.e. - 
  [   10.689256] proc: Unknown parameter 'adefinitelynotexistingmountoption'
  [   10.801045] tmpfs: Unknown parameter 'adefinitelynotexistingmountoption'
  [   11.119431] proc: Unknown parameter 'adefinitelynotexistingmountoption'
  [   11.692032] proc: Unknown parameter 'adefinitelynotexistingmountoption'

* will this generate other dmesg noise in general if the mount api messages
  are more noisy in general? (spot-checking old conversions, I don't think so.)

 fs/fs_context.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 98589aae5208..3c78b99d5cae 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -427,8 +427,8 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 EXPORT_SYMBOL(vfs_dup_fs_context);
 
 /**
- * logfc - Log a message to a filesystem context
- * @log: The filesystem context to log to, or NULL to use printk.
+ * logfc - Log a message to dmesg and optionally a filesystem context
+ * @log: The filesystem context to log to, or NULL to use printk alone
  * @prefix: A string to prefix the output with, or NULL.
  * @level: 'w' for a warning, 'e' for an error.  Anything else is a notice.
  * @fmt: The format of the buffer.
@@ -439,22 +439,24 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 	struct va_format vaf = {.fmt = fmt, .va = &va};
 
 	va_start(va, fmt);
-	if (!log) {
-		switch (level) {
-		case 'w':
-			printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
-			break;
-		case 'e':
-			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
-			break;
-		default:
-			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
-			break;
-		}
-	} else {
+	switch (level) {
+	case 'w':
+		printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
+					prefix ? ": " : "", &vaf);
+		break;
+	case 'e':
+		printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
+					prefix ? ": " : "", &vaf);
+		break;
+	default:
+		printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
+					prefix ? ": " : "", &vaf);
+		break;
+	}
+	va_end(va);
+
+	va_start(va, fmt);
+	if (log) {
 		unsigned int logsize = ARRAY_SIZE(log->buffer);
 		u8 index;
 		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n", level,
-- 
2.43.0


