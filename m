Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922351C524B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEEJ7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56849 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728695AbgEEJ70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vc/4f/MdW3BVxDRO0Zg9qb0kjvZ8rZJADpJurBxPrbA=;
        b=FW5zZQlRdzm4fLn8qvhVX7maKsVB5Q/nIgISDElokCO374QQr+iWXMfzRhvTKWjlCfj5Rf
        qI6TZcj9osTMkmy070cg+DoBSGWiZsRwG87zSVVvW9PvrfNdc+29KHagpBJ70ed7yA3zpJ
        zB0+WhGRJtqzWtx1osrQUxnyRDXM2zQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-DpPSvXxYN124lHAOOaSc3w-1; Tue, 05 May 2020 05:59:23 -0400
X-MC-Unique: DpPSvXxYN124lHAOOaSc3w-1
Received: by mail-wm1-f72.google.com with SMTP id h184so809489wmf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vc/4f/MdW3BVxDRO0Zg9qb0kjvZ8rZJADpJurBxPrbA=;
        b=bEeRpJemrlGfaN2Id/vkXX4HsyZN993ns9KooxOs3JjuKTUcKQ9fZP51v6K9jvLdbJ
         iQ08Kdm5yDci0TVq78BuupdWOYp2i5gnKP9HwJ+42YlTN9sRupLHptgkTbuOv8os+oAU
         43pdh+cpNR+F+R+3KshaZNx0pi1RgvgyAtpbEIR9173C77s0WwYDVpVVsF77+CYqcAl7
         2WF7fuEoPpqvbEibZAKcH9wmlGMMOyZtKYIvD/z9DYBi1XEfVo6uKfg5yETvooUICjwF
         syNJQc8YaBZtlK+Yq6yJyQukB/gtZhkaoLn/ExjCF/2gFA/JARLodFKatniXqdjwAI6L
         jqGw==
X-Gm-Message-State: AGi0PuY3X6VOJ07o8er/VRSGDn6aObp6IZJlqdc81K1s4aaPV5bBBCQS
        sq72jAAQJ+A3wfW5rLOUsVPeX+EWsn7GsvEUsK2x/x0qACo5LFg2Qe2z8+QdhHzQkiuVduQpMjd
        SQXH9VQbsEjg8tbgxiOOK2MjCbw==
X-Received: by 2002:adf:a35c:: with SMTP id d28mr2659102wrb.37.1588672762176;
        Tue, 05 May 2020 02:59:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypLmsq1mk1lZlDOqPUAUjDjMXScF3S3gI2pPbAOSnh0Yzw4qZuQmEOJmBxqDRSFZllyW+M3okw==
X-Received: by 2002:adf:a35c:: with SMTP id d28mr2659089wrb.37.1588672761982;
        Tue, 05 May 2020 02:59:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:21 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] utimensat: AT_EMPTY_PATH support
Date:   Tue,  5 May 2020 11:59:07 +0200
Message-Id: <20200505095915.11275-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes it possible to use utimensat on an O_PATH file (including
symlinks).

It supersedes the nonstandard utimensat(fd, NULL, ...) form.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/utimes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 1d17ce98cb80..b7b927502d6e 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -95,13 +95,13 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 		goto out;
 	}
 
-	if (flags & ~AT_SYMLINK_NOFOLLOW)
+	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 		goto out;
 
 	if (filename == NULL && dfd != AT_FDCWD) {
 		struct fd f;
 
-		if (flags & AT_SYMLINK_NOFOLLOW)
+		if (flags)
 			goto out;
 
 		f = fdget(dfd);
@@ -117,6 +117,8 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 
 		if (!(flags & AT_SYMLINK_NOFOLLOW))
 			lookup_flags |= LOOKUP_FOLLOW;
+		if (flags & AT_EMPTY_PATH)
+			lookup_flags |= LOOKUP_EMPTY;
 retry:
 		error = user_path_at(dfd, filename, lookup_flags, &path);
 		if (error)
-- 
2.21.1

