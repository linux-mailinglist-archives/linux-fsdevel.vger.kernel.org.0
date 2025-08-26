Return-Path: <linux-fsdevel+bounces-59288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E93B36F03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425B3980549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4837C11A;
	Tue, 26 Aug 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EZAtJaM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B937C0FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222931; cv=none; b=S0gV/p5mWHNM0XEWC+90/Kr0W4Qd06EUTc70/tTv6oiGDRtBrQ7W/15j5Jb1ec7YFXSyHG7ft6EaHzkydJBgee+jNjm/OxZhNo2Foo1aujo9dVG2+gbDQWSpbRihseRC+XvwMIQZFI5HpPnMvWXqMlwf1Wr7RPLtJyrA4DynlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222931; c=relaxed/simple;
	bh=6+l4qqO7cPjS+OcdqU60eH6nGjpyL/NFHbenLfxcpMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIKe8WriI00LTgwl/R0sTqmH3iGfvjfKtBu/rsEoQqTqS2S6z+dEMcgrqbytpJSysJ94lIlMNcM1dtb97J+eX/fFi2vbGZZYJ1oeXyoTgnjMdsziQoROEPbYsqq19QIdXG/HiBtD4BxSdfqT5MLN9fCFqTz8hImdgWzmMn4zYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EZAtJaM0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96e5535fcdso500502276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222929; x=1756827729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oFgVZN8uruNsS+lAxR5fVz/AF6jQJFAd4yIk2Hgzw4=;
        b=EZAtJaM0WU0112f52XWnP7zGLYOWofIaG0vGqwFFxLypbdDqpgdOWGYbruEPU4RRcR
         Lw9ZkwwixxrI+XV8lz1J65wF+1W0MwLlArCD+0hROjw01orB5erApny7CXWs0m9g1Q04
         rmEKQmr0aJTIn6laJJjM/7ex+JTZvkAuAIqGnPcSq7H7e+P48iVT3CuCptzAeUg8ZFEU
         xWQ2qVqPTZbdqt2iGbu0PWdpCD15QU2A5uljuHF+bymeKGLxbCuGw1eeu+Zs++HCGCTC
         RsUR6olvcgk7jBLd+mGzMuRtThjd/m8ZtIY5emx3IbQw92P5Nn+E217RZx0l7oZuVemn
         fRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222929; x=1756827729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oFgVZN8uruNsS+lAxR5fVz/AF6jQJFAd4yIk2Hgzw4=;
        b=fWnFMLz/xlWqIjKdn++oJGSNJhQhBA6j+MUTeOasTuEVoVYM9YrJzN6gPJ64XffHMK
         blW8gw9ntvb7lT7b2Nard1L5e9oWKjFEZhDM10GeJPor5KKCyumEX4ADLDsL0Qr13JhJ
         9DEj+Nd8u/aA89ywk8iEl5gcr/KL+lBnpE1rKmXcReJZB9oH4ZInHY2v9mDQWJLFf/hc
         eCX4Q1Scf/KP5Z6mdpDgObyvXXYzCh4OGKS6ig/G1+jRgmRC7hNaDdb3eOMwrZzjDPBa
         YTDRj2653iuGH/9X+H/UXATQlVSU9oAo0lDpr/xTiFlvxR+fC/q0hsTChxXFnoG4pwiX
         /BJQ==
X-Gm-Message-State: AOJu0YzPDcnR1VOdCFll+oHOKIzxHUD7XpqrBbxYLoCAx9TvVUliHMoI
	NNO3vgrCLzsne2jYcpliC/k/WuXsrJnUXCmP97xCXIIiM4P8I0g7AjSfszbSsh6iOYQgnGlnnZF
	nbpyw
X-Gm-Gg: ASbGncuZI4SM6CaCBdrkMKyKevB27Cl87FW5HkOy3A4970ktuNM7A6xA+3yM/UTrbsm
	Kr7/sgwipbICSgCJV2qQEBBUwyyHAcs1K5+D7idVTLxj/Tv7l5ktTc/nIL3YX3LmVY2NTh4CrAk
	uRbwtKgv/vKwIFuCEaSNrgWAFW2fyfreGdfkifUSnaq09xDvK6HCEFwDnnn9HJnyQTD8R+2noa6
	H/R9GrfaMp95DgbzfGf1OxCera0FK4pnbrq/BhNWbid+C9x9yL/wPFoiB8v5ze9XaNzDL9QlDRK
	KlVnWG/CuLaN/RvH2T1UZTU+7xE7BehcgSteDIsmAJTDhpL28lXpA46HDbgPujEtPY56dpA3oT+
	OycEG0F4epYNQG6yfphgYwRi2jgZJWWZITHgcfjvKCsa5ONPqORs466F7HEY=
X-Google-Smtp-Source: AGHT+IEGI2CYZy0ro+Ws/t4KuqvF6KWocw57Sgl44gXc88AHnPC59XkIz9DsxCd0U7oWiB0OUjD3qw==
X-Received: by 2002:a05:690c:62c8:b0:721:2390:e9ae with SMTP id 00721157ae682-72132cd6c2emr21525677b3.26.1756222928448;
        Tue, 26 Aug 2025 08:42:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b3691sm25145037b3.60.2025.08.26.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 54/54] fs: add documentation explaining the reference count rules for inodes
Date: Tue, 26 Aug 2025 11:39:54 -0400
Message-ID: <577f42a4b73d91d537f46e50649d9f6d82206ed7.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we've made these changes to the inode, document the reference
count rules in the vfs documentation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/vfs.rst | 86 +++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 229eb90c96f2..e285cf0499ab 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -457,6 +457,92 @@ The Inode Object
 
 An inode object represents an object within the filesystem.
 
+Reference counting rules
+------------------------
+
+The inode is reference counted in two distinct ways, an i_obj_count refcount and
+an i_count refcount. These control two different lifetimes of the inode. The
+i_obj_count is the simplest, think of it as a reference count on the object
+itself. When the i_obj_count reaches zero, the inode is freed.  Inode freeing
+happens in the RCU context, so the inode is not freed immediately, but rather
+after a grace period.
+
+The i_count reference is the indicator that the inode is "alive". That is to
+say, it is available for use by all the ways that a user can access the inode.
+Once this count reaches zero, we begin the process of evicting the inode. This
+is where the final truncate of an unlinked inode will normally occur.  Once
+i_count has reached 0, only the final iput() is allowed to do things like
+writeback, truncate, etc. All users that want to do these style of operation
+must use igrab() or, in very rare and specific circumstances, use
+inode_tryget().
+
+Every access to an inode must include one of these two references. Generally
+i_obj_count is reserved for internal VFS references, the s_inode_list for
+example. All file systems should use igrab()/lookup() to get a live reference on
+the inode, with very few exceptions.
+
+LRU rules
+---------
+
+This is tightly coupled with the reference counting rules above. If the inode is
+being held on an LRU it must be holding both an i_count and an i_obj_count
+reference. This is because we need the inode to be "live" while it is on the LRU
+so it can be accessed again in the future.
+
+This is different how we traditionally operated. Traditionally we put 0 refcount
+objects on the LRU, and then when eviction happened we would remove the inode
+from the LRU if it had a non-zero refcount, or evict it if it had a zero
+refcount.
+
+Now the rules are much simpler. The LRU has a live reference on the inode. That
+means that eviction simply has to remove the LRU and call iput_evict(), which
+will make sure the inode is not re-added to the LRU when putting the reference.
+If there are other active references to the inode, then when those references
+are dropped the inode will be added back to the LRU.
+
+We have two uses for i_lru, one is for the normal inactive inode LRU, and the
+other is for pinned inodes that are pinned because they are dirty or because
+they have pagecache attached to them.
+
+The dirty case is easy to reason about. If the inode is dirty we cannot reclaim
+it until it has been written back. The inode gets added to super block's cached
+inode list when it is dirty, and removed when it is clean.
+
+The pagecache case is a little more complex. The VM wants to pin inodes into
+memory as long as they have pagecache. This is because the pagecache has much
+better reclaim logic, it accounts for thrashing and refaulting, so it needs to
+be the ultimate arbiter of when an inode can be reclaimed. The inode remains on
+the cached list as long as it has pagecache to account for this. When pages are
+removed from the inode the VM calls inode_add_lru() to see if the inode still
+needs to be on the cached list or on the inactive LRU.
+
+Holding a live reference on the inode has one drawback. We must remove the inode
+from the LRU in more cases that previously, which can increase contention on the
+LRU. In practice this won't be a problem, because we only put the inode on the
+LRU that doesn't have a dentry associated with it. When we grab a live reference
+to an inode we must delete it from the LRU in order to make sure that any unlink
+operation results in the inode being removed on the final iput().
+
+Consider the case where we've removed the last dentry from an inode and the
+inode is added to the LRU list. We then lookup the inode to do an unlink. The
+final iput in the unlink path will just reduce the i_count to 1, and the inode
+will not be truly removed until eviction or unmount.  To avoid this we have two
+choices, make sure we delete the inode from the LRU at
+drop_nlink()/clear_nlink() time, or make sure we delete the inode from the LRU
+when we grab a live reference to it. We cannot do the drop at
+drop_nlink()/clear_nlink() time because we could be holding the i_lock.
+Additionally there are awkward things like BTRFS subvolume delete that do not
+use the nlink of the subvolume as the indicator that it needs to be removed, and
+so we would have to audit all of the possible unlink paths to make sure we
+properly deleted the inode from the LRU. Instead, to provide a more robust
+system, we remove an inode from the LRU at igrab() time. Internally where we're
+already holding the i_lock and use inode_tryget() we will delete the inode from
+the LRU at this point.
+
+The other case is in the unlink path itself. If there was a truncate at all we
+could have ended up on the cached list, so we already have an elevated i_count.
+Removing the inode from the LRU explicitly at this stage is necessary to make
+sure the inode is freed as soon as possible.
 
 struct inode_operations
 -----------------------
-- 
2.49.0


