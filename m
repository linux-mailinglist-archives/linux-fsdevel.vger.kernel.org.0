Return-Path: <linux-fsdevel+bounces-25469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193494C54D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA5B2515F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928615F3EE;
	Thu,  8 Aug 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="29sC+ltb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293A16190B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145319; cv=none; b=t+0fGxJ53TwNHcRcaN1Gww2WMcTnc6rilUJ1tsUk/81kBRF2dblVOFM089K3oHRVUxeXc3Kc6aJta2xpMnE9NivvFtQ1ifg8WzGp3oEXjlQ3y9YK0moXo1hGJZ1gpabD8BLDe3ivgNdjQNuap4aqaO4WyBPbbPIOyViD7OsQW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145319; c=relaxed/simple;
	bh=NX0d0m9ReKcqhm2PuSfHrLPH/9MXqCB++0q0ouz1III=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5aVF3yqca5lXNFIWEa71bQqOGvutD+bu+qdMQpaC05h5EHm+9UZjBBG/bXOlKcuPWYhXgdHSzt+Gi8xjxgCuGDj32nWBaZJtWDnFkeh8xdKFE39FEE1uQdk4YGSHySNP5AB3DlsP+92P87YEccCP1SoqfgB8DWH7kT2Vd2IC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=29sC+ltb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a3574acafeso64713085a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145317; x=1723750117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCXucMs8l0Ng5ZAiC85xGGR8b9zvUxCeXymlHlDJx8U=;
        b=29sC+ltbU5iX2JBtHMLxA26nSnqffvsQSu/RiKgpp8dohYTjNSFMvLexjzp32dAxwf
         pN4x/JGhe2I32IkUIpJa8cWW5laN4dFagjdmZA26JVAbJocrw2QY4j3vB4LEjO7dFHct
         VmWvo5sRbdY3FGIHBX/HQbrdIS9n9MA5xusFIS+XB5jvOdwAX82M1w0/RpCwcjj678KL
         j/0L8k90Sqbh72gbjtPrIlVMu2Ajelnmy8TMx2RaAd8plHIW7NdzJmd7wytyDApKFkFs
         h+UteWF72XcQRUSln0/NvOFGEMSxUzao6HH7EDfEAGmtDYuuOByZK5nQRCS8nsv53zat
         sRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145317; x=1723750117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCXucMs8l0Ng5ZAiC85xGGR8b9zvUxCeXymlHlDJx8U=;
        b=aRX810/cVaPRI/YDZkYvF/zFAQvBOgqNDe52kLv22I9QqQmk5n4v178m1zQPaouF4W
         w//0Y/2EwHsW1/sS+M4G74HzGYLl6lJftdoOmYnx+/VM6BKZVlUIZc0IscYeqEecdoUE
         38BE4FOVjU9amOJfZ00qN/xvQu2FSx/NSWUqFm1RB2eJrGJieR4R8+eJ+Bh+PNulQnEN
         RZ3Bz/vtsEoys6OwULx8Tf8YQ9UA2/BtzGTb0B/mMomL2Ikh1HezZpM6X1oqpG4qsZ4w
         zWnowjIj1NnDFMZx+l+rdfaJ3+oiLhWsgNsKx2S05RCKnTBBS3uDvRbX6w0wX2AcJ883
         UFjA==
X-Forwarded-Encrypted: i=1; AJvYcCUK4XcoQ7ocAQx20uJ9w2FUIOpz6+nXFKB70sTB3vZbgUuBte4eXxuPv3umMJajm7iXleTgAGnU4ktmCVLPM4AksabXCKB9IBzsgwmSSQ==
X-Gm-Message-State: AOJu0YyzYqFdtSWMHu1wtZZH+EDvSGUerIS1W+7E66WodESG3g5CP2bi
	a8Tv/NWrj7/KviwyuK5IKlri4dhSh2DaD5/J6ZHmcFxJu8bUAxokuV28Yw002Pjvg7MYAjFYGjd
	c
X-Google-Smtp-Source: AGHT+IFqTokrODzDW+F7aRkm8RWDe1d2EvLJDXo8zz/Qi7NPVBOa+VCzv+goifozXKnE/sORJ8j7uA==
X-Received: by 2002:a05:620a:3943:b0:79d:7246:ea67 with SMTP id af79cd13be357-7a3817f799emr380397285a.33.1723145316678;
        Thu, 08 Aug 2024 12:28:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786b5a15sm187770785a.101.2024.08.08.12.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 16/16] xfs: add pre-content fsnotify hook for write faults
Date: Thu,  8 Aug 2024 15:27:18 -0400
Message-ID: <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..585a8c2eea0f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1325,14 +1325,28 @@ __xfs_filemap_fault(
 	bool			write_fault)
 {
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
+	struct file		*fpin = NULL;
+	vm_fault_t		ret;
 
 	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
 
-	if (write_fault)
-		return xfs_write_fault(vmf, order);
 	if (IS_DAX(inode))
 		return xfs_dax_read_fault(vmf, order);
-	return filemap_fault(vmf);
+
+	if (!write_fault)
+		return filemap_fault(vmf);
+
+	ret = filemap_maybe_emit_fsnotify_event(vmf, &fpin);
+	if (unlikely(ret)) {
+		if (fpin)
+			fput(fpin);
+		return ret;
+	} else if (fpin) {
+		fput(fpin);
+		return VM_FAULT_RETRY;
+	}
+
+	return xfs_write_fault(vmf, order);
 }
 
 static inline bool
-- 
2.43.0


