Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53675B884
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGTUHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGTUHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB426AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689883616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucxp4CiclbQdAFxLcc4GXsXkfqukOJSf3s5CGFH45eo=;
        b=izpPrmzzn67HFEuoN3YmmtA66cEd6DLJVGg0rXTeEk7sRvjMo2fZa3bCLI6yPpEueaqV6d
        92IqwWlWQkMurlaDQk9NEBQqmex8IojwQWl/opQWazFAe5igr5fzQlouHygRZ4Tnjftfoe
        Z/k92r9ErlzTy/zayP1uwjpp55D+ERU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-oK_VKpx9NeeQ_hjGr_RH8A-1; Thu, 20 Jul 2023 16:06:54 -0400
X-MC-Unique: oK_VKpx9NeeQ_hjGr_RH8A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-639d9eaf37aso2996716d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 13:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883614; x=1690488414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucxp4CiclbQdAFxLcc4GXsXkfqukOJSf3s5CGFH45eo=;
        b=Hudt4s9+zZGAHqf7e9fNcWSVR8wnNfcm9Sqi24sLXZ7Rv2+woAatixz4y86WBz/fJL
         9TvywIQo8JoIBll6ANX0JOD9hhLmXZwPVas/zczYVt753EhiM5E821TpQoFtlY3aD6e8
         HcO53/+VFlYpdRyRf2zQIHnm3czQT+Tg8uEHVJx6Qf58NVup+23HIKKhBbdcn0SfIqcR
         q1uFZyt7h7mzjy3nZxaPlCuKMFQ34gadoXjEU2t6FL/7IydJOrVNHmqs8+L/1Q8uZ9hP
         xCRNGivBXIWMpa+Eh7HhpvWbjM3XVUhxhDGoOqkbpO8fhw/HdhdED37T97CHSfP/uvK/
         f5QA==
X-Gm-Message-State: ABy/qLbthAYJaWNQC9++qJAs3BkmyyA+tO1zP12lyOAWp6ymsuxAwH58
        xn5Cqp3iosaeTB0KBiscMtzlE9cDCLHDkTgsKChg6trpZAiKbn1+dfJ0r3KDZo79MZAJQaKEdv+
        tnpn0PTe4p9EiMnvImzTwVaTHDB8PYqaJbw==
X-Received: by 2002:a05:6214:21c4:b0:639:d239:b4fd with SMTP id d4-20020a05621421c400b00639d239b4fdmr138690qvh.1.1689883614126;
        Thu, 20 Jul 2023 13:06:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFfvvqT4xuU20f9j7ej5nd1HPvCjQU0/3eyMCHp2vS99rh43b9nNbOoZuAeDgyFr5glw3iNzQ==
X-Received: by 2002:a05:6214:21c4:b0:639:d239:b4fd with SMTP id d4-20020a05621421c400b00639d239b4fdmr138665qvh.1.1689883613762;
        Thu, 20 Jul 2023 13:06:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id k17-20020a0c9711000000b00635e68d3170sm721052qvd.31.2023.07.20.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:06:53 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:06:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <ZLmT3BfcmltfFvbq@x1n>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20230719211631.890995-1-axelrasmussen@google.com>
 <CAJHvVcj+Sc41mfercqxBii5cqRBEgZxNix2R1YMi04K-5nBh8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcj+Sc41mfercqxBii5cqRBEgZxNix2R1YMi04K-5nBh8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Axel, Dimitris,

On Wed, Jul 19, 2023 at 02:54:21PM -0700, Axel Rasmussen wrote:
> On Wed, Jul 19, 2023 at 2:16 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > Thanks for the detailed report Dimitris! I've CCed the MM mailing list and some
> > folks who work on userfaultfd.
> 
> Apologies, I should have quoted the original message for the others I
> added to CC: https://lore.kernel.org/lkml/79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr/T/#u
> 
> >
> > I took a look at this today, but I haven't quite come up with a solution.
> >
> > I thought it might be as easy as changing userfaultfd_release() to set released
> > *after* taking the lock. But no such luck, the ordering is what it is to deal
> > with another subtle case:
> >
> >
> >         WRITE_ONCE(ctx->released, true);
> >
> >         if (!mmget_not_zero(mm))
> >                 goto wakeup;
> >
> >         /*
> >          * Flush page faults out of all CPUs. NOTE: all page faults
> >          * must be retried without returning VM_FAULT_SIGBUS if
> >          * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
> >          * changes while handle_userfault released the mmap_lock. So
> >          * it's critical that released is set to true (above), before
> >          * taking the mmap_lock for writing.
> >          */
> >         mmap_write_lock(mm);
> >
> > I think perhaps the right thing to do is to have handle_userfault() release
> > mmap_lock when it returns VM_FAULT_NOPAGE, and to have GUP deal with that
> > appropriately? But, some investigation is required to be sure that's okay to do
> > in the other non-GUP ways we can end up in handle_userfault().

Heh, this is also what I thought after reading. :)

If we see in the very early commit from Andrea it seems that would not hang
gup but just sigbus-ing it (see the comment that's mostly exactly the thing
Dimitris hit here):

commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Sep 4 15:46:31 2015 -0700

    userfaultfd: add new syscall to provide memory externalization

+	/*
+	 * If it's already released don't get it. This avoids to loop
+	 * in __get_user_pages if userfaultfd_release waits on the
+	 * caller of handle_userfault to release the mmap_sem.
+	 */
+	if (unlikely(ACCESS_ONCE(ctx->released)))
+		return VM_FAULT_SIGBUS;
+

Then we switched over to the friendly way, assuming CRIU could close() the
uffd during the monitee process running, in:

commit 656710a60e3693911bee3a355d2f2bbae3faba33
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Sep 8 16:12:42 2017 -0700

    userfaultfd: non-cooperative: closing the uffd without triggering SIGBUS

I had a feeling that after that we didn't test gup (I assume normal page
fault path will still work).  Let me copy Mike too for that just in case he
has anything to say.  Paste thread again:

https://lore.kernel.org/lkml/79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr/T/#u

My understanding is that releasing mmap lock here should work, but we need
to move the code a bit.  Dimitris, please feel free to try the patch
attached here if you want.  It's probably not a major use case of uffd over
kvm (IIUC unregister before close() will also work?), but if it's trivial
to fix we should proably fix it.

Thanks,

===8<===
From 7e9ef050b487220463fa77a7aa97259ffe9bb15e Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 20 Jul 2023 15:33:55 -0400
Subject: [PATCH] mm/uffd: Fix release hang over GUP

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 57 ++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bbfaf5837a08..2358e6b00315 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -455,32 +455,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
 		goto out;
 
-	/*
-	 * If it's already released don't get it. This avoids to loop
-	 * in __get_user_pages if userfaultfd_release waits on the
-	 * caller of handle_userfault to release the mmap_lock.
-	 */
-	if (unlikely(READ_ONCE(ctx->released))) {
-		/*
-		 * Don't return VM_FAULT_SIGBUS in this case, so a non
-		 * cooperative manager can close the uffd after the
-		 * last UFFDIO_COPY, without risking to trigger an
-		 * involuntary SIGBUS if the process was starting the
-		 * userfaultfd while the userfaultfd was still armed
-		 * (but after the last UFFDIO_COPY). If the uffd
-		 * wasn't already closed when the userfault reached
-		 * this point, that would normally be solved by
-		 * userfaultfd_must_wait returning 'false'.
-		 *
-		 * If we were to return VM_FAULT_SIGBUS here, the non
-		 * cooperative manager would be instead forced to
-		 * always call UFFDIO_UNREGISTER before it can safely
-		 * close the uffd.
-		 */
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
 	/*
 	 * Check that we can return VM_FAULT_RETRY.
 	 *
@@ -517,6 +491,37 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
 		goto out;
 
+	/*
+	 * If it's already released don't get it. This avoids to loop
+	 * in __get_user_pages if userfaultfd_release waits on the
+	 * caller of handle_userfault to release the mmap_lock.
+	 */
+	if (unlikely(READ_ONCE(ctx->released))) {
+		/*
+		 * Don't return VM_FAULT_SIGBUS in this case, so a non
+		 * cooperative manager can close the uffd after the
+		 * last UFFDIO_COPY, without risking to trigger an
+		 * involuntary SIGBUS if the process was starting the
+		 * userfaultfd while the userfaultfd was still armed
+		 * (but after the last UFFDIO_COPY). If the uffd
+		 * wasn't already closed when the userfault reached
+		 * this point, that would normally be solved by
+		 * userfaultfd_must_wait returning 'false'.
+		 *
+		 * If we were to return VM_FAULT_SIGBUS here, the non
+		 * cooperative manager would be instead forced to
+		 * always call UFFDIO_UNREGISTER before it can safely
+		 * close the uffd.
+		 *
+		 * We release the mmap lock in this special case, just in
+		 * case we're in a gup to not dead loop, so the other uffd
+		 * handler thread/process can have a chance to take the
+		 * write lock and do the unregistration.
+		 */
+		release_fault_lock(vmf);
+		goto out;
+	}
+
 	/* take the reference before dropping the mmap_lock */
 	userfaultfd_ctx_get(ctx);
 
-- 
2.41.0
===8<===

-- 
Peter Xu

