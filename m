Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644B14B88E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfFSMad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36968 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbfFSMac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so3213138wrr.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vz+znNR3F5kjJHoZn9Crk81ccCGx1/tiF7Xfm+PRQVc=;
        b=nkheu9B/7aEURQMMqQuchxG0miiWUHHQNpz8MZLHm+x+RLDTi/n/hLnNtdlAOnzF09
         TM5GhswmWpSRfnidvUvMZ9Y6mR3sDtSnMb59f/9Uq6xer8BMrAUXjjj2Mi+2ugzwHArc
         9U/pf+xTZkJU3jNORp489Y5rV4y94dDgzsvHLe69aIg3a9y+nx8lAt0/9rTyScHdAQ9Q
         xR1bLh/z+8XY8TTy8+sYGSF1gpdbR3MG5jq//JSEwFsR/yrrLIRC5uNjnGCqySSaABn3
         kNUofnVc4DlmOAKLOD7/g249gl8G1INW6DKH7z92v01CTXFeyaiih2nYfwadBWpDjZoJ
         9Q2A==
X-Gm-Message-State: APjAAAUXttAnyZsn12ltQZU+VkNt0tq3wSJXI6LnxJqQXxsjUP4R48DE
        /MbyhhG6G6DftPHFXjq/s3E3svy18ao=
X-Google-Smtp-Source: APXvYqwz5ogA7h2G+mp6k4mHrwtXmsKu8SbTaB/WQVZOvIU+slS295oTNMYD8Kyv4OO88vNv8l44ig==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr22487471wrv.63.1560947430518;
        Wed, 19 Jun 2019 05:30:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:29 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] vfs: don't parse "posixacl" option
Date:   Wed, 19 Jun 2019 14:30:10 +0200
Message-Id: <20190619123019.30032-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike the others, this is _not_ a standard option accepted by mount(8).

In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
mount(2) interface is possibly a bug.

The only filesystem that apparently wants to handle the "posixacl" option
is 9p, but it has special handling of that option besides setting
SB_POSIXACL.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index cbf89117a507..49636e541293 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,7 +42,6 @@ static const struct constant_table common_set_sb_flag[] = {
 	{ "dirsync",	SB_DIRSYNC },
 	{ "lazytime",	SB_LAZYTIME },
 	{ "mand",	SB_MANDLOCK },
-	{ "posixacl",	SB_POSIXACL },
 	{ "ro",		SB_RDONLY },
 	{ "sync",	SB_SYNCHRONOUS },
 };
-- 
2.21.0

