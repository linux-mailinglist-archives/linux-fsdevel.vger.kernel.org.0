Return-Path: <linux-fsdevel+bounces-56172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACA1B14332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D8B4E41B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB77227FD7D;
	Mon, 28 Jul 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg2n9LbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFB27FB16
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734702; cv=none; b=jdAxivuS9Wc70loQEJ1w6RnVztWhm0zjd7OnAXRdXqvMim6XSQCbsM1tWxlEmtBl1dAnbjSf49vorczSFQ225Mq4XW23P424NjJsl6iXnic7e9eXfHn7STjeypjxgKyLD2xlp7MyCe2UuNzw/7FrDcArffr7j90it52sZ1p+dBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734702; c=relaxed/simple;
	bh=x5Nz15KXwUIsABy9dFJxBXLugqrRmEQkQIjmRIGsyMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmHK9viYZuOxMfN8EKDhNcgvcIMjJBymTl4jK51JZ8zXA9uKeqFzhvUbyKpk5GjeAeU4AIabH0wPCc02Rj4WfwG0tSurd1LQbfpXky2t8vTDbNOsDSd6TKvzO1yXh35LAmw8NIYK3MK/3CpkfQzsCDbRkbSi8W9zePymvujH4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mg2n9LbN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG3xbYkfyqe9KTbJIkVzQy7IvrDkvNxqTUGdcuAb7ck=;
	b=Mg2n9LbN7fi0cuwXmsltSt8v+n1cnrq0P67Cb/oy16u8YhU90jDYDX5ZMxC7iUZROdSfp2
	WT8JeL+8jmHnVVTfotDo5dtYgyDaR/WODGLg33H2gEt782A2soJdTrGXOqPA/FoKykNz75
	y3jtkR0gXofjlwNrk4h944WLNqMnkgk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-CXGhTcmONgK5eMdRyEh4HA-1; Mon, 28 Jul 2025 16:31:36 -0400
X-MC-Unique: CXGhTcmONgK5eMdRyEh4HA-1
X-Mimecast-MFC-AGG-ID: CXGhTcmONgK5eMdRyEh4HA_1753734695
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6154dc54644so959647a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734695; x=1754339495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG3xbYkfyqe9KTbJIkVzQy7IvrDkvNxqTUGdcuAb7ck=;
        b=YRjP/L7pS/UvJk8fBdMeF51WbtSe0+w9PMjF0sPHPNiwWckxM75qQ9jszGE01eMp80
         Cs7fJ7/AFNHWbjJR/OvL7FNxuaYdXylF5wzULjjojPX4E/uTo5fHA/57neRCrvNWCYMN
         eqGzKmqJOoxn5z92/Sno9tMStr4dVv+9f8JMcTFxZfJjpesL3V4cFg3OUh7qwGx6rZ+Y
         lj4Om8Y3WuVEYZDeY9aj6SDNKAXY55kho5zHW6nhLJVhwOZJSnzrZg7lftmHYLC1en7q
         KnVOzaqrCW3vEj48/DAtm0sdpsb+lpR/kk6ydZtwH75ag7mvb4T/GNSlJ0iY1ADMHwEa
         5goQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXMtRWeoVEQk9vXHpOXQWCtl3rqzJsIg6gnL2qtjd8LBcXTNjVukUOvQ/1LuwhYCf4fKZAxdp9bnKQpLqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrAaNvjKlkdFUE+RGAVxZVJ3qS83iIRRAIQVYmQbC9zCLJugc
	+vKqaIzzWaaxKeXjN/ZwLE6tkoKm7Rt4TS/9wHhMvvrQfxYPY808hnHNW3d0WcqmLHzHUedES7n
	jkjqvVyFw/BqxbAIF+P2PbXFuXLNSQksiQgGrk19kqCQrfMZcWjC1GnGIwUyy9pFkJA==
X-Gm-Gg: ASbGncupfBQ0dIpTwdbFNmZBbNDrn1GoLdR4DrNYtGkidP+03578aS1tw8EGLY/tLHJ
	O5itU9HDXV19d7zBXpC/OZAl8U7ul4lsL19Gq5lkvoov4ehAmCM0CMZsjLNUEZPRI2OPPkIDiss
	GqRgdLn2yUZd+H5SS+18A1we8aWhkYk97riUxNjwQYs6uPDYqqjYa+mvAj9N6Ez3sUcixbbbR/M
	pS6wskN5iqFkJxdsPjpr7I469QnR+CiWGDBW/QNRKtwhfu3/cml9US3h8/7kZxGV9KCRHMq6LG+
	w3P4IZIUQdJ2T6bbptg3Oo/9KS1Zx1HqIMseK99FCAokGw==
X-Received: by 2002:a05:6402:358b:b0:601:dc49:a99f with SMTP id 4fb4d7f45d1cf-614f1db598cmr12917544a12.18.1753734695380;
        Mon, 28 Jul 2025 13:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGslpLgFD2Wk4HYPGoKY6j2Y+H5h+F7xWmB6k7wiNuq+J2qJjWUKwsn2fyKFE6+B/xOhudYrg==
X-Received: by 2002:a05:6402:358b:b0:601:dc49:a99f with SMTP id 4fb4d7f45d1cf-614f1db598cmr12917527a12.18.1753734694935;
        Mon, 28 Jul 2025 13:31:34 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:34 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:18 +0200
Subject: [PATCH RFC 14/29] xfs: add attribute type for fs-verity
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-14-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3358; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=Roew8FJKORyBWKNq9tpryFTwDISUNruUQdRNGAZxZLU=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSXjMj7tmYCRmz+O04+a3zRtsbaoi53Eu82rd6
 HHfc5Vaj3JHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiXgtZGTY9DJQ30u/yoar
 Y80ykZmJC0RMvFb1Tfw+ey/ncsGEd39XMvx3SjnI375XeIXoRPslaT8uFzD4nZc+sollxhHOxm9
 35tfwAwAb2UWG
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

The fsverity descriptor is stored in the extended attributes of the
inode. Add new attribute type for fs-verity metadata. Add
XFS_ATTR_INTERNAL_MASK to skip parent pointer and fs-verity attributes
as those are only for internal use. While we're at it add a few comments
in relevant places that internally visible attributes are not suppose to
be handled via interface defined in xfs_xattr.c.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_da_format.h  | 11 ++++++++---
 fs/xfs/libxfs/xfs_log_format.h |  1 +
 fs/xfs/xfs_trace.h             |  3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 86de99e2f757..e5274be2fe9c 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -715,19 +715,23 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
 #define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
+#define	XFS_ATTR_VERITY_BIT	4	/* verity descriptor */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
 #define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
+#define XFS_ATTR_VERITY		(1u << XFS_ATTR_VERITY_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
 
 #define XFS_ATTR_NSP_ONDISK_MASK	(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
-					 XFS_ATTR_PARENT)
+					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY)
 
 /* Private attr namespaces not exposed to userspace */
-#define XFS_ATTR_PRIVATE_NSP_MASK	(XFS_ATTR_PARENT)
+#define XFS_ATTR_PRIVATE_NSP_MASK	(XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY)
 
 #define XFS_ATTR_ONDISK_MASK	(XFS_ATTR_NSP_ONDISK_MASK | \
 				 XFS_ATTR_LOCAL | \
@@ -737,7 +741,8 @@ struct xfs_attr3_leafblock {
 	{ XFS_ATTR_LOCAL,	"local" }, \
 	{ XFS_ATTR_ROOT,	"root" }, \
 	{ XFS_ATTR_SECURE,	"secure" }, \
-	{ XFS_ATTR_PARENT,	"parent" }
+	{ XFS_ATTR_PARENT,	"parent" }, \
+	{ XFS_ATTR_VERITY,	"verity" }
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 0d637c276db0..57721f092c80 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -1051,6 +1051,7 @@ struct xfs_icreate_log {
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
 					 XFS_ATTR_PARENT | \
+					 XFS_ATTR_VERITY | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ba45d801df1c..50034c059e8c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -108,7 +108,8 @@ struct xfs_open_zone;
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
 	{ XFS_ATTR_SECURE,	"SECURE" }, \
 	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }, \
-	{ XFS_ATTR_PARENT,	"PARENT" }
+	{ XFS_ATTR_PARENT,	"PARENT" }, \
+	{ XFS_ATTR_VERITY,	"VERITY" }
 
 DECLARE_EVENT_CLASS(xfs_attr_list_class,
 	TP_PROTO(struct xfs_attr_list_context *ctx),

-- 
2.50.0


