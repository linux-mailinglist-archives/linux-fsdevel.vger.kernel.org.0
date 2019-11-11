Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4FF6F05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 08:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKKHaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 02:30:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42372 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKKHaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:30:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so13378359wrf.9;
        Sun, 10 Nov 2019 23:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NY5K7XoiMGGUj/e5AbZmCH/5tz6YlPNT7ys8PeCHnBo=;
        b=eTKTmUVKe+sAUtiEjIll4p0x9ja0Q3uLF/osiHU5V5KowU6Kv9LUN4XeYfcRmvSjqf
         McUAgNxxQSxCSXG7XVtan1vNw0rj1wbcmx2Zqt0Os2cD68MUAA7vBnR/On94FFcf4dgN
         FpyAgYyQVr81uXnsJumM2b58bOeBHw8lrcX1kzHOq9N+B1Gmn3GWKBBxcDgwxSaa+Yow
         RUL/76g0l6khK3o07kA8fpfkegCYg7d0LyaCs/+57FWeIFcmsyRpkDB2Lbe7tuBReXZv
         9aKReHYw4+CO2WWoyrrfinmNnX9RtLUzq8bxlJIHJAhLwhSAQqTsSlMMA3/ylGs/RkC7
         Z6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NY5K7XoiMGGUj/e5AbZmCH/5tz6YlPNT7ys8PeCHnBo=;
        b=bufWZGvvJ85j/gadD6Fp9cfv6lDETnAUmXQ13j84Itf6kxOhQB1IcS18Wn3LfKDz2i
         9N+U4aQNT9Z7PuegZ8/5iIFfPusGuBO29NqgHUsbUkIimpfomBOJYxgTHqFsBVURmcVJ
         YRuMpzpt9mIMJ+dZxFBX7PMmiveTt/323Puo++j+Bcg8dEWE6OYLugFIb4XMq5an2J8d
         uFyV/qnSQGm/5P7aIWyiO1bCBbb9ry7LXPUhHUGEgdXSn3+CoEIMNv9Df3iHNIn1rf+R
         Sfzfim20RnHTyWSmvJJiG3WfNytAL0HhndDrA8lWGu/J8DHusDo1RVYAiZbb0GlIo96A
         e/7A==
X-Gm-Message-State: APjAAAXTkrxwDLvtWFIkKvr74RnyVWES+qQXyo3jYN2j9yMHQE8dOHR9
        +EiliYfdLsJ/cxIBP0v0r3c=
X-Google-Smtp-Source: APXvYqxRMATLlDFdxdTENYHygL9EJBYTfK+n2ZhiW1zS3MQ2uZBQQBxovLiP+oDNDjNuRVYoT4yHng==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr18500662wre.332.1573457407820;
        Sun, 10 Nov 2019 23:30:07 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id a6sm18960800wrh.69.2019.11.10.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 23:30:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: fix timestamp limits
Date:   Mon, 11 Nov 2019 09:30:00 +0200
Message-Id: <20191111073000.2957-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs timestamp overflow limits should be inherrited from upper
filesystem.

The current behavior, when overlayfs is over an underlying filesystem
that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
overflows post 2038 timestamps instead of clamping them.

This change fixes xfstest generic/402 (verify filesystem timestamps for
supported ranges).

Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

(*) generic/402 currently does 'notrun' on overlayfs and need
    a small fix that I will post shortly

 fs/overlayfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5d4faab57ba0..44915874fccb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1621,6 +1621,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 
 		sb->s_stack_depth = ofs->upper_mnt->mnt_sb->s_stack_depth;
 		sb->s_time_gran = ofs->upper_mnt->mnt_sb->s_time_gran;
+		sb->s_time_min = ofs->upper_mnt->mnt_sb->s_time_min;
+		sb->s_time_max = ofs->upper_mnt->mnt_sb->s_time_max;
 
 	}
 	oe = ovl_get_lowerstack(sb, ofs);
-- 
2.17.1

