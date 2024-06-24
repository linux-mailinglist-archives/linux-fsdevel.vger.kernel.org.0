Return-Path: <linux-fsdevel+bounces-22268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48C915750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D945F1C2169D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6491A01DE;
	Mon, 24 Jun 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="StkhaujT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6C1A01C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258069; cv=none; b=J7DFGn85nB2AiBCDWIB3uTXa5fNaaRzJVg40hutM6ZFZoj0rhl94R0IS8UxV/fI49Sml4oLEFRWUiP0Jg0ZMpZSdwjIUMFcKRUw06JFJJMAjtL1kdER0v8v0LcafZ00+MnmQaKYd52mlMPVFaL0giVSNFErNMxPfFmwY24VC6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258069; c=relaxed/simple;
	bh=EDrVeoczXRFadBjIWVglNHvO9PwxYV8uZVBtdcaBlxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ikMjbjb+XuzoNmMKUU6N4YhBh1fmYeHizSj7RaHFsWC+DG699s1TdQgxWRC9ab1Af4gtIWGEJ8/bK5PORlwptBX49Lz/WRCBIH+4NJdan9vVERKc7/UQTEgHemZkXImpS4YwtIx94YozSFRlvhyy4QtOLqIgOJYbBhQ+LucaMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=StkhaujT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7953f1dcb01so466004285a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719258066; x=1719862866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXXKNSSrWJ0YcK2tSaPFa+liDAb5izhDoCoPKTAfQjI=;
        b=StkhaujTAzRcu8cTqHDdvB20jPm/pMgrA30HToLmrXMiRt2u//swREkl8barZZ+8q6
         8i3jvoq1/1wdWk0is+FkD8PSxxGvUSqBbxsOqz2SVTu+K0qy/TihCsmPrxowaBG833wr
         Xn+lttpM4qSQvwE4vnj9SCwre/ipJ5XcwksxqVXmP/vK5YGetj6I6f1ObJk0Kv3Tv6Om
         6w/kgjVfVw2VfhglcVXQPHHvsC2Zi1H9V3y2wooAjTMuk6jLMXJTDC/4u58gzApQE6VA
         gBS1/AvbhgCPf0FMT5NCI7rctVoRxYraYIFiwTMojs9o4Kue/snsdsOEujBxsGdc/CMV
         admg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258066; x=1719862866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXXKNSSrWJ0YcK2tSaPFa+liDAb5izhDoCoPKTAfQjI=;
        b=a43Xn58F25J5qK8df0aYmHYxwI+1as6xmbltgEdc/A7FB5oFSyrhvvrJp6vPmgGKVq
         hbqoElFBlAP0f/q/iyvLmqStetUUYWK69yYBJ6noyhh+zmbSnEI+tn/fOThroJs8zfJm
         xzo4qh5EbgwGPCbkEMiPdoyYr/f10R6cKA4ZEwIG49iM/3yINIL9yoiv2Oo+XRIzGQyR
         7GPE2SKycZbm5a3WI40OyV0M95UECvPYwL9fEr2NJpw0v1o4e7h+pNO5jLEf5LiylfdY
         TMJ6phvXjfugXw+0jF0pTi/Yv4sVLQ02CNFzbXDHDVVB2K3odhQ9w/WX6wVckvcxgy07
         FD8A==
X-Gm-Message-State: AOJu0YwCSxfv6pWfMpiEn9V9Ro6W297ZGTUQoAuQe9b4FYqh0lEfUiEc
	3Z2pQAHpuW6NkAiIY3LOrxE06YKtPOGxsbPGdAV1X72Wg1lZmFqBovlehLlFOrUVmFzqmUx/Acz
	7
X-Google-Smtp-Source: AGHT+IGlQvXsFh08sReZA1YwLHV+NSpbgWuHUAfW1JctZwHC1y/o14sSS8xWOzSlcemDdr2Q84cEKA==
X-Received: by 2002:a05:620a:2992:b0:795:be0f:8fb1 with SMTP id af79cd13be357-79be70456c4mr683405685a.66.1719258065899;
        Mon, 24 Jun 2024 12:41:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce934550sm339537385a.114.2024.06.24.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:41:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/4] Add the ability to query mount options in statmount
Date: Mon, 24 Jun 2024 15:40:49 -0400
Message-ID: <cover.1719257716.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Currently if you want to get mount options for a mount and you're using
statmount(), you still have to open /proc/mounts to parse the mount options.
statmount() does have the ability to store an arbitrary string however,
additionally the way we do that is with a seq_file, which is also how we use
->show_options for the individual file systems.

Extent statmount() to have a flag for fetching the mount options of a mount.
This allows users to not have to parse /proc mount for anything related to a
mount.  I've extended the existing statmount() test to validate this feature
works as expected.  As you can tell from the ridiculous amount of silly string
parsing, this is a huge win for users and climate change as we will no longer
have to waste several cycles parsing strings anymore.

This is based on my branch that extends listmount/statmount to walk into foreign
namespaces.  Below are links to that posting, that branch, and this branch to
make it easier to review.

https://lore.kernel.org/linux-fsdevel/cover.1719243756.git.josef@toxicpanda.com/
https://github.com/josefbacik/linux/tree/listmount.combined
https://github.com/josefbacik/linux/tree/statmount-opts

Thanks,

Josef

Josef Bacik (4):
  fs: rename show_mnt_opts -> show_vfsmnt_opts
  fs: add a helper to show all the options for a mount
  fs: export mount options via statmount()
  sefltests: extend the statmount test for mount options

 fs/internal.h                                 |   5 +
 fs/namespace.c                                |   7 +
 fs/proc_namespace.c                           |  29 ++--
 include/uapi/linux/mount.h                    |   3 +-
 .../filesystems/statmount/statmount_test.c    | 131 +++++++++++++++++-
 5 files changed, 164 insertions(+), 11 deletions(-)

-- 
2.43.0


