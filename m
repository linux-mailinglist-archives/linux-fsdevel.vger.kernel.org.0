Return-Path: <linux-fsdevel+bounces-63547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE5BC15ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 14:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686A5188E8CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391332DBF7C;
	Tue,  7 Oct 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xNiadTs7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5T072lze";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xNiadTs7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5T072lze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADC2DAFA4
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840399; cv=none; b=n/a3mJdINxc+/s4BrvZG1X1a1/gH6mpAyqj+8+nx1W+YIEWfXHBm4dNwlgGYfWhFTeti21O4bxZ9FvvktA1P60+DGmQ9QRBOFteO2rGeTq9JwVsKlhnYu11kG1UT6OJCRIC/XnY98Q7DvYR7/np4dtPPg9PaCMRVZB1xNiKlWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840399; c=relaxed/simple;
	bh=jR0cyDkYil7dwUM+H92TkPHk3FsAPAjACPA+smr1tfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUmrHIYdxXHFrU7hXpCT2F6hvCMkqCjl35PprPZOWNAdPuhbvBvoxPD49ePI3+UKy4yehBOp1/s5dYL4WAR/b8ouTACV09OBJAaP93tpReX+FskJ+vIluxyJ9w9u5S49GNx98CHp6x1Eu6n4zBHKIgtj+geseFv9omdGrkoisG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xNiadTs7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5T072lze; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xNiadTs7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5T072lze; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43AE0336F3;
	Tue,  7 Oct 2025 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759840396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AKECBnZLOXYyLNKjk02Q7AUF/9AlrGDh5qa24XJcxk=;
	b=xNiadTs76jqTRVi1/s8HBgWQXLoxdQJpzFIaCDCa+j/oekrmuAx4sWaFpSx8m7icdtOEQk
	00liOhOqo1SfqHFwNt0qOcNgaSfKq9AMEahcwd4788hmry2PdzkGEIoAenx2AUzValt8O5
	0dl7+HhMsiLapZZsJtFfLTU1Q5BWm1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759840396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AKECBnZLOXYyLNKjk02Q7AUF/9AlrGDh5qa24XJcxk=;
	b=5T072lze5twv1qSQSW4urtaKdm7vUQHBct3UR/KpeZvIVu8Gw6Bjz1DDg6cj/DivOlvpUb
	RDwMoxHvwuovqBDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759840396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AKECBnZLOXYyLNKjk02Q7AUF/9AlrGDh5qa24XJcxk=;
	b=xNiadTs76jqTRVi1/s8HBgWQXLoxdQJpzFIaCDCa+j/oekrmuAx4sWaFpSx8m7icdtOEQk
	00liOhOqo1SfqHFwNt0qOcNgaSfKq9AMEahcwd4788hmry2PdzkGEIoAenx2AUzValt8O5
	0dl7+HhMsiLapZZsJtFfLTU1Q5BWm1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759840396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AKECBnZLOXYyLNKjk02Q7AUF/9AlrGDh5qa24XJcxk=;
	b=5T072lze5twv1qSQSW4urtaKdm7vUQHBct3UR/KpeZvIVu8Gw6Bjz1DDg6cj/DivOlvpUb
	RDwMoxHvwuovqBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3709513AAC;
	Tue,  7 Oct 2025 12:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id btJtDYwI5WhkEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Oct 2025 12:33:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE0CAA0A58; Tue,  7 Oct 2025 14:33:15 +0200 (CEST)
Date: Tue, 7 Oct 2025 14:33:15 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com, syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Subject: Re: [PATCH] ns: Fix mnt ns ida handling in copy_mnt_ns()
Message-ID: <6tzzwyardi2uit5js4r3bjujmboufmodrjfocozinq2g25yaco@73s7dx4vje43>
References: <20251002161039.12283-2-jack@suse.cz>
 <20251006-rammen-nerven-f7dff27e8e43@brauner>
 <20251007-atomkraftgegner-warnung-6b02ea18eb2c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-atomkraftgegner-warnung-6b02ea18eb2c@brauner>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[7d23dc5cd4fa132fb9f3,e0f8855a87443d6a2413];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Tue 07-10-25 12:58:11, Christian Brauner wrote:
> On Mon, Oct 06, 2025 at 01:03:15PM +0200, Christian Brauner wrote:
> > On Thu, 02 Oct 2025 18:10:40 +0200, Jan Kara wrote:
> > > Commit be5f21d3985f ("ns: add ns_common_free()") modified error cleanup
> > > and started to free wrong inode number from the ida. Fix it.
> > > 
> > > 
> > 
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.fixes
> > 
> > [1/1] ns: Fix mnt ns ida handling in copy_mnt_ns()
> >       https://git.kernel.org/vfs/vfs/c/502f6e0e7b72
> 
> Jan, I think Al fixed this in his series on accident in upstream.
> So I think we can drop your patch. emptied_ns is cleaned up after
> namespace_unlock() and will call free_mnt_ns() which will call
> ns_common_free(). Please take a look at what's in mainline and let me
> know if you read it the same way!

I've checked it and indeed Al's changes silently fixed this. So all should
be fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

