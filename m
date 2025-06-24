Return-Path: <linux-fsdevel+bounces-52686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A3AE5D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73BD3B489C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073A57C9F;
	Tue, 24 Jun 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="LzE+sqN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQyJ40h1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AE23ED5A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747742; cv=none; b=vCYH6ySXpyeYKsTO7+lRNKAH3xYu6W3fOSPy9hovPDXBCg28RqCFSFoKOZyna3vgbahkhZLZpnqKMHaEu3VJ6a5CTH7+OFsq2ryWNa6jfsZcrUk9ur+raVd0pKfbYq5xIT057syJTjuK1SbeydGJWvYjXq0J2E58eDi19uvUd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747742; c=relaxed/simple;
	bh=2FyipUH9qzlDCwUZ6jK4m5v9mKMKoxnMBry9n4+tJVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFz63YjdfHxVL5ZWakPrITHkSze++Fm2qfpHwE0QptwnfTh7aNGjnBuU+3YHEp8O03b8BEf3ppZXEKQWyel/f9bkRylThKS6RNCPXhXeeqFs0cqfsenoe1OjeLgodJhrpm44oFpBaKQrrn9tg9PH0b/CWNYfDz9Aue5CeY/1eJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=LzE+sqN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQyJ40h1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 66BC713807CA;
	Tue, 24 Jun 2025 02:48:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Jun 2025 02:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750747738;
	 x=1750834138; bh=JBTDdXhjUEapgS7FwhHX3E8h+VI2oi+JTHtfodoXhTs=; b=
	LzE+sqN4leqmD3zVg0O61LVH0MvnHOatP1Q7L/aJ5xA1i8/hrCypk+yLpHo5OPHl
	nfv9fpUirUejCPFMkyNZUgBSo+2cD+98QJKfDMRWSQzWArDhkkki6Pf2g3E2453B
	JXARWKSdKOK/DpXCMxaGUVTaHg/U8dUim6g5FQuQ6gxu/7g9+A0TJNenLaAlUQaI
	1qOJaRrUlIxB8Lpq2n2yv2NEwmAb0TfKZptK9VwXfjvkq5tna1ueVrBTNtIh6w2p
	RVoJfQEEoZoIuDJVULaRtwV6QD6J+Kbox3qRlsLUFcpronnBX7m3toU9AbyyG+Bm
	7MTG4nu7/aZy+6d8PGPBwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750747738; x=
	1750834138; bh=JBTDdXhjUEapgS7FwhHX3E8h+VI2oi+JTHtfodoXhTs=; b=f
	QyJ40h1OVoE13HioFo2FjonpSZ7GdYYplzxIo8VFeFSlFkrYCpMieW326j5mJSlL
	3ztQIiDkkR7soOXEYNybzMLRSCVtpR9bErWJAsMHPvW1GaTO5AiaPXpISHUhOwv2
	QCdXnP7P+pP7rnH3zfQEmdSmk5yGl+XPzUuB90OIxY4CMfg04J8NpdGCyy7x329Y
	IWF2ECUPoh26dHL6yY562YXsqlSOOEUu/WRw5hc5SA9UgzZ5DaF1l7OvsDEKZ1PJ
	2zjS5dckBIXwzsWgCshOfU4D5QTtyyz0e+Z0KRz9Aa3aN2iAE13CYNzLwAULre1u
	dU11OqrMLhSiZ/W+hRGkw==
X-ME-Sender: <xms:WUpaaFRkyTRy9CHc2oEOa3p_UOquLaH_x_StIJB0JqCCG1pXBCbgvA>
    <xme:WUpaaOxLSQevdX3SlG4PkPQaOdiXPmpf0SyWcvJyFaewmnkTd76AbrkMbjx_Zc9Rw
    -pxAWxPNdMh>
X-ME-Received: <xmr:WUpaaK2zW5EFzNGZgBHsHKFeXs-O9-IUKkNgZ6XrbwpLGykNZecDM9-9EDzzr5CiYjcliAuwEDeMPV54iMtULMl3Dg3GZ6xjEXo8UWcGhim_5Fi81qwhIQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedtud
    fghedtudfgfefgtdejgedutddtveefheetvdefueefgffggfdvieelteffgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrd
    gtohhm
X-ME-Proxy: <xmx:WUpaaNBa2DXUVaqvLEjZWH7I4peR4D4hZQ1XvvsVBT7zqBxUAlW35A>
    <xmx:WUpaaOhOuaJmPRWkSTW8hMYZPLEB27kVYrXrf4d36apZDfTMzQRhdg>
    <xmx:WUpaaBqlkTSZkZ0MBfDOn4UYyggQumrnexGwMcbq79jajPmGxdH3lw>
    <xmx:WUpaaJg57m7MTjQDqTuAW0a3AYsDcQepAvjsQ-ujyf1aG3fKl7Fvqg>
    <xmx:WkpaaFhHBdKDSUlSu2_oUTgHDfy-8TfksDKutwT0gfLrDZzlRr7jg6pm>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 02:48:55 -0400 (EDT)
Message-ID: <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
Date: Tue, 24 Jun 2025 14:48:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>
References: <20250610081758.GE299672@ZenIV> <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
 <20250623185540.GH1880847@ZenIV>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250623185540.GH1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/6/25 02:55, Al Viro wrote:
> On Mon, Jun 23, 2025 at 05:06:52PM +0800, Ian Kent wrote:
>
>> I also have revived my patch to make may_umount_tree() namespace aware
>>
>> and it still seems to work fine.
> Could you post it?


Not sure the formatting will be ok since my email setup is a mess.

It's against the v1 of your series.


Your advice (and Christian and others) would be much appreciated.


vfs: make may_umount_tree() mount namespace aware

From: Ian Kent <ikent@redhat.com>

Change may_umount_tree() to also check if propagated mounts are busy
during autofs expire runs.

Also alter may_umount_tree() to take a flag to indicate a reference to
the passed in mount is held.

This avoids unnecessary umount requests being sent to the automount
daemon if a mount in another mount namespace is in use when the expire
check is done.

Signed-off-by: Ian Kent <raven@themaw.net>
---
  fs/autofs/expire.c    |    4 ++--
  fs/namespace.c        |   36 ++++++++++++++++++++++++++++++------
  fs/pnode.c            |   32 ++++++++++++++++++++++++++++++++
  fs/pnode.h            |    1 +
  include/linux/mount.h |    5 ++++-
  5 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e48..c303d11f4c12 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -55,7 +55,7 @@ static int autofs_mount_busy(struct vfsmount *mnt,
      }

      /* Update the expiry counter if fs is busy */
-    if (!may_umount_tree(path.mnt)) {
+    if (!may_umount_tree(path.mnt, TREE_BUSY_REFERENCED)) {
          struct autofs_info *ino;

          ino = autofs_dentry_ino(top);
@@ -156,7 +156,7 @@ static int autofs_direct_busy(struct vfsmount *mnt,
          return 0;

      /* If it's busy update the expiry counters */
-    if (!may_umount_tree(mnt)) {
+    if (!may_umount_tree(mnt, TREE_BUSY_REFERENCED)) {
          struct autofs_info *ino;

          ino = autofs_dentry_ino(top);
diff --git a/fs/namespace.c b/fs/namespace.c
index bb95e5102916..3cb90bb46b94 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1635,25 +1635,49 @@ const struct seq_operations mounts_op = {
  /**
   * may_umount_tree - check if a mount tree is busy
   * @m: root of mount tree
+ * @flags: behaviour modifier flags:
+ *     TREE_BUSY_REFERENCED caller holds additional reference
+ *     to @m.
   *
   * This is called to check if a tree of mounts has any
   * open files, pwds, chroots or sub mounts that are
   * busy.
   */
-int may_umount_tree(struct vfsmount *m)
+bool may_umount_tree(struct vfsmount *m, unsigned int flags)
  {
      struct mount *mnt = real_mount(m);
+    struct mount *p, *q;
      bool busy = false;

-    /* write lock needed for mnt_get_count */
+    down_read(&namespace_sem);
      lock_mount_hash();
-    for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
-        if (mnt_get_count(p) > (p == mnt ? 2 : 1)) {
-            busy = true;
-            break;
+    for (p = mnt; p; p = next_mnt(p, mnt)) {
+        unsigned int f = 0;
+
+        if (p->mnt_mountpoint != mnt->mnt.mnt_root) {
+            if (p == mnt)
+                f = flags;
+            if (propagate_mount_tree_busy(p, f)) {
+                busy = true;
+                break;
+            }
+            continue;
+        }
+
+        /* p is a covering mnt, need to check if p or any of its
+         * children are in use. A reference to p is not held so
+         * don't pass TREE_BUSY_REFERENCED to the propagation
+         * helper.
+         */
+        for (q = p; q; q = next_mnt(q, p)) {
+            if (propagate_mount_tree_busy(q, f)) {
+                busy = true;
+                break;
+            }
          }
      }
      unlock_mount_hash();
+    up_read(&namespace_sem);

      return !busy;
  }
diff --git a/fs/pnode.c b/fs/pnode.c
index efed6bb20c72..e4222a008039 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -429,6 +429,38 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
      return 0;
  }

+/*
+ * Check if the mount tree at 'mnt' is in use or any of its
+ * propogated mounts are in use.
+ * @mnt: the mount to be checked
+ * @flags: see may_umount_tree() for modifier descriptions.
+ *
+ * Check if mnt or any of its propogated mounts have a reference
+ * count greater than the minimum reference count (ie. are in use).
+ */
+int propagate_mount_tree_busy(struct mount *mnt, unsigned int flags)
+{
+    struct mount *m;
+    struct mount *parent = mnt->mnt_parent;
+    int refcnt = flags & TREE_BUSY_REFERENCED ? 2 : 1;
+
+    if (do_refcount_check(mnt, refcnt))
+        return 1;
+
+    for (m = propagation_next(parent, parent); m;
+            m = propagation_next(m, parent)) {
+        struct mount *child;
+
+        child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
+        if (!child)
+            continue;
+
+        if (do_refcount_check(child, 1))
+            return 1;
+    }
+    return 0;
+}
+
  /*
   * Clear MNT_LOCKED when it can be shown to be safe.
   *
diff --git a/fs/pnode.h b/fs/pnode.h
index bfc10c095cbf..a0d2974e57d7 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -46,6 +46,7 @@ int propagate_mnt(struct mount *, struct mountpoint *, 
struct mount *,
          struct hlist_head *);
  void propagate_umount(struct list_head *);
  int propagate_mount_busy(struct mount *, int);
+int propagate_mount_tree_busy(struct mount *, unsigned int);
  void propagate_mount_unlock(struct mount *);
  void mnt_release_group_id(struct mount *);
  int get_dominating_id(struct mount *mnt, const struct path *root);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index cae7324650b6..d66555cc8e96 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -114,7 +114,10 @@ extern bool our_mnt(struct vfsmount *mnt);

  extern struct vfsmount *kern_mount(struct file_system_type *);
  extern void kern_unmount(struct vfsmount *mnt);
-extern int may_umount_tree(struct vfsmount *);
+
+#define TREE_BUSY_REFERENCED        0x01
+
+extern bool may_umount_tree(struct vfsmount *, unsigned int);
  extern int may_umount(struct vfsmount *);
  int do_mount(const char *, const char __user *,
               const char *, unsigned long, void *);


