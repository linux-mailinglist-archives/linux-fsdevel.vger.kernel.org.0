Return-Path: <linux-fsdevel+bounces-69096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993FC6F17C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBDFC50165B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFF363C50;
	Wed, 19 Nov 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj3myy68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FE3624AF;
	Wed, 19 Nov 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559765; cv=none; b=U0budM7vHvit0H9I2fm6ALCudbKSfdDUMjsXoZSZI4LZJepryTqpLMlrnHSfu1obuIbL3cX1pLGUuoowyLAKfpE4uBnrFXKnfGEBsjbJSaYM5QVSbCHRd2nr5J12WoeXFDN8SJMJ9ylc4vq9Z6Afg0Fpw8c3LASTofOYsc9lE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559765; c=relaxed/simple;
	bh=PFXUSzH9PyZbzkoKfXQR40e3WZl1vF7L9JQUzwpzrRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8v+oE5GmrqOZ1U16as7G3Hto7xWPh80Tv0+jy2uDtO9Xxg0Q6zG7ttqJiLSBcCNsBPu2myNhPBrWELm/3qxXUT9vOmQv/jAD8tZkHj/LzI757dP3xBtl9/pLkWucujB954H1xnUlETXNObQtSIckxbzD7BRZIK0pk4f3YheBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj3myy68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B391C2BCB5;
	Wed, 19 Nov 2025 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559764;
	bh=PFXUSzH9PyZbzkoKfXQR40e3WZl1vF7L9JQUzwpzrRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oj3myy687cd0Kw+vAWhO8XP92S7+mvJqyQee0ny5iVOAL4/9Qfqk192/xMaXCdG3i
	 ok6sRQZyirGYMeC0gIgYTEtlF08T6veJoEno/pVAuWvI56l1NGPB+MRiuzvitIAFC9
	 CPHROrFAQov5AvvMn8xvOdyz1NBv96Xv1KntihA7c8C/h6/YRWioBN3apxPxY+8m4w
	 +Eag7z/KpfL9DSoXnYeoDQpx2PoNfI4R82BlmRrGnqJYEezecBwrlDNhJuqj7TF1h5
	 Od12JMx6ReS3/jbSPkoi3HkhmA95Rf0sAS+STMqRZQfIXVF9oNcTX7tMA6lV+sg5cO
	 A6QZ2Kel/vDBQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Nov 2025 08:42:19 -0500
Subject: [PATCH v8 2/3] filelock: add lease_dispose_list() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-dir-deleg-ro-v8-2-81b6cf5485c6@kernel.org>
References: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
In-Reply-To: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PFXUSzH9PyZbzkoKfXQR40e3WZl1vF7L9JQUzwpzrRI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHclPYYH8b53huilGRRAYY3ySpZuzfp3abUG4h
 2h99muONzGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3JTwAKCRAADmhBGVaC
 FVPbD/4oszGuwBkENOqF/rp8Q6iZ97dVAWYU3fCWPr/36tB7jW4eUXMVD8GdM8WG+StA5XWeP9A
 8jZYyNkQV/BZ6P2T/55rtwiHOy9A3+13PDVAJu2qr6Bbfeek8rjMoum/1PyIUb4noS6ruwzWacZ
 T6cDCV8OKuAqu+w9WkmB3ZrphPLLNmSz5dx1VeDhvFMkrYhJYyn5sCIvpA4N16sDmCn/oQOjZeH
 +ViquFJXUMH54fTpd95FM79tjyqHECBTwDwc945lk2zaS5jM9rpT2KikZXi1FsP6UfbVvNGsXOw
 k9E3O9NsMWY0hFxbJ2pRvRMXEiUWnyK9xEwFMvFynJlDNi1jTAurWluLLgn+bPS5ZHiBgHOK4+Z
 WobTxPQijK7MZDCrw1jxjioppRF1MBo9bf2mrf2eXSA9hiZBxPeCma8qs5wzLvkROY+S0nFExiw
 PFMnPIiSQeNBMlYUkj7XG29NI5o8w7GqgCH8cWMnDxykiuiMMv1AHWLvqHNFDM7Tu1mD8esnbib
 KLvDp7zZATJsm4fyZHl/+HUr0/yH/E4ExpNG7+MCVw83bvVxrQyGwnNBAB/cSxA/yKwWWxSohf2
 n+PLBti8h+HdUkQutjbQhW33hoWuqBs943BIiXE/5Y7K6IpurKXDynXo4kdJTmGEsrfxq2aanyC
 3nCrnA5fCUr6Gjg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and call that from the lease handling code instead of
locks_dispose_list(). Remove the lease handling parts from
locks_dispose_list().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 3df07871b5ab7bbe883cdd8fba822d130282da8e..d4e6af6ac625204b337e94fd1e4f6df2eee5cf50 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -369,10 +369,19 @@ locks_dispose_list(struct list_head *dispose)
 	while (!list_empty(dispose)) {
 		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
 		list_del_init(&flc->flc_list);
-		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
-			locks_free_lease(file_lease(flc));
-		else
-			locks_free_lock(file_lock(flc));
+		locks_free_lock(file_lock(flc));
+	}
+}
+
+static void
+lease_dispose_list(struct list_head *dispose)
+{
+	struct file_lock_core *flc;
+
+	while (!list_empty(dispose)) {
+		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
+		list_del_init(&flc->flc_list);
+		locks_free_lease(file_lease(flc));
 	}
 }
 
@@ -1620,7 +1629,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
 						 list_empty(&new_fl->c.flc_blocked_member),
 						 break_time);
@@ -1643,7 +1652,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 free_lock:
 	locks_free_lease(new_fl);
 	return error;
@@ -1703,7 +1712,7 @@ static int __fcntl_getlease(struct file *filp, unsigned int flavor)
 		spin_unlock(&ctx->flc_lock);
 		percpu_up_read(&file_rwsem);
 
-		locks_dispose_list(&dispose);
+		lease_dispose_list(&dispose);
 	}
 	return type;
 }
@@ -1904,7 +1913,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	if (is_deleg)
 		inode_unlock(inode);
 	if (!error && !my_fl)
@@ -1940,7 +1949,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 		error = fl->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	return error;
 }
 
@@ -2735,7 +2744,7 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 }
 
 /*

-- 
2.51.1


