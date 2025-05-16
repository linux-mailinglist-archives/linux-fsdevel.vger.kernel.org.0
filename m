Return-Path: <linux-fsdevel+bounces-49297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECCEABA3C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B316AC69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B2226D13;
	Fri, 16 May 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOP7t6Ec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35F1CEAC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423693; cv=none; b=XSryzSUhJnhTzrDB0gZwJEOP1sbDOg4NyqmYWT4NwgPnjHyFtgI3kq+ojDJoleT4nddyaRyGJgrezrUYuDQaiXA8vEqM2b+HGw4I8tMsXyGtZaXKenF8utp6/ft2r6ANw262w9+GsqHp5od49izY+PFitfumhT+Q0K82cG+B4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423693; c=relaxed/simple;
	bh=doC0C9FuHlnU3HJ+BrbpGIuYaY5ADywA4krzyLA62Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKT9RTzOx+yJEOYTcqRbY4dEyMhIKbKcDeln1Zwy4LN/r6oIY8xLlyahMqKayo3ddHneigT+8b7vkPCYmG17IFlsj+j7LfNf1w5VpCgM78dXyIQGErrx93MP8p8KtXrFF81Iy1MQ7s2Cx0pxTNmzW/FYFNJIj5fbiP9rRr2IvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOP7t6Ec; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad52d9be53cso228320266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747423688; x=1748028488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TAyDGwn1qRuxYLt/VZ9jh0xi58B7pkPr18aYRJgglQ=;
        b=SOP7t6EcyiAYnMBTKh6AO+6GndX9UrIMTc3dZEaCgaDpPu2ooIDUmIhFvj7Hj1y/jg
         H43ITKzENdT+ksPWFPl6rnqascucN1Schjdklz+l0P6maYTOl5BcXUO3Uunr6rX0j15b
         l+XklSFIY7Nx3vqTcvWb1ycq+yHFLqLoF05xrv82INhYLQ7pQ5zAKup3X9OaxW6KFNCf
         fFxRwlSbFXPgnA1lYJC9b6jJ8yozUee/EpwpsMSrTdRBNYC/FHjuwCVa9VdX6yyN++5U
         EJsRRtlrCHE7+6d43ZIYUPvtGIn4IgH37tbkE0c+cV2VmZkqYQKRfqKjHqIs6TU1dzck
         gOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423688; x=1748028488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TAyDGwn1qRuxYLt/VZ9jh0xi58B7pkPr18aYRJgglQ=;
        b=wk8QTnliWc/4gxTCFxubYceDe0xC0qVbMKoxZIC4kk0sz1V3fIkSf5aU8Vgrx2Cw35
         PbLVNGHWE9U/ah5Xph2CYDIJA76WvAP3eFo1N3Kjk4dj7VE/B8ZrZ85e596PbsuvBwGM
         phSzu19DXwxwA/p2BSbqShloLGYCfW6VsH31SLf2nXzZxEiNW9Dk14RHEOmkXYsvgU58
         dHmpiyq5kQhK538596zGEKTbGXRnctNgwFPb5V3qAHTki047gK34fSnVa3UnzIEHmA5f
         fBqfU8B93PWpNG5RPwjiFTArqFDCo0JyhIrQXyhTbv3qhpxRpI245adUAnXRZl0xXg4p
         TJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYk+2M/QQD4KU0AvwFeTo6383h28ZDUqsWvp5LJagUPG4Pi+1IlWkwzTUsOI44UlLZjI4w5cLelh6omfXP@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGG+EnoD4q4yOuYg8RREGxd693xaXC0VXulO9W8Grd98ldwON
	tXhRoQd/Rk+oLcHEzA/yqjJDysMzU3XIRCcK6XVn1xZWvUlVclnLFZeo
X-Gm-Gg: ASbGncsE7udnm6MhUX80egaJrGOPpGjbPbCO/znpEIjtdO/EYgxpqYEHjikunlrFBxm
	NQekxracMdPRUTplv7FpuF/Kd5G58Fep1FJ/bXLaB1ZMcmP+ftg9jzVe7BCsG17BQY/SFbeezK8
	F20P2c/VGxUjT5sdRCZOdnQli8mzyIowIaSL6yU4GDByzUM3sUgqDS3mi64cfkmmaEiIQIpdNy+
	e05ou2haOX8b+P3uuqXeTIF5MCdYGtkGkadFS1z5bNbvwu1CpCuroNXoLBUStBs9HPH857Z7tJh
	13O6iskeXcE1astdbrtRJuOa0TOhSx7693hqQJ4fof8Tx6mti77YYUzVn3S23naBRIt8FGeCVeH
	o1IWYddP/oFlkWnB1MqzoWuARiK/+dK8AV0K+qsno2wFtncVy
X-Google-Smtp-Source: AGHT+IGB1t0tBsrDxulWr1NXKMVTmLcV5xqXbik33ymiS1UckW2l2OU89J5TzOGAmrnxp3HfFJNDoA==
X-Received: by 2002:a17:907:97c6:b0:ad5:e0a:5891 with SMTP id a640c23a62f3a-ad52d467000mr468022566b.1.1747423687627;
        Fri, 16 May 2025 12:28:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4466e2sm201075066b.93.2025.05.16.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:28:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/2] fanotify: remove redundant permission checks
Date: Fri, 16 May 2025 21:28:02 +0200
Message-Id: <20250516192803.838659-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516192803.838659-1-amir73il@gmail.com>
References: <20250516192803.838659-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARK flags are already checked
as part of the CAP_SYS_ADMIN check for any FANOTIFY_ADMIN_INIT_FLAGS.

Remove the individual CAP_SYS_ADMIN checks for these flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 87f861e9004f..471c57832357 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1334,6 +1334,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	 * A group with FAN_UNLIMITED_MARKS does not contribute to mark count
 	 * in the limited groups account.
 	 */
+	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_MARKS));
 	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
@@ -1637,21 +1638,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		goto out_destroy_group;
 	}
 
+	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
-		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
 		group->max_events = UINT_MAX;
 	} else {
 		group->max_events = fanotify_max_queued_events;
 	}
 
-	if (flags & FAN_UNLIMITED_MARKS) {
-		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
-	}
-
 	if (flags & FAN_ENABLE_AUDIT) {
 		fd = -EPERM;
 		if (!capable(CAP_AUDIT_WRITE))
-- 
2.34.1


