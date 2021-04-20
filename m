Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3E365AA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhDTOBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 10:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232303AbhDTOBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618927243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqK0WqphjMHPYvufL4Z+4mLDnbRLlFVDZfwTTB2AyQg=;
        b=K5sjqBXB3KAKdQjZFW3p5bSg1GjedXFcKf3QeRXzlRtNJrRULCaa90y4k2WA9vY7Pe4RBu
        6a1X1j1JZVisuA2e80xvJ3Zp250BsJqUpwLudEiv+WIzc4lWTwsCzDccltFMtlcMTt2tkF
        +Ruuzh1ba5faoESfhQGLq5f6bgDv+h8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-qi6LV12yM76vX_EAV-AB3Q-1; Tue, 20 Apr 2021 10:00:39 -0400
X-MC-Unique: qi6LV12yM76vX_EAV-AB3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CC968030DB;
        Tue, 20 Apr 2021 14:00:38 +0000 (UTC)
Received: from horse.redhat.com (ovpn-119-80.rdu2.redhat.com [10.10.119.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 366B55D6A1;
        Tue, 20 Apr 2021 14:00:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C1E8D22054F; Tue, 20 Apr 2021 10:00:33 -0400 (EDT)
Date:   Tue, 20 Apr 2021 10:00:33 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        jack@suse.cz, willy@infradead.org, linux-nvdimm@lists.01.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210420140033.GA1529659@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420093420.2eed3939@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:34:20AM +0200, Greg Kurz wrote:
> On Mon, 19 Apr 2021 17:36:35 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > As of now put_unlocked_entry() always wakes up next waiter. In next
> > patches we want to wake up all waiters at one callsite. Hence, add a
> > parameter to the function.
> > 
> > This patch does not introduce any change of behavior.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 00978d0838b1..f19d76a6a493 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> >  	finish_wait(wq, &ewait.wait);
> >  }
> >  
> > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > +			       enum dax_entry_wake_mode mode)
> >  {
> >  	/* If we were the only waiter woken, wake the next one */
> 
> With this change, the comment is no longer accurate since the
> function can now wake all waiters if passed mode == WAKE_ALL.
> Also, it paraphrases the code which is simple enough, so I'd
> simply drop it.
> 
> This is minor though and it shouldn't prevent this fix to go
> forward.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Ok, here is the updated patch which drops that comment line.

Vivek

Subject: dax: Add a wakeup mode parameter to put_unlocked_entry()

As of now put_unlocked_entry() always wakes up next waiter. In next
patches we want to wake up all waiters at one callsite. Hence, add a
parameter to the function.

This patch does not introduce any change of behavior.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: redhat-linux/fs/dax.c
===================================================================
--- redhat-linux.orig/fs/dax.c	2021-04-20 09:55:45.105069893 -0400
+++ redhat-linux/fs/dax.c	2021-04-20 09:56:27.685822730 -0400
@@ -275,11 +275,11 @@ static void wait_entry_unlocked(struct x
 	finish_wait(wq, &ewait.wait);
 }
 
-static void put_unlocked_entry(struct xa_state *xas, void *entry)
+static void put_unlocked_entry(struct xa_state *xas, void *entry,
+			       enum dax_entry_wake_mode mode)
 {
-	/* If we were the only waiter woken, wake the next one */
 	if (entry && !dax_is_conflict(entry))
-		dax_wake_entry(xas, entry, WAKE_NEXT);
+		dax_wake_entry(xas, entry, mode);
 }
 
 /*
@@ -633,7 +633,7 @@ struct page *dax_layout_busy_page_range(
 			entry = get_unlocked_entry(&xas, 0);
 		if (entry)
 			page = dax_busy_page(entry);
-		put_unlocked_entry(&xas, entry);
+		put_unlocked_entry(&xas, entry, WAKE_NEXT);
 		if (page)
 			break;
 		if (++scanned % XA_CHECK_SCHED)
@@ -675,7 +675,7 @@ static int __dax_invalidate_entry(struct
 	mapping->nrexceptional--;
 	ret = 1;
 out:
-	put_unlocked_entry(&xas, entry);
+	put_unlocked_entry(&xas, entry, WAKE_NEXT);
 	xas_unlock_irq(&xas);
 	return ret;
 }
@@ -954,7 +954,7 @@ static int dax_writeback_one(struct xa_s
 	return ret;
 
  put_unlocked:
-	put_unlocked_entry(xas, entry);
+	put_unlocked_entry(xas, entry, WAKE_NEXT);
 	return ret;
 }
 
@@ -1695,7 +1695,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *
 	/* Did we race with someone splitting entry or so? */
 	if (!entry || dax_is_conflict(entry) ||
 	    (order == 0 && !dax_is_pte_entry(entry))) {
-		put_unlocked_entry(&xas, entry);
+		put_unlocked_entry(&xas, entry, WAKE_NEXT);
 		xas_unlock_irq(&xas);
 		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
 						      VM_FAULT_NOPAGE);

