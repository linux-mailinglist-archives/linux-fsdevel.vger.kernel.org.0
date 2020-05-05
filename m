Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F581C5257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgEEJ7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728701AbgEEJ7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+1b61fIVNzRxmSBvn8JceIfr2zwI2o+5DSP0I2MUjY=;
        b=EbRzAqqOyW5fgpkNurjrDpMC6JKN3C2g/usN9tN/EOBSd622sDaBy/UZfxVB/2ywzvQpes
        SjHya1FKPNpk0zWXwysKUOoZkLmUWcQnoXjdfsSl0wweSJn/ixOk5GDfuaaZl6Xfoj06NV
        G3ivWg5+Sd9GhOWT3WrM0iExxop3pVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-DlXe1gAiNNieto8e13FjOA-1; Tue, 05 May 2020 05:59:32 -0400
X-MC-Unique: DlXe1gAiNNieto8e13FjOA-1
Received: by mail-wm1-f70.google.com with SMTP id 72so1060763wmb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+1b61fIVNzRxmSBvn8JceIfr2zwI2o+5DSP0I2MUjY=;
        b=W32TOreeezlXAhr9oFfNOnm7M7dO7F9yaDfHPFn5XPBUsEV6m3NjBYFjMLr0YivKNK
         rEpWF9hCYdCJR9zSVWeHQT1+h+nU8pe3VChW2SsUETTXAQMeeSJ7TDfWdClVK36aMs0f
         9ortV5gzxiCo6hFnWPHH442YNobnqy6t80fK8HtPU2LJ8sO8q3hGR+AXZEvDT34Mn4Gc
         h1fTFlDIdVnvlyfUuu8rkkD4LLhfNyQYhQ4E4BqfSvOXQ6CL9wffzDpgBaJEnpdsscNs
         Q3VWMRqyjYbzOOqP/dI2+23X0KxUVZNsXJvuGac+zBNK4QMWqlRVgy7WyjxYugkjyiXb
         DJTg==
X-Gm-Message-State: AGi0PuYrKwp9XpJcsD//DEol4TXT5EOrdeSx9f34Tak1tAp7qqZ9VSCA
        Sv4miLP6zOZA+CtK7crZ37MOk2vOj226ye7/U1FCMCoHV54rqEABdOmhMfEoFaKnDhWq0iLzHQ7
        pmUR8pTDZ+68Yofossn9WVRudlA==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr2255991wmi.64.1588672771523;
        Tue, 05 May 2020 02:59:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLVtZmeTj2ECRlDJWx4w0RMnjQr8z+ceKqshfy/tdfv2YG6kV2nYhcysbYO4K2VvQijKq+SOg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr2255978wmi.64.1588672771323;
        Tue, 05 May 2020 02:59:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:30 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] vfs: don't parse "silent" option
Date:   Tue,  5 May 2020 11:59:15 +0200
Message-Id: <20200505095915.11275-13-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parsing "silent" and clearing SB_SILENT makes zero sense.

Parsing "silent" and setting SB_SILENT would make a bit more sense, but
apparently nobody cares.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 82019569d493..7d5c5dd2b1d5 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -52,7 +52,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
-	{ "silent",	SB_SILENT },
 	{ },
 };
 
-- 
2.21.1

