Return-Path: <linux-fsdevel+bounces-28651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E396C895
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DC11C25B5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCBD1EAB8C;
	Wed,  4 Sep 2024 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Kxe1sZSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC851E974A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481787; cv=none; b=SFXPCRB7g3GHQGBvbk1S1r9N/zR7BIWvRNNeUR38BUXqeqOKvh3/hfMhZ5ZZ3o4/dXKr8NzZu2MnJ/giRWTaMjf4KG715fzxFIVtL0iRXyGqqYpqno2WiVkXraGpuHsrK7ltAlZVXCdAnKH6o2yme6yHa0SGJPk7OhEFmjES8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481787; c=relaxed/simple;
	bh=mlpkxER5ZXbhWxBFWH/+nNlNrq7abJQvDN93xPwV0N0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqkNEk/KD+wphQnQ+dBmGNDuUopXHUeJTMdCegVSom86L2TFBRX9FkGejMjHpfK4mM5DbJB9J+VUhQyevh7UjLQYvLtwLQ90L71hAavEf1hjPOMIZFTPZPb5S3eG7rHmM9oTalaRKzGdSU3PfdEaMFk62rhyY2o18sMKs2WAVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Kxe1sZSB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso86706d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481782; x=1726086582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2g5nWsdtLhh4I3qKZ9kVR48Zxv3ldXz3E9kfB37E8o=;
        b=Kxe1sZSBe9bkdYZJnRALn/HAAAEZMTeKx5eO5AvTJ1D3YwSVfn+q5BILaNQW8ER2gI
         mRsqj+KUHJ9z66im7l1ciGFzt9X9oXD3q4FjbbQeStUTGAd6/HYPBSW8vY3KM3CkbRJG
         Hqfe5P+PTSnrLsdQJr1+s9qkv/NAD7V7PMQtg3S94IcnTfuviqT7TkqwJTke7gTzi0K9
         ggVWsakCpTAaB6upon39dRx8Qqe245H8JgVEmnUuvRcNqde+hkeUQXMJUvWslK2tB1UV
         SnFSr76ju62cmfyRuo5JBgN0ZxMAN/PxBuPJeqtog6yIzIehwqBwFtxPE+Z4TEVlM9op
         3pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481782; x=1726086582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2g5nWsdtLhh4I3qKZ9kVR48Zxv3ldXz3E9kfB37E8o=;
        b=odT4cmL8AzNCevLMBBEoKQ2KFTPTj38DUpZYn8ghSldKaPb0Ju3iDcFC4mPTFHZGNU
         YP24ruc35jojEtr/FfJHyYWMs/EqJNt9X9wXHF401+Jv6UPbBtm82GkbRfud0/MWXUaw
         gGGkRfRqiis/wwnx2vl2T3cRuw2KhN34zKAufvYPwKBph/aMOYbAWj7AYujDt7UQUPJc
         s78QmRqRFH9IqdYGajLkPlsMt3p3vcXdHeVp0/CoENilfBio4Gz4TiV2UFO0L15QTSYR
         M/zpScd1HHMy5BETzIb2jkkkU8bBsDAblPFrlgsTi/GFXLNuDLxqZz1drozpvPYbpRy9
         Z1pw==
X-Forwarded-Encrypted: i=1; AJvYcCUluH7Nyc0LGi4qHdy0VYtwQcz0Og5JW9w1VfRDq8k90Se//xELGvoeBPrl5g8pTz7lJeuLxu0svWqWPw+p@vger.kernel.org
X-Gm-Message-State: AOJu0YygqeTog22lZRc1mU+E7FPI7HRfU+9mIhhC4VGFut4aj+HF+1WT
	IhPZEC+FJJPHc10/47VHMWd2J8AjHJNTiAPEtiDi6NIgYucC9tmi/Ta4i9zzv7A=
X-Google-Smtp-Source: AGHT+IGcGqc27V/yp+/MPiFXZlq6o8dH/S56y18i5ffiw87nR/uugOanZlUMV6j8hRmZXaYyxJ0xkA==
X-Received: by 2002:a05:6214:4a09:b0:6c3:5ebb:9524 with SMTP id 6a1803df08f44-6c35ebb9733mr193501086d6.48.1725481782473;
        Wed, 04 Sep 2024 13:29:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520419ecfsm1552666d6.126.2024.09.04.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 17/18] btrfs: disable defrag on pre-content watched files
Date: Wed,  4 Sep 2024 16:28:07 -0400
Message-ID: <367fe83ae53839b1e88dc00b5b420035496d28ff.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We queue up inodes to be defrag'ed asynchronously, which means we do not
have their original file for readahead.  This means that the code to
skip readahead on pre-content watched files will not run, and we could
potentially read in empty pages.

Handle this corner case by disabling defrag on files that are currently
being watched for pre-content events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..529f7416814f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2640,6 +2640,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
+		/*
+		 * Don't allow defrag on pre-content watched files, as it could
+		 * populate the page cache with 0's via readahead.
+		 */
+		if (fsnotify_file_has_pre_content_watches(file)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (argp) {
 			if (copy_from_user(&range, argp, sizeof(range))) {
 				ret = -EFAULT;
-- 
2.43.0


