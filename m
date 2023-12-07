Return-Path: <linux-fsdevel+bounces-5152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C4808AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493831F210FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A034437A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFN3RQ9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA010FC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 04:38:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3332efd75c9so790265f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952717; x=1702557517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkTRJy4JeCFBLG3CMd+4ebO5lvkwqEblB9voYoMpPs8=;
        b=LFN3RQ9A+fzRN6fbKYZSkoZ5A46QVAnbLQd6daK5tfUWdzMa0zkGj+bSMsjdzb2RAE
         na8vdEnwPicD3xedxWYGBS5KyMcbeQtTPmhQF+ajoAtPCmNkvhwY2R28ysYTCsRWStJi
         F3xIU8bx8YU6bse444jS1r2lKvW8KnwtaAvqBOcvEpWpUGeCZcscSfoWTsa9HrPJZcjC
         vqF2kPmPTUTMdlX1Ac5ZGHvvFBpw/lR3RDBBJHQKpzGcfr2h2lnTzaAEYL+gTa5Mq/5/
         8xB0RG+V4dpn/yynFCizgFJuUKpnkGw4dTIdri7YnpS2QUhhtnpyepo/bU1rWmM9x1aY
         SPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952717; x=1702557517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkTRJy4JeCFBLG3CMd+4ebO5lvkwqEblB9voYoMpPs8=;
        b=AZAECnlZFuExOZ5E9GtI+TgXzQi/H4Mno7LRAwovwSAzpS/PqDKHunwfZw44gchSpZ
         Z1OjLPZGx+2s+PN+lc/3J1LvdPQPmGbUkidbSb4S0TjeFDqESDy0orz7i5ttEMd9Jc6E
         ojXg2Rv2N7vglpWk6zCNq3VWMafVbfpFurawRMsmg34jUKSIa2E0fJ1lz3XG6wo1U8jF
         gchA8F7RinoK5u1F8EDknBfs+A5Bx2VNziQmk1HZc1QSJG8CCHgkzz1k1VA1eFNj50fM
         lVOTUSz7swvJD7q0eIBDLVrnl8rAZ/cRFgRQw/8u+SjEmzCB6S6to/RSetggxaCLaVzI
         Uweg==
X-Gm-Message-State: AOJu0YyAAvdqZJDRw0lpSVZaROByDOgKmEzH2oaI0bvHW7xaEHFob/L8
	khI2KL3ywmUjFY0ejwT7vRwWhcbHvKA=
X-Google-Smtp-Source: AGHT+IH2WMZPjXOWZc2zx4h+mLzuppi1FBU8vqbDZWky0l0vndRiRbsJgzrlBNUcGI73AxTEXCsI7w==
X-Received: by 2002:a05:6000:174e:b0:333:3117:c46e with SMTP id m14-20020a056000174e00b003333117c46emr575559wrf.255.1701952717344;
        Thu, 07 Dec 2023 04:38:37 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003333abf3edfsm1332431wrs.47.2023.12.07.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:38:36 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] fsnotify: assert that file_start_write() is not held in permission hooks
Date: Thu,  7 Dec 2023 14:38:24 +0200
Message-Id: <20231207123825.4011620-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207123825.4011620-1-amir73il@gmail.com>
References: <20231207123825.4011620-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filesystem may be modified in the context of fanotify permission events
(e.g. by HSM service), so assert that sb freeze protection is not held.

If the assertion fails, then the following deadlock would be possible:

CPU0				CPU1			CPU2
-------------------------------------------------------------------------
file_start_write()#0
...
  fsnotify_perm()
    fanotify_get_response() =>	(read event and fill file)
				...
				...			freeze_super()
				...			  sb_wait_write()
				...
				vfs_write()
				  file_start_write()#1

This example demonstrates a use case of an hierarchical storage management
(HSM) service that uses fanotify permission events to fill the content of
a file before access, while a 3rd process starts fsfreeze.

This creates a circular dependeny:
  file_start_write()#0 => fanotify_get_response =>
    file_start_write()#1 =>
      sb_wait_write() =>
        file_end_write()#0

Where file_end_write()#0 can never be called and none of the threads can
make progress.

The assertion is checked for both MAY_READ and MAY_WRITE permission
hooks in preparation for a pre-modify permission event.

The assertion is not checked for an open permission event, because
do_open() takes mnt_want_write() in O_TRUNC case, meaning that it is not
safe to write to filesystem in the content of an open permission event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 926bb4461b9e..0a9d6a8a747a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -107,6 +107,13 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
+	/*
+	 * filesystem may be modified in the context of permission events
+	 * (e.g. by HSM filling a file on access), so sb freeze protection
+	 * must not be held.
+	 */
+	lockdep_assert_once(file_write_not_started(file));
+
 	if (!(perm_mask & MAY_READ))
 		return 0;
 
-- 
2.34.1


