Return-Path: <linux-fsdevel+bounces-57840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFAB25B3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E13D7275F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3502248A0;
	Thu, 14 Aug 2025 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YCdf99ku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944931DF27F;
	Thu, 14 Aug 2025 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150708; cv=none; b=MWLel2KHHlH2vg18oxcFlt6IP2YzZcIQEhQOGolp5/wr8jpgr9lBEhJWpSPMca6tutHfFwEOAWpG/iZnwLsxzZfGmnqdCSR+MJcmeTFsfLKjZMgQ5lUTGA1fu6XRcHgwc/QPo6u5hylFVY/e3M8WmOTYM78LF2mY7F/aThtdbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150708; c=relaxed/simple;
	bh=yIV6jsNsYQGse3vWK+MI39lw1C5htlVqCQ7nXY2Rf3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLBBzet48SWmuIR4HjrGx3z3ZaRtE9tGE3+UrHbjFlUbtLnyw96B68yW3tYGc22aq/NZwfCccDMOZULM/k1aZOnXtz3q3mYUratFhHRNqJLAaFEP2UZqIOmxHAQqMB5Jg47eyx+dDubAuiOwwG0dcSexI9J/kD/YcgwAQvAXkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YCdf99ku; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9EgkRLTHf3vYcKV2S9JHcON4u9ACamEgHLf479pEIGM=; b=YCdf99kusOdEqS/HI26COGuyA6
	8bwU5Yhj3S0eIFtCvEwx378OpuXKqfPOHA52d8uGlBehWmFQBYqY/RF7IZ/e+tJxBaJqtdEEYYE19
	NfKKWUGd1DWrca7aikE8HFwM3G5uHNfv40bnYnq0hhh/U2Gw/N/vD8VYxBsDrLiCPPMUaoeYZwyGN
	PoKiyEBpCVWztsca6wlRQ1oDG1okqFH9Fbx/PooLK/HZ/nr2H1HOH7mokzh8YyEzglACiOXjtl+tX
	fs3CnSlBLwVcAXQW8L5F6OwzZavWgtJ0Pw6i5aZNLgfeDuVdhFE04Ntv+FNsfWL/nvFQJbwo0x0B/
	QPKMoY+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umQsI-0000000HNPw-3KTL;
	Thu, 14 Aug 2025 05:51:42 +0000
Date: Thu, 14 Aug 2025 06:51:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <snorcht@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: [PATCH][RFC][CFT] use uniform permission checks for all mount
 propagation changes
Message-ID: <20250814055142.GN222315@ZenIV>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV>
 <aJzi506tGJb8CzA3@tycho.pizza>
 <20250813194145.GK222315@ZenIV>
 <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
 <20250814044239.GM222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814044239.GM222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[this should fix userland regression from do_change_type() fix last cycle;
we have too little self-test coverage in the area, unfortunately.  First
approximation for selftest in the followup to this posting.  Review and
testing of both the patch and test would be very welcome]

do_change_type() and do_set_group() are operating on different
aspects of the same thing - propagation graph.  The latter
asks for mounts involved to be mounted in namespace(s) the caller
has CAP_SYS_ADMIN for.  The former is a mess - originally it
didn't even check that mount *is* mounted.  That got fixed,
but the resulting check turns out to be too strict for userland -
in effect, we check that mount is in our namespace, having already
checked that we have CAP_SYS_ADMIN there.

What we really need (in both cases) is
	* we only touch mounts that are mounted.  Hard requirement,
data corruption if that's get violated.
	* we don't allow to mess with a namespace unless you already
have enough permissions to do so (i.e. CAP_SYS_ADMIN in its userns).

That's an equivalent of what do_set_group() does; let's extract that
into a helper (may_change_propagation()) and use it in both
do_set_group() and do_change_type().

Fixes: 12f147ddd6de "do_change_type(): refuse to operate on unmounted/not ours mounts"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..a191c6519e36 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2862,6 +2862,19 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	return attach_recursive_mnt(mnt, p, mp);
 }
 
+static int may_change_propagation(const struct mount *m)
+{
+        struct mnt_namespace *ns = m->mnt_ns;
+
+	 // it must be mounted in some namespace
+	 if (IS_ERR_OR_NULL(ns))         // is_mounted()
+		 return -EINVAL;
+	 // and the caller must be admin in userns of that namespace
+	 if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		 return -EPERM;
+	 return 0;
+}
+
 /*
  * Sanity check the flags to change_mnt_propagation.
  */
@@ -2898,10 +2911,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
-	if (!check_mnt(mnt)) {
-		err = -EINVAL;
+	err = may_change_propagation(mnt);
+	if (err)
 		goto out_unlock;
-	}
+
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -3347,18 +3360,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 
 	namespace_lock();
 
-	err = -EINVAL;
-	/* To and From must be mounted */
-	if (!is_mounted(&from->mnt))
-		goto out;
-	if (!is_mounted(&to->mnt))
-		goto out;
-
-	err = -EPERM;
-	/* We should be allowed to modify mount namespaces of both mounts */
-	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(from);
+	if (err)
 		goto out;
-	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(to);
+	if (err)
 		goto out;
 
 	err = -EINVAL;

