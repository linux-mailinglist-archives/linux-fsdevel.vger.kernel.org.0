Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56EAA8312
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfIDMgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 08:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfIDMgj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:36:39 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45D02796EB
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2019 12:36:39 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id l64so22903800qkb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 05:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y7+4jzmWO4GQ/wOMEZ/4ITLQiTP1h3eEC+zHNesrpcA=;
        b=q+1DfYjzN2p/bM4IDm+4F55LFOeoZPYqbkdREPBODzQdz0BJZbeFGP1NgueHn1KzRP
         s/sKjcXk17Iw3VvNhcboaWuJGuF4OdE5Wqhhcocqw81Ub4X7cOd5F+c3+JlZZUKEtb5J
         09jfsaqCwnlDVvfGA9GXDW+wv3PF89t64DwTQiOWZDp+RXwDF50DB7i4QzzGTaq6I4d8
         fNlsYQG5U4Uq5AVZzwBWwZ8kIPoKF3Bojr1lA5xZCxhX1yHTt5APz91ccKISqZdylKJ7
         OxqrqqaV/IJrzGZaOeh2dbqcbVSB1lc1a3Y35Xlgfd2NI7lzj96g6UbNnvJXMyKjx2/h
         2woA==
X-Gm-Message-State: APjAAAX3PK6Lo0wxbzgv9+tAj7PoCUa7PAcvjP5pWxpgPhueUUToGZZX
        o+iTT4XuFcBJ8BG3YG6kBvYbeh94A5Q7MOBvMrtzi34SbGMPuWvRzRWz6uGw8KCBDelQIsehOnX
        qc7GzRIMDqd7oxBft3Q4QTj1YFg==
X-Received: by 2002:ac8:5388:: with SMTP id x8mr37130970qtp.26.1567600598619;
        Wed, 04 Sep 2019 05:36:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEZra2IRRbs1ImLBTb5SFO4EmzxasydlkHZDaR00UT9cJoLOJxESMOITKvTaUwBGo07h4nzg==
X-Received: by 2002:ac8:5388:: with SMTP id x8mr37130953qtp.26.1567600598487;
        Wed, 04 Sep 2019 05:36:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id s23sm11658356qte.72.2019.09.04.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 05:36:37 -0700 (PDT)
Date:   Wed, 4 Sep 2019 08:36:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH] fuse: reserve byteswapped init opcodes
Message-ID: <20190904123607.10048-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtio fs tunnels fuse over a virtio channel.  One issue is two sides
might be speaking different endian-ness. To detects this,
host side looks at the opcode value in the FUSE_INIT command.
Works fine at the moment but might fail if a future version
of fuse will use such an opcode for initialization.
Let's reserve this opcode so we remember and don't do this.

Same for CUSE_INIT.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/fuse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2971d29a42e4..f042e63f4aa0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -425,6 +425,10 @@ enum fuse_opcode {
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
+
+	/* Reserved opcodes: helpful to detect structure endian-ness */
+	FUSE_INIT_BSWAP_RESERVED	= 26 << 24,
+	CUSE_INIT_BSWAP_RESERVED	= 16 << 16,
 };
 
 enum fuse_notify_code {
-- 
MST
