Return-Path: <linux-fsdevel+bounces-56046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF40B121F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F727189FC51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB92F0033;
	Fri, 25 Jul 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXljbpm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72EC2EFD91;
	Fri, 25 Jul 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460590; cv=none; b=C1R8cTZfbgZNTK5/d0Dc9VzGdwdX4fPg6ZSiVvMMaFHZ25R+F6f8XYyajC0GvOsNSSq3g6si/VQU1ASK+xBEFXFKcZRENTiv8Jwqw0TtWXwO/wBv/nZRzPBLOGD1VmOqsRE5CoBw+oIn9KYMgWTElNEc6GGTtQP9Qtxz4qVZ71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460590; c=relaxed/simple;
	bh=neZhPWNjaWBKB5Z3M//a7sTXy5qc9Y2wCac0p/ThBFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/gGJiIJ5+Xuj1CPn7Fij0JMzSgGb8nuxiNcTGaWoaccI+tV8K61f19cA5dbqn/fxlkQH6blEftok3UK4jO6yawaw4/sqXHA5fly/Mut67LuayVHqRRrkbctaGnA4N1p7+5OSaN6SOSzHUTNjiWE7Bg31LyvXXLNP18+QVSkS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXljbpm3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad3400ea3so16861656d6.0;
        Fri, 25 Jul 2025 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460588; x=1754065388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg4daqcmOqhcR1CzrWxL0M/I6a0shgB30VgpkxJSydc=;
        b=eXljbpm31VyrEoVmVo8LSDuUG815UbVr/lRhHBWtO7Z2aMg/02rGKiYqrDyWb0RYw1
         1hKPhh6241MWNveoMFf9WM/oTf3PnuiSZvDsRHCkZUqNEeUXf/7ZAEVT22GczDtN0DTG
         xOC+TRyXTEF5JuInmrccNyID5NZhfwnZijTE7KlaEaJrxvW9hRy9YjdatSszMgFPkhBV
         2VzwBvVpR79J/A/5baZRSvqxRdt9G9yTWSrnLA6/+XmbIYepm/mLGoxjUiXi6F93Cluz
         s0959tSr9ngZFeESvIPxDar/3NbDgzE7MMsoQDbE0ZwWtWaJAPNO4WYDeDag1CjRpWAY
         XDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460588; x=1754065388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg4daqcmOqhcR1CzrWxL0M/I6a0shgB30VgpkxJSydc=;
        b=PCRuKmFjevGy6tSLdRgAjLqvqKxY7Du6I5ZoIIuqIyfx22L/QSqHUSWdZLGo1yMhyF
         zPqqE417ORie9JOSN8Dj6TazpCE/D/p3HxZtVrSFSMbQ3vMlXdjQoFR6io5u/tVc1WCD
         85NquKvIvxVMbzq8qxMFddiqcV8sEMnz1OLRMcFrt5aztZwcjCXXkIc1tyMxlmqxNyWp
         RVhgGEbcKpGZM6ErBfB/fo65Ge2fDkWfejJuc+EMjf3TYwSpT4brCLAe3Ux+gfYgBaEB
         +GMxeKeCmbPnuNqD+zxM0azH9iNdvTHysGYGeDS92RkV0wNnWi2GzCyTZiMDvh9Xy9Xz
         Igdg==
X-Forwarded-Encrypted: i=1; AJvYcCXX+pg8r6Z6bRn/+atNyP0NiC42flA0ebyWUdqKdJh86B96m4xz4TjyAWQsAL3w9Ynd4yq08taJMxw=@vger.kernel.org, AJvYcCXc/HPM25oq4hWcvXHcA0oCnqbs7zOZ+83H8VIRS5o+YNb2V20GwaRu71OmCYx5QHZ5yoY2MTagrhGvtMAp@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjy7jVb73x/62Zwbvz/DAj1i4ajHeF0C46HRq+kx6a6celcTC
	ShV53G2B7CtdaVbRlXOEagd5n3HnYuTWLFMhQHQ5cnPHKIO2LF4Dy9eV
X-Gm-Gg: ASbGncsgwhyIpbYpBrQSImbjHVactb3S+GtHvFndRYa1ItU+jSsRuGWE+vk46uDvkdt
	PNRHxj8Qe4Nprz/Wh0v06QdTETnZl5vPTdDBig1/sr2cDwSzsUST1EYKyCKoOtiBWCnv8cYqe0x
	cRWFqjDEZj4ccjKmNF2SYx2/61BRlUejU2iSdAF4Yw8afr2CB55bIQPF9uAy6ewNy8SZ8kS5rJQ
	gpzMFci8BUMItJc0sdIYJu8+4VcEyoOLa8I7heAseODwwMjUMcXg/1o4PJ6gzxE8FEwRFwi8T9I
	Id0xwOwSdTwN7wGN95JnkkYJYs0DXl8DAUdFLu04/pG02taCeJAm+SkM4k6KQ6hcS1hzOSw2haO
	Y4F0uoH80VFbq5ih9zIaH1NNBb/Wa5XY=
X-Google-Smtp-Source: AGHT+IGixZFGbIYWOPP1umgQcO8kd0SNYDAa2j8sTfscN1UGv/O9HXscnBrOMp7xCbnGJ+kgRCQEXg==
X-Received: by 2002:a05:6214:250a:b0:707:15c3:e4f8 with SMTP id 6a1803df08f44-707205e9b59mr32272166d6.38.1753460587555;
        Fri, 25 Jul 2025 09:23:07 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:71::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c4de30sm1873286d6.72.2025.07.25.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:23:06 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 5/5] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Fri, 25 Jul 2025 17:22:44 +0100
Message-ID: <20250725162258.1043176-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250725162258.1043176-1-usamaarif642@gmail.com>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test will set the global system THP setting to always and
the 2M setting to inherit before it starts (and reset to original
at teardown)

This tests if the process can:
- successfully set and get the policy to disable THPs expect for madvise.
- get hugepages only on MADV_HUGE and MADV_COLLAPSE after policy is set.
- successfully reset the policy of the process.
- get hugepages always after reset.
- repeat the above tests in a forked process to make sure  the policy is
  carried across forks.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 .../testing/selftests/mm/prctl_thp_disable.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 52f7e6659b1f..288d5ad6ffbb 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -65,6 +65,101 @@ static int test_mmap_thp(enum madvise_buffer madvise_buf, size_t pmdsize)
 	munmap(buffer, buf_size);
 	return ret;
 }
+
+FIXTURE(prctl_thp_disable_except_madvise)
+{
+	struct thp_settings settings;
+	size_t pmdsize;
+};
+
+FIXTURE_SETUP(prctl_thp_disable_except_madvise)
+{
+	if (!thp_is_enabled())
+		SKIP(return, "Transparent Hugepages not available\n");
+
+	self->pmdsize = read_pmd_pagesize();
+	if (!self->pmdsize)
+		SKIP(return, "Unable to read PMD size\n");
+
+	thp_read_settings(&self->settings);
+	self->settings.thp_enabled = THP_ALWAYS;
+	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
+	thp_save_settings();
+	thp_push_settings(&self->settings);
+
+}
+
+FIXTURE_TEARDOWN(prctl_thp_disable_except_madvise)
+{
+	thp_restore_settings();
+}
+
+/* prctl_thp_disable_except_madvise fixture sets system THP setting to always */
+static void prctl_thp_disable_except_madvise(struct __test_metadata *const _metadata,
+					     size_t pmdsize)
+{
+	int res = 0;
+
+	res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
+	ASSERT_EQ(res, 3);
+
+	/* global = always, process = madvise, we shouldn't get HPs without madvise */
+	res = test_mmap_thp(NONE, pmdsize);
+	ASSERT_EQ(res, 0);
+
+	res = test_mmap_thp(HUGE, pmdsize);
+	ASSERT_EQ(res, 1);
+
+	res = test_mmap_thp(COLLAPSE, pmdsize);
+	ASSERT_EQ(res, 1);
+
+	/* Reset to system policy */
+	res =  prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL);
+	ASSERT_EQ(res, 0);
+
+	/* global = always, hence we should get HPs without madvise */
+	res = test_mmap_thp(NONE, pmdsize);
+	ASSERT_EQ(res, 1);
+
+	res = test_mmap_thp(HUGE, pmdsize);
+	ASSERT_EQ(res, 1);
+
+	res = test_mmap_thp(COLLAPSE, pmdsize);
+	ASSERT_EQ(res, 1);
+}
+
+TEST_F(prctl_thp_disable_except_madvise, nofork)
+{
+	int res = 0;
+
+	res = prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL);
+	ASSERT_EQ(res, 0);
+	prctl_thp_disable_except_madvise(_metadata, self->pmdsize);
+}
+
+TEST_F(prctl_thp_disable_except_madvise, fork)
+{
+	int res = 0, ret = 0;
+	pid_t pid;
+
+	res = prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL);
+	ASSERT_EQ(res, 0);
+
+	/* Make sure prctl changes are carried across fork */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (!pid)
+		prctl_thp_disable_except_madvise(_metadata, self->pmdsize);
+
+	wait(&ret);
+	if (WIFEXITED(ret))
+		ret = WEXITSTATUS(ret);
+	else
+		ret = -EINVAL;
+	ASSERT_EQ(ret, 0);
+}
+
 FIXTURE(prctl_thp_disable_completely)
 {
 	struct thp_settings settings;
-- 
2.47.3


