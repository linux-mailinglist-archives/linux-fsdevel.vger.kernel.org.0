Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA44D2D1643
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgLGQeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727811AbgLGQem (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE0m3vgq1/OaRAwZjvKOK2ey/mE38mR/q+wtN6wib9s=;
        b=Eg87k5igU07VVyU7gpntFf3poClRUjMOlw7v0GBPEorMtynYOXsofThHhUeLdb1V6DxNjI
        /JLlV88aynvZQ5Dc5aj3pw0U1aLb3J69TrXmEQScAGoinIL6+JScwpbTn+6XSdKges5l1t
        DaAC9Bu+/wJggHOT4WG4Ej477iq1RCQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-45VGdHYhNlm5LXG75mpyHg-1; Mon, 07 Dec 2020 11:33:14 -0500
X-MC-Unique: 45VGdHYhNlm5LXG75mpyHg-1
Received: by mail-ed1-f69.google.com with SMTP id g8so6030036edm.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RE0m3vgq1/OaRAwZjvKOK2ey/mE38mR/q+wtN6wib9s=;
        b=g8Fv8r9R7mifCAV1mKrlhJS4FFgna4NBEoj8fZFik0U8c8/dVhWbQV9V6RgTNG0o8E
         ef5jt2zI+QcobVFLBKPU+AOTMR2X6NXB3BWs1iy/SqU+g6QwCFMNQe0FAugEx2y51meG
         mjRIe1TvvuZb7b0MCKZAnPENZYnwEJ+zZaOr7fr3mu0aS70Q/bk9RtT46//K5YVM0gaR
         HO+lotei1S4tb5gVSfVT7HCMJ6OC3x8FPUySPfTAxXs7KDg7NePMgz9Q3+cotqBTezap
         B6jryZHApyuHe7OL5vh5BzliGcK8BvgjiVGYaqbipVpF8c7y8xX5i0Jrm0V5sMqueOcr
         6PLA==
X-Gm-Message-State: AOAM531BnDXxgxEcLU5CDcV+I0lD8clFiy8iTDOmThLZERoS1f72zgxL
        9ucsRn9rNXuBhudi6bdVCBwgP8zZ3Zsai6CPn4XNITDEr55Z4pivUvSSB3wlsAXug/eT433B4iU
        oza9oZK1UiQjaDXaKFpsXGa77HQ==
X-Received: by 2002:a50:d74c:: with SMTP id i12mr20512779edj.236.1607358793439;
        Mon, 07 Dec 2020 08:33:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZo9cLo2B/sr3LytBzOfhCP7NvepbgDDGPqp8OuSqAKVtWfqlfy6nWwFOViRsEnP4mLzJm9A==
X-Received: by 2002:a50:d74c:: with SMTP id i12mr20512764edj.236.1607358793260;
        Mon, 07 Dec 2020 08:33:13 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:12 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] ovl: unprivieged mounts
Date:   Mon,  7 Dec 2020 17:32:55 +0100
Message-Id: <20201207163255.564116-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable unprivileged user namespace mounts of overlayfs.  Overlayfs's
permission model (*) ensures that the mounter itself cannot gain additional
privileges by the act of creating an overlayfs mount.

This feature request is coming from the "rootless" container crowd.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 189380b946be..019e6f1834b0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2073,6 +2073,7 @@ static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
 static struct file_system_type ovl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "overlay",
+	.fs_flags	= FS_USERNS_MOUNT,
 	.mount		= ovl_mount,
 	.kill_sb	= kill_anon_super,
 };
-- 
2.26.2

