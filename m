Return-Path: <linux-fsdevel+bounces-1253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903477D8646
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D18F2820AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA137C88;
	Thu, 26 Oct 2023 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0N6GyBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26C2D03B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:52:33 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E42AF;
	Thu, 26 Oct 2023 08:52:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d9b507b00so796707f8f.1;
        Thu, 26 Oct 2023 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698335550; x=1698940350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLwv5flNVsiaVz0MGDwMlr7NgRA0cXHcqK+i79WYra0=;
        b=k0N6GyBHqrVnmLx/vkFVPzK1hgv4qzryG5tY0YX2z9i3H//Kl27T0678nhUXWMtyaY
         BH8RLt39z5nJa//9uzfh9ETZbgywaEQHSTJWnXY7DnKyxoblidcntFaIybNJbjssa3sC
         liEOwPIkTFF9plFhFLIVriDm0dBQAf2nZqn05yMYM+NKgd0ciN8vCMWPVuig/JVlT2l6
         RB0lWYx834daM8gcQS++1F87NaroTXioaoKFnnlr/kD9yutQFnBiH7doJ4bWysd+cGHe
         hi2VKvIEG+XucHs38KS5jgnXhrT5STQ6/5qsg0l5dv6f6W0EwwZ+B98+PSoCefXgkBo1
         CCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335550; x=1698940350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLwv5flNVsiaVz0MGDwMlr7NgRA0cXHcqK+i79WYra0=;
        b=I8dj//XXAkhWF0SQ6j2+Ik3PZlhYfKzRZWYek3O1xAZ9GUK/WmHSZ+o8qnZnxdoo+/
         nDhgJlvSOgAFhqPk0frkOVZSrYKbWLxaom14kgheD1lIg+EU1XMYBQseZGxQJd9uZBxk
         zFFdZXzlvO+k64TFrun8QmHoUYS2YblacKP/yg0sjK9deeAt2GktxgrFH84q1debh3Sm
         F9/hvObukuSloTcn7ILVswFyMEn5FaiSoY+h0OtHnCY6nPGEI+tHtZ7uk32j2cGJWDg7
         edWAssvnFONY9Ko/HohMTgbJfVtzd4QRJeCrgkhnUIPg4bPyA7Fe5bBiGyoEyV8P5E3V
         7rcg==
X-Gm-Message-State: AOJu0Ywf9WTwCtCfOL3FZsdbDEpVaAZql7J41H6YQn0QIzyz53900acr
	eU+OEWT8MLCBTf8NPBkJ6s8=
X-Google-Smtp-Source: AGHT+IG8QNcu3SGG8ks1KMICgejWG+xzDqvXHl+PwS4mbbQHm3qsCOAf+I7IigIsvxvWX2Y7RGBdcA==
X-Received: by 2002:adf:f487:0:b0:32d:a10d:90dd with SMTP id l7-20020adff487000000b0032da10d90ddmr31119wro.50.1698335549707;
        Thu, 26 Oct 2023 08:52:29 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00326f0ca3566sm14609838wrm.50.2023.10.26.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:52:29 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Date: Thu, 26 Oct 2023 18:52:21 +0300
Message-Id: <20231026155224.129326-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

As agreed on the review of v1 [1], we do not need any vfs changes
to support fanotify on btrfs sub-volumes and we can enable setting
marks on btrfs sub-volumes simply by caching the fsid in the mark
object instead of the connector.

This is the would be man page update to clarify the meaning of fsid
as it is reflected in this patch set:

fsid

  This is a unique identifier of the filesystem containing the object
  associated with the event.  It is a structure of type __kernel_fsid_t
  and contains the same value reported in  f_fsid  when calling
  statfs(2) with the same pathname argument that was used for
  fanotify_mark(2).  Note that some filesystems (e.g., btrfs(5)) report
  non-uniform values of f_fsid on different objects of the same filesystem.
  In these cases, if fanotify_mark(2) is called several times with different
  pathname values, the fsid value reported in events will match f_fsid
  associated  with at least one of those pathname values.

Thanks,
Amir.

[1] https://lore.kernel.org/r/CAOQ4uxg9wjESoCFNDADbneF0-nW4xVHHV3Rhhp=gJwAs=S83dQ@mail.gmail.com/

Amir Goldstein (3):
  fanotify: store fsid in mark instead of in connector
  fanotify: report the most specific fsid for btrfs
  fanotify: support setting marks in btrfs sub-volumes

 fs/notify/fanotify/fanotify.c      | 21 ++++--------
 fs/notify/fanotify/fanotify.h      | 10 ++++++
 fs/notify/fanotify/fanotify_user.c | 31 ++++++++----------
 fs/notify/mark.c                   | 52 +++++-------------------------
 include/linux/fsnotify_backend.h   | 18 +++++------
 5 files changed, 47 insertions(+), 85 deletions(-)

-- 
2.34.1


