Return-Path: <linux-fsdevel+bounces-51703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D9ADA67C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 04:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C09918900AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0148D1DE2D8;
	Mon, 16 Jun 2025 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="GdMNZPTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNoVEsEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A7AD58
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042268; cv=none; b=qDHzE/xUM6T9JLrL9xJzZqvRYXcQ1ydUTbXLQJIVrKnzanmL2E7L1ICLHQajJ3PX3kdkx47i07wKc6pkzAgCJoAvDGu1r9H1GYFe3a66K3cUm6ndkbVgMV4LMah4d5ANoARusKtKP1yJYYlGcmn4kGYs6rg0YnJxOe1gtZkPHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042268; c=relaxed/simple;
	bh=RLLJWZfQ08Z5SkqI1HEGhpzj4t3AmquwGeUq442iUQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gurkj/rauDWZ2OdTJM/j5j2gnoAb+M4+fRGBUQ/ZrkvrmFekZDwErDVUt9Vrx2qCcprytz9XrLxxGLqxBTxhxeXW704Hl9eG7olLi+E3ogkEuB2u2yAUTG3vcDSvGs/RjcmWPtxAnpyhJWr5GcK55TSe/IB1902mn1X1zr3oYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=GdMNZPTw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNoVEsEt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5EC51140295;
	Sun, 15 Jun 2025 22:51:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 15 Jun 2025 22:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750042264;
	 x=1750128664; bh=9ZWkuuw41tpzbeY2Rekc9BSpp2FQ2nnCCTfcKn5Oy9Q=; b=
	GdMNZPTwSI1aS2O59zy4wrISnhC96HCfW6aoJwlM447L1Q3Gt2CVC8NyW3j72Xg1
	dj2HLBdcssMttBYjf34Fh5iewsmMQbbdddV5Bd5niygXOpVxxIMmJmHriOm9pOQN
	KFa3vWv7x/viyD5GD2yqrCFJS4cK9a4V07dC+Uy9WXOFmr+kSwOCYs3fzKcSbXF1
	Lm/lOfCYzskE0QXRSw3Ag+UOjbZNkB91FUk6582IvzdQXDaFgAMPKg/gMnT94dqZ
	m5OjJ3L9ECdzMeuYL58G/jJlqYo0NRBIR6WPweQSpzvJWewOCOv1EHIhqB0wbyv7
	rr/u/rjLlRZOfl3p1AKDYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750042264; x=
	1750128664; bh=9ZWkuuw41tpzbeY2Rekc9BSpp2FQ2nnCCTfcKn5Oy9Q=; b=S
	NoVEsEtKO3WUPztXBeRS7XbJHub10XUYnWC6niRi6Rbs77Jk2EAhGpg9pGBH7Dzo
	zqlBiwosvqo/f9WDWvrs6fuYOXCEKLq22oaLFmIFnuSrG7WBzlqLvQ4Oj915CrDc
	nFsgYl/1BMaGD5K7T7pguZJUAOViXhSYmwWfb2GvNzGtALBf1j0c/q446+PCbFT9
	SH7M/kt+l+2Fi5CvFIagL21QBRrKWylLJ9q+4U3lFKxorbegvHPQQFP7YkOJt79J
	96hhSGiSjZA87yN1bVWqTElHNy9quDrVEIQhV0yjy5OeEcfmGbJBCao1mxQu5nnr
	c1e1Z036ll6mkGCR/0Fgw==
X-ME-Sender: <xms:mIZPaEC2ZyDGpYa7NN5EMLGCGZykvEGgk2H5gfjTVYCbVSUx-fdFDA>
    <xme:mIZPaGg13MRufYOAU_DB9TQ_Ief-iCtVAqGHsM0uxG1Ysgq3TinPURnhYf2m-yswo
    v0FjBwTPMP7>
X-ME-Received: <xmr:mIZPaHmF_gxJfc1rib1A3-kozmMTGRzStRHul64KYHbgLptTqRqzBMJEVBypFF5yFeJdBfSCbqszb3EuAEZ-LGSOaXq0ynnYp-7QHErqTSQIeIq5smXDkNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqe
    enucggtffrrghtthgvrhhnpeefkefhgeeigeetleffgeelteejkeduvdfhheejhfehueei
    tdehuefhkeeukeffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuh
    igrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphht
    thhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgusheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:mIZPaKz2uHIJP-3-bKosRX1bZp1NtHmx0Pb617NLVdMVjCKzdmAkuw>
    <xmx:mIZPaJRTM9H4K1OWmDLaJ10zJeaTuyeoxTaML5ctuxlQX6o6ifwMbg>
    <xmx:mIZPaFYqSBU1u5tvo6LwcQPp1NEt8V2y6Lwo0IVoMhwgE3wEiqJcUQ>
    <xmx:mIZPaCTcqPN3QUJA2Mo5ZBUq0ujh2AuvqnlnvKythOjzbSlqzljB_w>
    <xmx:mIZPaAShFgwPrjL78rnd9TAnURo6H7OcZWU2lQZ0D-9a5etByGuwgnEE>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 22:51:01 -0400 (EDT)
Message-ID: <44330b00-71ca-4699-b4a0-8926348ffe87@themaw.net>
Date: Mon, 16 Jun 2025 10:50:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/26] don't have mounts pin their parents
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
 torvalds@linux-foundation.org
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-26-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250610082148.1127550-26-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 16:21, Al Viro wrote:
> Simplify the rules for mount refcounts.  Current rules include:
> 	* being a namespace root => +1
> 	* being someone's child => +1
> 	* being someone's child => +1 to parent's refcount, unless you've
> 				   already been through umount_tree().
>
> The last part is not needed at all.  It makes for more places where need
> to decrement refcounts and it creates an asymmetry between the situations
> for something that has never been a part of a namespace and something that
> left one, both for no good reason.
>
> If mount's refcount has additions from its children, we know that
> 	* it's either someone's child itself (and will remain so
> until umount_tree(), at which point contributions from children
> will disappear), or
> 	* or is the root of namespace (and will remain such until
> it either becomes someone's child in another namespace or goes through
> umount_tree()), or
> 	* it is the root of some tree copy, and is currently pinned
> by the caller of copy_tree() (and remains such until it either gets
> into namespace, or goes to umount_tree()).
> In all cases we already have contribution(s) to refcount that will last
> as long as the contribution from children remains.  In other words, the
> lifetime is not affected by refcount contributions from children.
>
> It might be useful for "is it busy" checks, but those are actually
> no harder to express without it.
>
> NB: propagate_mnt_busy() part is an equivalent transformation, ugly as it
> is; the current logics is actually wrong and may give false negatives,
> but fixing that is for a separate patch (probably earlier in the queue).

This looks a lot like the patch you sent over long ago, ;)


I did spend quite a bit of time on fixing may_umount_tree() but I was always

concerned about how the parent ref count change would be received and I had

trouble with one of my two patches which essentially tried to add an fairly

aggressive optimization. Early on I had it working but kept getting the 
feeling

it was too aggressive and later it stopped working and I couldn't work 
out how

to fix it so I dropped it.


In any case the first of my patches always worked and IMHO is adequate to be

used to fix the may_umount_tree() namespace awareness problem. I guess 
we may

soon see if all goes well with this series.


I'll run my two usual autofs tests against this (once I've setup an VM 
for it)

and report back.


>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/namespace.c | 31 +++++++++--------------------
>   fs/pnode.c     | 53 ++++++++++++++++++++------------------------------
>   2 files changed, 30 insertions(+), 54 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1f1cf1d6a464..1bfc26098fe3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1072,7 +1072,6 @@ void mnt_set_mountpoint(struct mount *mnt,
>   			struct mountpoint *mp,
>   			struct mount *child_mnt)
>   {
> -	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
>   	child_mnt->mnt_mountpoint = mp->m_dentry;
>   	child_mnt->mnt_parent = mnt;
>   	child_mnt->mnt_mp = mp;
> @@ -1112,7 +1111,6 @@ static void attach_mnt(struct mount *mnt, struct mount *parent,
>   void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
>   {
>   	struct mountpoint *old_mp = mnt->mnt_mp;
> -	struct mount *old_parent = mnt->mnt_parent;
>   
>   	list_del_init(&mnt->mnt_child);
>   	hlist_del_init(&mnt->mnt_mp_list);
> @@ -1121,7 +1119,6 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
>   	attach_mnt(mnt, parent, mp);
>   
>   	maybe_free_mountpoint(old_mp, &ex_mountpoints);
> -	mnt_add_count(old_parent, -1);
>   }
>   
>   static inline struct mount *node_to_mount(struct rb_node *node)
> @@ -1646,23 +1643,19 @@ const struct seq_operations mounts_op = {
>   int may_umount_tree(struct vfsmount *m)
>   {
>   	struct mount *mnt = real_mount(m);
> -	int actual_refs = 0;
> -	int minimum_refs = 0;
> -	struct mount *p;
> -	BUG_ON(!m);
> +	bool busy = false;
>   
>   	/* write lock needed for mnt_get_count */
>   	lock_mount_hash();
> -	for (p = mnt; p; p = next_mnt(p, mnt)) {
> -		actual_refs += mnt_get_count(p);
> -		minimum_refs += 2;
> +	for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
> +		if (mnt_get_count(p) > (p == mnt ? 2 : 1)) {
> +			busy = true;
> +			break;
> +		}

This function is broken, it's not namespace aware (as you know).

But, surprisingly, it's adequate in many cases.

For example autofs uses this when expiring trees of mounts and v5 does 
this in subtrees

from the bottom up so the single level check works fine unless it's in 
use in another

namespace which (surprisingly) doesn't happen very often. In any case 
the consequence

is it fails to umount a subtree or two which must be handled by the 
daemon anyway.


Nevertheless the namespace awareness needs to be fixed.


Ian

>   	}
>   	unlock_mount_hash();
>   
> -	if (actual_refs > minimum_refs)
> -		return 0;
> -
> -	return 1;
> +	return !busy;
>   }
>   
>   EXPORT_SYMBOL(may_umount_tree);
> @@ -1863,7 +1856,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>   
>   		disconnect = disconnect_mount(p, how);
>   		if (mnt_has_parent(p)) {
> -			mnt_add_count(p->mnt_parent, -1);
>   			if (!disconnect) {
>   				/* Don't forget about p */
>   				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
> @@ -1940,7 +1932,7 @@ static int do_umount(struct mount *mnt, int flags)
>   		 * all race cases, but it's a slowpath.
>   		 */
>   		lock_mount_hash();
> -		if (mnt_get_count(mnt) != 2) {
> +		if (!list_empty(&mnt->mnt_mounts) || mnt_get_count(mnt) != 2) {
>   			unlock_mount_hash();
>   			return -EBUSY;
>   		}
> @@ -3640,9 +3632,7 @@ static int do_move_mount(struct path *old_path,
>   out:
>   	unlock_mount(&mp);
>   	if (!err) {
> -		if (!is_anon_ns(ns)) {
> -			mntput_no_expire(parent);
> -		} else {
> +		if (is_anon_ns(ns)) {
>   			/* Make sure we notice when we leak mounts. */
>   			VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
>   			free_mnt_ns(ns);
> @@ -4710,7 +4700,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>   	/* mount new_root on / */
>   	attach_mnt(new_mnt, root_parent, root_mnt->mnt_mp);
>   	umount_mnt(root_mnt);
> -	mnt_add_count(root_parent, -1);
>   	/* mount old root on put_old */
>   	attach_mnt(root_mnt, old_mnt, old_mp.mp);
>   	touch_mnt_namespace(current->nsproxy->mnt_ns);
> @@ -4723,8 +4712,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>   	error = 0;
>   out4:
>   	unlock_mount(&old_mp);
> -	if (!error)
> -		mntput_no_expire(ex_parent);
>   out3:
>   	path_put(&root);
>   out2:
> diff --git a/fs/pnode.c b/fs/pnode.c
> index f1752dd499af..efed6bb20c72 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -332,21 +332,6 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
>   	return ret;
>   }
>   
> -static struct mount *find_topper(struct mount *mnt)
> -{
> -	/* If there is exactly one mount covering mnt completely return it. */
> -	struct mount *child;
> -
> -	if (!list_is_singular(&mnt->mnt_mounts))
> -		return NULL;
> -
> -	child = list_first_entry(&mnt->mnt_mounts, struct mount, mnt_child);
> -	if (child->mnt_mountpoint != mnt->mnt.mnt_root)
> -		return NULL;
> -
> -	return child;
> -}
> -
>   /*
>    * return true if the refcount is greater than count
>    */
> @@ -404,12 +389,8 @@ bool propagation_would_overmount(const struct mount *from,
>    */
>   int propagate_mount_busy(struct mount *mnt, int refcnt)
>   {
> -	struct mount *m, *child, *topper;
>   	struct mount *parent = mnt->mnt_parent;
>   
> -	if (mnt == parent)
> -		return do_refcount_check(mnt, refcnt);
> -
>   	/*
>   	 * quickly check if the current mount can be unmounted.
>   	 * If not, we don't have to go checking for all other
> @@ -418,23 +399,31 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
>   	if (!list_empty(&mnt->mnt_mounts) || do_refcount_check(mnt, refcnt))
>   		return 1;
>   
> -	for (m = propagation_next(parent, parent); m;
> +	if (mnt == parent)
> +		return 0;
> +
> +	for (struct mount *m = propagation_next(parent, parent); m;
>   	     		m = propagation_next(m, parent)) {
> -		int count = 1;
> -		child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
> -		if (!child)
> -			continue;
> +		struct list_head *head;
> +		struct mount *child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
>   
> -		/* Is there exactly one mount on the child that covers
> -		 * it completely whose reference should be ignored?
> -		 */
> -		topper = find_topper(child);
> -		if (topper)
> -			count += 1;
> -		else if (!list_empty(&child->mnt_mounts))
> +		if (!child)
>   			continue;
>   
> -		if (do_refcount_check(child, count))
> +		head = &child->mnt_mounts;
> +		if (!list_empty(head)) {
> +			struct mount *p;
> +			/*
> +			 * a mount that covers child completely wouldn't prevent
> +			 * it being pulled out; any other would.
> +			 */
> +			if (head->next != head->prev)
> +				continue;
> +			p = list_first_entry(head, struct mount, mnt_child);
> +			if (p->mnt_mountpoint != p->mnt.mnt_root)
> +				continue;
> +		}
> +		if (do_refcount_check(child, 1))
>   			return 1;
>   	}
>   	return 0;

