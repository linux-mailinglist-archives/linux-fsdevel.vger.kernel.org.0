Return-Path: <linux-fsdevel+bounces-78210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPjoHI7znGk5MQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320218048A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3A2C3011D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177C233723;
	Tue, 24 Feb 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coF+OnyJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718211367
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893638; cv=none; b=SCbcHJrjoPYElrKyhg1kusgEWNmebtCVDuu9fFzQmWAYAE7SiLP3yNg2bGrGlmoOU6ak/CsaIfELOKv9DetjIXZdqikd5U1tt+AapzYjuj440udA11ltdue4HuAWbRdGoZUUXCxS0HEKoDv8Mj2CrRFLndFS3d9V1AGAFkT36wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893638; c=relaxed/simple;
	bh=C+xPza4eFwrBmPy+6xJnvwElTqsUVNZSDeChbofTjD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkxAnJD+8CwsE81EaPCxme2yBOOy5vJNBb39mlaadZ1C4MRER6d/zj5oBldHaX5jPUW7ufg3MG8X7PjQ2pUd11JEv3H868Jz2c4xYAvL/lPpCw7+7+y16hDPmn4yUtfhAWeLLPi9/hHV52XBZW5UOCjeBKkF8ZiQx2oSFJJsBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coF+OnyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00330C19423;
	Tue, 24 Feb 2026 00:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771893638;
	bh=C+xPza4eFwrBmPy+6xJnvwElTqsUVNZSDeChbofTjD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=coF+OnyJLuSu8yGY9SySbkMHDXydSp3GzipGRXTxxw9RaI/6GwxETsFlV4Hwdz44B
	 cLMN4GkeS/CTBMexg+mkvXX89k6i6V2BjEkzSfYfyV5BVWc+LBeCbNq1dEmpk7Us+D
	 5R4e6SwRbfO1IL7CycuCsoTIiizmeef+ucXL0Zw+xfyatnHlZYqT4dyAHYTos2/2MY
	 oWQTIAwkyLyOy8EBxzeT3XArumlDBBBCPM/ZocKPVC7YrlhF8veu5tp9NVQ8hOwMmz
	 BqdCvjqly5ijvDItsZa97L8+GgT2ad4XRq/jWwCDF/2WXCakjKmTHOKKFGRQ4CboZj
	 0AuxDFaDw/bRg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Feb 2026 01:40:26 +0100
Subject: [PATCH RFC 1/3] move_mount: transfer MNT_LOCKED
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-work-mount-beneath-rootfs-v1-1-8c58bf08488f@kernel.org>
References: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
In-Reply-To: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3320; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C+xPza4eFwrBmPy+6xJnvwElTqsUVNZSDeChbofTjD4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO+dxkwFf5TMgoSNixSKVxhZ7ypfVzeWedKT0S8OzR3
 2SvvbYeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5cJXhv1ub3Yq1y74d/uw9
 VWr1iaDgeL95n9TufNSe6FK09a/Qn3mMDFu2S9YUHD2iJVUxWWZjVJ/d9zPTGg59bMvZP0VfUU6
 5nhMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78210-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7320218048A
X-Rspamd-Action: no action

When performing a mount-beneath operation the target mount can often be
locked:

  unshare(CLONE_NEWUSER | CLONE_NEWNS);
  mount --beneath -t tmpfs tmpfs /proc

will fail because the procfs mount on /proc became locked when the mount
namespace was created from the parent mount namespace. Same logic for:

  unshare(CLONE_NEWUSER | CLONE_NEWNS);
  mount --beneath -t tmpfs tmpfs /

MNT_LOCKED is raised to prevent an unprivileged mount namespace from
revealing whatever is under a given mount. To replace the rootfs we need
to handle that case though.

We can simply transfer the locked mount property from the top mount to
the mount beneath. The new mount we mounted beneath the top mount takes
over the job of the top mount in protecting the parent mount from being
revealed. This leaves us free to allow the top mount to be unmounted.

This also works during mount propagation and also works for the
non-MOVE_MOUNT_BENEATH case:

(1) move_mount(MOVE_MOUNT_BENEATH): @source_mnt->overmount always NULL
(2) move_mount():                   @source_mnt->overmount maybe !NULL

For (1) can_move_mount_beneath() rejects overmounted @source_mnt (We
could allow this but whatever it's not really a use-case and it's fugly
to move an overmounted mount stack around. What are you even doing? So
let's keep that restriction.

For (2) we can have @source_mnt overmounted (Someone overmounted us
while we locked the target mount.). Both are fine. @source_mnt will be
mounted on whatever @q was mounted on and @q will be mounted on the top
of the @source_mnt mount stack. Even in such cases we can unlock @q and
lock @source_mnt if @q was locked.

This effectively makes mount propagation useful in cases where a mount
namespace has a locked mount somewhere and we propagate a new mount
beneath it but the mount namespace could never get at it because the old
top mount remains locked. Again, we just let the newly propagated mount
take over the protection and unlock the top mount.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ebe19ded293a..cdde6c6a30ee 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2636,6 +2636,19 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 
 			if (unlikely(shorter) && child != source_mnt)
 				mp = shorter;
+			/*
+			 * If @q was locked it was meant to hide
+			 * whatever was under it. Let @child take over
+			 * that job and lock it, then we can unlock @q.
+			 * That'll allow another namespace to shed @q
+			 * and reveal @child. Clearly, that mounter
+			 * consented to this by not severing the mount
+			 * relationship. Otherwise, what's the point.
+			 */
+			if (IS_MNT_LOCKED(q)) {
+				child->mnt.mnt_flags |= MNT_LOCKED;
+				q->mnt.mnt_flags &= ~MNT_LOCKED;
+			}
 			mnt_change_mountpoint(r, mp, q);
 		}
 	}
@@ -3529,9 +3542,6 @@ static int can_move_mount_beneath(const struct mount *mnt_from,
 {
 	struct mount *parent_mnt_to = mnt_to->mnt_parent;
 
-	if (IS_MNT_LOCKED(mnt_to))
-		return -EINVAL;
-
 	/* Avoid creating shadow mounts during mount propagation. */
 	if (mnt_from->overmount)
 		return -EINVAL;

-- 
2.47.3


