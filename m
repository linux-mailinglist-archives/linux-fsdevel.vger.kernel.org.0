Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B862D165F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgLGQfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727678AbgLGQec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YovU3sr3PaW3+O202/CGPLg5GcG7AOB5YNKN3Gg/9CM=;
        b=eY//RxJ9+AOqhRGCGP3FFBiltTNprKHjjyFG/yj1G0J5SmOgBmsKRHw7wFynTs7rKVRSaz
        H7YyNA8z26sLu4y5+h1x/f9vr5rhB8AZErvh0pgD8iX/wpygC92whFS3n0qw9y9rKO6BLM
        L5smGVo13fzvlfGWgjC4ryuscIG2q/o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-6p7sW53jPY2h843hVvuLzg-1; Mon, 07 Dec 2020 11:33:04 -0500
X-MC-Unique: 6p7sW53jPY2h843hVvuLzg-1
Received: by mail-ed1-f69.google.com with SMTP id bf13so5987886edb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YovU3sr3PaW3+O202/CGPLg5GcG7AOB5YNKN3Gg/9CM=;
        b=inIwpgJBdB/EcWo7Fqi5FDQKWMzfAVb2Gr8zogu6tBfyv2nDWd4Qz2O2wyAxgComAn
         AQrTaA1pKYD0cvmTLfdGvD4b4my1aDEf9yIfaQrxNHHeAuiLYGZILH1jzSZWf/0Z2gDp
         g+qqEeA9CdN4B14loRHczm7Q4nEEYPZcxNCajGd7nW0jBBLnswfH2QepGDDCisOwO+q3
         g0ng54rkLLWyvV2ocoevLxcNSE/ZbXnnn3LVgjK6aeu4rQjoTFiSLcodMUu+AoOD6NJT
         11fspwStPaU7e23zjDdEeemix5potImgLTYoHChHrP1qbaix/re70cL85Rm6HZaVqUa3
         w5Iw==
X-Gm-Message-State: AOAM533fbHGCqEc7nRTK9or1KW14dsRVI3+gRi0NyV29qJGu12KL5DJE
        Xt/7iVq8h51iuLad2Wil6w6ZsZ2rWRf/LN31kvzq/6KJb6TNtcfieJ+zeCyYuwvoVqN67b7lAPS
        BgJ1Cp6DjNA/viBa9qGkFhomX2A==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr20047770ejb.354.1607358783580;
        Mon, 07 Dec 2020 08:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRh6Xa+5iZaFkMzkShNmnm8HMI1mEJZ43C03cBXKlr6CObJxEgF3paS8CuYV44ij1yPUSsGQ==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr20047758ejb.354.1607358783452;
        Mon, 07 Dec 2020 08:33:03 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] ovl: check privs before decoding file handle
Date:   Mon,  7 Dec 2020 17:32:48 +0100
Message-Id: <20201207163255.564116-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CAP_DAC_READ_SEARCH is required by open_by_handle_at(2) so check it in
ovl_decode_real_fh() as well to prevent privilege escalation for
unprivileged overlay mounts.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a6162c4076db..82a55fdb1e7a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -156,6 +156,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	struct dentry *real;
 	int bytes;
 
+	if (!capable(CAP_DAC_READ_SEARCH))
+		return NULL;
+
 	/*
 	 * Make sure that the stored uuid matches the uuid of the lower
 	 * layer where file handle will be decoded.
-- 
2.26.2

