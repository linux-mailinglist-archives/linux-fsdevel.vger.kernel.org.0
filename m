Return-Path: <linux-fsdevel+bounces-59283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F793B36ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F251B289BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0837427F;
	Tue, 26 Aug 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BILrCV0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432653728AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222923; cv=none; b=lAhNQqlwBYqQlvUJ6HxaZrse61SV0VPADnm/ZJPazKilMKnxxMvy0OtHrXg+ehZai03Xzyqka93pA4I4R3wJLI9BO7gzd54c8ypPILcNMy58X7wfOkOuB4PRZwyQMcCBLHwi6y82aJbOfk2WQk4fplQC6cThZ81sA8aGLRwRoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222923; c=relaxed/simple;
	bh=MRbjz58EJk2DIV/CMfsuQeru3Gjlj5upRwbvX0t3mqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pts9Pren+Rg8Jl3BLENI6jM4OE2/g5wsbnUc8gfoZZ44feCXuurmCJ0cgf5LDEDFFz8UT8dUM7jqu2nUzQ8I6CIKzGEJr6blAodNInffoT+dyOOv7Au/QFSAbdjnzObRvS5lNfUZb6yXm8+7m2dD671EpHzBq1Bl93NAs7bDbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BILrCV0W; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71fd1f94ad9so46395797b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222921; x=1756827721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=BILrCV0WYnWT1+2jq6fXe3vKn1IHeBBILGrrJVAnTnpJcJYKAMzR3plnA76m6YeXxF
         a6pcAgQ3YvsnQlJBDZcbjUKnbWHJIRT+cixh8gcWP4ozxfkU3ayzIPS4WbvCgVM1V1J9
         JivlLLAyTLjmRyOshv7iUp7r/q08xiYFz/EZOzzeVwBZrD+XfNGu6Z8H70D2dCsk7QVB
         kMEYOeV4tsj1mLQdqgYFePAosHW+XMhrIGGEFCXaEAWEtoZarqJJMIzyqhK4SfnsdTzY
         duTPScZDefdP6Ngt2VeLd7tNlT3lkFmPY6rGXWhbi9BCBCri92kMMlbCwHc8levsNrco
         GlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222921; x=1756827721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=d6CUl7eeTlHRPJ3UpIoeBZahuxkPseTKpIXDqzEoC4w6+mvvsQHE4xwJ48TjU9QrNx
         /LAbSlye+RLaFIzi4cAxirXlUx+oUiAqKN05Zpr8YNevrzjf7Ex81RH4kA2oHvKdeIdY
         mJIPXwfyKz0J4iEi2xPEPFlT8qJMe4LnFGP8GO/u/iLcC2W5yvqksix7e+tL19WuGIKy
         4z8S0AJyXIyvncb1LLVjpcLODrl4d6otAtMoKAlU/OUXrruf+2ehkpBLYLGzd1cOyF/s
         meJxyA2t3nFQuR/BE6pHwm4l71CINsxaIA7u3S/USVCQmTgT5ZfIhApC9UTc747EeWaJ
         SIoA==
X-Gm-Message-State: AOJu0Ywcfluj1Xu7Cm+q0BF5N6T5Ft3/37dre+8B5jvpDY7di4VIlFJY
	R0fRoe3IpOV+YHfTZrcjMmRG5wEdq8auvT7NEO0wLsDkHrlytIkOwcIKiNqi5DPLZBBTmZ0z51C
	yhKL8
X-Gm-Gg: ASbGncs/nJYvx/JerQrk+7DducEL7F6iuDwNTVEuADZ1MuM4/NybGSPgdnhRlfE6XMc
	2LSPoQ6mL/6kEizSlNSmWmrDEXbXx+lbeOQ0xMPGuqE88jcUbBlbFDAUlEh3ezD752ipCL87zmY
	+bicqcObanSftJr6Dn9+lt3W/31I/Ug4gPDVH7+bPJ6iQoxmPReyNJweyPwB2lIaz8lALjFBVF8
	dm5hb0MhcwzbVaiNT1BVE7oYzo+FByqvrBkzdDVawWqHXhZ3rJJzw654GCJJoEL8I4r/2MRP6dJ
	qCH47wn6WsO+nlIckD2eHgZ7oGeXzwdcgLG4qNYXEHt/dIeMzWF1bVB8ZecjFunnfb9xaU+Uloe
	lZLo86a8G9YKnQrYyiU0VZ9TiAF24YdNjYWFjElkwIWwxTAxkxdFYu8QyiPs5ED590i4eZg==
X-Google-Smtp-Source: AGHT+IEMOMVn8rVVn/LrSUqLRsgPs8HrTr922RJlf5aayGldBVTuMlA9OhISdmU7x/PsUdxbw40paw==
X-Received: by 2002:a05:690c:680c:b0:71d:5782:9d4c with SMTP id 00721157ae682-71fdc3e0679mr159524887b3.28.1756222920808;
        Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm419060d50.4.2025.08.26.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 49/54] xfs: remove reference to I_FREEING|I_WILL_FREE
Date: Tue, 26 Aug 2025 11:39:49 -0400
Message-ID: <681053424e9eefe065dc689a325e94f79d0f918b.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs already is using igrab which will do the correct thing, simply
remove the reference to these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/scrub/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..b0bb40490493 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
 
 /*
  * Install an already-referenced inode for scrubbing.  Get our own reference to
- * the inode to make disposal simpler.  The inode must not be in I_FREEING or
- * I_WILL_FREE state!
+ * the inode to make disposal simpler.  The inode must be live.
  */
 int
 xchk_install_live_inode(
-- 
2.49.0


