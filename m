Return-Path: <linux-fsdevel+bounces-40308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72EA22139
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A957165BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B91DE4E6;
	Wed, 29 Jan 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj1N6UNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50C14830F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166810; cv=none; b=P39o1I+fqLoVfxuQ+UaeEMFx1QicoluUVml5RK4ISzO/p+4kn7BpBt5uR4vx/mmmsuHUfmMRY31ty6sYh1nwKRojbmcT9pCjhi25MAgRQVyJIUwLJGpJvX3B9mQgDwo9Wla81LNIGWQyUp1Iky0ZgAo/Db4NGj4scYgsm3UxIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166810; c=relaxed/simple;
	bh=Y7VwTJssdNd+8+pYdIFMY4venrc8Fjl3u348SiMYcVc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZPUZ10kJrS7ZQMIffknpDthc/NjwtffhYvr7DfuTpsrPwmu4vKGeDQHtaqjKeW/6NnmhEPgHZ9e7kCZUk+aXlQrI1xdbd2aekZNLuW6xUGsl5YpaY70hOVkrYZVDZbbJMp7CxpeJWC02yuTPrlGWVKaf6jf1Dmf8nPPymV+Km64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tj1N6UNZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738166807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wmLMoMGwAOEqS6rwrq61xZMioVxxgg2l4aVdzHC9QXw=;
	b=Tj1N6UNZpb1HjSb7opiWYWhviUXk9AZsxOMyBB1LS7y4nU7YtlyX9sBHcOAFodTXLszMji
	cZXtg5iy0vKZLGnPitq0ez+HQRvFA+pH0sigton4rIIf2XnYnb3ruU+GkN3oGcmxxgyEV7
	R/3xkf66qEoYls4Gmu/0I8fWvOiGASk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-jrooDx6FN66nCcCKSNK87g-1; Wed, 29 Jan 2025 11:06:46 -0500
X-MC-Unique: jrooDx6FN66nCcCKSNK87g-1
X-Mimecast-MFC-AGG-ID: jrooDx6FN66nCcCKSNK87g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab2b300e5daso676013366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 08:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738166804; x=1738771604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmLMoMGwAOEqS6rwrq61xZMioVxxgg2l4aVdzHC9QXw=;
        b=xTzm623snSTbiuvHt7lXAFn6VvL/v0N8RVLc3EeNiggD0Mk9prEslzundxS2ZEbYy/
         heWGdhZwgn6qC5s45rx8/8Ld6Fnj64opqSl4sw115db9ixkpLVYZKxy/gVnHm52EkNuI
         cJpEXh8pfK7IQuxVi1I4wf0XOJtlIpPP0pWPMWsuQucIe171uEyJAxYVmDTpQePsK82s
         BDfVrVd0ZG5wUCxxcitk0NaWmYgGulUjVd5epapE2aZ58/eNgkO9ayYqf7ITeCdBagR2
         pkL2a5fJPm8d+q4mhp2J7U4b+qvpTltAoe4ieiSj+sjbhkWYkqbK8O6amRFOtIpf/vyI
         i15w==
X-Gm-Message-State: AOJu0YyFUraTu80lxbi3cvWwHMqyhAUH4WMD+nJrV7gaBMyo8J7IFsdF
	3zgn0BcWh8iqb2HB/8YoQJeN/NecsYXptYbUA5BxB4bFFPP/Nych2QCkgXnZGuQBTspCG7mOuRR
	i6jRupsZEPGawaXgOFmjZBHaRSvNJ4ksUEWdCXz95O9ZnkONcp6Fyb+rjTOwYLil6w9Me+N9dwa
	tUoL1ToHCoVCFK1QC0xfdq/bhtieJo/IyAUOYqqDNlitHqBNKRcQ==
X-Gm-Gg: ASbGnctl+m/QwZGt9ofIQ2Blp8+nTUiaXuxYUmZzVnG8vOsNIXSkPGfJhU0NW4RyHgc
	/IU6UYWd7uWXcPG9trQYPvthIHIT1MlgjZH2+HpVdWlrl7LehY4YcDEaFpqKp/Wvlax5+8pQbfw
	ZozI617+mYam1FbOvXDs/gOnFyr63wSgtUQ1OunFl74ASUKh2KEMjcGfM663Qw7bdsIIhOAo7n0
	YzmfFTt8krXvv/gORJflvy/OINV1mv0tF7bJRN2SxyBauQ7b7bCXboP96hx9FK7GluEJ7/nnisv
	3tu4GO3Bu8sulaYpXuv/3BB/Z67+Tq430VCJiHyA26ebZ73zqQGnNMF3
X-Received: by 2002:a17:906:28cf:b0:ab6:daa8:79f7 with SMTP id a640c23a62f3a-ab6daa87bdcmr156686066b.41.1738166803673;
        Wed, 29 Jan 2025 08:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtjpnHS+1wNXqYRp95udJFTOYpPhJvZEqyBLWFJMtzlthFK9Be7ELbZ5ajN/hGjs74cVVGsg==
X-Received: by 2002:a17:906:28cf:b0:ab6:daa8:79f7 with SMTP id a640c23a62f3a-ab6daa87bdcmr156676366b.41.1738166803047;
        Wed, 29 Jan 2025 08:06:43 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676116b23sm1002379266b.178.2025.01.29.08.06.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:06:42 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests: always check mask returned by statmount(2)
Date: Wed, 29 Jan 2025 17:06:41 +0100
Message-ID: <20250129160641.35485-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

STATMOUNT_MNT_OPTS can actually be missing if there are no options.  This
is a change of behavior since 75ead69a7173 ("fs: don't let statmount return
empty strings").

The other checks shouldn't actually trigger, but add them for correctness
and for easier debugging if the test fails.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 .../filesystems/statmount/statmount_test.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 8eb6aa606a0d..46d289611ce8 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -383,6 +383,10 @@ static void test_statmount_mnt_point(void)
 		return;
 	}
 
+	if (!(sm->mask & STATMOUNT_MNT_POINT)) {
+		ksft_test_result_fail("missing STATMOUNT_MNT_POINT in mask\n");
+		return;
+	}
 	if (strcmp(sm->str + sm->mnt_point, "/") != 0) {
 		ksft_test_result_fail("unexpected mount point: '%s' != '/'\n",
 				      sm->str + sm->mnt_point);
@@ -408,6 +412,10 @@ static void test_statmount_mnt_root(void)
 				      strerror(errno));
 		return;
 	}
+	if (!(sm->mask & STATMOUNT_MNT_ROOT)) {
+		ksft_test_result_fail("missing STATMOUNT_MNT_ROOT in mask\n");
+		return;
+	}
 	mnt_root = sm->str + sm->mnt_root;
 	last_root = strrchr(mnt_root, '/');
 	if (last_root)
@@ -437,6 +445,10 @@ static void test_statmount_fs_type(void)
 				      strerror(errno));
 		return;
 	}
+	if (!(sm->mask & STATMOUNT_FS_TYPE)) {
+		ksft_test_result_fail("missing STATMOUNT_FS_TYPE in mask\n");
+		return;
+	}
 	fs_type = sm->str + sm->fs_type;
 	for (s = known_fs; s != NULL; s++) {
 		if (strcmp(fs_type, *s) == 0)
@@ -464,6 +476,11 @@ static void test_statmount_mnt_opts(void)
 		return;
 	}
 
+	if (!(sm->mask & STATMOUNT_MNT_BASIC)) {
+		ksft_test_result_fail("missing STATMOUNT_MNT_BASIC in mask\n");
+		return;
+	}
+
 	while (getline(&line, &len, f_mountinfo) != -1) {
 		int i;
 		char *p, *p2;
@@ -514,7 +531,10 @@ static void test_statmount_mnt_opts(void)
 		if (p2)
 			*p2 = '\0';
 
-		statmount_opts = sm->str + sm->mnt_opts;
+		if (sm->mask & STATMOUNT_MNT_OPTS)
+			statmount_opts = sm->str + sm->mnt_opts;
+		else
+			statmount_opts = "";
 		if (strcmp(statmount_opts, p) != 0)
 			ksft_test_result_fail(
 				"unexpected mount options: '%s' != '%s'\n",
-- 
2.48.1


