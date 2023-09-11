Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E790479C103
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbjIKUxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbjIKUBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE4211B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 13:00:30 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-cvYAhfKWMqmfcrNkbOtDYQ-1; Mon, 11 Sep 2023 16:00:26 -0400
X-MC-Unique: cvYAhfKWMqmfcrNkbOtDYQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ab5129ad9aso1212410b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 13:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462425; x=1695067225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7k1BCCMhUdMc7MBxV2Fkz09e2OQ+XzuBURjAWODFmw=;
        b=AJui02cZXgAl+19lNO/ei/fcFT7nAbdR4xJnk6npaBCzFxeDfre7XP5iWyrytUkFDx
         lsXSDnuE9cLU00LCwfIfBaMj1sDNUphU2EEHf/bR/vJ6R+1qN3HHfkMy6ckkNDQHnKW6
         9wn0NELWOEQDMP3OMst42MzeShKJtIUj4kWxrqC5ezqKkWWojKU133UxOfE7Yd2MJLlY
         kthbCBwai9jqdDrW+gwXEpBLHzkPuJHq7W1FogBQp5lKRijDcsOS0Ah851KAIQ4fz5Sp
         NTuISfQ6ABR6Z/Wqnhro6iPKYXJkxssGNzktYT1yzWUySWAgtyZeoDkrOri+bCSnsD+6
         eruw==
X-Gm-Message-State: AOJu0YzaulhxVSKL3OEgJZQYP7rTM179EaOfZC8sDhItxcQ4l+o7IQLm
        bkk2QsZEfr0p/hI2m+OX9a4foOWaRZOXtZRyaR6h6djFYElfRlqeHuJejNH9l8jdJt9XDvcUqx8
        xRzIlewRFOFaxZgSUa0+2tK1E9w==
X-Received: by 2002:a05:6359:6393:b0:139:fd45:5db5 with SMTP id sg19-20020a056359639300b00139fd455db5mr8262764rwb.1.1694462425128;
        Mon, 11 Sep 2023 13:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLSLn699Uw0nOKsm/qG04I1zHHRgNNS45OC8Q8LJ5yPwlslg4FRPCQrknANhYmqNDDC0Bcjw==
X-Received: by 2002:a05:6359:6393:b0:139:fd45:5db5 with SMTP id sg19-20020a056359639300b00139fd455db5mr8262746rwb.1.1694462424820;
        Mon, 11 Sep 2023 13:00:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id dd4-20020ad45804000000b00655d6d31470sm2273025qvb.43.2023.09.11.13.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:00:24 -0700 (PDT)
Date:   Mon, 11 Sep 2023 16:00:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 2/7] poll: Add a poll_flags for poll_queue_proc()
Message-ID: <ZP9x1vRGE15CHaKW@x1n>
References: <20230905214235.320571-1-peterx@redhat.com>
 <20230905214235.320571-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905214235.320571-3-peterx@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:42:30PM -0400, Peter Xu wrote:
> Allows the poll enqueue function to pass over a flag into it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

A fixup for this patch (should fix all syzbot errors):

===8<===
From ba55ee0539a7a80b98e7a5e3942c0ee8cabe5f73 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 5 Sep 2023 20:05:33 -0400
Subject: [PATCH] fixup! poll: Add a poll_flags for poll_queue_proc()

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/vhost/vhost.c | 4 ++--
 drivers/xen/privcmd.c | 3 ++-
 net/9p/trans_fd.c     | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 02caad721843..00813db53ff1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -152,7 +152,7 @@ static void vhost_flush_work(struct vhost_work *work)
 }
 
 static void vhost_poll_func(struct file *file, wait_queue_head_t *wqh,
-			    poll_table *pt)
+			    poll_table *pt, poll_flags flags)
 {
 	struct vhost_poll *poll;
 
@@ -162,7 +162,7 @@ static void vhost_poll_func(struct file *file, wait_queue_head_t *wqh,
 }
 
 static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
-			     void *key, poll_flags flags)
+			     void *key)
 {
 	struct vhost_poll *poll = container_of(wait, struct vhost_poll, wait);
 	struct vhost_work *work = &poll->work;
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index f00ad5f5f1d4..43e65186f25d 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -914,7 +914,8 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
 }
 
 static void
-irqfd_poll_func(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
+irqfd_poll_func(struct file *file, wait_queue_head_t *wqh, poll_table *pt,
+		poll_flags flags)
 {
 	struct privcmd_kernel_irqfd *kirqfd =
 		container_of(pt, struct privcmd_kernel_irqfd, pt);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 91f9f474ab01..2912c4b086a2 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -545,6 +545,7 @@ static int p9_pollwake(wait_queue_entry_t *wait, unsigned int mode, int sync, vo
  * @filp: file pointer being polled
  * @wait_address: wait_q to block on
  * @p: poll state
+ * @flags: poll flags
  *
  * called by files poll operation to add v9fs-poll task to files wait queue
  */
-- 
2.41.0
===8<===

Thanks,

-- 
Peter Xu

