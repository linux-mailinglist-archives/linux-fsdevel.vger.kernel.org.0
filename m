Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E471D5089D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379231AbiDTN6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354116AbiDTN6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CEFF186F7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650462945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oH7gu/xzVmtcanjocJ87OHouz9O553w779jbyyEl/Jw=;
        b=H4v5aupOn5G1bXeaTJyuWel/Q4twla+kT+/JfD55sFGj02i1RZs2OT7MLgOuOMBkDttXit
        u9FCBzFJTUMI1NF1b2aHf1uNM+ZXJO3VIndOBSYeli2rSGuogCJtF7nL7G6Hl3Mz1xqXk/
        P/q1TIWCf+RfeRNy/5BPRfQribqIEKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-0wkoF-_2OLeXjBtv6Z21zA-1; Wed, 20 Apr 2022 09:55:43 -0400
X-MC-Unique: 0wkoF-_2OLeXjBtv6Z21zA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95F3F80159B;
        Wed, 20 Apr 2022 13:55:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE442026D2D;
        Wed, 20 Apr 2022 13:55:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yl75D02pXj71kQBx@rabbit.intern.cm-ag>
References: <Yl75D02pXj71kQBx@rabbit.intern.cm-ag> <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <507518.1650383808@warthog.procyon.org.uk> <509961.1650386569@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <705277.1650462934.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 20 Apr 2022 14:55:34 +0100
Message-ID: <705278.1650462934@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> > Do the NFS servers change the files that are being served - or is it
> > just WordPress pushing the changes to the NFS servers for the web
> > servers to then export?
> =

> I'm not sure if I understand this question correctly.  The NFS server
> (a NetApp, btw.) sees the new file contents correctly; all other web
> servers also see non-corrupt new files.  Only the one web server which
> performed the update saw broken files.

I was wondering if there was missing invalidation if the web clients were
modifying the same files in parallel, but it sounds like only one place is
doing the modification, and the problem is the lack of invalidation when a
file is opened for writing.

I have a tentative patch for this - see attached.

David
---
commit 9b00af0190dfee6073aab47ee88e15c31d3c357d
Author: David Howells <dhowells@redhat.com>
Date:   Wed Apr 20 14:27:17 2022 +0100

    fscache: Fix invalidation/lookup race
    =

    If an NFS file is opened for writing and closed, fscache_invalidate() =
will
    be asked to invalidate the file - however, if the cookie is in the
    LOOKING_UP state (or the CREATING state), then request to invalidate
    doesn't get recorded for fscache_cookie_state_machine() to do somethin=
g
    with.
    =

    Fix this by making __fscache_invalidate() set a flag if it sees the co=
okie
    is in the LOOKING_UP state to indicate that we need to go to invalidat=
ion.
    Note that this requires a count on the n_accesses counter for the stat=
e
    machine, which that will release when it's done.
    =

    fscache_cookie_state_machine() then shifts to the INVALIDATING state i=
f it
    sees the flag.
    =

    Without this, an nfs file can get corrupted if it gets modified locall=
y and
    then read locally as the cache contents may not get updated.
    =

    Fixes: d24af13e2e23 ("fscache: Implement cookie invalidation")
    Reported-by: Max Kellermann <mk@cm4all.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Link: https://lore.kernel.org/r/YlWWbpW5Foynjllo@rabbit.intern.cm-ag [=
1]

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 9d3cf0111709..3bb6deeb4279 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -705,7 +705,11 @@ static void fscache_cookie_state_machine(struct fscac=
he_cookie *cookie)
 		spin_unlock(&cookie->lock);
 		fscache_init_access_gate(cookie);
 		fscache_perform_lookup(cookie);
-		goto again;
+		spin_lock(&cookie->lock);
+		if (test_and_clear_bit(FSCACHE_COOKIE_DO_INVALIDATE, &cookie->flags))
+			__fscache_set_cookie_state(cookie,
+						   FSCACHE_COOKIE_STATE_INVALIDATING);
+		goto again_locked;
 =

 	case FSCACHE_COOKIE_STATE_INVALIDATING:
 		spin_unlock(&cookie->lock);
@@ -752,6 +756,9 @@ static void fscache_cookie_state_machine(struct fscach=
e_cookie *cookie)
 			spin_lock(&cookie->lock);
 		}
 =

+		if (test_and_clear_bit(FSCACHE_COOKIE_DO_INVALIDATE, &cookie->flags))
+			fscache_end_cookie_access(cookie, fscache_access_invalidate_cookie_end=
);
+
 		switch (state) {
 		case FSCACHE_COOKIE_STATE_RELINQUISHING:
 			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
@@ -1048,6 +1055,9 @@ void __fscache_invalidate(struct fscache_cookie *coo=
kie,
 		return;
 =

 	case FSCACHE_COOKIE_STATE_LOOKING_UP:
+		__fscache_begin_cookie_access(cookie, fscache_access_invalidate_cookie)=
;
+		set_bit(FSCACHE_COOKIE_DO_INVALIDATE, &cookie->flags);
+		fallthrough;
 	case FSCACHE_COOKIE_STATE_CREATING:
 		spin_unlock(&cookie->lock);
 		_leave(" [look %x]", cookie->inval_counter);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index e25539072463..a25804f141d3 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -129,6 +129,7 @@ struct fscache_cookie {
 #define FSCACHE_COOKIE_DO_PREP_TO_WRITE	12		/* T if cookie needs write pr=
eparation */
 #define FSCACHE_COOKIE_HAVE_DATA	13		/* T if this cookie has data stored =
*/
 #define FSCACHE_COOKIE_IS_HASHED	14		/* T if this cookie is hashed */
+#define FSCACHE_COOKIE_DO_INVALIDATE	15		/* T if cookie needs invalidatio=
n */
 =

 	enum fscache_cookie_state	state;
 	u8				advice;		/* FSCACHE_ADV_* */

