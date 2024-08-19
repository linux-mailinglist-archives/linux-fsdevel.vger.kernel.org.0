Return-Path: <linux-fsdevel+bounces-26220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCBF95633F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3CAB20993
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76C14BF97;
	Mon, 19 Aug 2024 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBYp4gdX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UaS+nuS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBYp4gdX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UaS+nuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C142A8F;
	Mon, 19 Aug 2024 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045799; cv=none; b=r+a8s3GvzcPdQaabMki3o+GLlI2T6u5wABn2lh/8/2kVHP10esq+BSCLyXl/krQM7RLUATsKLOyi4pqo16SNr+V3+j+y3wK8EghAZsWvb6X3jV6NADmmDDcd30HmzjH+gZfGwl7XtDCU/mSRThmyOGBZPpReqCxRQ8JPZGKPwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045799; c=relaxed/simple;
	bh=TChKMd5ikloih+zyTwKUF1EFyYEXWxh4hkbSSStYYb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh+w0xQ/TGkT9FXPCpOSs4HMQuD92Y8GX5L2TbUywKu338/MBdrzzuP6+/Dj9NknHtV3uxi2u0ulpNfxfZ1VAGvRhomU38DNh2g0QFdx6pZlRCnTqagcJuKxDVQwP/urIYQ25ptIho9PEpgl6ZTdYROHNKCZr5wt0YG9bYztLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBYp4gdX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UaS+nuS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBYp4gdX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UaS+nuS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0E6122764;
	Mon, 19 Aug 2024 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLJWLKjZDp9yW9IpwRTOxwdqtMIJKiVDA0wksDl27hM=;
	b=UBYp4gdXW27DvF/McdHxJ1N9AWFxOzjJuI8YuL2VPkWMdo98SSljyFdXZ0Uv8VmI2XQzFL
	iP9WaPGT+h3L1ZWN7LGfOO/rXquMPYVMK+Mib2icqpddj5+CWuQptAROwxgndHhBypGpzb
	UXXz8r8/kpAXFcviUc5MiW6oPYVVgz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLJWLKjZDp9yW9IpwRTOxwdqtMIJKiVDA0wksDl27hM=;
	b=8UaS+nuSN8JqzXHs71h6Xn1MT2juN7/mw6qo7xJZr9pPXOvRVDrhoSx3IgMUwH3w3/2pl3
	ofwN4kpxi+Pc7JDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLJWLKjZDp9yW9IpwRTOxwdqtMIJKiVDA0wksDl27hM=;
	b=UBYp4gdXW27DvF/McdHxJ1N9AWFxOzjJuI8YuL2VPkWMdo98SSljyFdXZ0Uv8VmI2XQzFL
	iP9WaPGT+h3L1ZWN7LGfOO/rXquMPYVMK+Mib2icqpddj5+CWuQptAROwxgndHhBypGpzb
	UXXz8r8/kpAXFcviUc5MiW6oPYVVgz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLJWLKjZDp9yW9IpwRTOxwdqtMIJKiVDA0wksDl27hM=;
	b=8UaS+nuSN8JqzXHs71h6Xn1MT2juN7/mw6qo7xJZr9pPXOvRVDrhoSx3IgMUwH3w3/2pl3
	ofwN4kpxi+Pc7JDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E0021397F;
	Mon, 19 Aug 2024 05:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lXBTMeDZwmbEYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:36:32 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] i915: remove wake_up on I915_RESET_MODESET.
Date: Mon, 19 Aug 2024 15:20:35 +1000
Message-ID: <20240819053605.11706-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

Since Commit d59cf7bb73f3 ("drm/i915/display: Use dma_fence interfaces
instead of i915_sw_fence") no code has waited for this wake_up, so let's
remove the wake_up itself.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/gpu/drm/i915/display/intel_display_reset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_reset.c b/drivers/gpu/drm/i915/display/intel_display_reset.c
index c2c347b22448..123571bf8af5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_reset.c
+++ b/drivers/gpu/drm/i915/display/intel_display_reset.c
@@ -35,8 +35,6 @@ void intel_display_reset_prepare(struct drm_i915_private *dev_priv)
 
 	/* We have a modeset vs reset deadlock, defensively unbreak it. */
 	set_bit(I915_RESET_MODESET, &to_gt(dev_priv)->reset.flags);
-	smp_mb__after_atomic();
-	wake_up_bit(&to_gt(dev_priv)->reset.flags, I915_RESET_MODESET);
 
 	if (atomic_read(&dev_priv->gpu_error.pending_fb_pin)) {
 		drm_dbg_kms(&dev_priv->drm,
-- 
2.44.0


