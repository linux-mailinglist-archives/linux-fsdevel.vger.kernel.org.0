Return-Path: <linux-fsdevel+bounces-34294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA59C46CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E1EB2A978
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FF81C9DDC;
	Mon, 11 Nov 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ul3sfdrd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DA1C9B95
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356380; cv=none; b=HStgp510eyfA8jM4jjPCrxn3e96Zf9M4QqhMYTk39WWR+UYOgBoLdXp0IFO0PTkeKGa2APXC6W7gO2YQaqJ0eT1srT6WyNC+KtQNEO/JPh8z6G9Fpy6B7TbKEiG7HKbhPEcysagmqOOShgk265YhjSXbl17cxpH9+ZaVigSYQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356380; c=relaxed/simple;
	bh=g8f8HPGo6FF6bNhCenpptLnEwEhFsJS2XcfOHpq3gpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGSgWSHiropUB+CJeeE419WYJow4cIKH3pOEwBSBDVPrMekXrg0unnxEWVxyxJUV2H9p+pFXo/IYf/piVE9Vzv9omQxjrUFyPylq/bX4L/42s6e3N6pnrvJ2F4BabpxONEohF2rwB+H3yjrWuFjuGPtGOaHzPXn06ry2fHYVpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ul3sfdrd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1b224f6c6so364945885a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356377; x=1731961177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkyyLOcMapxd8eZps50M2cPjgtuAOvBDRyUA+1LsM90=;
        b=ul3sfdrdnV34wC5BOw9gEuQZTFZo6RWEaCK/AQr3weUiTVU/eJkPtu9fgqudOsJXnv
         mZQj0sOAbfHNRFTehmU174vQivZGCUYNwADSJ9qV7Wyw/j3oyq5/gRKmj06ki2wD6JNy
         75RkjRTrqTQ/lCnQa22zFxX7asmDSp3503jGvAIce+8FbpLPJ6UB6O/AJPUeLCiV+aCR
         7+PZ6R7vOGnkwyTkgTDuCySVK9RNBzQhe5LdYWDiV1Ej1FOBlVtMQwdGy495bC+y56mu
         6ZCDJEMlkyjuYiDc5dW7atL7J8aPlLG605AIYviz0sGSZc6jaB8FO3OYgiwfU0pytqqC
         apdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356377; x=1731961177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkyyLOcMapxd8eZps50M2cPjgtuAOvBDRyUA+1LsM90=;
        b=D24OEE+slcw02m9fGrcVRw9cAAO9d4ffn/IhH4EQ0MITp23pyEB0NuRnyUQ4UzjNyk
         M6cGTY8iRIQ8iQ+4J5MZP6mLipcJdSIuRyyp0GG80i2B2CMrvoSvI2bsUCegkbIIznK1
         rRhabDtUgneS902zIxkRn0CUXj8Z8EV5tfuRxmdwyrNdBMsAC9XG4DXJX41Vps/uCPlG
         55TOpdYN8iOBVtfElQfwDDhBF2/6hCTv6SY+8+TGAVOD1baxclrfz6e5e76FeqamG2q/
         N9r61At8kRG6cW2DDFRFLG9AUgsRYdUNFk39uOZz56Yk68Bd4brnEkIEUYDDl75JjaEU
         gSgA==
X-Forwarded-Encrypted: i=1; AJvYcCWqPPlD1ClwMIGjEzHlU4InD7mNfhulPv/ShZlJbCzWEr5uV4l76sG8gClkFZivBMz//xGiZ+lBuEKuibeU@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQzZ8hvf4BO34SslbaW+BnDrvNs4+dVzJ5qih2pQcpTs34QAG
	f3Ic3oxjGQZowAw9W0alzQOXxaps/yYLY+Aoff/yDDxueD3oXhjAOzANAx0PoTg=
X-Google-Smtp-Source: AGHT+IGjGL9g3kFfcH+6V8KAtQzfg7b48XSPpKvHKYOiM22WInprVkhEgNc7K8iBcMmLd7E6fsLBYg==
X-Received: by 2002:a05:620a:19a7:b0:7b1:3e41:849f with SMTP id af79cd13be357-7b331eff745mr2211412185a.47.1731356377090;
        Mon, 11 Nov 2024 12:19:37 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae57asm525455685a.81.2024.11.11.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 16/17] btrfs: disable defrag on pre-content watched files
Date: Mon, 11 Nov 2024 15:18:05 -0500
Message-ID: <c46f21bd55082ccf7380d438d82d3ebbaea284f9.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
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
index 226c91fe31a7..9b13df1ea729 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2638,6 +2638,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
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


