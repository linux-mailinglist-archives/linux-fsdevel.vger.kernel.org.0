Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F112E33AB0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 06:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCOFiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 01:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhCOFhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:37:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC01C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:37:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j6so14717171plx.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aYq0J+9b4tKDZXBHw2wOWvtavxgBRahDPr03liFECw0=;
        b=puwumHcKmr61wNYUFotpbK2IfHnTbHcpCnzievNuhMmjO4+Eo52l2U71CPjXORPQz0
         YWaZVO/rDFNIZGuUgdkCM/DYmhSJACrGuGbgZ96S0h8GYCQo6udNxn/gTu3jjeOrPW7W
         hVbFsIw4Q4NwTZtm31kC2rzC+rWg9rO4G5tG79ebQG6fU5JB9zEI0EEx75Cx+YFRO6IT
         As3HPa1UlB63m9oLqpFab0cmMrrodrVeOKP/AkxkFjU5tWMyxjzRvXIYkER++lr4Q7zv
         l/oDALFuxF6tADxCV5wqSCQc+zPtkKBdt0k5n/nVcBHSOyLMB23OQQcHkXC8zoumc/tL
         RIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYq0J+9b4tKDZXBHw2wOWvtavxgBRahDPr03liFECw0=;
        b=sASqcIgdX2tLCiyoNe70sno277Wu7p2Oztt/xSKv5D4g6ERiRsRjcYM/FHyO5oaePF
         EgIzYVjz/Se3HuJj7fhni6owrr6jJT1IVIAsmBanQl8ffp8IktQagIx6ule66TUjUIyd
         gLF5AvrP0ZXCl3u5ICeO2Trzjnhh8MbJUrgdnphHZ0xKKul3ZgTa4ANpektcoDiovv5F
         UcIGORaFkjotb5nUK/tGaVv8EEMd9AkBcLXjUKRaOqBVSkxvPSD4tCIzTe/s9jFelbGy
         w0Aj6dAV/0AF53zi25a2gCJ7SU8SvF4TkPbH3qYkc1ZH1cA2ME0oFYubuhFwbCfXGV9/
         hm/w==
X-Gm-Message-State: AOAM531b1NE2+PfZfPYC5B4G2p7fzNcU4tRZ0/faqKGeI4LNWraEIEKB
        RbECv2df0kSgguJfXDauaFt2
X-Google-Smtp-Source: ABdhPJy4+A1RYkcNV8xwLGkTiZKllYZiilY4Bu0DGetxutWdy9edDqFjAl4qPO0fDEr21OfnR4xE2Q==
X-Received: by 2002:a17:902:ecc3:b029:e5:d7cc:2a20 with SMTP id a3-20020a170902ecc3b02900e5d7cc2a20mr9865008plh.11.1615786674068;
        Sun, 14 Mar 2021 22:37:54 -0700 (PDT)
Received: from localhost ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id h16sm8544215pfc.194.2021.03.14.22.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 22:37:53 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 01/11] file: Export __receive_fd() to modules
Date:   Mon, 15 Mar 2021 13:37:11 +0800
Message-Id: <20210315053721.189-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315053721.189-1-xieyongji@bytedance.com>
References: <20210315053721.189-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export __receive_fd() so that some modules can use
it to pass file descriptor between processes.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index dab120b71e44..a2e5bcae63ba 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1107,6 +1107,7 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	__receive_sock(file);
 	return new_fd;
 }
+EXPORT_SYMBOL(__receive_fd);
 
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
-- 
2.11.0

