Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4D366F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhDUP5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 11:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234894AbhDUP5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619020605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIe5tKrugrnOlOskmdMbwkkEL74PO/UkyVq9Mz8MMs8=;
        b=aN5WF/cr+8OU7awsplSflALVksYrf0gWRdAd4YCvQjAjc5VHlU8MK1luP/Fsk/djMUvRZr
        kpxYQtAZNRbOhrhwdMMYg96KeyOAdp49WBIcbRLsoWJI7+s1WolzY/O7SP0ejVAAHLEDJZ
        HHci7J7+lPExbzt5PoSZRAS/HN3jj8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-nQmi_AIYPVuFDxN6YabeCQ-1; Wed, 21 Apr 2021 11:56:44 -0400
X-MC-Unique: nQmi_AIYPVuFDxN6YabeCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3181020C30;
        Wed, 21 Apr 2021 15:56:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-206.rdu2.redhat.com [10.10.114.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF28E5B69B;
        Wed, 21 Apr 2021 15:56:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 822EE220BCF; Wed, 21 Apr 2021 11:56:31 -0400 (EDT)
Date:   Wed, 21 Apr 2021 11:56:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        willy@infradead.org, virtio-fs@redhat.com, slp@redhat.com,
        miklos@szeredi.hu, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210421155631.GC1579961@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-2-vgoyal@redhat.com>
 <20210421092440.GM8706@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421092440.GM8706@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:24:40AM +0200, Jan Kara wrote:
> On Mon 19-04-21 17:36:34, Vivek Goyal wrote:
> > Dan mentioned that he is not very fond of passing around a boolean true/false
> > to specify if only next waiter should be woken up or all waiters should be
> > woken up. He instead prefers that we introduce an enum and make it very
> > explicity at the callsite itself. Easier to read code.
> > 
> > This patch should not introduce any change of behavior.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index b3d27fdc6775..00978d0838b1 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -144,6 +144,16 @@ struct wait_exceptional_entry_queue {
> >  	struct exceptional_entry_key key;
> >  };
> >  
> > +/**
> > + * enum dax_entry_wake_mode: waitqueue wakeup toggle
> > + * @WAKE_NEXT: entry was not mutated
> > + * @WAKE_ALL: entry was invalidated, or resized
> 
> Let's document the constants in terms of what they do, not when they are
> expected to be called. So something like:
> 
> @WAKE_NEXT: wake only the first waiter in the waitqueue
> @WAKE_ALL: wake all waiters in the waitqueue
> 
> Otherwise the patch looks good so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Hi Jan,

Here is the updated patch based on your feedback.

Thanks
Vivek


Subject: dax: Add an enum for specifying dax wakup mode

Dan mentioned that he is not very fond of passing around a boolean true/false
to specify if only next waiter should be woken up or all waiters should be
woken up. He instead prefers that we introduce an enum and make it very
explicity at the callsite itself. Easier to read code.

This patch should not introduce any change of behavior.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

Index: redhat-linux/fs/dax.c
===================================================================
--- redhat-linux.orig/fs/dax.c	2021-04-21 11:51:04.716289502 -0400
+++ redhat-linux/fs/dax.c	2021-04-21 11:52:10.298010850 -0400
@@ -144,6 +144,16 @@ struct wait_exceptional_entry_queue {
 	struct exceptional_entry_key key;
 };
 
+/**
+ * enum dax_entry_wake_mode: waitqueue wakeup toggle
+ * @WAKE_NEXT: wake only the first waiter in the waitqueue
+ * @WAKE_ALL: wake all waiters in the waitqueue
+ */
+enum dax_entry_wake_mode {
+	WAKE_NEXT,
+	WAKE_ALL,
+};
+
 static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
 		void *entry, struct exceptional_entry_key *key)
 {
@@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(w
  * The important information it's conveying is whether the entry at
  * this index used to be a PMD entry.
  */
-static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
+static void dax_wake_entry(struct xa_state *xas, void *entry,
+			   enum dax_entry_wake_mode mode)
 {
 	struct exceptional_entry_key key;
 	wait_queue_head_t *wq;
@@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_sta
 	 * must be in the waitqueue and the following check will see them.
 	 */
 	if (waitqueue_active(wq))
-		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
+		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
 }
 
 /*
@@ -268,7 +279,7 @@ static void put_unlocked_entry(struct xa
 {
 	/* If we were the only waiter woken, wake the next one */
 	if (entry && !dax_is_conflict(entry))
-		dax_wake_entry(xas, entry, false);
+		dax_wake_entry(xas, entry, WAKE_NEXT);
 }
 
 /*
@@ -286,7 +297,7 @@ static void dax_unlock_entry(struct xa_s
 	old = xas_store(xas, entry);
 	xas_unlock_irq(xas);
 	BUG_ON(!dax_is_locked(old));
-	dax_wake_entry(xas, entry, false);
+	dax_wake_entry(xas, entry, WAKE_NEXT);
 }
 
 /*
@@ -524,7 +535,7 @@ retry:
 
 		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
-		dax_wake_entry(xas, entry, true);
+		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrexceptional--;
 		entry = NULL;
 		xas_set(xas, index);
@@ -937,7 +948,7 @@ static int dax_writeback_one(struct xa_s
 	xas_lock_irq(xas);
 	xas_store(xas, entry);
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
-	dax_wake_entry(xas, entry, false);
+	dax_wake_entry(xas, entry, WAKE_NEXT);
 
 	trace_dax_writeback_one(mapping->host, index, count);
 	return ret;

