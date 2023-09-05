Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B932279311C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbjIEVnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjIEVny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF01AE
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFjFRpr2tLumBDFqT/D9Qiro5EdrVpMUq8hDA8RT3eI=;
        b=YT8lAwKSFpQErl1edaTjvaGFNMLsR729J/06Z/XByeMsTxRvHgn+Glq2u9xOgttYZHAoZv
        Hk5DFFfbqKF7oCMeT0pFRLQ4BIJOcWqc5+/F+ZHm0xR+6G+t0Kfkva1VOkWThWWcsve2Ul
        ixT6bWYb5IXYaQdQsEMsVW+bNQ5oko0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-wpO3ATzzNM24fMD9RrORDA-1; Tue, 05 Sep 2023 17:42:41 -0400
X-MC-Unique: wpO3ATzzNM24fMD9RrORDA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76efdcb7be4so82010285a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950160; x=1694554960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFjFRpr2tLumBDFqT/D9Qiro5EdrVpMUq8hDA8RT3eI=;
        b=ZwqIRL7tfHwE66VdnwhBsunqlMRq4dB0QaTf6yEdzcPbFX8D/PT46FD7hnA+IcmHEi
         lfK7XZOnXHYwUxENFSDGk5O8+LgDV8G5bj8idFD/cABW1YAwrkp69EctQhyNnOoJzRlB
         2mYsH9rgZGMvRnUap6liuQ9p66IuqvWprqqF1VtAe3U6yQrtiXyIGAjzo4zupRByPrk7
         5J17Tyc7SozannLO/VJPgKTqnXvf9v8Q3sLLPEb7GUaLFOZDYJNVb3a6O/thOueAOE++
         TK0H36amKB0A8nFJ+3LQ8oCbIHecrjd4Vz9IuS88n5lD+u1BAHZQcaltcQvXDKeHwafN
         pwXQ==
X-Gm-Message-State: AOJu0YxzOGs69TAMBENcOXhGoqOfySEKRzy5QWEowtHpedQrZvKlHLjF
        3zcakK4wxdq+NBBG8A4zkxaLMHIc5GpwGk+D6IfagnYS3i0g1+XRRJSjzkZiiHCzyHn1cr4TGud
        2+zSHwY34KpDAs1U6ijfy7rLwjQ==
X-Received: by 2002:a05:620a:1a92:b0:76c:ea67:38e2 with SMTP id bl18-20020a05620a1a9200b0076cea6738e2mr16297938qkb.2.1693950160428;
        Tue, 05 Sep 2023 14:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0/uwjCE+wD8vjFeylTm+w9KR1ry9a3YxdBWKPhIRxUJR2OeC5hjEf8cXax4t1I0LDP54fg==
X-Received: by 2002:a05:620a:1a92:b0:76c:ea67:38e2 with SMTP id bl18-20020a05620a1a9200b0076cea6738e2mr16297913qkb.2.1693950160176;
        Tue, 05 Sep 2023 14:42:40 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>, peterx@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 2/7] poll: Add a poll_flags for poll_queue_proc()
Date:   Tue,  5 Sep 2023 17:42:30 -0400
Message-ID: <20230905214235.320571-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
References: <20230905214235.320571-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allows the poll enqueue function to pass over a flag into it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/vfio/virqfd.c     | 4 ++--
 drivers/vhost/vhost.c     | 2 +-
 drivers/virt/acrn/irqfd.c | 2 +-
 fs/aio.c                  | 2 +-
 fs/eventpoll.c            | 2 +-
 fs/select.c               | 4 ++--
 include/linux/poll.h      | 7 +++++--
 io_uring/poll.c           | 4 ++--
 mm/memcontrol.c           | 4 +++-
 net/9p/trans_fd.c         | 3 ++-
 virt/kvm/eventfd.c        | 2 +-
 11 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 29c564b7a6e1..4b817a6f4f72 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -75,8 +75,8 @@ static int virqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void
 	return 0;
 }
 
-static void virqfd_ptable_queue_proc(struct file *file,
-				     wait_queue_head_t *wqh, poll_table *pt)
+static void virqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+				     poll_table *pt, poll_flags flags)
 {
 	struct virqfd *virqfd = container_of(pt, struct virqfd, pt);
 	add_wait_queue(wqh, &virqfd->wait);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c71d573f1c94..02caad721843 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -162,7 +162,7 @@ static void vhost_poll_func(struct file *file, wait_queue_head_t *wqh,
 }
 
 static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
-			     void *key)
+			     void *key, poll_flags flags)
 {
 	struct vhost_poll *poll = container_of(wait, struct vhost_poll, wait);
 	struct vhost_work *work = &poll->work;
diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index d4ad211dce7a..9b79e4e76e49 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -94,7 +94,7 @@ static int hsm_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 }
 
 static void hsm_irqfd_poll_func(struct file *file, wait_queue_head_t *wqh,
-				poll_table *pt)
+				poll_table *pt, poll_flags flags)
 {
 	struct hsm_irqfd *irqfd;
 
diff --git a/fs/aio.c b/fs/aio.c
index a4c2a6bac72c..abb5b22f4fdf 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1823,7 +1823,7 @@ struct aio_poll_table {
 
 static void
 aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
-		struct poll_table_struct *p)
+		    struct poll_table_struct *p, poll_flags flags)
 {
 	struct aio_poll_table *pt = container_of(p, struct aio_poll_table, pt);
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1d9a71a0c4c1..c74d6a083fd1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1270,7 +1270,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
  * target file wakeup lists.
  */
 static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
-				 poll_table *pt)
+				 poll_table *pt, poll_flags flags)
 {
 	struct ep_pqueue *epq = container_of(pt, struct ep_pqueue, pt);
 	struct epitem *epi = epq->epi;
diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..0433448481e9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -117,7 +117,7 @@ struct poll_table_page {
  * poll table.
  */
 static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
-		       poll_table *p);
+		       poll_table *p, poll_flags flags);
 
 void poll_initwait(struct poll_wqueues *pwq)
 {
@@ -220,7 +220,7 @@ static int pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *key
 
 /* Add a new entry */
 static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
-				poll_table *p)
+		       poll_table *p, poll_flags flags)
 {
 	struct poll_wqueues *pwq = container_of(p, struct poll_wqueues, pt);
 	struct poll_table_entry *entry = poll_get_entry(pwq);
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a9e0e1c2d1f2..cbad520fc65c 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -27,12 +27,15 @@
 
 #define DEFAULT_POLLMASK (EPOLLIN | EPOLLOUT | EPOLLRDNORM | EPOLLWRNORM)
 
+typedef unsigned int poll_flags;
+
 struct poll_table_struct;
 
 /* 
  * structures and helpers for f_op->poll implementations
  */
-typedef void (*poll_queue_proc)(struct file *, wait_queue_head_t *, struct poll_table_struct *);
+typedef void (*poll_queue_proc)(struct file *, wait_queue_head_t *,
+				struct poll_table_struct *, poll_flags);
 
 /*
  * Do not touch the structure directly, use the access functions
@@ -46,7 +49,7 @@ typedef struct poll_table_struct {
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
 	if (p && p->_qproc && wait_address)
-		p->_qproc(filp, wait_address, p);
+		p->_qproc(filp, wait_address, p, 0);
 }
 
 /*
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 4c360ba8793a..c3b41e963a8d 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -533,7 +533,7 @@ static void __io_queue_proc(struct io_poll *poll, struct io_poll_table *pt,
 }
 
 static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
-			       struct poll_table_struct *p)
+			       struct poll_table_struct *p, poll_flags flags)
 {
 	struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
 	struct io_poll *poll = io_kiocb_to_cmd(pt->req, struct io_poll);
@@ -644,7 +644,7 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 }
 
 static void io_async_queue_proc(struct file *file, struct wait_queue_head *head,
-			       struct poll_table_struct *p)
+				struct poll_table_struct *p, poll_flags flags)
 {
 	struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
 	struct async_poll *apoll = pt->req->apoll;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ecc07b47e813..97b03ab30d5e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4877,7 +4877,9 @@ static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
 }
 
 static void memcg_event_ptable_queue_proc(struct file *file,
-		wait_queue_head_t *wqh, poll_table *pt)
+					  wait_queue_head_t *wqh,
+					  poll_table *pt,
+					  poll_flags flags)
 {
 	struct mem_cgroup_event *event =
 		container_of(pt, struct mem_cgroup_event, pt);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index c4015f30f9fa..91f9f474ab01 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -550,7 +550,8 @@ static int p9_pollwake(wait_queue_entry_t *wait, unsigned int mode, int sync, vo
  */
 
 static void
-p9_pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p)
+p9_pollwait(struct file *filp, wait_queue_head_t *wait_address, poll_table *p,
+	    poll_flags flags)
 {
 	struct p9_conn *m = container_of(p, struct p9_conn, pt);
 	struct p9_poll_wait *pwait = NULL;
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 89912a17f5d5..645b5d155386 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -246,7 +246,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 
 static void
 irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
-			poll_table *pt)
+			poll_table *pt, poll_flags flags)
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(pt, struct kvm_kernel_irqfd, pt);
-- 
2.41.0

