Return-Path: <linux-fsdevel+bounces-59266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9451B36E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FB91BA8A59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF33369979;
	Tue, 26 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EozQPsVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F9369336
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222900; cv=none; b=EK0xI2wqHhTQj7wBDAuFuAuzfQ/YR7Z4/JtWHaArrb/t5LIeN0vlgJlEgqoCZzoFAAjyriRcJR9ewSVxU/EpIAk+/remhKAQf8lnBqgHqPYUeX6yzHilFV0Gnjv8jGoTYE7+pfVRBAZeqoaywP34fmVdtPED7mxZCb5EAJvZj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222900; c=relaxed/simple;
	bh=BXlX6/e3FMWvwMNd0XczwC8NoieaU2IAVI9/xOw4ajQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc3cPTgPRhdDOxCoI6ncPRhACf305BB6G0fAi1YaxvSAMJNKgZnDXBWdkqdHtOFczaicPW+yDqHKJ8BTb7/KSNie2OuXUb+0Tg2ONe3dBi6wVs6Rji3dZCk+Sr5L6qL4lPDgj+w+LIv75/hB3W8HhOdBhuX1KMVfbu9bvi+FoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EozQPsVp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d6059f490so51939087b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222897; x=1756827697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INSJnyvPg2WRednM7++OGWJKHeVt/LRMVDwrRwGwm+I=;
        b=EozQPsVpDqvP6qhtnb5+TIdQFia/oOY7o40GTMwU5MrnqGP+eQX2uDl1Clwz7TmnOA
         mLpIz43D06MCeQ9rmM53PGlsfxLfdtqkJm0DJk+faObSqnD5DGx4RlZ8/YVa4mfGD2ub
         XcZW1YnPpNpwK/oYEZtKHkQ8xNje8sduDljkT1iYM0T0tfytUgufU0sX+fbEu4j1M1NZ
         C1LbB28AeO440O8XQmCNpCt2ToOiM1H21LaF6TlNlj+Gykz8inKgwjG3nyN3r+JpLhPl
         pbqXZPFFnY5tI05E4Xbw7V2v7O6HA2gA4haIK231XNSyizV1CT2JuYPQ56Efy30YnNb4
         YvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222897; x=1756827697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INSJnyvPg2WRednM7++OGWJKHeVt/LRMVDwrRwGwm+I=;
        b=C9d0kI+AF/ixXo+MxHcaZbYHuCX40xJggd5MmhogBPbA/DJHIR1+v7uIrmVKWBjiN7
         hG7uff2FP4ZAV6YzxitcwufkumnzdQYXR25NqFrZZtgKhXHN/6AFQPMbmc19GzPcCkPh
         RvUrYfUS4vKNy0/6U8NXgARZhq5cYRyMJb8vPE4tsYW5PcWZJ/sGb976DAuoT7b0fmKo
         JEO+9xRs1SU5nv1zfjvSj7MOUz6g/afXMNzY8McADyK+xPtIgc9+tUfMY5b1X+3yLbTo
         n9Y99rrCsZS1ShxPKisYOdrAfGzo5G86cLa+UItFA8HtvotsBCyAQsyNag91mX18/JT1
         nA8A==
X-Gm-Message-State: AOJu0Yzlbl2ECswdwOdhFQM1mv31VkjOEpWOBcj8oX9yOlHT7RM4zPF9
	3E3ue6xbiU4s8f9AK7HNz3gZxFEcBDuvoixXqGz6Di68PUEzXqCDRZTA8vKbdWBZXEdv00M86Gd
	Gdrrn
X-Gm-Gg: ASbGncspMeDgsy2u2cBRjbSSwZcHLSzI5GJT4sJNhK4bJ4LR5FGRu+6OJL1ITWUUJdk
	IoLDTPdz9nPfbkULIaBsoPj/TkNnC1rvqK3amewNmIK8WvpsNRYef3XiiDF5oXvYRWwNTIqquAM
	VOQvsDhCc9TH9mR7HTqANCzSz9LKmy18Nox52w4uuQlmnbIVojsxlzuRgD/Cr+qvIEEh6FrUTVu
	bLsLINfMEB6JNF9XVUkQS75Xuk/jhM0NDLpsf0QJb/s8fYTrQUl1swURwg9MUAMCyIiPskz0lrP
	W6F0fr4JXpJXVixQ7kfy2HWW3pcGvxRnznI31pau9BcLA81HgJUuDsc7lR/NIo8ofxRbOlW4lYb
	B4IG8ArjHU4sHWSv2RVxuEmuae8MHBOQW8brMxswerPW5C/AVN2cb4wXLj1gjm4DQSgi5CLNfpt
	gtD+5P
X-Google-Smtp-Source: AGHT+IH7pEeTz6Uz6BY9mq83w3WefooqttZ9snitZUIdAl5ESrBe4f30t0FX5yPTibQ5HgYDSnEUOw==
X-Received: by 2002:a05:690c:d1d:b0:710:f55f:7922 with SMTP id 00721157ae682-71fdc40106dmr156858857b3.34.1756222896947;
        Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff170323esm25307497b3.3.2025.08.26.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 33/54] btrfs: don't check I_WILL_FREE|I_FREEING
Date: Tue, 26 Aug 2025 11:39:33 -0400
Message-ID: <af647029b7c50d887744808315c2640bae298337.1756222465.git.josef@toxicpanda.com>
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

btrfs has it's own per-root inode list for snapshot uses, and it has a
sanity check to make sure we're not overwriting a live inode when we add
one to the root's xarray. Change this to check the refcount to validate
it's not a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb9496342346..69aab55648b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3860,7 +3860,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!icount_read(&existing->vfs_inode));
 	}
 
 	return 0;
-- 
2.49.0


