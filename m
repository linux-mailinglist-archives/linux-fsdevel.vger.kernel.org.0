Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773644B860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfFSMa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34203 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbfFSMao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3235668wrl.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nQV+HbwwVC5JDcFHvgQnxZlAQ2DeroGpuSkk8jd0Tk=;
        b=lMsGq3SrQyPmVErvJJxZRUXt7yjGvJmsagjwV1SLeIK1S1UE/nItGYdACZPDWNddSw
         1MWEa/su9thg7q1A8LG/tFdjFEJESdT2mfGiINqv/l3a/DcvYNHgy6ErazcDHxCUJNg+
         utGl0Lws6AaINUO60uhWuzF8WShekd8GISCgj8g3svguOn2+2kX2EB0m+In59zZcHy8r
         vP035v+CCb/eDZzXZocJFzjLz75Jr9TdeBgxUO9ZPDbqrpbsdn3JvYQfK+vzSL0WDVd2
         CFSgrXZ3WxXez4YGBBTz8QYA6WXMyQTPIwSDyApGU7yBW1k1qy86Cd5mmVE5w352xfx+
         yKzg==
X-Gm-Message-State: APjAAAWsEyzBkG2v3IT8lAF/9Q5KPhnYWcrHJaCfFyOXJ2dpX+2mB8xQ
        wxtdM68iiPtNU/8G0PzDgPwIsQ==
X-Google-Smtp-Source: APXvYqzHsHTMP8Vjwh/pAfZnm0GsX3Los4ghw0Tsr9S1GdEGtjlvPbrdctjrtSZCkpbDaeO0HjA9Bg==
X-Received: by 2002:a5d:4908:: with SMTP id x8mr18266350wrq.290.1560947442583;
        Wed, 19 Jun 2019 05:30:42 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:42 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] cgroup: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:17 +0200
Message-Id: <20190619123019.30032-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the cgroup filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 kernel/cgroup/cgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index f960e6149311..1f50d59f7f4e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -929,7 +929,7 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int ret, opt, i;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 93890285b510..f2e86b3942b3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1836,7 +1836,7 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	struct fs_parse_result result;
 	int ret, opt;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

