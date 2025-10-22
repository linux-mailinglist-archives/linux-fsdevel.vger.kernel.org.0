Return-Path: <linux-fsdevel+bounces-65082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7EBFB334
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1181E19A0317
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27E3054C8;
	Wed, 22 Oct 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t9vo5ahd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3TYCux+9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oSbKmclu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QMCr60nz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F70298CDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126105; cv=none; b=Mbq/5COa3WQourCjKKowOs1FDcHJOoRbVmj4DSer4f29yd30IU0GOV5Tj6AURLp+44nSx0Dvvp/MBz9vXYiLblxRTPmPtiF1vI3fymXLrBUGA6/pT2EiDhl4HNfqlU57BAJz7X/opiVC/o4p4jds3LJo4yK6Smhn0Rawq/UoEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126105; c=relaxed/simple;
	bh=JuJPUNbJhfoQN7skxUPxJH/M2L5l46P08n+PKvmscGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5pEl6D5NYpuhjSWQ97shBoT8BLE+vPxM6P4XAJuowvxUI6nwBLj72QycPfPF/KmUFx+5Qel24r20Kmnpjsr5y37aHUdqjMl4f2dbxH8Y76Nkrn7fgPJqKOKU+sfdTESPWfm1zvn6aNI5JBC12VYss4Gwy0OFV46gG2/Hyh4ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t9vo5ahd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3TYCux+9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oSbKmclu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QMCr60nz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF71C1F445;
	Wed, 22 Oct 2025 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761126096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVMPNnxVCiBVEkaRNyX61pBNpM3YhHjIok9iR2+4Olw=;
	b=t9vo5ahdowM4eR/yGWn4Hcujq9sPcsLaHp9UVR5y8Y+WmEC8GhouqZlfEDGGL5mpx7yt+r
	cUy5Rm2TtwRapDzJYmmtUNcO+e0kanARe87/6JcScVOrD6EN2vfSHUH/MgSaD9iuhFr43q
	rNnt/NWKSPHbQ+UfRDbz0E/NPvNJkgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761126096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVMPNnxVCiBVEkaRNyX61pBNpM3YhHjIok9iR2+4Olw=;
	b=3TYCux+9oAT3GW+oh8kuoojsxHoxkqVJ7VZNTWADjh4Hx3A2hjHbVom5QYv3RXHpePpceE
	qafFlL20GhEsN/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761126092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVMPNnxVCiBVEkaRNyX61pBNpM3YhHjIok9iR2+4Olw=;
	b=oSbKmcluaxK+IU6pGorHF5c9fc6loxVttWljv3Wo5xWNTMNN4AyrzOYCORvRpt1Y7AQIE7
	f9/L2TSXbfsL7Bp7+/3h6KxuywFIq/c8EfdyJgj2sNz+Vy28R704uMR6EgnIa3LMTQcYrm
	uUDygj2wWnTvfORyH/di2XLCO3MVXyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761126092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVMPNnxVCiBVEkaRNyX61pBNpM3YhHjIok9iR2+4Olw=;
	b=QMCr60nzeJ9XBTdfLEbPDDPWu3OG/ZfDtcKdT43okU+hownj4o6LGOFWUjLautHhOpXqbB
	WZGDstoTMG26swAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A55AA1339F;
	Wed, 22 Oct 2025 09:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MVVbKMym+Gh1EgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Oct 2025 09:41:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5AE89A0990; Wed, 22 Oct 2025 11:41:17 +0200 (CEST)
Date: Wed, 22 Oct 2025 11:41:17 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
Message-ID: <ndpmuv4j2ycl5w5ssagzijgsykjo7mfzwenrrlvlhnbzpszlcr@3hkkdfmc54rz>
References: <20251010221737.1403539-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010221737.1403539-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 11-10-25 00:17:36, Mateusz Guzik wrote:
> In the inode hash code grab the state while ->i_lock is held. If found
> to be set, synchronize the sleep once more with the lock held.
> 
> In the real world the flag is not set most of the time.
> 
> Apart from being simpler to reason about, it comes with a minor speed up
> as now clearing the flag does not require the smp_mb() fence.
> 
> While here rename wait_on_inode() to wait_on_new_inode() to line it up
> with __wait_on_freeing_inode().
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> This temporarily duplicated sleep code from inode_wait_for_lru_isolating().
> This is going to get dedupped later.
> 
> There is high repetition of:
> 	if (unlikely(isnew)) {
> 		wait_on_new_inode(old);
> 		if (unlikely(inode_unhashed(old))) {
> 			iput(old);
> 			goto again;
> 		}
> 
> I expect this is going to go away after I post a patch to sanitize the
> current APIs for the hash.

Yeah, it seems all but one caller (ilookup5_nowait() which is only used by
AFS) would be fine with waiting for I_NEW inodes as a part of hash lookup
similarly as we wait for I_FREEING. What AFS is doing is beyond me as it
seems to be playing weird tricks with I_NEW in afs_fetch_status_success().

Anyway with the promise of deduplication I think this is moving in a good
direction so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

