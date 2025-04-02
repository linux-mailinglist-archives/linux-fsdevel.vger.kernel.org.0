Return-Path: <linux-fsdevel+bounces-45494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9AA78812
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 08:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5ED97A3F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E169232373;
	Wed,  2 Apr 2025 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em2CMvcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5141DB13A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743575233; cv=none; b=MxbWmdz5+SOpabGdelYpfGQStxlSCDYiTfXYncOJyeZf1/PN9sV6oEr4jUTPPkaCAYMsCnWehxHEqkBbuhgjs/sDvG549oKIM59XqIJmZfULUOIvVGrLlx/S0uYhDNBQQq+y2+RKmTLEW1KfgLtfFbaVczIZoTbzGY6XrV9lQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743575233; c=relaxed/simple;
	bh=Lm1A2srMFH6zPYntYyZXtbydjDYEL6f3MTqnRltdOG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keinEMDGtOvvnRA88JHh0BN6zP0beXzsqqtAX3mWuC3kkybRQlK3+MxE3Ch+n/DdGob9EhbkxWDRhzJWgd8oGr7mRtvwpKxvV2sAiRjy420+Sl/goZIod+ZtifsaD0esy8I+Wfa/OQXfEBgvcUwA0G05hxXWAgLKjQTiiMSSbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em2CMvcr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1135050966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743575230; x=1744180030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjIB/7kjMRpYvulq9RcpshpzL/fC3nFGReB5MLuPLmw=;
        b=em2CMvcr2eptVPBldGYRZ2nO/gUEYIgvjZ8Ol56b0UHKq/oGwAmj5gGqDS1U0fVDYr
         8eZKHjUk48ZqYyWfEqTW8NMs5hCY7BsVwzlscdesTLiMNC+6Qay1K5a1CSutdOomtFSD
         hHjvel6Ls1gu5JWpXlAs9TDFxXxOw9g2VlubXFIFVG1GSGsGtlvgiSPrN17BKrxKKNgD
         v0EbewwS8PyV7LbmT0YnDPWT14xC/Lz3DA2T+hRXBRdreizS9kMX/sgM3HgVPYV3KaG0
         54SuKT4vobQx1UkSVViaiTNr8emBdu59BFnWAxcjm43hLhNqCmux9g9AuT74tCbazef4
         U7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743575230; x=1744180030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjIB/7kjMRpYvulq9RcpshpzL/fC3nFGReB5MLuPLmw=;
        b=b/6pD7ym1B3DHD9MPSCNU9XgItavi9522U8k8aN0/3uJBXN8Hc5nt19WAbBODB7145
         Eb5C5vtgTecdecHSjvF13zd7FZdnVvpgycKQjJ9jv5NrOw0DoX1qRdOpQjq96LL2ax7E
         UBLcthsU+hGos7rgrEwor+h8mGOAsWQ1Z0tCyKLzyB+2DwpCvsV3DadpuhQVUo/yBR4e
         2zAQSM9mt39w9bJtP//q8CDYSrW00hKpOSxqGlykA1h+8AUGG3HEw/eYr8ElcLzVVhHn
         f+0FQTt/Acru+2KQNNSvdJE/wr3L20C/vrZOjzu5Ru6P37cP9xvIkVQqAmdtNktx+iqk
         zcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBQi4HEG+aOtfUuj4J7SC4b+SAqj6lbkvTl4oSqx0tbez4HSOnRePRCnN6tzfcslNE2PQNJuwNyRKFrD+q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz732Seiitp3BfiXs2yXuS2nl1fU0jgwuVwDMR12P8Y5M9zXRMC
	rx02GTJvSUX0ENvIrzeBr4Kyqa3Xxq/71eO/70+WAMYoyRoUOk6yC8x7TcZ0
X-Gm-Gg: ASbGncuqe6T+Yv+ZYYFBcrSN+Pq4xs8nH2ddf+3SHWHdxuIfzYKdSNlLgWVirYgB/cr
	8YWpiZNCekHb83U++/KhRA/pH03twhZa4m4tZve053eLXWFmBBCpVM+XufWdlKgtpRs/iFafiC4
	moC4Lwdj+d2uef1FYe70jcECOSWNsbUy8TAIHuzMIlYVYRSdhnh5L221RDIaIILn/YXCp2JtLoc
	bVTXW7OxGChalBuzwUlz1lRe85BP/7i9q/orLU/qtXijh2njq1kwavoEa1vByVU+34J/kiAj6ps
	TLpukQl5TmLKLmf0Y27BM/gPmF+xbV3ZX2QuDfipg/LF7ILXSZ368Jgd2CgrTQ4XcUQKmSmnLLX
	IakaAZgGFMPIHPMXj7JjQYt5LU4EC2zG2duWvAVp8XH4ZMepAo3ra
X-Google-Smtp-Source: AGHT+IGO8BkLNcjmB7Mh7lU9FBaQcIjDFcSNkCFeNYn8mCGnvwcqAa+Xx4Z1Vs5Ql5TS60j3bLOewg==
X-Received: by 2002:a17:907:1c13:b0:ac7:81b0:62c8 with SMTP id a640c23a62f3a-ac781b06490mr560540766b.31.1743575229716;
        Tue, 01 Apr 2025 23:27:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196f7a6csm873843366b.176.2025.04.01.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:27:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on directories
Date: Wed,  2 Apr 2025 08:27:07 +0200
Message-Id: <20250402062707.1637811-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like files, a FAN_PRE_ACCESS event will be generated before every
read access to directory, that is on readdir(3).

Unlike files, there will be no range info record following a
FAN_PRE_ACCESS event, because the range of access on a directory
is not well defined.

FAN_PRE_ACCESS events on readdir are only generated when user opts-in
with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
readdir report the FAN_ONDIR flag, so user can differentiate them from
event on read.

An HSM service is expected to use those events to populate directories
from slower tier on first readdir access. Having to range info means
that the entire directory will need to be populated on the first
readdir() call.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

IIRC, the reason we did not allow FAN_ONDIR with FAN_PRE_ACCESS event
in initial API version was due to uncertainty around reporting range info.

Circling back to this, I do not see any better options other than not
reporting range info and reporting the FAN_ONDIR flag.

HSM only option is to populate the entire directory on first access.
Doing a partial range populate for directories does not seem practical
with exising POSIX semantics.

If you accept this claim, please consider fast tracking this change into
6.14.y.

LTP tests pushed to my fan_hsm branch.

Thanks,
Amir.

 fs/notify/fanotify/fanotify.c      | 11 +++++++----
 fs/notify/fanotify/fanotify_user.c |  9 ---------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6c877b3646ec..531c038eed7c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -303,8 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignore_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
-				     FANOTIFY_EVENT_FLAGS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
@@ -356,6 +355,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * the child entry name information, we report FAN_ONDIR for mkdir/rmdir
 	 * so user can differentiate them from creat/unlink.
 	 *
+	 * For pre-content events we report FAN_ONDIR for readdir, so user can
+	 * differentiate them from read.
+	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
 	 * to user in fid mode for all event types.
@@ -368,8 +370,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		/* Do not report event flags without any event */
 		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
-	} else {
-		user_mask &= ~FANOTIFY_EVENT_FLAGS;
+		user_mask |= FANOTIFY_EVENT_FLAGS;
+	} else if (test_mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		user_mask |= FAN_ONDIR;
 	}
 
 	return test_mask & user_mask;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f2d840ae4ded..38cb9ba54842 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1410,11 +1410,6 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		return -EEXIST;
 
-	/* For now pre-content events are not generated for directories */
-	mask |= fsn_mark->mask;
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EEXIST;
-
 	return 0;
 }
 
@@ -1956,10 +1951,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
 		return -EINVAL;
 
-	/* Pre-content events are not currently generated for directories. */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EINVAL;
-
 	if (mark_cmd == FAN_MARK_FLUSH) {
 		if (mark_type == FAN_MARK_MOUNT)
 			fsnotify_clear_vfsmount_marks_by_group(group);
-- 
2.34.1


