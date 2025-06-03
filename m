Return-Path: <linux-fsdevel+bounces-50430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88EACC193
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A72C16F9C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592FB27FD40;
	Tue,  3 Jun 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PjTSnPvS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PasKWW0Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PjTSnPvS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PasKWW0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A327F72D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748937551; cv=none; b=gkriWd67iZSpOGPMSnL6HBEkQNYITyADFC/s/92yK7wtQYpfIO2zCzjHoYJBHHd+VmNttZGk2qdoDo/hNu0ch96lVzt/gSv7BUu9tsKuS0UPcUE+TzT5mGAUKKUQH5PmWWqii/OPRnIj2CV36BF6irfIVpDW3YDk52fGODm8lXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748937551; c=relaxed/simple;
	bh=RJypxZB7iCnpisYKx+MTn0PXvT3zYTATogDT3I1sJBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ6cvC+P3A5VaxTsjjxUohFx2SBGG1ozS79befMhtDnSkgHBTxrMBndP7zCJxL8gOmamUQgunTEslUsrlw98n3NSD6cnz1z4kyOPrcjHwwbwmcTD/Qmq3zhjIgVacJbRayXYSexH2riBTxiDjuMcWoHwwfUNenOv334dvhJ4/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PjTSnPvS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PasKWW0Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PjTSnPvS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PasKWW0Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 131601F395;
	Tue,  3 Jun 2025 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748937548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCJG5k3LJs9X8fzOBTrsMAyW8lELxLWpibzubjMPIn0=;
	b=PjTSnPvS+KRw7LgGER+iWFrPBNubouUzM8Zo88QXmZcWa/89+sxcL2G5UOR3ph77CeHxPs
	K1b7grsAo5gf5ehln520OPMCuPbkIrDVZQUYpt15FOrbNad+0xGepLWFh26ck/M0cpxKFI
	7Z6tDJaC5jEH6mIfJzre7B3lIuGUM6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748937548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCJG5k3LJs9X8fzOBTrsMAyW8lELxLWpibzubjMPIn0=;
	b=PasKWW0YS+JcVA0YMKQaEi31VZWZH0qzT8GwwpVo0Njhvmg2BI3LTmdy1bUozlpcERqChp
	qkA8vnOwOF1iCeBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748937548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCJG5k3LJs9X8fzOBTrsMAyW8lELxLWpibzubjMPIn0=;
	b=PjTSnPvS+KRw7LgGER+iWFrPBNubouUzM8Zo88QXmZcWa/89+sxcL2G5UOR3ph77CeHxPs
	K1b7grsAo5gf5ehln520OPMCuPbkIrDVZQUYpt15FOrbNad+0xGepLWFh26ck/M0cpxKFI
	7Z6tDJaC5jEH6mIfJzre7B3lIuGUM6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748937548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCJG5k3LJs9X8fzOBTrsMAyW8lELxLWpibzubjMPIn0=;
	b=PasKWW0YS+JcVA0YMKQaEi31VZWZH0qzT8GwwpVo0Njhvmg2BI3LTmdy1bUozlpcERqChp
	qkA8vnOwOF1iCeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E871B13A92;
	Tue,  3 Jun 2025 07:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFZHOEurPmjzGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 07:59:07 +0000
Date: Tue, 3 Jun 2025 09:59:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH v3] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250603075902.GJ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250505030345.GD2023217@ZenIV>
 <20250506193405.GS2023217@ZenIV>
 <20250506195826.GU2023217@ZenIV>
 <9a49247a-91dd-4c13-914a-36a5bfc718ba@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a49247a-91dd-4c13-914a-36a5bfc718ba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,vger.kernel.org,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Thu, May 08, 2025 at 06:59:04PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/7 05:28, Al Viro 写道:
> > [Aaarghh...]
> > it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> > no need to mess with ->s_umount.
> >      
> > [fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Test-by: Qu Wenruo <wqu@suse.com>
> 
> Although the commit message can be enhanced a little, I can handle it at 
> merge time, no need to re-send.

If you're going to add the patch to for-next, please fix the subject
line and update the changelog. Thanks.

