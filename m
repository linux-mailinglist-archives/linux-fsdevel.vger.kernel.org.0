Return-Path: <linux-fsdevel+bounces-69167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD37C7193D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 01:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A52B334C5A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F61EF091;
	Thu, 20 Nov 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEv0pYgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1D1E98E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599191; cv=none; b=t8E2ewElBBFGmlqew3ZkUks7mZKZNtt6kdosJf8vbkMjLje8srVXOP/KJJNC5FU0tSnYK27QqdpgORmRghjzeYIwNTUYzG3BgctMXVswLdFMmUpKIKb2/40Ng2paz+svWj6BahCZzvH2JP+E80xMn4lXwamlwXLi0ewrY99THuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599191; c=relaxed/simple;
	bh=5QCS4FbofST1CGb1iBwEzymNUXazcsCaLOPnvpRbt08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0/63/UR1RA1uw6bKOvvnCTZL3IN/eZUyIVEvKEMQUmcFi2+9IGs67trSXJEQBPjfTvsUqBTVPghrNW+zMQTltXndPVa4iFhNpiBEEAfb9QfAv2KCpZ2Rt7NM6Bqhk59vcXYtL1wE1O6oGQiup+12nDq9YdAI8lpHorLoXDWpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEv0pYgi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso2147335e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763599186; x=1764203986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqrnorOXdUD9V20jycUQnvP9DYoduqpO8F6pbmihTY4=;
        b=hEv0pYgiOY4g80Tw2MxFMbjQ1NfR8iSw+HyHtUFOj1yNDwifvCNjDTjSXOW44oen24
         b1W8oIJbFsD26279sByobsU8v2zSrXsFp+DdYlC+Yw3nLKP8n6mYMV9F1mRm3hlO8lHv
         CnYvFtnikDoD64jVsQDcE8brFuR1vs86mSRmBUMKnjMcXGwMiIKkZ0LjXqJsKXX4R2qs
         iL2kuB6t0/k6xQOB8TV3f7B42eozY4th0w0kvqGdFbpojY1xXiLt+/QkiykCl6Ai6nnK
         ASohR2t8YAXo3QvLKj1OJaia6lNtDVZwu1JoPK44Xa+gbQ1azx4zgjqhw2bR80OX3DEt
         QJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763599186; x=1764203986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqrnorOXdUD9V20jycUQnvP9DYoduqpO8F6pbmihTY4=;
        b=vtpVMhgTYYSyShJjd7sUGe9YqSWAXZ98Ud2+leYdbqJ8jbxaEHN0e4xd1bgCLgYk8d
         SScmaZXb0HO5ndvedGzuytjg96uzdrTM98fk3yXZInGA3x7YW72me+xpfeTq+M7PnUFn
         9zSFI/f1Naa4PKgSlhS7d2qerH+U1B8+v1/0/WiBa3VUE/S8Xs59IGwY4uVnvOemaZVh
         /iwUKF03qkJ1WcsFA6cwD5/7eDk1q+HF1iDLrHXdJkDCxjwMyEyOoH/bkdY4jD/Dc5ow
         xPcwRBT/9yiMhS6oNyRCSqPjlyoNaCVlPsDhI4N87naSCmpMbXVxIFh+8uooagfHM6c4
         +LNg==
X-Forwarded-Encrypted: i=1; AJvYcCVofr342qByipoQoBRXgA4RX47VtG7OYIPKNpfzp4I8nZXiFggD4i7+luh1AEdgXVABgkTuyEjfRqcqx7gX@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTC1f90eO33PbEMtWsSJbEaqtzseSTn+37Q3YCCHSMDqRs93r
	HOxal8FWXYQugHjjjEqeAAwHuN3HYulNX0fSYyM2fizhqA2D5NbP5iKw
X-Gm-Gg: ASbGncuhdeAOGCd7z4cTBAJBVh0kV9giyNYy07GvBMOdT02/pHEcQEND/x1NymuR/Dq
	gizX0DyskpCfE/1OI70IE+zf524b8q2JCcifOVr6gFvgWp5g8Cqg2Fw3ftCH3wkZ3Ztud/silqJ
	FutkattQ4q/Tj56m8GmOSBgW7wUHaxTmIC/a+GrOFj0FR+D+b9koyPRQsHOC/kSSdH7+u2Q5iIJ
	sRikpTcj8+9ijw9xbwwV0uzRhBeiBjQl/NxWml/uk72/Jr1O9IKUvMoWeNEUlq3nONgl+2PrXtJ
	A76pZ9OKuVWCID+xfC/XWaysmECrSPSkRsm23FHODugMhwZVVzypqNIwX99UkfGcijMWYcCF3SZ
	FMBdN48ei9BEPNYeIlTbNxU7cxzibpE55aPlqcKSKgCP8Rvt7vtz+HHZKgAclPFeaKoD7sSqtGM
	eXEZkzbeSGw+web/4GVqln/fdFcNJb/VuCBWFKxwld5XXZZPWX/7BTO4Y7X8ZgSVqqW0NoPA==
X-Google-Smtp-Source: AGHT+IGbuvXeuiCUpvegB1QW9K1Ctmlj9b5/pDbVuUK11RX5qkO0rSsIgs4pWbVMws2MqD09FqO0OA==
X-Received: by 2002:a05:600c:458e:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-477bac0cfb5mr398635e9.16.1763599186257;
        Wed, 19 Nov 2025 16:39:46 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e581sm1902407f8f.8.2025.11.19.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:39:45 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/2] fs: inline step_into() and walk_component()
Date: Thu, 20 Nov 2025 01:38:03 +0100
Message-ID: <20251120003803.2979978-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120003803.2979978-1-mjguzik@gmail.com>
References: <20251120003803.2979978-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary consumer is link_path_walk(), calling walk_component() every
time which in turn calls step_into().

Inlining these saves overhead of 2 function calls per path component,
along with allowing the compiler to do better job optimizing them in place.

step_into() had absolutely atrocious assembly to facilitate the
slowpath. In order to lessen the burden at the callsite all the hard
work is moved into step_into_slowpath() and instead an inline-able
fastpath is implemented for rcu-walk.

The new fastpath is a stripped down step_into() RCU handling with a
d_managed() check from handle_mounts().

Benchmarked as follows on Sapphire Rapids:
1. the "before" was a kernel with not-yet-merged optimizations (notably
   elision of calls to security_inode_permission() and marking ext4
   inodes as not having acls as applicable)
2. "after" is the same + the prep patch + this patch
3. benchmark consists of issuing 205 calls to access(2) in a loop with
   pathnames lifted out of gcc and the linker building real code, most
   of which have several path components and 118 of which fail with
   -ENOENT.

Result in terms of ops/s:
before:	21619
after:	22536 (+4%)

profile before:
  20.25%  [kernel]                  [k] __d_lookup_rcu
  10.54%  [kernel]                  [k] link_path_walk
  10.22%  [kernel]                  [k] entry_SYSCALL_64
   6.50%  libc.so.6                 [.] __GI___access
   6.35%  [kernel]                  [k] strncpy_from_user
   4.87%  [kernel]                  [k] step_into
   3.68%  [kernel]                  [k] kmem_cache_alloc_noprof
   2.88%  [kernel]                  [k] walk_component
   2.86%  [kernel]                  [k] kmem_cache_free
   2.14%  [kernel]                  [k] set_root
   2.08%  [kernel]                  [k] lookup_fast

after:
  23.38%  [kernel]                  [k] __d_lookup_rcu
  11.27%  [kernel]                  [k] entry_SYSCALL_64
  10.89%  [kernel]                  [k] link_path_walk
   7.00%  libc.so.6                 [.] __GI___access
   6.88%  [kernel]                  [k] strncpy_from_user
   3.50%  [kernel]                  [k] kmem_cache_alloc_noprof
   2.01%  [kernel]                  [k] kmem_cache_free
   2.00%  [kernel]                  [k] set_root
   1.99%  [kernel]                  [k] lookup_fast
   1.81%  [kernel]                  [k] do_syscall_64
   1.69%  [kernel]                  [k] entry_SYSCALL_64_safe_stack

While walk_component() and step_into() of course disappear from the
profile, the link_path_walk() barely gets more overhead despite the
inlining thanks to the fast path added and while completing more walks
per second.

I did not investigate why overhead grew a lot on __d_lookup_rcu().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- reimplement without gotos, instead make it look like step_into
- use d_managed instead of open-coding it

Technically this version was written by Al Viro, but this is just
step_into() RCU handling with an internal RCU check removed and
d_managed() check added which re-did anyway to make sure nothing is
missing (that and some trivial comment changes).

Since Al did not respond yet to a query what he wants done with an
authorship and I had the cleanup prepared, I decided to send this v2.

I'm more than happy to change the author and drop my name from this
patch if that's most expedient to get it in.


 fs/namei.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8777637ef939..2c83f894f276 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1951,7 +1951,7 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
 	int error;
 
 	if (nd->flags & LOOKUP_RCU) {
-		/* make sure that d_is_symlink from step_into() matches the inode */
+		/* make sure that d_is_symlink from step_into_slowpath() matches the inode */
 		if (read_seqcount_retry(&link->dentry->d_seq, nd->next_seq))
 			return ERR_PTR(-ECHILD);
 	} else {
@@ -2033,7 +2033,7 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
  *
  * NOTE: dentry must be what nd->next_seq had been sampled from.
  */
-static const char *step_into(struct nameidata *nd, int flags,
+static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
 		     struct dentry *dentry)
 {
 	struct path path;
@@ -2066,6 +2066,31 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, flags);
 }
 
+static __always_inline const char *step_into(struct nameidata *nd, int flags,
+                    struct dentry *dentry)
+{
+	/*
+	 * In the common case we are in rcu-walk and traversing over a non-mounted on
+	 * directory (as opposed to e.g., a symlink).
+	 *
+	 * We can handle that and negative entries with the checks below.
+	 */
+	if (likely((nd->flags & LOOKUP_RCU) &&
+	    !d_managed(dentry) && !d_is_symlink(dentry))) {
+		struct inode *inode = dentry->d_inode;
+		if (read_seqcount_retry(&dentry->d_seq, nd->next_seq))
+			return ERR_PTR(-ECHILD);
+		if (unlikely(!inode))
+			return ERR_PTR(-ENOENT);
+		nd->path.dentry = dentry;
+		/* nd->path.mnt is retained on purpose */
+		nd->inode = inode;
+		nd->seq = nd->next_seq;
+		return NULL;
+	}
+	return step_into_slowpath(nd, flags, dentry);
+}
+
 static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct dentry *parent, *old;
@@ -2176,7 +2201,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 	return NULL;
 }
 
-static const char *walk_component(struct nameidata *nd, int flags)
+static __always_inline const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
 	/*
-- 
2.48.1


