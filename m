Return-Path: <linux-fsdevel+bounces-13042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40B86A786
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A71F24C96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 04:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D5208A9;
	Wed, 28 Feb 2024 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNEqdi28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E2200B7;
	Wed, 28 Feb 2024 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094039; cv=none; b=tGugleM6cQNKABt32L3QD6uZcNy59EB8p1O0GbxybBdYEFOe9RCI53uN+iGBytuPBkQ/x7nagOmzmeskjyhOjOJrxLUV1Y/LChyzEEm6+c1SiNJ789AFj2N7dZof+90sfPEM9dmIKqB4iZiahGDb0iSOipykJVA73yhK+f6lIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094039; c=relaxed/simple;
	bh=ZPm+GwZd577nB8ZUduThtSFZ2o4FAjzwXa4um3NIR7U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gaxN2x1n1LRk8tJM/Lx+cp6ahMK0LnsYkUJA/8G7jadAcTrSGj5esocCEuAE1dq1TabqWShDN0I7osfxI2G7GNPRWUr9U7/L7lD4cGv0Ikqem0dxR63iIXfpVWN3TPORG6gVHY7OqVRst+uLCS0X3Nh7G+9LEJ6WPafSi6ph36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNEqdi28; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29ac703a6b5so1808362a91.1;
        Tue, 27 Feb 2024 20:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709094037; x=1709698837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eodb5CvdSe9XMcvk7dNogUgkp553bG/HJKa75f7yVdo=;
        b=MNEqdi2875+e9e9fcEghXr+oQkjnnzLNSuX7hWp1sOWxYhmzTh8tl36h97mI5RmaQm
         nG/+DoHvg//pCFTA5fK8Ae3yR76fbGajttrBkR0utv1yhio6oQ1/vcEGo3P/J0KnqGuN
         ng1DNb0QCOHi6ga6ttqTRKaiMzL2hbpFLEv5YQZuWmDC9a7YpK+3cRLj0dXMCnTv1VjF
         /ze7sHiLkVpUXoP/wUhzgerdVladzEfc/aJnf7T5fgMl5G8iv/8CzTJ/0gHd0vYZa3ib
         SVQpNhJqKhbtsljRpIY2wsNc+srBbzLZL92Eo+4rOIEAglkCvg0EUhY1MK7iA0/8p42V
         WjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709094037; x=1709698837;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eodb5CvdSe9XMcvk7dNogUgkp553bG/HJKa75f7yVdo=;
        b=RfFUKYcz9t7kLVaEhhicyNPRB0OGrfkBvkLtJyE51cmkE5likq7NYv2M8u7roG+imQ
         apcANVQ6IHyG16CuGonniBhw+tsLo6/+Qzf2l4MCc+LOvVXZTqJNBcHjraQTM64S7+9M
         mX2H5kIM/HC4XSALSNiCeXnHW4q0osjc0aKkGB5mw4sj4FRvYgokriZf/N+X12+GrKjC
         p60xxVTHKKAZjEFhXkxyin0IprCm+cqE6oVWFYHzwUh/baKTZsnff2FNDybHD3bS5lTp
         Wl1TCqhCRO4u6wSNpe9M0KyX0nNEY1VHZV0k9eo6UEdvPilrndCLqIhjpdANKZezi+YQ
         IcLg==
X-Forwarded-Encrypted: i=1; AJvYcCXy/Yj+LgVeMjSB6WLY6XPJ/UVvqWEvb+NIU7Uh8DFERh6SBC2EaC5nrAqju5o3MMfK5Z1maz4RBCrMlNEcVDcyT3bgYD/KqiIAXLzgFA==
X-Gm-Message-State: AOJu0YxlGrYZUvxl0U6WxCXjucrZSN3JpNyWdP2SeKf2+klrWGZLJam8
	3LCnweoExEkXAi362jUHBuSUAP9SRqA4NK7oOpAi5w+SZ1spdYNEYpKLZW8N
X-Google-Smtp-Source: AGHT+IFymfFEYEELHm32gHj7f94GcsRR7ihpvMnl+6WjMfMapVM0npL3P5d7dH8magjlV8kbWS/5VQ==
X-Received: by 2002:a17:90b:1b44:b0:299:2d59:a3d2 with SMTP id nv4-20020a17090b1b4400b002992d59a3d2mr9440704pjb.32.1709094037200;
        Tue, 27 Feb 2024 20:20:37 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090ad60800b00296a23e407csm419790pju.7.2024.02.27.20.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 20:20:36 -0800 (PST)
Message-ID: <4d7c9c8b-4fc0-4ed8-8be7-627daf8f4018@gmail.com>
Date: Wed, 28 Feb 2024 13:20:35 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: viro@kernel.org
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 torvalds@linux-foundation.org, Akira Yokosawa <akiyks@gmail.com>
References: <Zd2XqwmAtNFe1Is9@duke.home>
Subject: Re: [RFC][v3] documentation on filesystem exposure to RCU pathwalk
 from fs maintainers' POV
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <Zd2XqwmAtNFe1Is9@duke.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Al,

I'm not a VFS/FS person, but just wanted to suggest proper formatting
of footnotes in ReST.

On Tue, 27 Feb 2024 03:04:59 -0500, Al Viro wrote:
...
> On Mon, Feb 26, 2024 at 01:35:12PM -0500, Al Viro wrote:
>> Updated variant follows.  Changes since the previous:
>> * beginning has been rewritten
>> * typos spotted by Randy should be fixed
>> * dumb braino in "opt out" part fixed (->d_automount is irrelevant, it's
>> ->d_manage one needs to watch out for)
>> * a stale bit in discussion of ->permission() ("currently (6.5) run afoul")
>> updated (to "did (prior to 6.8-rc6) run afoul").
>> * I gave up on ReST footnotes and did something similar manually.

But first, one of enumerated lists here:

> Opting out
> ==========
> 
> To large extent a filesystem can opt out of RCU pathwalk; that loses all
> scalability benefits whenever your filesystem gets involved in pathname
> resolution, though.  If that's the way you choose to go, just make sure
> that
> 
> 1. any non-default ->d_revalidate(), ->permission(), ->get_link() and
> ->get_inode_acl() instance bails out if called by RCU pathwalk (see below
> for details).  Costs a couple of lines of boilerplate in each.
> 
> 2. if some symlink inodes have ->i_link set to a dynamically allocated
> object, that object won't be freed without an RCU delay.  Anything
> coallocated with inode is fine, so's anything freed from ->free_inode().
> Usually comes for free, just remember to avoid freeing directly
> from ->destroy_inode().
> 
> 3. any ->d_hash() and ->d_compare() instances (if you have those) do
> not access any filesystem objects.
> 
> 4. there's no ->d_manage() instances in your filesystem.
>
> If your case does not fit the above, the easy opt-out is not for you.
> If so, you'll have to keep reading...

is not recognized by Sphinx due to missing indents.

You need to indent each item as shown bellow:

----------8-<---------------
Opting out
==========

To large extent a filesystem can opt out of RCU pathwalk; that loses all
scalability benefits whenever your filesystem gets involved in pathname
resolution, though.  If that's the way you choose to go, just make sure
that

1. any non-default ->d_revalidate(), ->permission(), ->get_link() and
   ->get_inode_acl() instance bails out if called by RCU pathwalk (see below
   for details).  Costs a couple of lines of boilerplate in each.

2. if some symlink inodes have ->i_link set to a dynamically allocated
   object, that object won't be freed without an RCU delay.  Anything
   coallocated with inode is fine, so's anything freed from ->free_inode().
   Usually comes for free, just remember to avoid freeing directly
   from ->destroy_inode().

3. any ->d_hash() and ->d_compare() instances (if you have those) do
   not access any filesystem objects.

4. there's no ->d_manage() instances in your filesystem.

If your case does not fit the above, the easy opt-out is not for you.
If so, you'll have to keep reading...
----------8-<---------------

Missing indents is also the reason why your footnotes didn't work as you
expected.

Diff below partially reverts your v2 changes WRT footnotes and does
proper indents in footnote contents area.

----------8-<---------------
--- a/Documentation/filesystems/rcu-exposure.rst
+++ b/Documentation/filesystems/rcu-exposure.rst
@@ -42,7 +42,7 @@ caller deliberately does *not* take steps that would normally protect
 the object from being torn down by another thread while the method is
 trying to work with it.  That applies not just to dentries - associated
 inodes and even the filesystem instance the object belongs to could be
-in process of getting torn down (yes, really - see [0] for details).
+in process of getting torn down (yes, really).\ [#f0]_
 Of course, from the filesystem POV every call like that is a potential
 source of headache.
 
@@ -188,8 +188,8 @@ when called for dying dentry - an incorrect return value won't harm the
 caller in such case.  False positives and false negatives alike - the
 callers take care of that.  To be pedantic, make that "false positives
 do not cause problems unless they have ->d_manage()", but ->d_manage()
-is present only on autofs and there's no autofs ->d_compare() instances.
-See [1] for details, if you are curious.
+is present only on autofs and there's no autofs ->d_compare()
+instances.\ [#f1]_
 
 There is no indication that ->d_compare() is called in RCU mode;
 the majority of callers are such, anyway, so we need to cope with that.
@@ -321,8 +321,7 @@ goes there [this is NOT a suggestion, folks].
 
 Again, this can be called in RCU mode.  Even if your ->d_revalidate()
 always returns -ECHILD in RCU mode and kicks the pathwalk out of it,
-you can't assume that ->get_link() won't be reached (see [2] for
-details).
+you can't assume that ->get_link() won't be reached.\ [#f2]_
 
 NULL dentry argument is an indicator of unsafe call; if you can't handle
 it, just return ERR_PTR(-ECHILD).  Any allocations you need to do (and
@@ -350,13 +349,14 @@ bailout is done by returning ERR_PTR(-CHILD) and the usual considerations
 apply for any access to data structures you might need to do.
 
 
-Footnotes
-=========
+.. rubric:: Footnotes
 
-[0]  The fast path of pathname resolution really can run into a dentry on
-a filesystem that is getting shut down.
+.. [#f0]
 
-Here's one of the scenarios for that to happen:
+  The fast path of pathname resolution really can run into a dentry on
+  a filesystem that is getting shut down.
+
+  Here's one of the scenarios for that to happen:
 
 	1. have two threads sharing fs_struct chdir'ed on that filesystem.
 	2. lazy-umount it, so that the only thing holding it alive is
@@ -366,54 +366,54 @@ Here's one of the scenarios for that to happen:
 	4. at the same time the second thread does fchdir(), moving to
 	   different directory.
 
-In fchdir(2) we get to set_fs_pwd(), which set the current directory
-to the new place and does mntput() on the old one.  No RCU delays here,
-we calculate the refcount of that mount and see that we are dropping
-the last reference.  We make sure that the pathwalk in progress in
-the first thread will fail when it comes to legitimize_mnt() and do this
-(in mntput_no_expire())::
+  In fchdir(2) we get to set_fs_pwd(), which set the current directory
+  to the new place and does mntput() on the old one.  No RCU delays here,
+  we calculate the refcount of that mount and see that we are dropping
+  the last reference.  We make sure that the pathwalk in progress in
+  the first thread will fail when it comes to legitimize_mnt() and do this
+  (in mntput_no_expire())::
 
 	init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
 	if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
 		return;
 
-As we leave the syscall, we have __cleanup_mnt() run; it calls cleanup_mnt()
-on our mount, which hits deactivate_super().  That was the last reference to
-superblock.
+  As we leave the syscall, we have __cleanup_mnt() run; it calls cleanup_mnt()
+  on our mount, which hits deactivate_super().  That was the last reference to
+  superblock.
 
-Voila - we have a filesystem shutdown right under the nose of a thread
-running in ->d_hash() of something on that filesystem.  Mutatis mutandis,
-one can arrange the same for other methods called by rcu pathwalk.
+  Voila - we have a filesystem shutdown right under the nose of a thread
+  running in ->d_hash() of something on that filesystem.  Mutatis mutandis,
+  one can arrange the same for other methods called by rcu pathwalk.
 
-It's not easy to hit (especially if you want to get through the
-entire ->kill_sb() before the first thread gets through ->d_hash()),
-and it's probably impossible on the real hardware; on KVM it might be
-borderline doable.  However, it is possible and I would not swear that
-other ways of arranging the same thing are equally hard to hit.
+  It's not easy to hit (especially if you want to get through the
+  entire ->kill_sb() before the first thread gets through ->d_hash()),
+  and it's probably impossible on the real hardware; on KVM it might be
+  borderline doable.  However, it is possible and I would not swear that
+  other ways of arranging the same thing are equally hard to hit.
 
-The bottom line: methods that can be called in RCU mode need to
-be careful about the per-superblock objects destruction.
+  The bottom line: methods that can be called in RCU mode need to
+  be careful about the per-superblock objects destruction.
 
-[1]
+.. [#f1]
 
-Some callers prevent being called for dying dentry (holding ->d_lock and
-having verified !d_unhashed() or finding it in the list of inode's aliases
-under ->i_lock).  For those the scenario in question simply cannot arise.
+  Some callers prevent being called for dying dentry (holding ->d_lock and
+  having verified !d_unhashed() or finding it in the list of inode's aliases
+  under ->i_lock).  For those the scenario in question simply cannot arise.
 
-Some follow the match with lockref_get_not_dead() and treat the failure
-as mismatch.  That takes care of false positives, and false negatives on
-dying dentry are still correct - we simply pretend to have lost the race.
+  Some follow the match with lockref_get_not_dead() and treat the failure
+  as mismatch.  That takes care of false positives, and false negatives on
+  dying dentry are still correct - we simply pretend to have lost the race.
 
-The only caller that does not fit into the classes above is
-__d_lookup_rcu_op_compare().  There we sample ->d_seq and verify
-!d_unhashed() before calling ->d_compare().  That is not enough to
-prevent dentry from starting to die right under us; however, the sampled
-value of ->d_seq will be rechecked when the caller gets to step_into(),
-so for a false positive we will end up with a mismatch.  The corner case
-around ->d_manage() is due to the handle_mounts() done before step_into()
-gets to ->d_seq validation...
+  The only caller that does not fit into the classes above is
+  __d_lookup_rcu_op_compare().  There we sample ->d_seq and verify
+  !d_unhashed() before calling ->d_compare().  That is not enough to
+  prevent dentry from starting to die right under us; however, the sampled
+  value of ->d_seq will be rechecked when the caller gets to step_into(),
+  so for a false positive we will end up with a mismatch.  The corner case
+  around ->d_manage() is due to the handle_mounts() done before step_into()
+  gets to ->d_seq validation...
 
-[2]
+.. [#f2]
 
-binding a symlink on top of a regular file on another filesystem is possible
-and that's all it takes for RCU pathwalk to get there.
+  binding a symlink on top of a regular file on another filesystem is possible
+  and that's all it takes for RCU pathwalk to get there.
----------8-<---------------

This should generate footnotes both in PDF and HTML outputs.

Note that the pattern "foo bar.\ [#fn]_" in the referencing sites is to
place the footnote markers just next to the punctuation. In PDF, it should
prevent line breaks in front of the markers.  HTML doesn't behave that
way, it seems.

HTH, Akira


