Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7373921B456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgGJL6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 07:58:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbgGJL6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594382291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAOXmVWgoczSuOlfXxBAYA4BAGAkdUAmIONdRmDi7fU=;
        b=ZiVc9Lrjg7ReYJcQPsFmHve71fuCzEsGs+B3MvNkD9omQ2lO0VIr+Boelfg8aHuMjNzbb9
        xAz+Zh33nauJlK2oQabo0JaHi+sOlOyfO52rjSVjiY0ypTOeYA4pr4r0Gssw1xHL90Lcqt
        RlJhasf4oxeySbebPOLfBINEnidhVis=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-8nB1mRDiO8yRCwWowf70Fw-1; Fri, 10 Jul 2020 07:58:10 -0400
X-MC-Unique: 8nB1mRDiO8yRCwWowf70Fw-1
Received: by mail-ej1-f72.google.com with SMTP id a26so6178667ejr.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 04:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAOXmVWgoczSuOlfXxBAYA4BAGAkdUAmIONdRmDi7fU=;
        b=aPrAl563/dpGaUh6dIloBpPl/DhvUw+ySzEvSACPSlGxz4r/GdkJnu1b3DceqNkohq
         x/XyCV2h97+cr70giDxyAL3PPWTVqI/jxZgzEflNX4daXwMo1dViqlvAct+M26uZKyNb
         ZZeznoW9c2JIH8ZVAt+rbXgCO7KSMJiN4LhuI81qZ9harOGQExRg6gfe39qxm9nYv+4b
         gvGUvs3EnUCZ3ELj9NZ7JfU9NeYkeroNPp4fy1BTe8GavoXdSjeqDGewWn53nF1FoHcq
         m7ErMi/NcIdHEvGjFdmf/Czr4EybqzNXxfsYM3sCmLXMdYgvicScLGx2BmwJImZaTAX3
         gzGg==
X-Gm-Message-State: AOAM530NSgsf1MI8cvoGQed9iyKTnLoRUCNfinCeRZPGU0lgwoOyMdIZ
        ldWhhj8yrmqjs4rLo+Ttc4MbxnbMngqbiGaaaqwmO2Zu62+pCZHVle23T7rRpFyRSWo84covjl2
        wwyOLSsbYdM+mkcA8qi1fm7ZibQ==
X-Received: by 2002:a17:906:cd2:: with SMTP id l18mr63295734ejh.18.1594382288908;
        Fri, 10 Jul 2020 04:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTEnQRlfNnkfPFFldvYN1w1+dgGHdWpPHvYgpL+8iT4dpCcLKqV3BiLsKe2MEEqovgVDMfZQ==
X-Received: by 2002:a17:906:cd2:: with SMTP id l18mr63295724ejh.18.1594382288749;
        Fri, 10 Jul 2020 04:58:08 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id a8sm3536951ejp.51.2020.07.10.04.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:58:08 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Stefan Priebe <s.priebe@profihost.ag>,
        David Howells <dhowells@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] fuse: ignore 'data' argument of mount(..., MS_REMOUNT)
Date:   Fri, 10 Jul 2020 13:58:04 +0200
Message-Id: <20200710115805.4478-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200710115805.4478-1-mszeredi@redhat.com>
References: <20200710115805.4478-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The command

  mount -o remount -o unknownoption /mnt/fuse

succeeds on kernel versions prior to v5.4 and fails on kernel version at or
after.  This is because fuse_parse_param() rejects any unrecognised options
in case of FS_CONTEXT_FOR_RECONFIGURE, just as for FS_CONTEXT_FOR_MOUNT.

This causes a regression in case the fuse filesystem is in fstab, since
remount sends all options found there to the kernel; even ones that are
meant for the initial mount and are consumed by the userspace fuse server.

Fix this by ignoring mount options, just as fuse_remount_fs() did prior to
the conversion to the new API.

Reported-by: Stefan Priebe <s.priebe@profihost.ag>
Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: <stable@vger.kernel.org> # v5.4
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index be39dff57c28..ba201bf5ffad 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -477,6 +477,13 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fuse_fs_context *ctx = fc->fs_private;
 	int opt;
 
+	/*
+	 * Ignore options coming from mount(MS_REMOUNT) for backward
+	 * compatibility.
+	 */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
+
 	opt = fs_parse(fc, fuse_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
-- 
2.21.1

