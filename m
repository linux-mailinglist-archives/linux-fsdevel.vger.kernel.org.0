Return-Path: <linux-fsdevel+bounces-34945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91069CF03E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8552B1F29502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC11F76C2;
	Fri, 15 Nov 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="L/iy3LQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B41F707D
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684719; cv=none; b=UEYhOdl3nk57zbggqa8SyWq9HZYKnqPA+42VIsuyHxtjC/mIH94F+ZKUpl7KPEfJN6Tz6X1D3OxbX0h8Sjpjk7PI0wGEguKIb7efVi1R8NzcZMjyIhdm0b2V02Odi5I0p1q5DbbNGbR3BkjF/PYtSzzzgNgFSE9UJ3rRjozTeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684719; c=relaxed/simple;
	bh=6I0DlDU7r6h299w7wCYMACFg3R+68ox0OBCaPPO6OWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5f1e74jvXCSm/8kCt6bFol8pVPCLAzG6R/Injxx+P4MHQfRonhi2PeAmYd/AEgoycqhBKNinYiYo3tMpzGhf4tz3jCn2Sks0lGlO6Lz383k5c5EfM+JNP4+zzjntjEOwiYHy5BESNesYSKzuvm78Acz4dXWPjRZzNZjOxSSvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=L/iy3LQa; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eb0c2dda3cso20778867b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684717; x=1732289517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVlCssk7TvFYg+mPz0+epJww2XrJywW98H8fNg6oZ9s=;
        b=L/iy3LQaJK51zfKZy836wWqkdRDua/qu5MWDwfT8I+E560K7SSexHUFmeDq26/zUrn
         h3KOdqsG9twRzlUB4bV2Nq2HJynSF/gfw2d8JSFEQAK5/9W6UZhfou3tLH1og64avY/J
         Al9XK1PhX/dtHA3RzLGasw9+49kqMcgj2JnPqB38Y6LkIe+lMiQN0PXvIr7yOdO8agL6
         6STMChfP/Z54ueyAO40XQ+EIECZbAI8QivqPPmKrO+2+9PQus8SboVJ5LJjwauCVsou2
         3x15CjQZiEa/h92ZZTZ0gwOxHvYIa37dpkfhLsrXitqxCpUoNwqZUx4okJMzBlTVDtAL
         vA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684717; x=1732289517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVlCssk7TvFYg+mPz0+epJww2XrJywW98H8fNg6oZ9s=;
        b=Dud3XDzPbm8X3pEXly7F4EhUWhumUWIgCLB1MiZWUvERvqqkp814nkIsiiUBSPYuy1
         nUrtkdjGU9MKWNZuS/fOTcSxCbIReEcSaDEJw/DGmoiSiUNJcF9J5hyrDfaqx/x12GJA
         1lEs2acQeGXUPyXLVsL7PcdrIgDDYDMge8uKPqwqhs5g/SZP8lpnWkxAaYkXo/pF1fpZ
         UP9hHk252hiY2EBJ5NXElyZoInt8tZ1LCxJY31j5O/qWmw9wVAnFDMsrYUjYs0xvd0Sb
         o7fvn+3/xhmwStqNdTc2eEEELxomUJikDBGqkLaY/P2Iu90WrTToqJ6NHIDQe1VmsjNq
         9i4w==
X-Forwarded-Encrypted: i=1; AJvYcCXVoDC5hxu7v2SlSVm1ju/SuGTZxOydrRgXmgHFjXXHCSfQrCYCXXly43VM85FWG2OWpT7UbTOlHsMXBWkx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lOXQNxU9iFzGUyGWmPsP9tv20uA4bH+J35+yaJuq8pafWByE
	J6h7vcDWxJTGO/b/Ts0LZ5XLVOVP6YaZAx509UtFRnRdNvlz/w/nqQCu1oZatCM=
X-Google-Smtp-Source: AGHT+IHB7s7jP8NWV/O0FcTu86HRGJSs7P0wkOPC0j5cMuO18DrwRH2o+5qB1EsHLQ8UmBf4vwq9wQ==
X-Received: by 2002:a05:690c:62c5:b0:6ea:8a23:7673 with SMTP id 00721157ae682-6ee55bbae6amr38804727b3.8.1731684717148;
        Fri, 15 Nov 2024 07:31:57 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44075016sm7768367b3.63.2024.11.15.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 18/19] btrfs: disable defrag on pre-content watched files
Date: Fri, 15 Nov 2024 10:30:31 -0500
Message-ID: <4cc5bcea13db7904174353d08e85157356282a59.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
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
index c9302d193187..1e5913f276be 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2635,6 +2635,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
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


