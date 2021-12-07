Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C910846C795
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhLGWjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 17:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbhLGWjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:39:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1466C061574;
        Tue,  7 Dec 2021 14:35:43 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 58B206EE1; Tue,  7 Dec 2021 17:35:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 58B206EE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638916542;
        bh=DSAGTK/ZALvwunOEhrseEkKuVAe4HsOu0EXKehGC8NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5Z0YMw5qQ4ma0iDFy96xQdc83FtN/jZAzQxDVC9Yk4v57X9QKB39ZpfXAZfu+333
         rVIdZCBFO/dCcaXGRnRWi6wOWg5HXbqbGiiP2mIuaidWc9PEn5jJzcutUty78h0F+6
         7oSktqMO7NXoAA5KtpwmmrAjMW7K09mHUYY6In8U=
Date:   Tue, 7 Dec 2021 17:35:42 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211207223542.GA14522@fieldses.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
 <242C2259-2CF0-406F-B313-23D6D923C76F@oracle.com>
 <20211206225249.GE20244@fieldses.org>
 <DEB6A7B8-0772-487F-8861-BEB924259860@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEB6A7B8-0772-487F-8861-BEB924259860@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:00:22PM +0000, Chuck Lever III wrote:
> Thanks for clarifying! If you are feeling industrious, it would be nice
> for this to be documented somewhere in the source code....

I did that, then noticed I was duplicating a comment I'd already written
elsewhere, so, how about the following?

--b.

From 2e3f00c5f29f033fd5db05ef713d0d9fa27d6db1 Mon Sep 17 00:00:00 2001
From: "J. Bruce Fields" <bfields@redhat.com>
Date: Tue, 7 Dec 2021 17:32:21 -0500
Subject: [PATCH] nfsd: improve stateid access bitmask documentation

The use of the bitmaps is confusing.  Add a cross-reference to make it
easier to find the existing comment.  Add an updated reference with URL
to make it quicker to look up.  And a bit more editorializing about the
value of this.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 14 ++++++++++----
 fs/nfsd/state.h     |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0031e006f4dc..f07fe7562d4d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -360,11 +360,13 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops = {
  * st_{access,deny}_bmap field of the stateid, in order to track not
  * only what share bits are currently in force, but also what
  * combinations of share bits previous opens have used.  This allows us
- * to enforce the recommendation of rfc 3530 14.2.19 that the server
- * return an error if the client attempt to downgrade to a combination
- * of share bits not explicable by closing some of its previous opens.
+ * to enforce the recommendation in
+ * https://datatracker.ietf.org/doc/html/rfc7530#section-16.19.4 that
+ * the server return an error if the client attempt to downgrade to a
+ * combination of share bits not explicable by closing some of its
+ * previous opens.
  *
- * XXX: This enforcement is actually incomplete, since we don't keep
+ * This enforcement is arguably incomplete, since we don't keep
  * track of access/deny bit combinations; so, e.g., we allow:
  *
  *	OPEN allow read, deny write
@@ -372,6 +374,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops = {
  *	DOWNGRADE allow read, deny none
  *
  * which we should reject.
+ *
+ * But you could also argue that what our current code is already
+ * overkill, since it only exists to return NFS4ERR_INVAL on incorrect
+ * client behavior.
  */
 static unsigned int
 bmap_to_share_mode(unsigned long bmap)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e73bdbb1634a..6eb3c7157214 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -568,6 +568,10 @@ struct nfs4_ol_stateid {
 	struct list_head		st_locks;
 	struct nfs4_stateowner		*st_stateowner;
 	struct nfs4_clnt_odstate	*st_clnt_odstate;
+/*
+ * These bitmasks use 3 separate bits for READ, ALLOW, and BOTH; see the
+ * comment above bmap_to_share_mode() for explanation:
+ */
 	unsigned char			st_access_bmap;
 	unsigned char			st_deny_bmap;
 	struct nfs4_ol_stateid		*st_openstp;
-- 
2.33.1

