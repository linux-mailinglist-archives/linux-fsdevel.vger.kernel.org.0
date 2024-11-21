Return-Path: <linux-fsdevel+bounces-35408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8009D4ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14949B214C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2F3C47B;
	Thu, 21 Nov 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3PbC7j72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z000pJx+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3PbC7j72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z000pJx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF21CC159;
	Thu, 21 Nov 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184572; cv=none; b=ETJKBpY4BXwWDDtbQtDZfTlg+lq0ttOLo/ivP8LY8viKRcP40GDZi8k5EuceUup6PW114CBJfovSozG2zPl+ZRjhOn+q5nav0oi0k4L7LLIBf/V0dl/b2qTfuzFe+S4mNSFrWN2qdJs7THbk4DSZi+Z6P0U5KHJqIDiDniWBDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184572; c=relaxed/simple;
	bh=zWRppg95xtzt+hN/u5oBd5oGkUCkdBlpKTRrRrIFJs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL7WDpOu4Atl8d00jIzoblPimpEJsrnQ59utfMzSG8h07Ko8xmzx51M/Ch5VuwPQt/wEbVYFwvBBzsRmn+AsPqQjh6uSsHI1FYdpc5edEdjTl91yZ1ASEGwa90ga5U2jh1n6yaJE/bREEzZlP9HLZnJrSaQtKNdLsa4KgMGkv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3PbC7j72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z000pJx+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3PbC7j72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z000pJx+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9877B219BD;
	Thu, 21 Nov 2024 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732184568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxm7ovrk+K1yTBvGNMVkCAtMMkTAJ4W+DeknJDrENns=;
	b=3PbC7j72wbheuOzDwR2yXVLAGtJ7F3Lda6T4yPr3abvmptbP9bMRm0l/cIg0BC9mUfAb9J
	onnZ2NvoMT5suPU++qVE382uPxncTqDd252RnlJ16wuDb+9awsVxzU/5TzkeU8DAfuqgk3
	XtipTWHH2kIhFPbdMi6V19mku7OlisE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732184568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxm7ovrk+K1yTBvGNMVkCAtMMkTAJ4W+DeknJDrENns=;
	b=z000pJx+2ebarxGC/hK4I0Vsx2r9l9zMoGFYyMerkRoW1OfFZBEIRWLhPZiUf+SOVZfoK/
	wQ/aPWzupghQuBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732184568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxm7ovrk+K1yTBvGNMVkCAtMMkTAJ4W+DeknJDrENns=;
	b=3PbC7j72wbheuOzDwR2yXVLAGtJ7F3Lda6T4yPr3abvmptbP9bMRm0l/cIg0BC9mUfAb9J
	onnZ2NvoMT5suPU++qVE382uPxncTqDd252RnlJ16wuDb+9awsVxzU/5TzkeU8DAfuqgk3
	XtipTWHH2kIhFPbdMi6V19mku7OlisE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732184568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxm7ovrk+K1yTBvGNMVkCAtMMkTAJ4W+DeknJDrENns=;
	b=z000pJx+2ebarxGC/hK4I0Vsx2r9l9zMoGFYyMerkRoW1OfFZBEIRWLhPZiUf+SOVZfoK/
	wQ/aPWzupghQuBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ABFA137CF;
	Thu, 21 Nov 2024 10:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UbbXIfgJP2cZawAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 10:22:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C07FA089E; Thu, 21 Nov 2024 11:22:48 +0100 (CET)
Date: Thu, 21 Nov 2024 11:22:48 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 17/19] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <20241121102248.w3jkpcn3wosxbh62@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <9eccdf59a65b72f0a1a5e2f2b9bff8eda2d4f2d9.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eccdf59a65b72f0a1a5e2f2b9bff8eda2d4f2d9.1731684329.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 15-11-24 10:30:30, Josef Bacik wrote:
> xfs has it's own handling for write faults, so we need to add the
> pre-content fsnotify hook for this case.  Reads go through filemap_fault
> so they're handled properly there.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This was missing proper handling for DAX read faults. What I've ended up
with is:

        struct xfs_inode        *ip = XFS_I(file_inode(vmf->vma->vm_file));
        vm_fault_t              ret;
 
+       ret = filemap_fsnotify_fault(vmf);
+       if (unlikely(ret))
+               return ret;
        xfs_ilock(ip, XFS_MMAPLOCK_SHARED);
        ret = xfs_dax_fault_locked(vmf, order, false);
        xfs_iunlock(ip, XFS_MMAPLOCK_SHARED);
@@ -1412,6 +1415,17 @@ xfs_write_fault(
        unsigned int            lock_mode = XFS_MMAPLOCK_SHARED;
        vm_fault_t              ret;
 
+       /*
+        * Usually we get here from ->page_mkwrite callback but in case of DAX
+        * we will get here also for ordinary write fault. Handle HSM
+        * notifications for that case.
+        */
+       if (IS_DAX(inode)) {
+               ret = filemap_fsnotify_fault(vmf);
+               if (unlikely(ret))
+                       return ret;
+       }
+
        sb_start_pagefault(inode->i_sb);
        file_update_time(vmf->vma->vm_file);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

