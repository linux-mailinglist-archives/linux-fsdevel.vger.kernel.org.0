Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50300568A20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiGFNwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiGFNwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:52:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3491EAC5
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IGzH70xSyPKuqAHmGbi8YxnvKpA0WupTOhm3OlPhxTk=; b=YIxvZcMFeiSigBGl2q7q0IT9Po
        sHdzGATAWKg8w7HufHqTvgpJDwnNyNlUkJKEw68Zo/fXnktNoQLNQmOZ774CpWZjH2oZc+impQoSV
        /aI90Wa/CAVVwUUStc/U5CqbvU+QLgBJuKODKNsWce+NYf6mA18Ov9sHsmS/fbw61tcFjNnBrgGj1
        i+mYw1xLHDJzcXr1EPv+57DXt169uZAyssAlNi94qZZ/Yrx0FH4W7N2UZ79zwsaj81aJWceXl/wL3
        usBTqkl8R/uOjYKvRdAxQf9f+hY+fTFKCDgQQEe4nUgYusqPDuXT7RpYP+OXwpxbYEe81S72qn7EX
        Rq2bAKdg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o95Ry-008n9e-3E;
        Wed, 06 Jul 2022 13:52:18 +0000
Date:   Wed, 6 Jul 2022 14:52:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH] burying long-dead rudiments in mntput_no_expire()
Message-ID: <YsWTkmAs53Wjf2nN@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	A bit of context: the original RCU conversion of struct mount
handling had several bugs, spotted and fixed only 5 years later, in
119e1ef80ecf "fix __legitimize_mnt()/mntput() race".  However, bits and
pieces of old broken approach hadn't been removed.

	legitimize_mnt() takes a non-counting reference the caller had
found after rcu_read_lock() and sampling of mount_lock seqcount and
tries to turn it into counting one if mount_lock seqcount had not been changed.

	The hard part is dealing with the possibility of race with final
mntput() - we want the successful fast path through legitimize_mnt()
to be lockless, so there's a possibility of legitimize_mnt()
incrementing refcount, only to recheck the mount_lock seqcount and
notice that it had been disturbed by what would've been the final
mntput().  In that case legitimize_mnt() needs to drop the reference
it has acquired and report failure.

	Original approach had been to have the final mntput() to
mark mount as doomed when it commits to killing it off, with
legitimize_mnt() doing mntput() if it noticed mount_lock disturbed
while it had been grabbing a reference and mntput checking if
it has already marked the mount doomed and leaving its destruction
to the thread that had done the marking.

	That had been racy - since this mntput() from legitimize_mnt()
might end up doing real work (if what would've been the final mntput()
had observed attempted increment by legitimize_mnt()) it can't be done
under rcu_read_lock(), but in case if the race went the other way round
and final mntput() had *not* seen an attempted increment, rcu_read_lock()
we are holding might be the only thing preventing freeing of struct
mount in question.

	Fortunately, legitimize_mnt() can tell one case from another by
grabbing mount_lock and checking whether the mount had been marked doomed
- if it had been marked we known that the final mntput() has already done
mnt_get_count() and not observed our increment, so we can just decrement
it quietly.  If it hadn't been marked, we know that we need to do full
mntput(), but we also know that it's safe to drop rcu_read_lock() -
mount won't get freed under us.

	That's what the commit in question had done - in effect,
it had taken the "is it already marked doomed?"  check from mntput()
to legitimize_mnt().  Which is the right thing to do, but we should've
removed that check from mntput() itself.  While we are at it, there's
no reason for mntput() to hold onto rcu_read_lock() past the handling of
"still mounted, we know it's not the final drop" case.

	Patch below takes the remnants out.  It should've been done
as part of the original fix; as it is, the magical mystery shite had
been left behind.

	Folks, could you give it some beating?  I realize that original
reproducers might be long gone, but...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 68789f896f08..ad94f9e228ae 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1224,6 +1224,7 @@ static void mntput_no_expire(struct mount *mnt)
 		rcu_read_unlock();
 		return;
 	}
+	rcu_read_unlock();
 	lock_mount_hash();
 	/*
 	 * make sure that if __legitimize_mnt() has not seen us grab
@@ -1234,17 +1235,10 @@ static void mntput_no_expire(struct mount *mnt)
 	count = mnt_get_count(mnt);
 	if (count != 0) {
 		WARN_ON(count < 0);
-		rcu_read_unlock();
-		unlock_mount_hash();
-		return;
-	}
-	if (unlikely(mnt->mnt.mnt_flags & MNT_DOOMED)) {
-		rcu_read_unlock();
 		unlock_mount_hash();
 		return;
 	}
 	mnt->mnt.mnt_flags |= MNT_DOOMED;
-	rcu_read_unlock();
 
 	list_del(&mnt->mnt_instance);
 
